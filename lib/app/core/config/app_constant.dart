import '../../../utils/exports.dart';
/// Constants used across the app (non-localized).
/// Localization-dependent strings belong in AppStrings / l10n.
abstract class AppConstant {
  // Layout & device
  static const double smallDeviceHeight = 800;
  static const double webPixelWidth = 1200;
  static const double mobilePixelWidth = 600;
  static const String interFontFamily = "inter";

  // Locale & language
  static const String en = "en";
  static const String ar = "ar";
  static const String defaultLanguageAlignment = "LTR";
  static const String rtlLanguageAlignment = "RTL";

  // Platform
  static const String web = "web";
  static const String android = "android";
  static const String ios = "ios";

  // App identity & store
  static const String appName = "FlutterBySajid";
  static const String updateApp = "force_update_maintainance_config";
  static const String update = "Update";
  static const String playStoreURL =
      "https://play.google.com/store/apps/details?id=";
  static const String appstoreURL = "https://apps.apple.com/app/";
  static const String appId = "base.com.flutterbysajid.app";
  static const String appStoreId = "kdd-online-grocery/id1551339483";
  static const String platformNotSupportedCode = 'PlatformNotSupported';
  static const String platformNotSupportedMessage =
      'This platform is not supported';

  // Utils
  static const String dateFormatPattern = "dd/MM/yyyy";
  static const int encryptionLength = 16;
  static const String nonceKey =
      "0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._";
  static const List<String> imageExtensions = <String>[
    'png',
    'jpg',
    'jpeg',
    'gif',
    'bmp',
    'webp',
  ];
  static const List<String> jsonExtensions = <String>['json'];



  static const List<String> methods = <String>[
    'Cash Withdrawal',
    'Balance Enquiry',
    'Mini Statement',
    'Aadhaar Pay',
  ];

  static const List<String> banks = <String>[
    'FINO',
    'NSDL',
    'CITY UNION',
  ];

  // Navigation / routing (utils_functions)
  static const String promotion = "promotion";
  static const String order = "order";
  static const String pageNotFound = "Page not found!!!";
  static const String home = "home";
  static const String work = "work";
  static const String male = "male";
  static const String female = "female";

  // Validation & lengths
  static const int otpTextLength = 4;
  static const int minLengthMobileNumber = 8;
  static const int maxLengthMobileNumber = 14;

  // UI
  static const int zero = 0;
  static const int shimmerCategoryLength = 7;

  /// Language list (uses [AppConstantString.englishText] / [AppConstantString.arabicText]).
  static const List<String> listOfLanguage = <String>[
    AppConstantString.englishText,
    AppConstantString.arabicText,
  ];

  // Social auth messages
  static const String appleSignInSuccess = "Apple Sign in Complete";
  static const String appleSignInFailed = "Apple Sign in Failed";
  static const String googleSignInSuccess = "Google Sign in Complete";
  static const String facebookSignInSuccess = "facebook Sign in Complete";
  static const String facebookSignInFailed = "Facebook Sign in Failed";
}

abstract class NotificationConst {
  static const String channelGroupKey = 'basic_channel_group';
  static const String channelGroupName = 'Basic group';
  static const String channelKey = 'basic_channel';
  static const String channelName = 'Basic notifications';
  static const String channelDescription =
      'Notification channel for basic tests';
}

abstract class APIConstant {
  static const String defaultCurrency = "AED";
  static const String badRequest = "Bad Request";
  static const String badRequestStateKey = "Bad Request";
  static const String unauthorizedKey = "Unauthorized";
  static const String serverNotRespondKey = "Server not responding";
  static const String contentType = "application/json";
  static const String cookie =
      'private_content_version=6d5fe654c801a721bf77a4b59bb1824c';
}

abstract class ApiConst {
  static const String cacheArgument = 'cache';
  static const String cacheDurationArgument = 'validate_time';
  static const int defaultCacheTime = 30;
}



abstract class AppConstantString {
  static const String englishText = 'English';
  static const String arabicText = 'العربية';
}
