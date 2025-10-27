import '../../../utils/exports.dart';

/// Abstract class for handling review listing data operations.
abstract class ReviewListingRepository extends BaseRepository {
  /// Fetches product reviews based on the provided request model.
  Future<ResponseHandler<ProductReview>> getProductReview(
    GetProductReviewRequestModel getProductReviewRequestModel,
  );
}
