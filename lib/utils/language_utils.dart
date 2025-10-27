import 'exports.dart';

/// Utility class for common language alignment operations
class LanguageUtils {
  /// Private constructor to prevent instantiation
  LanguageUtils._();

  /// Get language alignment based on language code
  ///
  /// Returns [AppConstant.defaultLanguageAlignment] for English (LTR)
  /// Returns [AppConstant.rtlLanguageAlignment] for Arabic (RTL)
  static String getLanguageAlignment(String languageCode) {
    return languageCode == AppConstant.en
        ? AppConstant.defaultLanguageAlignment
        : AppConstant.rtlLanguageAlignment;
  }

  /// Get language alignment based on current locale
  ///
  /// Uses [getLocale()] to get current language code
  static String getCurrentLanguageAlignment() {
    final Locale locale = getLocale();
    return getLanguageAlignment(locale.languageCode);
  }

  /// Get current language code from locale
  static String getCurrentLanguageCode() {
    final Locale locale = getLocale();
    return locale.languageCode;
  }

  /// Check if current language is English
  static bool isEnglishLanguage() {
    return getCurrentLanguageCode() == AppConstant.en;
  }

  /// Check if current language is Arabic (RTL)
  static bool isArabicLanguage() {
    return getCurrentLanguageCode() == AppConstant.ar;
  }

  /// Check if current language alignment is LTR
  static bool isLTRLanguage() {
    return getCurrentLanguageAlignment() == AppConstant.defaultLanguageAlignment;
  }

  /// Check if current language alignment is RTL
  static bool isRTLanguage() {
    return getCurrentLanguageAlignment() == AppConstant.rtlLanguageAlignment;
  }

  /// Get locale from the current context or system
  static Locale getLocale() {
    // This should be implemented based on your app's locale management
    // For now, returning a default locale
    return const Locale(AppConstant.en);
  }
}





