/// Model class for my reviews and rating request parameters.
class MyReviewsRatingRequestModel {
  /// The language identifier.
  int? languageId;

  /// The customer authentication token.
  String? customerToken;

  /// The platform from which the request is made.
  String? platform;

  /// The application version.
  String? version;

  /// The maximum number of items to return.
  int? limit;

  /// The number of items to skip for pagination.
  int? offset;

  /// Creates an instance of [MyReviewsRatingRequestModel].
  MyReviewsRatingRequestModel({
    this.languageId,
    this.customerToken,
    this.platform,
    this.version,
    this.limit,
    this.offset,
  });

  /// Converts the model to a JSON map.
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['languageId'] = languageId;
    data['customerToken'] = customerToken;
    data['platform'] = platform;
    data['version'] = version;
    data['limit'] = limit;
    data['offset'] = offset;

    return data;
  }
}


