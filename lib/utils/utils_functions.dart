
import 'package:async/async.dart';

import 'exports.dart';

///this file helps to define all the common function

/// hide Keyboard
void hideKeyboard() {
  FocusManager.instance.primaryFocus?.unfocus();
}

//------------------------------------------
/// hide status bar
Future<void> showStatusBar() async {
  await SystemChrome.setEnabledSystemUIMode(
    SystemUiMode.manual,
    overlays: <SystemUiOverlay>[SystemUiOverlay.top, SystemUiOverlay.bottom],
  );
}
//------------------------------------------

/// show status bar
void hideStatusBar() {
  unawaited(SystemChrome.setEnabledSystemUIMode(SystemUiMode.leanBack));
}
//------------------------------------------

///go back
///
/// helps to go back to previous page
void goBack(BuildContext context, {dynamic result}) {
  unawaited(context.router.maybePop(result));
}

//-------------------------------------------

///loader view
///
/// [value] while value comes true then loader will be visible else hide
Future<void> showLoader({required bool value, String? message}) async {
  if (value) {
    // show loader here
    await EasyLoading.show(status: message);
  } else {
    await EasyLoading.dismiss();
    // hide loader here
  }
}

///perform async tasks using 'FutureGroup'
Future<void> performAsyncTask(
  List<dynamic> functionsList, {
  Function(List<dynamic>)? success,
}) async {
  FutureGroup<dynamic> futureGroup = FutureGroup<dynamic>();
  for (final dynamic function in functionsList) {
    futureGroup.add(function);
  }

  futureGroup.close();
  await futureGroup.future.then((List<dynamic> value) {
    success?.call(value);
  });
}

/// Checks if the device is small based on the height threshold
/// defined in [AppConstant.smallDeviceHeight].
bool isSmallDevice() =>
    !(MainConfig.context.height >= AppConstant.smallDeviceHeight);





/// Formats the given [date] string to match the pattern
/// in [AppConstant.dateFormatPattern].
String formatDate(String date) {
  DateTime parsedDate = DateFormat(AppConstant.dateFormatPattern).parse(date);
  return DateFormat(AppConstant.dateFormatPattern).format(parsedDate);
}

/// Returns the appropriate text alignment based on the current language direction.
///
/// For English (LTR): returns [TextAlign.start]
/// For Arabic (RTL): returns [TextAlign.end]
///
/// Usage:
/// ```dart
/// textAlign: getTextAlign(context),
/// ```
TextAlign getTextAlign(BuildContext context) {
  return context.isEnglishLanguage ? TextAlign.start : TextAlign.end;
}

// Method to get OrderStatus from a string
/// Returns the corresponding [OrderStatus] for a given [status]
/// string, or null if not found.
OrderStatus? getOrderStatus(String? status) {
  if (status == null) {
    return null; // Handle null case
  }

  return OrderStatus.values.firstWhere(
    (OrderStatus orderStatus) => orderStatus.status == status,
    orElse: () => OrderStatus.processing,
  );
}

/// Returns the discount percentage between [price] and [finalPrice],
/// or 0 if invalid.
int getDiscountedPrice(double? finalPrice, double? price) {
  if (finalPrice == null || price == null || price == 0) {
    return 0;
  }
  int percentOff = (100 - (finalPrice / price * 100)).toInt();
  return percentOff;
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



/// Replaces the suffix 'route' in [routeName] with a custom page identifier.
String replaceRouteSuffix(String? routeName) {
  if (routeName == null || routeName.isEmpty) {
    return AppConstant.pageNotFound; // Default fallback
  }

  // Check if the route name ends with 'route' (case insensitive)
  if (routeName.toLowerCase().endsWith('route')) {
    String trimmedRouteName = routeName.substring(0, routeName.length - 5);
    return '$trimmedRouteName${AppAnalyticsConstant.page}';
  }

  // Return the original route name if no match
  return routeName;
}

///calculate max date
DateTime calculateFirstDate() {
  DateTime today = DateTime.now();
  return DateTime(today.year - 125, today.month, today.day);
}
///createBoxShadowForTopBar
BoxShadow createBoxShadowForTopBar({
  Color color = const Color(0xFF000000), // Default black color
  double opacity = 0.1, // Default opacity
  Offset offset = const Offset(0, 2), // Default offset
  double blurRadius = 4.0, // Default blur radius
}) {
  return BoxShadow(
    color: color.withValues(alpha:opacity), // Apply color with opacity
    offset: offset, // Shadow offset
    blurRadius: blurRadius, // Blur radius
  );
}
///fadePageTransition
Widget fadePageTransition(
  BuildContext context,
  Animation<double> animation,
  Animation<double> secondaryAnimation,
  Widget child,
) {
  return FadeTransition(
    opacity: CurvedAnimation(
      parent: animation,
      curve: Curves.easeInOutQuad, // Smoothest curve
    ),
    child: child,
  );
}



/// Creates a spannable text widget that allows multiple segments of text to be styled differently.
///
/// This method is useful for displaying text with different styles (e.g., bold, italic, color)
/// in a single `Text` widget, where each segment of text can be customized separately.
/// Returns a [RichText] widget that displays the formatted text.
Widget createSpannableText({
  required String content,
  required List<String> boldPhrases,
  required BuildContext context,
  TextStyle? defaultTextStyle,
  TextStyle? boldTextStyle,
})
{
  List<TextSpan> spans = <TextSpan>[];

  // Split the content into words
  List<String> words = content.split(' ');

  for (final String word in words) {
    if (boldPhrases.contains(word)) {
      spans.add(
        TextSpan(
          text: '$word ',
          style: boldTextStyle ??
              context.textTheme.headlineMedium?.copyWith(
                color: MainConfig.appColors.textWhiteColor,
                fontSize: Dimens.size14,
                height: Dimens.lineHeight16.toLineHeight(Dimens.fontSize14),
                fontWeight: FontWeight.bold,
              ),
        ),
      );
    } else {
      spans.add(
        TextSpan(
          text: '$word ',
          style: defaultTextStyle ??
              context.textTheme.headlineMedium?.copyWith(
                color: MainConfig.appColors.textWhiteColor,
                fontSize: Dimens.fontSize12,
                height: Dimens.lineHeight16.toLineHeight(Dimens.fontSize12),
                fontWeight: FontWeight.w600,
              ),
        ),
      );
    }
  }

  return Text.rich(
    textScaler: TextScaler.noScaling,
    TextSpan(children: spans),
  );
}
///getFileType
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



///logCrashlyticsError
Future<void> logCrashlyticsError(
    dynamic exception,
    StackTrace? stackTrace, {
      bool fatal = false,
    }) async {
  if (Firebase.apps.isNotEmpty) {
    // Firebase is initialized, use Firebase Crashlytics
    try {
      if (stackTrace != null) {
        // Log with stack trace
        await FirebaseCrashlytics.instance.recordError(
          exception,
          stackTrace,
          fatal: fatal,
        );
      } else {
        // Log without stack trace
        await FirebaseCrashlytics.instance.recordFlutterFatalError(
          FlutterErrorDetails(exception: exception),
        );
      }
    } on Exception catch (e) {
      // If Firebase Crashlytics fails, fall back to debug logging
      if (kDebugMode) {
        print('Firebase Crashlytics error: $e');
      }
    }
  } else {
    // Firebase not initialized, use debug logging
    if (kDebugMode) {
      print('Firebase not initialized, logging error: $exception');
      if (stackTrace != null) {
        print('Stack trace: $stackTrace');
      }
    }
  }
}

