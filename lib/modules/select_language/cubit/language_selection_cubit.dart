import '../../../utils/exports.dart';

/// Cubit responsible for managing the state of the language selection screen.
class LanguageSelectionCubit extends Cubit<LanguageSelectionState> {
  /// Constructor for [LanguageSelectionCubit].
  ///
  /// [repository] is the repository for language selection.
  /// Initializes the state and schedules a microtask to initialize the cubit.
  LanguageSelectionCubit({
    required this.repository,
  }) : super(LanguageSelectionState.initial()) {
    scheduleMicrotask(
          () async => _init(),
    );
  }

  /// The repository used for language selection operations.
  final LanguageSelectionRepository repository;

  /// Initializes the cubit by setting the initial language code.
  Future<void> _init() async {
    Locale locale=getLocale();
    emit(state.copyWith(languageCode: locale.languageCode, ));
  }

  /// Navigates to the login screen after setting the selected language.
  ///
  /// [languageCode] is the selected language code.
  /// Emits a loading state, then updates the shared preferences and emits a success state with the redirect route.
  FutureOr<void> navigateToLoginScreen(LanguageCode languageCode) async {
    emit(state.copyWith(status: BaseStateStatus.loading));
    
    try {
      // Get the language list from LanguageService
      List<LanguageList> languageList = await getIt<LanguageService>().getLanguageList();
      
      // Find the selected language by language code
      LanguageList? selectedLanguage;
      if (languageCode == LanguageCode.en) {
        selectedLanguage = languageList.firstWhereOrNull(
          (LanguageList lang) => lang.languageSortCode == 'en',
        );
      } else if (languageCode == LanguageCode.ar) {
        selectedLanguage = languageList.firstWhereOrNull(
          (LanguageList lang) => lang.languageSortCode == 'ar',
        );
      }
      
      // Store the selected language model in LanguageService
      if (selectedLanguage != null) {
        await getIt<LanguageService>().storeSelectedLanguage(selectedLanguage);
      }
      
      await Future.wait(<Future<void>>[
        SharedPref.instance.setValue(PrefsKey.isCountryAndLanguageSelectedKey, true),
        SharedPref.instance.setValue(PrefsKey.isEnglishLanguageLoadedKey, languageCode==LanguageCode.en)
      ]).then((_) {
        emit(state.copyWith(
          languageCode: languageCode.code,
          languageAlignment: languageCode==LanguageCode.en ?
              AppConstant.defaultLanguageAlignment : AppConstant.rtlLanguageAlignment,
          status: BaseStateStatus.success,
          redirectRoute: LoginRoute(),
        ));
      });
    } on Exception catch (e) {
      DebugLog.instance.e('Error storing selected language: $e');
      // Continue with the flow even if language storage fails
      await Future.wait(<Future<void>>[
        SharedPref.instance.setValue(PrefsKey.isCountryAndLanguageSelectedKey, true),
        SharedPref.instance.setValue(PrefsKey.isEnglishLanguageLoadedKey, languageCode==LanguageCode.en)
      ]).then((_) {
        emit(state.copyWith(
          languageCode: languageCode.code,
          languageAlignment: languageCode==LanguageCode.en ?
              AppConstant.defaultLanguageAlignment : AppConstant.rtlLanguageAlignment,
          status: BaseStateStatus.success,
          redirectRoute: LoginRoute(),
        ));
      });
    }
  }



}
