import 'package:freezed_annotation/freezed_annotation.dart';

part 'get_product_review_request_model.freezed.dart';
part 'get_product_review_request_model.g.dart';

/// Model representing the request data for fetching product reviews.
@freezed
class GetProductReviewRequestModel with _$GetProductReviewRequestModel {
  /// Constructs a request model for fetching product reviews with store and entity ID.
  const factory GetProductReviewRequestModel({
    // required String store,
    required String entityId,
  }) = _GetProductReviewRequestModel;

  /// Factory constructor to create an instance from a JSON map
  factory GetProductReviewRequestModel.fromJson(Map<String, dynamic> json) =>
      _$GetProductReviewRequestModelFromJson(json);
}
