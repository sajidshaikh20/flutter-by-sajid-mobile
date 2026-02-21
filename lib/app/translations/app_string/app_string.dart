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
}
