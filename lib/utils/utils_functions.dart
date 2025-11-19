
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
String formatMixedLanguageText(String text, {bool? isRTL}) {
  // Add bidirectional markers
  const String ltrMarker = '\u202A';
  const String rtlMarker = '\u202B';
  const String popMarker = '\u202C';
  if (isRTL ?? false) {
    return '$rtlMarker$text$popMarker';
  } else {
    return '$ltrMarker$text$popMarker';
  }
}

bool _isNavigating = false;

/// Handles redirection based on [type] and optional [data], navigating to
/// appropriate pages while preventing duplicate navigation
void handleRedirection({
  required String type,
  Map<String, dynamic>? data,
}) {
  if (_isNavigating) {
    return; // Prevent duplicate navigation
  }
  _isNavigating = true;
  AppRouter router = getIt<AppRouter>();
  bool isInitialRoute = router.pageCount == 0;

  switch (type) {
    case AppConstant.promotion:
      if(data?['entity']== '0'){
        if (isInitialRoute) {
          unawaited(router.pushAll(<PageRouteInfo>[const DashboardRoute()]));
        } else {
          unawaited(router.push(const DashboardRoute()));
        }
      }else{
        int productId = int.tryParse(data?['entity'] ?? '') ?? 0;
        if (isInitialRoute) {
          unawaited(router.pushAll(<PageRouteInfo>[
            const DashboardRoute(),

          ]));
        } else {
          //unawaited(router.push(ProductDetailsRoute(entityId: productId)));
        }
      }


    case AppConstant.order:
      String? orderId = data?['entity'] ?? '0';
      if (isInitialRoute) {
        unawaited(router.pushAll(<PageRouteInfo>[
          const DashboardRoute(),
         // MyOrderDetailRoute(orderId: int.tryParse(orderId ?? '')),
        ]));
      } else {
        //unawaited(router.push(MyOrderDetailRoute(orderId: int.tryParse(orderId ?? ''))));
      }

    default:
      if (isInitialRoute) {
        unawaited(router.pushAll(<PageRouteInfo>[const DashboardRoute()]));
      } else {
        unawaited(router.push(const DashboardRoute()));
      }
  }
  // Reset flag after navigation completes
  unawaited(Future<void>.delayed(const Duration(milliseconds: 500), () {
    _isNavigating = false;
  }));
}

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

/// Calculates the height of the screen
/// excluding the status bar, toolbar, tab bar,
/// and an additional offset.
double calculateHeightWithoutStatusBar(
  BuildContext context, {
  required bool isTabBarDimensRequired,
}) {
  const double toolbarHeight = kToolbarHeight; // Default height for AppBar
  double sizeOfTabBar = isTabBarDimensRequired
      ? Dimens.size50
      : Dimens.zero; // Height of the TabBar
  double screenHeight = context.height; // Total screen height
  double statusBarHeight =
      MediaQuery.of(context).padding.top; // Height of the status bar
  const double additionalOffset = 100.0; // Any additional spacing or offset

  // Calculate and return the height
  //excluding specified components
  return screenHeight -
      statusBarHeight -
      toolbarHeight -
      sizeOfTabBar -
      additionalOffset;
}

/// Displays a success dialog with a [message], and redirects to [redirectRoute]
/// when the OK button is clicked.
void showSuccessDialog({
  required String message,
  required BuildContext context,
  required PageRouteInfo redirectRoute,
  required ScreenType device,
}) {
  showCustomDialog(
    message,
    barrierDismissible: false,
    title: "Base app",
    okBtnTitle: context.appString.okayKey,
    isDialogHideOnClick: true,
    onOkClicked: () async {
      // context.read<CartPageCubit>().
      //callCartScreenApi(false, -1,isFreeGift: false);
      await context.router.push(redirectRoute);
    },
    device: device,
  );
}

/// Navigates to the specified tab [index] by popping all routes and setting
/// the active tab in the TabRouter.
void navigateToTab(BuildContext context, int index) {
  context.router.popUntilRoot();

  BuildContext? tabsRouterContext = getIt<TabRouterService>().tabsRouterContext;

  if (tabsRouterContext != null) {
    scheduleMicrotask(() {
      if (tabsRouterContext.mounted) {
        AutoTabsRouter.of(tabsRouterContext).setActiveIndex(index);
      }
    });
  } else {
    // Handle the error gracefully (e.g., log it or display a message)
    DebugLog.instance.d('TabsRouter context is not available');
  }
}

