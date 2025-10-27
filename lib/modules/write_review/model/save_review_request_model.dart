import 'package:freezed_annotation/freezed_annotation.dart';

part 'save_review_request_model.freezed.dart';
part 'save_review_request_model.g.dart';

/// Model representing a request to save a product review.
///
/// This model is used to send review-related data such as title, details,
/// product ID, nickname, and ratings to the backend API.
@freezed
class SaveReviewRequestModel with _$SaveReviewRequestModel {
  /// Creates a [SaveReviewRequestModel] instance.
  ///
  /// All parameters are optional.
  const factory SaveReviewRequestModel({
    /// The ID of the website where the review is being submitted.
    String? websiteId,

    /// The store ID associated with the review submission.
    String? storeId,

    /// The cart/quote ID, if applicable.
    String? quoteId,

    /// The token of the customer submitting the review.
    String? customerToken,

    /// The title or headline of the review.
    String? title,

    /// Detailed content of the review.
    String? details,

    /// The ID of the product being reviewed.
    String? productID,

    /// The nickname or display name of the reviewer.
    String? nickname,

    /// The ratings for the review, represented as a map of criteria and scores.
    Map<String, dynamic>? ratings,
  }) = _SaveReviewRequestModel;

  /// Creates a [SaveReviewRequestModel] object from a JSON map.
  factory SaveReviewRequestModel.fromJson(Map<String, dynamic> json) =>
      _$SaveReviewRequestModelFromJson(json);
}
