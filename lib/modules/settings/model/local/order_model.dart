import '../../../../utils/exports.dart';

/// Model class for order/account item data.
class OrderModel {
  /// The SVG image for the item.
  SvgGenImage? itemImage;

  /// The country flag image URL.
  String? countryImage;

  /// The main title of the item.
  String title;

  /// The subtitle of the item.
  String? subTitle;

  /// Whether country icon is available.
  bool isCountryIconAvailable;

  /// Whether country image is available.
  bool isCountryImageAvailable;

  /// Whether language or currency is available.
  bool isLanguageOrCurrencyAvailable;

  /// The type of the account item.
  MyAccountItemType type;

  /// Creates an instance of [OrderModel].
  OrderModel({
    this.itemImage,
    required this.title,
    this.subTitle,
    this.countryImage,
    this.isCountryIconAvailable = false,
    this.isCountryImageAvailable = false,
    this.isLanguageOrCurrencyAvailable = false,
    this.type = MyAccountItemType.none
  });
}
