import 'exports.dart';


/// An extension on [BuildContext] that provides convenient shortcuts
/// for accessing commonly used Flutter properties and methods.
///
/// Example:
/// ```dart
/// context.theme; // Access ThemeData
/// context.textTheme; // Access TextTheme
/// context.appString; // Access localized strings
/// context.scaffoldMessenger.showSnackBar(...); // Show snackbar
/// context.width; // Screen width
/// context.height; // Screen height
/// context.instance<MyCubit>(); // Access a Bloc/Cubit instance
/// context.isEnglishLanguage; // Check if current language is LTR (English)
/// ```
extension CustomExtension on BuildContext {
  /// Returns the current [ThemeData] for the context.
  ThemeData get theme => Theme.of(this);

  /// Returns the current [TextTheme] for the context.
  TextTheme get textTheme => Theme.of(this).textTheme;

  /// Returns the current localized strings from [AppString].
  AppString get appString => AppString.of(this);

  /// Returns the [ScaffoldMessengerState] for showing snackbars and material banners.
  ScaffoldMessengerState get scaffoldMessenger => ScaffoldMessenger.of(this);

  /// Returns the screen width for the current context.
  double get width => MediaQuery.of(this).size.width;

  /// Returns the screen height for the current context.
  double get height => MediaQuery.of(this).size.height;

  /// Reads an instance of type [T] from the context.
  ///
  /// Example: `context.instance<MyCubit>()`
  T instance<T>() => read<T>();

  /// Returns `true` if the current text direction is left-to-right (LTR),
  /// which is typically used for English and other LTR languages.
  bool get isEnglishLanguage => Directionality.of(this) == TextDirection.ltr;
}
