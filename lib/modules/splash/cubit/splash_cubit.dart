import '../../../utils/exports.dart';

/// A Cubit responsible for managing the splash screen logic,
/// such as triggering navigation after a delay and handling
/// initial app configuration tasks.
class SplashCubit extends Cubit<SplashState> {

  ///
  /// Upon creation, it schedules [_showAfterDelay] to be called asynchronously
  /// after the initial state is emitted.
  SplashCubit()
      : super(const SplashState(status: BaseStateStatus.initial)) {
    //_fetchRemoteConfig();
    scheduleMicrotask(
      () async => _showAfterDelay(),
    );
  }



  // navigate to language screen
  Future<void> _showAfterDelay() async {
    // First check if user is already logged in
    bool isLoggedIn = SharedPref.instance.getBool(
      PrefsKey.isLoggedInKey,
      defValue: false,
    );

    DebugLog.instance.d('Calling _fetchLanguageData()');
    // Load existing LanguageService data from SharedPreferences
    await SharedPref.instance.loadAndStoreLanguageService();



    if (isLoggedIn) {
      // User is logged in, go directly to dashboard
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
            redirectPath: AppPaths.dashboard,
          ));
        },
      );
      return;
    }
    

    // Introduce a delay of 3 seconds
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
          redirectPath: AppPaths.dashboard,
        ));
      },
    );
  }

}
