import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../utils/exports.dart';
import '../state/splash_state.dart';

/// Notifier for managing splash screen logic (Riverpod version).
class SplashNotifier extends StateNotifier<SplashState> {
  /// Creates a [SplashNotifier] with the given [repository].
  ///
  /// Upon creation, it schedules [_showAfterDelay] to be called asynchronously
  /// after the initial state is emitted.
  SplashNotifier({required this.repository})
      : super(const SplashState(status: BaseStateStatus.initial)) {
    //_fetchRemoteConfig();
    scheduleMicrotask(
      () async => _showAfterDelay(),
    );
  }

  /// The [LanguageSelectionRepository] used for fetching language data
  /// and related configurations during splash screen initialization.
  final LanguageSelectionRepository repository;

  // navigate to task management module
  Future<void> _showAfterDelay() async {
    DebugLog.instance.d('Loading existing data from SharedPreferences');
    // Load existing LanguageService data from SharedPreferences
    await SharedPref.instance.loadAndStoreLanguageService();

    // Load existing UserProfileService data from SharedPreferences
    await SharedPref.instance.loadAndStoreUserProfileService();

    // Navigate to task management module after splash delay
    await Future<void>.delayed(
      const Duration(seconds: Dimens.seconds3),
      () {
        final Locale locale = getLocale();
        state = state.copyWith(
          languageAlignment: locale.languageCode == AppConstant.en
              ? AppConstant.defaultLanguageAlignment
              : AppConstant.rtlLanguageAlignment,
          languageCode: locale.languageCode,
          status: BaseStateStatus.success,
          redirectPath: AppPaths.taskManagement,
        );
      },
    );
  }
}

/// Provider for LanguageSelectionRepository (for splash).
final Provider<LanguageSelectionRepository> splashLanguageSelectionRepositoryProvider =
    Provider<LanguageSelectionRepository>((ProviderRef<LanguageSelectionRepository> ref) {
  return LanguageSelectionRepositoryImpl();
});

/// Provider for SplashNotifier.
final StateNotifierProvider<SplashNotifier, SplashState> splashNotifierProvider =
    StateNotifierProvider<SplashNotifier, SplashState>((StateNotifierProviderRef<SplashNotifier, SplashState> ref) {
  final LanguageSelectionRepository repository = ref.watch(splashLanguageSelectionRepositoryProvider);
  return SplashNotifier(repository: repository);
});

