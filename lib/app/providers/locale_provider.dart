import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../utils/exports.dart' hide ChangeLocaleState;
import '../../modules/localization/state/locale_state.dart';

/// Notifier for managing app locale and language settings (Riverpod version).
class LocaleNotifier extends StateNotifier<ChangeLocaleState> {
  /// Creates a [LocaleNotifier] instance.
  LocaleNotifier()
      : super(ChangeLocaleState(
          locale: const Locale(AppConstant.en),
          languageAlignment: AppConstant.defaultLanguageAlignment,
        ));

  /// Changes the language of the app.
  ///
  /// [languageCode] is the two-letter code of the language (e.g., 'en', 'ar').
  /// [languageAlignment] is the alignment of the language (e.g., 'ltr', 'rtl').
  /// This method also saves the selected language code to shared preferences.
  Future<void> changeLanguage(String languageCode, String languageAlignment) async {
    await setLocale(languageCode);
    state = ChangeLocaleState(
      locale: Locale(languageCode),
      languageAlignment: languageAlignment,
    );
  }

  /// Changes the language of the app on initialization.
  ///
  /// [languageCode] is the two-letter code of the language (e.g., 'en', 'ar').
  /// [languageAlignment] is the alignment of the language (e.g., 'ltr', 'rtl').
  /// This method is intended to be used when the app is first launched to set the initial language.
  Future<void> changeLanguageOnInit(String languageCode, String languageAlignment) async {
    state = ChangeLocaleState(
      locale: Locale(languageCode),
      languageAlignment: languageAlignment,
    );
  }

  /// Gets the current locale based on the layout direction.
  ///
  /// [isLtr] is a boolean indicating whether the layout direction is left-to-right.
  ///
  /// Returns a [Locale] object representing the current locale.
  Locale getLocaleFun({required bool isLtr}) {
    /// if isLtr true will return English locale
    /// otherwise will return Arabic locale
    return isLtr
        ? const Locale(AppConstant.en, '')
        : const Locale(AppConstant.ar, '');
  }
}

/// Provider for LocaleNotifier.
final StateNotifierProvider<LocaleNotifier, ChangeLocaleState> localeNotifierProvider =
    StateNotifierProvider<LocaleNotifier, ChangeLocaleState>((StateNotifierProviderRef<LocaleNotifier, ChangeLocaleState> ref) {
  return LocaleNotifier();
});

