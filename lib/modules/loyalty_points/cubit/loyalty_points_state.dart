import '../../../utils/exports.dart';

/// Immutable state representing the loyalty points screen.
class LoyaltyPointsState extends BaseState {
  /// Creates an instance of [LoyaltyPointsState].
  const LoyaltyPointsState({
    required super.status,
  });

  @override
  List<Object?> get props => <Object?>[
        super.props,
      ];

  /// Creates a copy of this [LoyaltyPointsState] with optional new values.
  LoyaltyPointsState copyWith({
    BaseStateStatus? status,
  }) {
    return LoyaltyPointsState(
      status: status ?? this.status,
    );
  }

  /// Creates an initial state instance.
  factory LoyaltyPointsState.initial() {
    return const LoyaltyPointsState(
      status: BaseStateStatus.initial,
    );
  }
}
