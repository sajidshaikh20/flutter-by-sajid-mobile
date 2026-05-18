import 'dart:async';

import '../../../utils/exports.dart';

/// AetherCubit — orchestrates the Geo-Raid and Engagement Chat for the
/// single-screen Aether experience. The 100 ms World-Pulse is owned by
/// [WorldPulseService] directly (via a [ValueNotifier]) so the cubit
/// never emits at the high-frequency tick rate.
class AetherCubit extends BaseCubit<AetherState> {
  /// Constructs the cubit. Services are injected so the cubit is
  /// trivially testable without Firebase running.
  AetherCubit({
    required RaidService raidService,
    required ChatService chatService,
    required this.channelId,
    required this.localUserId,
  })  : _raidService = raidService,
        _chatService = chatService,
        super(AetherState.initial());

  final RaidService _raidService;
  final ChatService _chatService;

  /// Chat channel id this cubit is bound to.
  final String channelId;

  /// Local user's display id, used when posting chat / joining the raid.
  final String localUserId;

  StreamSubscription<RaidSnapshot>? _raidSub;
  StreamSubscription<List<ChatMessage>>? _chatSub;

  /// Wires up the live streams. Idempotent — safe to call after a
  /// hot-restart even if the cubit was created earlier.
  Future<void> bind() async {
    // Seed the raid doc on first run so demos work without a backend.
    try {
      await _raidService.seedIfMissing();
    } on Exception catch (e) {
      DebugLog.instance.w('Aether seed skipped: $e');
    }

    await _raidSub?.cancel();
    _raidSub = _raidService.watchRaid().listen(
      (RaidSnapshot snap) {
        emit(state.copyWith(raid: snap, status: BaseStateStatus.success));
      },
      onError: (Object error) {
        DebugLog.instance.e('Raid stream error: $error');
        emit(
          state.copyWith(
            status: BaseStateStatus.failure,
            msg: 'Lost connection to the raid roster.',
          ),
        );
      },
    );

    await _chatSub?.cancel();
    _chatSub = _chatService.watchChannel(channelId).listen(
      (List<ChatMessage> msgs) {
        emit(state.copyWith(messages: msgs));
      },
      onError: (Object error) {
        DebugLog.instance.e('Chat stream error: $error');
      },
    );
  }

  /// User tapped "Join Raid". Disables the button while in flight,
  /// shows a one-shot result via [AetherState.lastJoinSucceeded].
  Future<void> joinRaid() async {
    if (state.isJoining) {
      return;
    }
    emit(state.copyWith(isJoining: true, lastJoinSucceeded: null));
    final bool ok = await _raidService.joinRaid(userId: localUserId);
    emit(state.copyWith(isJoining: false, lastJoinSucceeded: ok));
  }

  /// Update the composer text without triggering chat-list rebuilds.
  void onComposerChanged(String value) {
    if (value == state.composer) {
      return;
    }
    emit(state.copyWith(composer: value));
  }

  /// Send the current composer body. No-op if blank.
  Future<void> sendMessage() async {
    final String body = state.composer.trim();
    if (body.isEmpty) {
      return;
    }
    emit(state.copyWith(composer: ''));
    try {
      await _chatService.postMessage(
        channelId: channelId,
        author: localUserId,
        body: body,
      );
    } on Exception catch (e) {
      // @AETHER: Don't escalate transient Firestore connectivity to .e;
      // it floods the log on every keystroke-send when the device is
      // offline. The UI shows a one-shot snackbar via state.msg.
      DebugLog.instance.w('Chat post failed: $e');
      emit(
        state.copyWith(
          composer: body,
          msg: 'Could not send. Check your connection.',
          status: BaseStateStatus.failure,
        ),
      );
    }
  }

  @override
  Future<void> close() async {
    await _raidSub?.cancel();
    await _chatSub?.cancel();
    return super.close();
  }

  @override
  AetherState getResetErrorState() =>
      state.copyWith(msg: '', status: BaseStateStatus.initial);

  @override
  AetherState getResetRedirectionState() => state.copyWith();
}
