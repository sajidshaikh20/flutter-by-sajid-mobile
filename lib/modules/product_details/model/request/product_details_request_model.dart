// To parse this JSON data, do
//
//     final productDetailsRequestModel = productDetailsRequestModelFromJson(jsonString);


/// Model class for product details request parameters.
class ProductDetailsRequestModel {
  /// The customer authentication token.
  final String? customerToken;

  /// The language identifier.
  final int? languageId;

  /// The quote/cart identifier.
  final dynamic quoteId;

  /// The store identifier.
  final int? storeId;

  /// The product identifier.
  final int? productId;

  /// The platform from which the request is made.
  final String? platform;

  /// The application version.
  final String? version;

  /// The currency code.
  final String? currency;

  /// Creates an instance of [ProductDetailsRequestModel].
  ProductDetailsRequestModel({
    this.customerToken,
    this.languageId,
    this.quoteId,
    this.storeId,
    this.productId,
    this.platform,
    this.version,
    this.currency,
  });

  /// Creates a copy of this [ProductDetailsRequestModel] with optional new values.
  ProductDetailsRequestModel copyWith({
    String? customerToken,
    int? languageId,
    dynamic quoteId,
    int? storeId,
    int? productId,
    String? platform,
    String? version,
    String? currency,
  }) =>
      ProductDetailsRequestModel(
        customerToken: customerToken ?? this.customerToken,
        languageId: languageId ?? this.languageId,
        quoteId: quoteId ?? this.quoteId,
        storeId: storeId ?? this.storeId,
        productId: productId ?? this.productId,
        platform: platform ?? this.platform,
        version: version ?? this.version,
        currency: currency ?? this.currency,
      );

  /// Creates a [ProductDetailsRequestModel] instance from a JSON map.
  factory ProductDetailsRequestModel.fromJson(Map<String, dynamic> json) => ProductDetailsRequestModel(
    customerToken: json["customerToken"],
    languageId: json["languageId"],
    quoteId: json["quoteId"],
    storeId: json["storeId"],
    productId: json["product_id"],
    platform: json["platform"],
    version: json["version"],
    currency: json["currency"],
  );

  /// Converts the model to a JSON map.
  Map<String, dynamic> toJson() => <String, dynamic>{
    "customerToken": customerToken,
    "languageId": languageId,
    "quoteId": quoteId,
    "storeId": storeId,
    "product_id": productId,
    "platform": platform,
    "version": version,
    "currency": currency,
  };
}
