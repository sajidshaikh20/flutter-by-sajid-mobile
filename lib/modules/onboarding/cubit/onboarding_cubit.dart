import '../../../utils/exports.dart';

/// Cubit responsible for managing the state and logic of the onboarding flow.
class OnboardingCubit extends Cubit<OnboardingState> {
  /// Creates the onboarding cubit.
  OnboardingCubit()
      : super(const OnboardingState(status: BaseStateStatus.initial));

  /// Updates the current page index.
  void updatePage(int page) {
    emit(state.copyWith(currentPage: page));
  }

  /// Marks onboarding as complete, saves settings, and triggers redirection.
  Future<void> completeOnboarding() async {
    await SharedPref.instance.setValue(PrefsKey.onboardingSeenKey, true);
    emit(state.copyWith(
      status: BaseStateStatus.success,
      hasCompleted: true,
      redirectRoute: const SocialLoginRoute(),
    ));
  }

  /// Animates to the next onboarding page or completes onboarding.
  Future<void> nextPage(PageController pageController) async {
    if (state.currentPage < 3) {
      await pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      await completeOnboarding();
    }
  }
}
