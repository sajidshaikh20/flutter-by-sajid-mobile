/// Model class for rating a product request.
class RateProductRequestModel {
  /// The language ID for the request.
  int? languageId;

  /// The customer authentication token.
  String? customerToken;

  /// The platform from which the request is made.
  String? platform;

  /// The version of the application.
  String? version;

  /// The SKU (Stock Keeping Unit) of the product being rated.
  String? productSKU;

  /// The overview or comment for the rating.
  String? overview;

  /// The rating value given to the product.
  int? rating;

  /// Creates a new instance of [RateProductRequestModel].
  ///
  /// All parameters are optional and can be null.
  RateProductRequestModel({
    this.languageId,
    this.customerToken,
    this.platform,
    this.version,
    this.productSKU,
    this.overview,
    this.rating,
  });

  /// Converts the model to a JSON map.
  ///
  /// Returns a [Map<String, dynamic>] representation of the object.
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['languageId'] = languageId;
    data['customerToken'] = customerToken;
    data['platform'] = platform;
    data['version'] = version;
    data['productSKU'] = productSKU;
    data['overview'] = overview;
    data['rating'] = rating;
    return data;
  }
}

