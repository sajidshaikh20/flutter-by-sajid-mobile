/// Model class for product review response data.
class ProductReview {

  /// Creates an instance of [ProductReview].
  ProductReview({this.reviewCount, this.ratings, this.reviews});

  /// Creates a [ProductReview] instance from a JSON map.
  ProductReview.fromJson(Map<String, dynamic> json) {
    reviewCount = json['review_count'];
    ratings = json['ratings'];
    if (json['reviews'] != null) {
      reviews = (json['reviews'] as List<dynamic>)
          .map((dynamic v) => Reviews.fromJson(v))
          .toList();
    }
  }
  /// The total number of reviews.
  String? reviewCount;

  /// The average rating value.
  num? ratings;

  /// List of individual review objects.
  List<Reviews>? reviews;

  /// Converts the model to a JSON map.
  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = <String, dynamic>{};
    data['review_count'] = reviewCount;
    data['ratings'] = ratings;
    if (reviews != null) {
      data['reviews'] = reviews!.map((Reviews v) => v.toJson()).toList();
    }
    return data;
  }
}

/// Model class for individual review data.
class Reviews {

  /// Creates an instance of [Reviews].
  Reviews({
    this.stars,
    this.name,
    this.title,
    this.detail,
    this.customerId,
    this.createdAt,
    this.status,
  });

  /// Creates a [Reviews] instance from a JSON map.
  Reviews.fromJson(Map<String, dynamic> json) {
    stars = json['stars'];
    name = json['name'];
    title = json['title'];
    detail = json['detail'];
    customerId = json['customerId'];
    createdAt = json['createdAt'];
    status = json['status'];
  }
  /// The star rating given by the customer.
  String? stars;

  /// The name of the customer who wrote the review.
  String? name;

  /// The title of the review.
  String? title;

  /// The detailed review text.
  String? detail;

  /// The unique identifier of the customer.
  String? customerId;

  /// The timestamp when the review was created.
  String? createdAt;

  /// The status of the review.
  String? status;

  /// Converts the model to a JSON map.
  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = <String, dynamic>{};
    data['stars'] = stars;
    data['name'] = name;
    data['title'] = title;
    data['detail'] = detail;
    data['customerId'] = customerId;
    data['createdAt'] = createdAt;
    data['status'] = status;
    return data;
  }
}
