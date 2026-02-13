import '../../../utils/exports.dart';

/// Cubit for the splash screen. Navigates to main after delay.
class SplashCubit extends Cubit<SplashState> {
  /// Creates a [SplashCubit].
  SplashCubit() : super(const SplashState()) {
    unawaited(_navigateAfterDelay());
  }

  Future<void> _navigateAfterDelay() async {
    await Future<void>.delayed(
      const Duration(seconds: Dimens.seconds3),
    );
    emit(state.copyWith(redirectPath: AppPaths.main));
  }
}
