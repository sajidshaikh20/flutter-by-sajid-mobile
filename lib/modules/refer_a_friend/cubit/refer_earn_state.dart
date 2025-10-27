import '../../../utils/exports.dart';

/// Immutable state representing the refer and earn screen.
class ReferEarnState extends BaseState {
  /// Creates a new instance of [ReferEarnState].
  const ReferEarnState({
    required super.status,
    super.msg,
    this.referCode,
    this.signUps,
    this.ordered,
  });

  /// The referral code for sharing.
  final String? referCode;

  /// The number of sign-ups from referrals.
  final String? signUps;

  /// The number of orders from referrals.
  final String? ordered;

  @override
  List<Object?> get props => <Object?>[super.props];

  /// Creates a copy of this [ReferEarnState] with optional new values.
  ReferEarnState copyWith({
    BaseStateStatus? status,
    String? referCode,
    String? errorMessage,
  }) {
    return ReferEarnState(
      status: status ?? this.status,
      referCode: referCode ?? this.referCode,
      msg: errorMessage ?? msg,
    );
  }
}
