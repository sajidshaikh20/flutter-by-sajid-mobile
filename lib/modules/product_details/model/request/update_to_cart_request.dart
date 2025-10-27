import 'add_to_cart_request.dart';
/// UpdateToCartRequest
class UpdateToCartRequest {
  /// Constructor
  UpdateToCartRequest({
    this.websiteId,
    this.storeId,
    this.customerToken,
    this.quoteId,
    this.sku,
    this.platform,
    this.version,
    this.productVariant,
    this.languageId,
  });

  // Factory constructor for creating a new instance
  /// from a map (JSON deserialization)
  factory UpdateToCartRequest.fromJson(Map<String, dynamic> json) =>
      UpdateToCartRequest(
        languageId: json['languageId'],
        websiteId: json['websiteId'],
        storeId: json['storeId'],
        customerToken: json['customerToken'],
        quoteId: json['quoteId'],
        sku: json['sku'],
        platform: json['platform'],
        version: json['version'],
        productVariant: json['product_variant'] != null
            ? CartProductVariant.fromJson(json['product_variant'])
            : null,
      );

  /// The unique identifier for the website.
  int? websiteId;

  /// The unique identifier for the store.
  int? storeId;

  /// The authentication token of the customer.
  String? customerToken;

  /// The unique identifier for the quote associated with the cart.
  int? quoteId;

  /// The SKU (Stock Keeping Unit) of the product to be added to the cart.
  String? sku;

  /// The platform from which the request is made (e.g., 'Android', 'iOS', 'Web').
  String? platform;

  /// The version of the application or API.
  String? version;

  /// The language identifier used for localization.
  int? languageId;

  /// The variant details of the product (e.g., size, color).
  CartProductVariant? productVariant;

  /// Method to convert this class instance into a map (JSON serialization)
  Map<String, dynamic> toJson() => <String, dynamic>{
        'websiteId': websiteId,
        'storeId': storeId,
        'customerToken': customerToken,
        'quoteId': quoteId,
        'sku': sku,
        'platform': platform,
        'version': version,
        'languageId': languageId,
        if (productVariant != null) 'product_variant': productVariant!.toJson(),
      };
}
