import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter_by_sajid/modules/aether/service/raid_service.dart';
import 'package:flutter_test/flutter_test.dart';

/// Project Aether — Geo-Raid concurrency harness.
///
/// 50 simultaneous "Join" requests are fired against [RaidService].
/// Exactly 15 must succeed; the remaining 35 must fail gracefully
/// (return `false`, never throw). If the cap is breached, the
/// architecture under test is racy and the submission fails.
void main() {
  group('Aether Raid Concurrency Integrity', () {
    late FakeFirebaseFirestore fakeFirestore;
    late RaidService raidService;

    setUp(() async {
      fakeFirestore = FakeFirebaseFirestore();

      try {
        raidService = RaidService(firestore: fakeFirestore);
      } on Object catch (e) {
        fail(
          'HEALING ACTION: RaidService must accept a firestore instance '
          'via constructor injection for testing. Error: $e',
        );
      }

      await fakeFirestore.collection('events').doc('dragon_raid').set(
        <String, Object?>{
          'slots_filled': 0,
          'max_slots': 15,
        },
      );
    });

    test(
        'Thundering Herd: 50 simultaneous join requests must strictly cap at 15',
        () async {
      final List<Future<bool>> joinRequests = <Future<bool>>[];

      for (int i = 0; i < 50; i++) {
        try {
          joinRequests.add(raidService.joinRaid(userId: 'user_$i'));
        } on Object catch (e) {
          fail(
            'HEALING ACTION: joinRaid() crashed. Ensure it accepts a '
            'userId and returns a Future<bool>. Error: $e',
          );
        }
      }

      final List<bool> results = await Future.wait(joinRequests);
      final int successfulJoins =
          results.where((bool result) => result == true).length;

      final DocumentSnapshot<Map<String, dynamic>> snapshot = await fakeFirestore
          .collection('events')
          .doc('dragon_raid')
          .get();
      final int slotsFilled =
          (snapshot.data()?['slots_filled'] as int?) ?? 0;

      expect(
        successfulJoins,
        15,
        reason:
            'HEALING ACTION: Exactly 15 requests should report success '
            '(return true) to the client. The rest must gracefully '
            'return false.',
      );
      expect(
        slotsFilled,
        15,
        reason:
            'HEALING ACTION: The database must record exactly 15 filled '
            'slots. If this is higher, your code suffers from a race '
            'condition. Use Transactions.',
      );
    });
  });
}
