// To parse this JSON data, do
//
//     final getReviewSummaryResponse = getReviewSummaryResponseFromJson(jsonString);

import 'dart:convert';

/// Converts a JSON string to a [GetReviewSummaryResponse] instance.
GetReviewSummaryResponse getReviewSummaryResponseFromJson(String str) => GetReviewSummaryResponse.fromJson(json.decode(str));

/// Converts a [GetReviewSummaryResponse] instance to a JSON string.
String getReviewSummaryResponseToJson(GetReviewSummaryResponse data) => json.encode(data.toJson());

/// Model class for review summary response data.
class GetReviewSummaryResponse {
  /// The total number of reviews for the product.
  final int? reviewCount;

  /// The average rating value.
  final double? ratings;

  /// Whether to show ratings in the UI.
  final bool? showRatings;

  /// Map containing rating distribution by star count.
  final Map<String, int>? ratingArray;

  /// List of review objects.
  final List<ReviewCommon>? reviews;

  /// Creates an instance of [GetReviewSummaryResponse].
  GetReviewSummaryResponse({
    this.reviewCount,
    this.ratings,
    this.showRatings,
    this.ratingArray,
    this.reviews,
  });

  /// Creates a copy of this [GetReviewSummaryResponse] with optional new values.
  GetReviewSummaryResponse copyWith({
    int? reviewCount,
    double? ratings,
    bool? showRatings,
    Map<String, int>? ratingArray,
    List<ReviewCommon>? reviews,
  }) =>
      GetReviewSummaryResponse(
        reviewCount: reviewCount ?? this.reviewCount,
        ratings: ratings ?? this.ratings,
        showRatings: showRatings ?? this.showRatings,
        ratingArray: ratingArray ?? this.ratingArray,
        reviews: reviews ?? this.reviews,
      );

  /// Creates a [GetReviewSummaryResponse] instance from a JSON map.
  factory GetReviewSummaryResponse.fromJson(Map<String, dynamic> json) => GetReviewSummaryResponse(
    reviewCount: json["review_count"],
    ratings: (json["ratings"] as num?)?.toDouble(),
    showRatings: json["showRatings"],
    ratingArray: json["ratingArray"] != null 
        ? Map<String, int>.fromEntries(
            (json["ratingArray"] as Map<String, dynamic>).entries.map<MapEntry<String, int>>(
              (MapEntry<String, dynamic> e) => MapEntry<String, int>(e.key, (e.value as num).toInt()),
            ),
          )
        : null,
    reviews: json["reviews"] == null ? <ReviewCommon>[] : List<ReviewCommon>.from(
      (json["reviews"] as List<dynamic>).map<ReviewCommon>((dynamic x) => ReviewCommon.fromJson(x as Map<String, dynamic>))
    ),
  );

  /// Converts the model to a JSON map.
  Map<String, dynamic> toJson() => <String, dynamic>{
    "review_count": reviewCount,
    "ratings": ratings,
    "showRatings": showRatings,
    "ratingArray": ratingArray != null 
        ? Map<dynamic, dynamic>.from(ratingArray!).map((dynamic k, dynamic v) => MapEntry<String, dynamic>(k, v))
        : null,
    "reviews": reviews == null ? <dynamic>[] : List<dynamic>.from(reviews!.map((ReviewCommon x) => x.toJson())),
  };
}

/// Model class for individual review data.
class ReviewCommon {
  /// The star rating given by the customer.
  final int? stars;

  /// The name of the customer who wrote the review.
  final String? name;

  /// The detailed review text.
  final String? detail;

  /// The unique identifier of the customer.
  final int? customerId;

  /// The timestamp when the review was created.
  final String? createdAt;

  /// Additional rating details.
  final String? ratingDetail;

  /// The status of the review.
  final String? status;

  /// Creates an instance of [ReviewCommon].
  ReviewCommon({
    this.stars,
    this.name,
    this.detail,
    this.customerId,
    this.createdAt,
    this.ratingDetail,
    this.status,
  });

  /// Creates a copy of this [ReviewCommon] with optional new values.
  ReviewCommon copyWith({
    int? stars,
    String? name,
    String? detail,
    int? customerId,
    String? createdAt,
    String? ratingDetail,
    String? status,
  }) =>
      ReviewCommon(
        stars: stars ?? this.stars,
        name: name ?? this.name,
        detail: detail ?? this.detail,
        customerId: customerId ?? this.customerId,
        createdAt: createdAt ?? this.createdAt,
        ratingDetail: ratingDetail ?? this.ratingDetail,
        status: status ?? this.status,
      );

  /// Creates a [ReviewCommon] instance from a JSON map.
  factory ReviewCommon.fromJson(Map<String, dynamic> json) => ReviewCommon(
    stars: json["stars"] != null ? (json["stars"] as num).toInt() : null,
    name: json["name"],
    detail: json["detail"],
    customerId: json["customerId"] != null ? (json["customerId"] as num).toInt() : null,
    createdAt: json["createdAt"],
    ratingDetail: json["rating_detail"],
    status: json["status"],
  );

  /// Converts the model to a JSON map.
  Map<String, dynamic> toJson() => <String, dynamic>{
    "stars": stars,
    "name": name,
    "detail": detail,
    "customerId": customerId,
    "createdAt": createdAt,
    "rating_detail": ratingDetail,
    "status": status,
  };
}
