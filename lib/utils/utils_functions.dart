
import 'exports.dart';

/// Common utility functions used across the app.

/// Hide keyboard
void hideKeyboard() {
  FocusManager.instance.primaryFocus?.unfocus();
}

/// Hide status bar
Future<void> showStatusBar() async {
  await SystemChrome.setEnabledSystemUIMode(
    SystemUiMode.manual,
    overlays: <SystemUiOverlay>[SystemUiOverlay.top, SystemUiOverlay.bottom],
  );
}

/// Show status bar
void hideStatusBar() {
  unawaited(SystemChrome.setEnabledSystemUIMode(SystemUiMode.leanBack));
}

/// Go back to previous page
void goBack(BuildContext context, {dynamic result}) {
  unawaited(context.router.maybePop(result));
}

/// Show or hide loader. When [value] is true the loader is visible.
Future<void> showLoader({required bool value, String? message}) async {
  if (value) {
    await EasyLoading.show(status: message);
  } else {
    await EasyLoading.dismiss();
  }
}

/// Returns true if the language is aligned from left to right (LTR).
bool get isLanguageAlignmentLTR => SharedPref.instance.getBool(
      PrefsKey.isEnglishLanguageLoadedKey,
      defValue: true,
    );

/// Checks if the given [text] is written in a right-to-left (RTL) language.
bool isRTLText(String text) {
  RegExp rtlRegex = RegExp(
    r'[\u0590-\u05FF\u0600-\u06FF\u0700-\u074F\u07C0-\u07FF\u0750-\u077F\u08A0-\u08FF]',
  );
  return rtlRegex.hasMatch(text);
}

/// Adds bidirectional markers to [text] based on [isRTL] flag (default is LTR).
String formatMixedLanguageText(String text, {bool? isRTL}) {
  const String ltrMarker = '\u202A';
  const String rtlMarker = '\u202B';
  const String popMarker = '\u202C';
  if (isRTL ?? false) {
    return '$rtlMarker$text$popMarker';
  } else {
    return '$ltrMarker$text$popMarker';
  }
}




/// Fade page transition for route animations
Widget fadePageTransition(
  BuildContext context,
  Animation<double> animation,
  Animation<double> secondaryAnimation,
  Widget child,
) {
  return FadeTransition(
    opacity: CurvedAnimation(
      parent: animation,
      curve: Curves.easeInOutQuad,
    ),
    child: child,
  );
}

/// Returns [FileType] for the given file name based on extension.
FileType getFileType(String fileName) {
  String extension = fileName.split('.').last.toLowerCase();
  if (AppConstant.imageExtensions.contains(extension)) {
    return FileType.image;
  } else if (AppConstant.jsonExtensions.contains(extension)) {
    return FileType.jsonFile;
  } else {
    return FileType.unknown;
  }
}

/// Log error to Crashlytics when available
Future<void> logCrashlyticsError(
  dynamic exception,
  StackTrace? stackTrace, {
  bool fatal = false,
}) async {
  if (Firebase.apps.isNotEmpty) {
    try {
      if (stackTrace != null) {
        await FirebaseCrashlytics.instance.recordError(
          exception,
          stackTrace,
          fatal: fatal,
        );
      } else {
        await FirebaseCrashlytics.instance.recordFlutterFatalError(
          FlutterErrorDetails(exception: exception),
        );
      }
    } on Exception catch (e) {
      if (kDebugMode) {
        print('Firebase Crashlytics error: $e');
      }
    }
  } else {
    if (kDebugMode) {
      print('Firebase not initialized, logging error: $exception');
      if (stackTrace != null) {
        print('Stack trace: $stackTrace');
      }
    }
  }
}
