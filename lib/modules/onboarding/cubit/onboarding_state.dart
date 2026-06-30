import '../../../utils/exports.dart';

/// Immutable state for the onboarding screen.
class OnboardingState extends BaseState {
  /// Creates an [OnboardingState].
  const OnboardingState({
    required super.status,
    this.currentPage = 0,
    this.hasCompleted = false,
    super.redirectRoute,
    super.msg,
  });

  /// The active onboarding page index.
  final int currentPage;

  /// Whether the onboarding has been completed.
  final bool hasCompleted;

  /// Returns a copy with updated fields.
  OnboardingState copyWith({
    BaseStateStatus? status,
    int? currentPage,
    bool? hasCompleted,
    PageRouteInfo? redirectRoute,
    String? msg,
  }) {
    return OnboardingState(
      status: status ?? this.status,
      currentPage: currentPage ?? this.currentPage,
      hasCompleted: hasCompleted ?? this.hasCompleted,
      redirectRoute: redirectRoute ?? this.redirectRoute,
      msg: msg ?? this.msg,
    );
  }

  @override
  List<Object?> get props => <Object?>[
        ...super.props,
        currentPage,
        hasCompleted,
      ];
}
