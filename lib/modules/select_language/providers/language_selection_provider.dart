import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../utils/exports.dart';
import '../state/language_selection_state.dart';
import '../repository/language_selection_repository.dart';

/// Notifier for managing language selection state (Riverpod version).
class LanguageSelectionNotifier extends StateNotifier<LanguageSelectionState> {
  /// Creates a language selection notifier.
  LanguageSelectionNotifier({
    required this.repository,
  }) : super(LanguageSelectionState.initial()) {
    scheduleMicrotask(() async => _init());
  }

  /// The repository used for language selection operations.
  final LanguageSelectionRepository repository;

  /// Initializes the notifier by setting the initial language code.
  Future<void> _init() async {
    final Locale locale = getLocale();
    state = state.copyWith(languageCode: locale.languageCode);
  }

  /// Navigates to the login screen after setting the selected language.
  FutureOr<void> navigateToLoginScreen(LanguageCode languageCode) async {
    state = state.copyWith(status: BaseStateStatus.loading);
    
    try {
      final List<LanguageList> languageList = await getIt<LanguageService>().getLanguageList();
      
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
      
      if (selectedLanguage != null) {
        await getIt<LanguageService>().storeSelectedLanguage(selectedLanguage);
      }
      
      await Future.wait(<Future<void>>[
        SharedPref.instance.setValue(PrefsKey.isCountryAndLanguageSelectedKey, true),
        SharedPref.instance.setValue(PrefsKey.isEnglishLanguageLoadedKey, languageCode==LanguageCode.en)
      ]).then((_) {
        state = state.copyWith(
          languageCode: languageCode.code,
          languageAlignment: languageCode==LanguageCode.en ?
              AppConstant.defaultLanguageAlignment : AppConstant.rtlLanguageAlignment,
          status: BaseStateStatus.success,
          redirectRoute: const SocialLoginRoute(),
        );
      });
    } on Exception catch (e) {
      DebugLog.instance.e('Error storing selected language: $e');
      await Future.wait(<Future<void>>[
        SharedPref.instance.setValue(PrefsKey.isCountryAndLanguageSelectedKey, true),
        SharedPref.instance.setValue(PrefsKey.isEnglishLanguageLoadedKey, languageCode==LanguageCode.en)
      ]).then((_) {
        state = state.copyWith(
          languageCode: languageCode.code,
          languageAlignment: languageCode==LanguageCode.en ?
              AppConstant.defaultLanguageAlignment : AppConstant.rtlLanguageAlignment,
          status: BaseStateStatus.success,
          redirectRoute: const SocialLoginRoute(),
        );
      });
    }
  }
}

/// Provider for LanguageSelectionRepository.
final Provider<LanguageSelectionRepository> languageSelectionRepositoryProvider =
    Provider<LanguageSelectionRepository>((Ref ref) {
  return LanguageSelectionRepositoryImpl();
});

/// Provider for LanguageSelectionNotifier.
final AutoDisposeStateNotifierProvider<LanguageSelectionNotifier, LanguageSelectionState> languageSelectionNotifierProvider =
    StateNotifierProvider.autoDispose<LanguageSelectionNotifier, LanguageSelectionState>(
  (AutoDisposeStateNotifierProviderRef<LanguageSelectionNotifier, LanguageSelectionState> ref) {
    final LanguageSelectionRepository repository = ref.watch(languageSelectionRepositoryProvider);
    return LanguageSelectionNotifier(repository: repository);
  },
);

