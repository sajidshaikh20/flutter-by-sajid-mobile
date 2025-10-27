import '../../utils/exports.dart';

/// Sets the application's locale to the specified
/// [languageCode] and stores it in shared preferences.
Future<Locale> setLocale(String languageCode) async {
  await SharedPref.instance.setValue(PrefsKey.currentLocaleKey, languageCode);
  return _locale(languageCode);
}

/// Retrieves the application's current locale from shared preferences,
/// defaulting to English if not set.
Locale getLocale() {
  String languageCode = SharedPref.instance.getString(PrefsKey.currentLocaleKey, AppConstant.en);
  return _locale(languageCode);
}

/// Helper function to return a [Locale] based on the [languageCode],
/// defaulting to English if empty.
Locale _locale(String languageCode) => languageCode.isNotEmpty
    ? Locale(languageCode, '')
    : const Locale(AppConstant.en, '');
