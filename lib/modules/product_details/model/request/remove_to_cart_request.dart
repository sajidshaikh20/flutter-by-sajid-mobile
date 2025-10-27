/// Model class for remove from cart request parameters.
class RemoveToCartRequest {

  /// Creates an instance of [RemoveToCartRequest].
  RemoveToCartRequest({
    this.languageId,
    this.customerToken,
    this.quoteId,
    this.sku,
    this.platform,
    this.version,
  });

  /// Creates a [RemoveToCartRequest] instance from a JSON map.
  factory RemoveToCartRequest.fromJson(Map<String, dynamic> json) =>
      RemoveToCartRequest(
        languageId: json['languageId'],
        customerToken: json['customerToken'],
        quoteId: json['quoteId'],
        sku: json['sku'],
        platform: json['platform'],
        version: json['version'],
      );

  /// The language identifier.
  int? languageId;

  /// The customer authentication token.
  String? customerToken;

  /// The quote/cart identifier.
  int? quoteId;

  /// The product SKU to remove.
  String? sku;

  /// The platform from which the request is made.
  String? platform;

  /// The application version.
  String? version;

  /// Converts the model to a JSON map.
  Map<String, dynamic> toJson() => <String,dynamic >{
        'languageId': languageId,
        'customerToken': customerToken,
        'quoteId': quoteId,
        'sku': sku,
        'platform': platform,
        'version': version,
      };
}
