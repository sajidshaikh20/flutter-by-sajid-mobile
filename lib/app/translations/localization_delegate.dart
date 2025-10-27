import '../../utils/exports.dart';

/// A [LocalizationsDelegate] implementation for loading localized string
/// resources used in the application.
///
/// This delegate determines whether a given [Locale] is supported, and
/// loads the corresponding [AppString] subclass for that language.
///
/// Supported languages:
/// - English (`AppConstant.en`)
/// - Arabic (`AppConstant.ar`)
///
/// Example usage:
/// ```dart
/// MaterialApp(
///   localizationsDelegates: [
///     AppLocalizationsDelegate(),
///     GlobalMaterialLocalizations.delegate,
///     GlobalWidgetsLocalizations.delegate,
///   ],
///   supportedLocales: [
///     Locale(AppConstant.en),
///     Locale(AppConstant.ar),
///   ],
/// );
/// ```
///
/// Methods:
/// - [isSupported]: Checks if the given [Locale] is in the supported language list.
/// - [load]: Returns the appropriate [AppString] subclass based on the locale.
/// - [shouldReload]: Always returns `false` since the localization data
///   does not need to be reloaded during runtime.
class AppLocalizationsDelegate extends LocalizationsDelegate<AppString> {
  @override
  bool isSupported(Locale locale) => <String>[
        AppConstant.en,
        AppConstant.ar
      ].contains(locale.languageCode);

  @override
  Future<AppString> load(Locale locale) async {
    switch (locale.languageCode) {
      case AppConstant.en:
        return EnUS();
      case AppConstant.ar:
        return ArDu();
      default:
        return EnUS();
    }
  }

  @override
  bool shouldReload(covariant LocalizationsDelegate<AppString> old) => false;
}