/// Checks if the Dashboard route exists in the current navigation stack.
bool isDashboardInStack(BuildContext context) {
  List<AutoRoutePage<dynamic>> stack = AutoRouter.of(context).stack;
  return stack
      .any((AutoRoutePage<dynamic> route) => route.name == 'DashboardRoute');
}

/// Navigates to the Dashboard, either by switching
/// tabs or replacing the current route stack.
Future<void> navigateOrReplaceWithDashboard(
  BuildContext context,
  int indexPosition,
  PageRouteInfo route,
) async {
  if (isDashboardInStack(context)) {
    navigateToTab(context, indexPosition);
  } else {
    await context.router.replaceAll(<PageRouteInfo>[const DashboardRoute()]);
  }
}

/// Converts an angle in degrees to an `Alignment` object.
AlignmentGeometry calculateAlignment(double angleInDegrees) {
  final double angleInRadians =
      angleInDegrees * pi / 180; // Convert degrees to radians
  final double x = cos(angleInRadians); // Calculate x coordinate
  final double y = sin(angleInRadians); // Calculate y coordinate
  return Alignment(x, y); // Return alignment
}
///calculateDate
DateTime calculateDate() {
  DateTime today = DateTime.now();
  return DateTime(today.year, today.month, today.day);
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

///pickDate
Future<String?> pickDate(BuildContext context) async {
  final DateTime? pickedDate = await showDatePicker(
    context: context,
    firstDate: calculateFirstDate(),
    lastDate: calculateDate(),
    initialDate: DateTime.now(),
    initialEntryMode: DatePickerEntryMode.calendarOnly,
    builder: (BuildContext context, Widget? child) {
      return Theme(
        data: Theme.of(context).copyWith(
          colorScheme: ColorScheme.light(
            primary: MainConfig.appColors.mainColor,
          ),
          textButtonTheme: TextButtonThemeData(
            style: TextButton.styleFrom(foregroundColor: Colors.black),
          ),
          dialogTheme: DialogThemeData(
            titleTextStyle: context.textTheme.headlineMedium?.copyWith(
              color: AppColors.blackColor,
              fontSize: Dimens.fontSize20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        child: child!,
      );
    },
  );

  if (pickedDate != null) {
    return DateFormat('dd-MM-yyyy')
        .format(pickedDate); // Returning the formatted date as a string
  }
  return null; // Return null if no date is picked
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
    final String extension = fileName.split('.').last.toLowerCase();

    if (AppConstant.imageExtensions.contains(extension)) {
      return FileType.image;
    } else if (AppConstant.jsonExtensions.contains(extension)) {
      return FileType.jsonFile;
    } else {
      return FileType.unknown;
    }
  }

/// Creates a [Text] widget in which any text between parentheses ()
/// is given a different (e.g., bold) style.
///
/// For example:
///   "You've earned (2000) points from order (#4534345)"
/// This method will highlight (2000) and (#4534345).
Widget createSpannableTextWithParentheses({
  required String content,
  required BuildContext context,
  TextStyle? defaultTextStyle,
  TextStyle? parenthesisTextStyle,
}) {
  // A RegExp that matches '(' followed by any characters until the matching ')'.
  // It handles any characters except newlines inside parentheses.
  final RegExp pattern = RegExp(r'\([^)]*\)');

  List<TextSpan> spans = <TextSpan>[];
  int lastIndex = 0;

  // Find all matches of the pattern.
  final Iterable<RegExpMatch> matches = pattern.allMatches(content);

  for (final Match match in matches) {
    // If there's text before the '(' that hasn't yet been added, add it.
    if (match.start > lastIndex) {
      spans.add(
        TextSpan(
          text: content.substring(lastIndex, match.start),
          style: defaultTextStyle ??
              context.textTheme.bodyMedium?.copyWith(
                color: MainConfig.appColors.textBlackColor,
                fontSize: Dimens.fontSize14,
                height: Dimens.lineHeight18.toLineHeight(Dimens.fontSize14),
                fontWeight: FontWeight.normal,
              ),
        ),
      );
    }

    // Now add the text within parentheses with a bold style.
    final String parenthesesText = content.substring(match.start, match.end);
    spans.add(
      TextSpan(
        text: parenthesesText,
        style: parenthesisTextStyle ??
            context.textTheme.bodyMedium?.copyWith(
              color: MainConfig.appColors.textBlackColor,      // or your color
              fontSize: Dimens.fontSize14,
              height: Dimens.lineHeight16.toLineHeight(Dimens.fontSize14),
              fontWeight: FontWeight.bold,
            ),
      ),
    );

    // Update the last index so we know where to continue from.
    lastIndex = match.end;
  }

  // Add any remaining text after the last closing parenthesis.
  if (lastIndex < content.length) {
    spans.add(
      TextSpan(
        text: content.substring(lastIndex, content.length),
        style: defaultTextStyle ??
            context.textTheme.bodyMedium?.copyWith(
              color: MainConfig.appColors.textBlackColor,
              fontSize: Dimens.fontSize14,
              height: Dimens.lineHeight18.toLineHeight(Dimens.fontSize14),
              fontWeight: FontWeight.normal,
            ),
      ),
    );
  }



  return Text.rich(
    textScaler: TextScaler.noScaling,
    TextSpan(children: spans),

  );
}
///getPlatformName
String getPlatformName() {
  if (kIsWeb) return AppConstant.web;
  if (Platform.isAndroid) return AppConstant.android;
  if (Platform.isIOS) return AppConstant.ios;
  return "";
}

/// Gets the unique device identifier for the current platform.
/// 
/// Returns:
/// - For Android: The device ID from AndroidDeviceInfo
/// - For iOS: The identifier for vendor from IosDeviceInfo
/// - For web and other platforms: Empty string
String getDeviceId() {
  if (kIsWeb) {
    return '';
  }
  String deviceId = '';
  if (Platform.isAndroid) {
    deviceId = getIt<MainConfig>().androidInfo.id;
  } else if (Platform.isIOS) {
    deviceId = getIt<MainConfig>().iosDeviceInfo.identifierForVendor ?? '';
  }
  return deviceId;
}

/// Formats a price value with currency symbol
String formatPrice(double? value, String currency, {bool isDiscount = false}) {
  if (value == null) return "${currency}0.00";
  final String formattedValue = value.toStringAsFixed(2);
  return isDiscount ? "-$currency$formattedValue" : "$currency$formattedValue";
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

/// Get localized "All" text based on current language using context
/// 
/// Returns the appropriate "All" text based on the current language:
/// - English (LTR): "All"
/// - Arabic (RTL): "الكل"
/// 
/// Usage:
/// ```dart
/// String allText = getLocalizedAllText(context);
/// ```
String getLocalizedAllText() {
  try {
    // Use the context-based localization system
    return MainConfig.context.appString.allKey;
  } on Exception catch (e) {
    DebugLog.instance.e(e.toString());
    // Fallback to English if localization fails
    return '';
  }
}

/// Converts gender string to AppConstant value
/// 
/// This utility function standardizes gender values across the app
/// by converting various gender string formats to AppConstant values.
/// 
/// Parameters:
/// - [gender]: The gender string to convert (case-insensitive)
/// 
/// Returns:
/// - [AppConstant.male] for "male" or "m"
/// - [AppConstant.female] for "female" or "f" 
/// - [AppConstant.male] as default for unrecognized values
/// 
/// Usage:
/// ```dart
/// String genderConstant = getGenderConstant("Male"); // Returns "male"
/// String genderConstant = getGenderConstant("F"); // Returns "female"
/// String genderConstant = getGenderConstant("unknown"); // Returns "male" (default)
/// ```
String getGenderConstant(String gender) {
  final String lowerGender = gender.toLowerCase();
  if (lowerGender == 'male' || lowerGender == 'm') {
    return AppConstant.male;
  } else if (lowerGender == 'female' || lowerGender == 'f') {
    return AppConstant.female;
  } else {
    // Default to male if gender is not recognized
    return AppConstant.male;
  }
}
///getLocalizedAddressType
String getLocalizedAddressType(BuildContext context, String? addressType) {
  if (addressType == null) return '';

  switch (addressType.toLowerCase()) {
    case AppConstant.home:
      return context.appString.navHomeKey;
    case AppConstant.work:
      return context.appString.workKey;
    case 'other':
      return context.appString.otherKey;
    default:
      return addressType.toTitleCase;
  }
}
