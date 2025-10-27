import '../../../utils/exports.dart';

/// A model class representing a checkout item.
class CheckoutModel {

  /// Creates a new instance of [CheckoutModel].
  ///
  /// [title] The title of the checkout item.
  /// [itemImage] The image associated with the item (optional).
  /// [subTitle] The subtitle for the checkout item (optional).
  /// [isCountryIconAvailable] A boolean indicating if the country icon is available (default is false).
  /// [isLanguageOrCurrencyAvailable] A boolean indicating if language or currency is available (default is false).
  CheckoutModel({
    required this.title,
    this.itemImage,
    this.subTitle,
    this.isCountryIconAvailable = false,
    this.isLanguageOrCurrencyAvailable = false,
  });

  /// The image associated with the item.
  final SvgGenImage? itemImage;

  /// The title of the checkout item.
  final String title;

  /// The subtitle for the checkout item.
  final String? subTitle;

  /// A boolean indicating if the country icon is available.
  final bool isCountryIconAvailable;

  /// A boolean indicating if language or currency options are available.
  final bool isLanguageOrCurrencyAvailable;
}
