import '../../../utils/exports.dart';

/// A Cubit responsible for managing the splash screen logic,
/// such as triggering navigation after a delay and handling
/// initial app configuration tasks.
class SplashCubit extends Cubit<SplashState> {
  /// Creates a [SplashCubit] with the given [repository].
  ///
  /// Upon creation, it schedules [_showAfterDelay] to be called asynchronously
  /// after the initial state is emitted.
  SplashCubit({required this.repository})
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
        Locale locale = getLocale();
        emit(state.copyWith(
          languageAlignment: locale.languageCode == AppConstant.en
              ? AppConstant.defaultLanguageAlignment
              : AppConstant.rtlLanguageAlignment,
          languageCode: locale.languageCode,
          status: BaseStateStatus.success,
          redirectPath: AppPaths.taskManagement,
        ));
      },
    );
  }
}
