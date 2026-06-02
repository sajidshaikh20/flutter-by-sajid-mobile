import '../../../utils/exports.dart';

/// Application string resources for localization (only keys in use).
abstract class AppString {
  static AppString of(BuildContext context) {
    return Localizations.of<AppString>(context, AppString)!;
  }

  String get allKey;
  String get cancelKey;
  String get clearAllKey;
  String get hideKey;
  String get kuwaitCountryCodeKey;
  String get mobileNumberKey;
  String get navAccountKey;
  String get navCategoriesKey;
  String get navHomeKey;
  String get navNotificationsKey;
  String get navWishlistKey;
  String get noInternetConnectionKey;
  String get okayKey;
  String get otherKey;
  String get pleaseCheckYourNetworkConnectionKey;
  String get searchProductKey;
  String get showKey;
  String get tryAgainKey;
  String get workKey;

  // Login & Social Login Keys
  String get loginSignupKey;
  String get continueWithGoogleKey;
  String get continueWithMobileEmailKey;
  String get loginKey;
  String get labelMobileOrMailKey;
  String get passwordKey;
  String get pleaseEnterMobileOrNumberKey;
  String get pleaseEnterThePasswordKey;
  String get pleaseEnterMobileNumberKey;
  String get onlyNumbersAllowedKey;
  String get enterValidMobileNumberKey;
  String get pleaseEnterTheEmailKey;
  String get pleaseEnterValidEmailKey;
  String get passAllCriteriaKey;
  String get dontHaveAccountKey;
  String get forgotPasswordKey;
  String get welcomeBackKey;
  String get byContinuingAgreeKey;
  String get termsOfServiceKey;
  String get andKey;
  String get privacyPolicyKey;
  String get memberLoginKey;
  String get continueJourneySecurelyKey;
  String get emailOrUsernameKey;
  String get pleaseEnterEmailOrUsernameKey;

  // Forgot Password
  String get resetPasswordTitleKey;
  String get enterEmailToReceiveResetLinkKey;
  String get enterYourEmailKey;
  String get sendResetLinkKey;
  String get backToLoginKey;
  String get resetLinkSentSuccessKey;
  String get forgotPasswordFailedKey;
}
