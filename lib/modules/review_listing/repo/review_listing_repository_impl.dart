import '../../../utils/exports.dart';

/// Implementation of the ReviewListingRepository to fetch product reviews.
class ReviewListingRepositoryImpl extends ReviewListingRepository {
  @override
  Future<ResponseHandler<ProductReview>> getProductReview(
    GetProductReviewRequestModel getProductReviewRequestModel,
  ) async {
    ResponseHandler<Map<String, dynamic>?> response =
        await MainConfig.apiClient.handleApiCall<Map<String, dynamic>>(
      endUrl: Apis.getProductReview,
      params: <String, dynamic>{
        APIConstant.id: getProductReviewRequestModel.entityId,
      },
    );

    return getParsedResponseHandler(
      responseHandler: response,
      parser: ProductReview.fromJson,
    );
  }
}
