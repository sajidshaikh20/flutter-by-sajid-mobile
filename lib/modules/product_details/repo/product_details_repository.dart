import '../../../utils/exports.dart';

/// Abstract repository for product details operations.
abstract class ProductDetailsRepository extends BaseRepository {
  /// Creates an instance of [ProductDetailsRepository].
  ProductDetailsRepository();

  /// Fetches product details by entity ID.
  Future<ResponseHandler<BaseResponse<ProductDetailsResponse>>> getProductDetails(
      String entityId);

  /// Fetches product reviews by entity ID.
  Future<ResponseHandler<BaseResponse<GetReviewSummaryResponse>>> getProductReview(
      String entityId);

  /// Fetches related products by product SKU.
  Future<ResponseHandler<BaseResponse<List<ProductListingResponse>>>> getRelatedProducts(
      String productSku);

  /// Fetches trending products.
  Future<ResponseHandler<BaseResponse<List<ProductListingResponse>>>> getTrendingProducts();
}
