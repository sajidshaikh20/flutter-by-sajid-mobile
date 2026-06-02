import '../../../utils/exports.dart';

/// Total steps in the sign up flow.
const int signUpTotalSteps = 3;

/// State for the sign up screen.
class SignUpState extends BaseState {
  /// Creates [SignUpState].
  const SignUpState({
    required super.status,
    this.currentStep = 0,
    this.totalSteps = signUpTotalSteps,
    super.msg = '',
    super.redirectRoute,
  });

  /// Active step index (0: basic info, 1: verification, 2: complete profile).
  final int currentStep;

  /// Total number of sign up steps.
  final int totalSteps;

  @override
  List<Object?> get props => <Object?>[
    currentStep,
    totalSteps,
    ...super.props,
  ];

  /// Returns a copy with updated fields.
  SignUpState copyWith({
    BaseStateStatus? status,
    String? msg,
    PageRouteInfo? redirectRoute,
    int? currentStep,
    int? totalSteps,
  }) {
    return SignUpState(
      status: status ?? this.status,
      currentStep: currentStep ?? this.currentStep,
      totalSteps: totalSteps ?? this.totalSteps,
      msg: msg ?? this.msg,
      redirectRoute: redirectRoute ?? this.redirectRoute,
    );
  }
}
