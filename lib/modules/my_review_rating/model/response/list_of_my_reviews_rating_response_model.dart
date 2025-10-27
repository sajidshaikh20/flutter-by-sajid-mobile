import '../../../../utils/exports.dart';

/// Converts a JSON string to a list of [ListOfMyReviewsRatingResponseModel].
List<ListOfMyReviewsRatingResponseModel> listOfMyReviewsRatingFromJson(String str) => List<ListOfMyReviewsRatingResponseModel>.from((json.decode(str) as List<dynamic>).map((dynamic x) => ListOfMyReviewsRatingResponseModel.fromJson(x as Map<String, dynamic>)));

/// Converts a list of [ListOfMyReviewsRatingResponseModel] to a JSON string.
String lisMyReviewsRatingToJson(List<ListOfMyReviewsRatingResponseModel> data) => json.encode(List<dynamic>.from(data.map((ListOfMyReviewsRatingResponseModel x) => x.toJson())));

/// Model class for individual review and rating response data.
class ListOfMyReviewsRatingResponseModel {
  /// The customer identifier.
  final int? customerId;

  /// The star rating given by the customer.
  final double? stars;

  /// The name of the customer who gave the review.
  final String? name;

  /// The detailed review text.
  final String? detail;

  /// The timestamp when the review was created.
  final String? createdAt;

  /// The status of the review.
  final String? status;

  /// Additional rating details.
  final String? ratingDetail;

  /// The image URL associated with the review.
  final String? image;

  /// Creates an instance of [ListOfMyReviewsRatingResponseModel].
  ListOfMyReviewsRatingResponseModel({
    this.customerId,
    this.stars,
    this.name,
    this.detail,
    this.createdAt,
    this.status,
    this.ratingDetail,
    this.image,
  });

  /// Creates a copy of this [ListOfMyReviewsRatingResponseModel] with optional new values.
  ListOfMyReviewsRatingResponseModel copyWith({
    int? customerId,
    double? stars,
    String? name,
    String? detail,
    String? createdAt,
    String? status,
    String? ratingDetail,
    String? image,

  }) => ListOfMyReviewsRatingResponseModel(
    customerId: customerId ?? this.customerId,
    stars: stars ?? this.stars,
    name: name ?? this.name,
    detail: detail ?? this.detail,
    status: status ?? this.status,
    createdAt: createdAt ?? this.createdAt,
    ratingDetail: ratingDetail ?? this.ratingDetail,
    image: image ?? this.image,
  );

  /// Creates an instance of [ListOfMyReviewsRatingResponseModel] from a JSON map.
  factory ListOfMyReviewsRatingResponseModel.fromJson(Map<String, dynamic> json) {
    return ListOfMyReviewsRatingResponseModel(
      customerId: json['customerId'] as int?,
      stars: json['stars'] as double?,
      name: json['name'] as String?,
      detail: json['detail'] as String?,
      status: json['status'] as String?,
      createdAt: json['createdAt'] as String?,
      ratingDetail: json['rating_detail'] as String?,
      image: json['image'] as String?,
    );
  }

  /// Converts the model to a JSON map.
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['customerId'] = customerId;
    data['stars'] = stars;
    data['name'] = name;
    data['detail'] = detail;
    data['status'] = status;
    data['createdAt'] = createdAt;
    data['rating_detail'] = ratingDetail;
    data['image'] = image;
    return data;
  }
}
