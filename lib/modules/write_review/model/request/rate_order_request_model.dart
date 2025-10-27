/// Model class for rating an order request.
class RateOrderRequestModel {
  /// The language ID for the request.
  int? languageId;

  /// The customer authentication token.
  String? customerToken;

  /// The platform from which the request is made.
  String? platform;

  /// The version of the application.
  String? version;

  /// The overview or comment for the rating.
  String? overview;

  /// The rating value given to the order.
  int? rating;

  /// The unique identifier of the order being rated.
  int? orderId;

  /// Creates a new instance of [RateOrderRequestModel].
  ///
  /// All parameters are optional and can be null.
  RateOrderRequestModel({
    this.languageId,
    this.customerToken,
    this.platform,
    this.version,
    this.overview,
    this.rating,
    this.orderId,
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
    data['overview'] = overview;
    data['rating'] = rating;
    data['orderId'] = orderId;
    return data;
  }
}

