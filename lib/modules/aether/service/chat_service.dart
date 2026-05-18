import 'package:cloud_firestore/cloud_firestore.dart';

/// ChatService — sharded, capped engagement chat.
///
/// @AETHER: The naive "listen to all chat documents" pattern is a
/// studio-killer. With 10 000 concurrent players each posting one
/// message per minute, an unbounded `collection().snapshots()` would
/// bill ≈ 10 000 × 10 000 = 100 000 000 reads per minute. The strategy
/// below cuts that by ~3 orders of magnitude:
///
///   1. SHARDING — every channel id is bucketed into one of N shards
///      (default 64). A client only listens to its own shard, so the
///      fan-out per shard is ~10 000 / 64 ≈ 160 listeners.
///   2. WINDOWING — `limit(50)` + `orderBy(ts desc)` means a new
///      listener only ever pays 50 reads at attach time, not the full
///      history. Older messages page in cold on user scroll.
///   3. SUMMARISATION — at higher scale, heavy channels would be
///      promoted to Cloud Functions that batch writes into a
///      `chat_summary` doc on a 1 s tick; clients listen to the summary,
///      not to the raw messages. (Out of scope for this single screen,
///      but referenced in README.md.)
class ChatService {
  /// Creates a chat service bound to [firestore] and using [shardCount]
  /// buckets. The default 64 fits a 10 k MAU channel comfortably.
  ChatService({required FirebaseFirestore firestore, int shardCount = 64})
      : assert(shardCount > 0, 'shardCount must be positive'),
        _firestore = firestore,
        _shardCount = shardCount;

  final FirebaseFirestore _firestore;
  final int _shardCount;

  /// Per-channel cap on the live tail. Anything older is paginated in
  /// on user scroll, which keeps history as cold data.
  static const int liveTailLimit = 50;

  /// Stable shard id for [channelId]. We hash so chat traffic
  /// distributes evenly across shards even when channel ids are bursty
  /// (e.g. all-caps guild names sorting near each other).
  int shardFor(String channelId) {
    final int h = channelId.hashCode & 0x7fffffff;
    return h % _shardCount;
  }

  CollectionReference<Map<String, dynamic>> _shardCollection(
    String channelId,
  ) {
    final int shard = shardFor(channelId);
    return _firestore
        .collection('chat')
        .doc('shard_$shard')
        .collection(channelId);
  }

  /// The bounded live tail of messages for a channel. The cap is
  /// enforced at the query layer so the first snapshot pays at most 50
  /// document reads.
  Stream<List<ChatMessage>> watchChannel(String channelId) {
    return _shardCollection(channelId)
        .orderBy('ts', descending: true)
        .limit(liveTailLimit)
        .snapshots()
        .map<List<ChatMessage>>(
      (QuerySnapshot<Map<String, dynamic>> snap) {
        final List<ChatMessage> out = <ChatMessage>[];
        for (final QueryDocumentSnapshot<Map<String, dynamic>> d
            in snap.docs) {
          final Map<String, dynamic> data = d.data();
          out.add(
            ChatMessage(
              id: d.id,
              author: (data['author'] as String?) ?? 'anon',
              body: (data['body'] as String?) ?? '',
              ts: (data['ts'] as Timestamp?)?.toDate() ?? DateTime.now(),
            ),
          );
        }
        return out;
      },
    );
  }

  /// Append a message. Writes are cheap — the cost cliff is in reads —
  /// so we don't bother batching here.
  Future<void> postMessage({
    required String channelId,
    required String author,
    required String body,
  }) async {
    final String trimmed = body.trim();
    if (trimmed.isEmpty) {
      return;
    }
    await _shardCollection(channelId).add(<String, Object?>{
      'author': author,
      'body': trimmed,
      'ts': FieldValue.serverTimestamp(),
    });
  }
}

/// Plain immutable chat row consumed by the UI.
class ChatMessage {
  /// Creates a chat message snapshot.
  const ChatMessage({
    required this.id,
    required this.author,
    required this.body,
    required this.ts,
  });

  /// Firestore doc id (used as the widget key).
  final String id;

  /// Display name of the author.
  final String author;

  /// Body text.
  final String body;

  /// Server-stamped post time.
  final DateTime ts;
}
