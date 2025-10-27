
import 'dart:ui';

/// Represents the state for a change in application locale.
///
/// Contains the new locale and the text alignment corresponding
/// to the selected language.
class ChangeLocaleState {
  /// The new locale of the application.
  final Locale locale;

  /// The text alignment for the selected language.
  ///
  /// Example values: "ltr" for left-to-right, "rtl" for right-to-left.
  final String languageAlignment;

  /// Creates a [ChangeLocaleState] with the given [locale] and [languageAlignment].
  ChangeLocaleState({
    required this.locale,
    required this.languageAlignment,
  });
}
