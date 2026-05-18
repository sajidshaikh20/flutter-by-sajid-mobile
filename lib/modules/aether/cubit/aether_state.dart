import '../../../utils/exports.dart';

/// State for the Aether single-screen experience.
///
/// `worldPulse` is intentionally NOT held here — the 100 ms ticker
/// drives a dedicated [ValueNotifier] so the cubit doesn't emit ten
/// times per second and trigger global rebuilds.
class AetherState extends BaseState {
  /// Creates the Aether state.
  const AetherState({
    super.status = BaseStateStatus.initial,
    super.msg = '',
    super.redirectRoute,
    this.raid,
    this.lastJoinSucceeded,
    this.isJoining = false,
    this.messages = const <ChatMessage>[],
    this.composer = '',
  });

  /// Initial empty state.
  factory AetherState.initial() => const AetherState();

  /// Current raid roster snapshot (null until the first stream emit).
  final RaidSnapshot? raid;

  /// Result of the most recent join attempt — drives the snackbar.
  final bool? lastJoinSucceeded;

  /// `true` while a join request is in-flight (disables the button).
  final bool isJoining;

  /// Live tail of chat messages (most recent first).
  final List<ChatMessage> messages;

  /// Current composer text (kept in state so chat scroll-position
  /// rebuilds don't lose what the user typed).
  final String composer;

  /// Returns a copy of this state with the given fields replaced.
  AetherState copyWith({
    BaseStateStatus? status,
    String? msg,
    PageRouteInfo? redirectRoute,
    RaidSnapshot? raid,
    bool? lastJoinSucceeded,
    bool? isJoining,
    List<ChatMessage>? messages,
    String? composer,
  }) =>
      AetherState(
        status: status ?? this.status,
        msg: msg ?? this.msg,
        redirectRoute: redirectRoute ?? this.redirectRoute,
        raid: raid ?? this.raid,
        lastJoinSucceeded: lastJoinSucceeded ?? this.lastJoinSucceeded,
        isJoining: isJoining ?? this.isJoining,
        messages: messages ?? this.messages,
        composer: composer ?? this.composer,
      );

  @override
  List<Object?> get props => <Object?>[
        status,
        msg,
        redirectRoute,
        raid,
        lastJoinSucceeded,
        isJoining,
        messages,
        composer,
      ];
}
