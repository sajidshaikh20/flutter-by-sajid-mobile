import '../../../utils/exports.dart';

abstract class AppString {
  static AppString of(BuildContext context) {
    return Localizations.of<AppString>(context, AppString)!;
  }

  /// Key for the "delivery" string.
  String get deliveryKey;

  /// Key for the "pickup" string.
  String get pickupKey;

  /// Key for the "navigation home" string.
  String get navHomeKey;

  /// Key for the "login" string.
  String get loginKey;

  /// Label Mobile or Mail
  String get labelMobileOrMailKey;

  /// Enter Password
  String get pleaseEnterThePasswordKey;

  /// Pass All Criteria
  String get passAllCriteriaKey;

  /// Enter Mobile Or Number
  String get pleaseEnterMobileOrNumberKey;

  /// Please Enter The Email
  String get pleaseEnterTheEmailKey;

  /// Show Key
  String get showKey;

  /// Hide Key
  String get hideKey;

  /// Key for the "continue as guest" string.
  String get continueGuestKey;

  /// Key for the "don't have account" string.
  String get dontHaveAccountKey;

  /// Key for the "password" string.
  String get passwordKey;

  /// Key for the "hello" string.
  String get helloKey;

  /// Key for the validation when only number allowed
  String get onlyNumbersAllowedKey;

  /// Example: 'Mobile Number'
  String get mobileNumberKey;

  /// Key for the "Cancel" action.
  String get cancelKey;

  /// Key for the "Clear All" action.
  String get clearAllKey;

  /// Key for the product search placeholder.
  String get searchProductKey;

  /// Key for the "Okay" button.
  String get okayKey;

  /// Key for the "Work" tag.
  String get workKey;

  /// Key for the "Other" tag.
  String get otherKey;

  /// Key for the logout confirmation message.
  String get logoutConformationKey;

  /// Key for the delete account confirmation message.
  String get deleteAccountConformationKey;

  /// Key for the "Yes" confirmation action.
  String get yesKey;

  /// Key for the Kuwait country code label.
  String get kuwaitCountryCodeKey;

  /// Key for the "Welcome to Dukkan" title.
  String get welcomeToDukkanKey;

  /// Key for the "Edit Profile" action.
  String get editProfileKey;

  /// Key for the "Change Password" action.
  String get changePasswordKey;

  /// Key for the "Cancel Order" action.
  String get cancelOrderkey;

  /// Key for the "Gift Cards" title.
  String get giftCardsKey;

  /// Key for the "My Orders" title.
  String get myOrdersKey;

  /// Key for the "Language" setting.
  String get languageKey;

  /// Key for the "Contact Us" title.
  String get contactUsKey;

  /// Key for the "Store Locations" title.
  String get storeLocationsKey;

  /// Key for the "About App" title.
  String get aboutAppKey;

  /// Key for the "Terms and Conditions" link/label.
  String get termsAndConditionsKey;

  /// Key for the "Rate the App" action.
  String get rateTheAppKey;

  /// Key for the "Notifications Settings" title.
  String get notificationsSettingsKey;

  /// Key for the "My Addresses" title.
  String get myAddressesKey;

  /// Key for the "My Reviews & Ratings" title.
  String get myReviewsAndRatingsKey;

  /// Key for the "Refer a Friend" title.
  String get referAFriendKey;

  /// Key for the "FAQs" title.
  String get faqsKey;

  /// Key for the "Logout" action label.
  String get logoutKey;

  /// Key for the "Delete Account" action label.
  String get deleteAccountKey;

  /// Example: 'No Internet Connection'
  String get noInternetConnectionKey;

  /// Example: 'Please Check Your Network Connection'
  String get pleaseCheckYourNetworkConnectionKey;

  /// Example: 'Try Again'
  String get tryAgainKey;

  String get keyStoreReceiptKey;

  /// Example: 'buy1Get1Key'
  String get buy1Get1Key;

  /// Key for selectPay.
  String get selectPay;

  /// Key for englishKey.
  String get englishKey;

  /// Key for the "All" string.
  String get allKey;
}
