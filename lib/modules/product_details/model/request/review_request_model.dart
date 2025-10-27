/// Model class for review request parameters.
class ReviewRequestModel {
  /// The customer authentication token.
  final String customerToken;

  /// The website identifier.
  final int websiteId;

  /// The language identifier.
  final int languageId;

  /// The platform from which the request is made.
  final String platform;

  /// The application version.
  final String version;

  /// The currency code.
  final String currency;

  /// The store identifier.
  final int storeId;

  /// The product identifier.
  final int productId;

  /// Creates an instance of [ReviewRequestModel].
  ReviewRequestModel({
    required this.customerToken,
    required this.websiteId,
    required this.languageId,
    required this.platform,
    required this.version,
    required this.currency,
    required this.storeId,
    required this.productId,
  });

  /// Converts the model to a JSON map.
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'customerToken': customerToken,
      'websiteId': websiteId,
      'languageId': languageId,
      'platform': platform,
      'version': version,
      'currency': currency,
      'storeId': storeId,
      'product_id': productId,
    };
  }
}
