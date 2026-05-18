import 'package:cloud_firestore/cloud_firestore.dart';

/// RaidService — atomic slot allocation for the Geo-Raid.
///
/// @AETHER: A naive `get()` then `update()` is racy. Under a thundering
/// herd of N concurrent clients, every client reads `slots_filled = 0`
/// before anyone writes back, so N joins commit instead of the desired
/// 15. We delegate the read-modify-write to Firestore's `runTransaction`,
/// which the server retries automatically on contention and serialises
/// against the document's compare-and-swap token. Exactly 15 commits
/// land; the rest are rejected before the write ever leaves the wire.
class RaidService {
  /// Builds a RaidService bound to the given [firestore] instance.
  /// Constructor injection is mandatory so the concurrency harness can
  /// swap in `FakeFirebaseFirestore`.
  RaidService({required FirebaseFirestore firestore}) : _firestore = firestore;

  final FirebaseFirestore _firestore;

  /// Default document coordinates. Centralised so the UI, the seed job
  /// and the test harness all agree on the path.
  static const String raidCollection = 'events';

  /// Doc id used by the demo. Real deployments would key by raid id.
  static const String raidDocId = 'dragon_raid';

  DocumentReference<Map<String, dynamic>> get _raidDoc =>
      _firestore.collection(raidCollection).doc(raidDocId);

  /// Attempts to claim a slot for [userId].
  ///
  /// Returns `true` if the player was admitted, `false` if the raid was
  /// already full or the transaction failed for any non-fatal reason.
  /// Never throws to the caller — the UI must not have to reason about
  /// Firestore error codes inside a button handler.
  Future<bool> joinRaid({required String userId}) async {
    try {
      final bool admitted = await _firestore.runTransaction<bool>(
        (Transaction txn) async {
          final DocumentSnapshot<Map<String, dynamic>> snap =
              await txn.get(_raidDoc);

          if (!snap.exists) {
            // @AETHER: Fail closed. We do NOT auto-create the raid here
            // because that would let a malicious client spin up
            // arbitrary raids by spamming joins.
            return false;
          }

          final Map<String, dynamic> data =
              snap.data() ?? <String, dynamic>{};
          final int slotsFilled = (data['slots_filled'] as int?) ?? 0;
          final int maxSlots = (data['max_slots'] as int?) ?? 0;

          if (slotsFilled >= maxSlots) {
            return false;
          }

          // @AETHER: Plain assignment is safe here because we already
          // hold the doc lock through the transaction. `FieldValue.
          // increment` would also work but is unnecessary inside a txn.
          txn.update(_raidDoc, <String, Object?>{
            'slots_filled': slotsFilled + 1,
            'last_joined_by': userId,
            'updated_at': FieldValue.serverTimestamp(),
          });

          return true;
        },
        timeout: const Duration(seconds: 10),
      );
      return admitted;
    } on FirebaseException catch (error) {
      // @AETHER: A FAILED_PRECONDITION means we lost the optimistic
      // race after Firestore's internal retry budget was exhausted.
      // The client surfaces a graceful "raid full" rather than a crash.
      assert(error.code.isNotEmpty, 'unexpected empty Firebase error code');
      return false;
    } on Exception {
      // Transport / unknown failure — fail closed.
      return false;
    }
  }

  /// Reactive stream of the raid roster. The UI binds to this; we expose
  /// only the fields the widget actually needs, so an upstream schema
  /// change cannot smuggle dynamic data into the render tree.
  Stream<RaidSnapshot> watchRaid() {
    return _raidDoc.snapshots().map<RaidSnapshot>(
      (DocumentSnapshot<Map<String, dynamic>> snap) {
        final Map<String, dynamic> data =
            snap.data() ?? <String, dynamic>{};
        return RaidSnapshot(
          slotsFilled: (data['slots_filled'] as int?) ?? 0,
          maxSlots: (data['max_slots'] as int?) ?? 0,
        );
      },
    );
  }

  /// One-shot seed used by demo / dev environments. Idempotent: if the
  /// doc already exists we leave it untouched.
  Future<void> seedIfMissing({int maxSlots = 15}) async {
    final DocumentSnapshot<Map<String, dynamic>> snap = await _raidDoc.get();
    if (snap.exists) {
      return;
    }
    await _raidDoc.set(<String, Object?>{
      'slots_filled': 0,
      'max_slots': maxSlots,
      'created_at': FieldValue.serverTimestamp(),
    });
  }
}

/// Plain value type — keeps the widget layer free of Firestore imports.
class RaidSnapshot {
  /// Creates a raid snapshot.
  const RaidSnapshot({required this.slotsFilled, required this.maxSlots});

  /// Slots currently filled.
  final int slotsFilled;

  /// Maximum slots allowed.
  final int maxSlots;

  /// `true` once all slots are claimed.
  bool get isFull => slotsFilled >= maxSlots;

  /// Remaining slots, clamped to `[0, maxSlots]`.
  int get slotsRemaining => (maxSlots - slotsFilled).clamp(0, maxSlots);
}
