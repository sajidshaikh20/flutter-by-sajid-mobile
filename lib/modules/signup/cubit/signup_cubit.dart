import '../../../utils/exports.dart';

/// Cubit for sign up multi-step flow.
class SignUpCubit extends Cubit<SignUpState> {
  /// Creates [SignUpCubit].
  SignUpCubit({required SignUpState initialState}) : super(initialState);

  /// Updates the active step index.
  void setStep(int step) {
    if (step < 0 || step >= state.totalSteps) {
      return;
    }
    emit(state.copyWith(currentStep: step, status: BaseStateStatus.initial));
  }

  /// Moves to the next step when available.
  void nextStep() {
    if (state.currentStep < state.totalSteps - 1) {
      emit(state.copyWith(currentStep: state.currentStep + 1));
    }
  }

  /// Moves to the previous step when available.
  void previousStep() {
    if (state.currentStep > 0) {
      emit(state.copyWith(currentStep: state.currentStep - 1));
    }
  }

  bool get canGoNext => state.currentStep < state.totalSteps - 1;

  bool get canGoPrevious => state.currentStep > 0;

  bool get isLastStep => state.currentStep == state.totalSteps - 1;
}
