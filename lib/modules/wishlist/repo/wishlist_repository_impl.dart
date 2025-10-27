import '../../../utils/exports.dart';

/// Implementation of the WishlistRepository, handling API calls related to
/// wishlist.
///
class WishlistRepositoryImpl extends WishlistRepository {
  @override
  Future<ResponseHandler<BaseResponse<List<ProductListingResponse>>>>  callWishlistAPI(
      CallWishlistRequestModel callWishlistRequestModel,
  ) async {
    ResponseHandler<Map<String, dynamic>?> response =
        await MainConfig.apiClient.handleApiCall<Map<String, dynamic>>(
      endUrl: Apis.getWishlist,
      apiType: ApiType.post,
      data: callWishlistRequestModel.toJson(),
    );
    return getParsedResponseHandler(
      responseHandler: response,
      parser: (Map<String, dynamic> value) {
        final List<ProductListingResponse> orders =
        (value['data'] as List<dynamic>? ?? <dynamic>[])
            .whereType<Map<String, dynamic>>()
            .map((Map<String, dynamic> item) =>
            ProductListingResponse.fromJson(item))
            .toList();

        final BaseResponse<List<ProductListingResponse>> result =
        BaseResponse<List<ProductListingResponse>>(
          success: value['success'] == true || value['status_code'] == 200,
          statusCode: value['status_code'] ?? 0,
          message: value['message'] ?? '',
          data: orders,
          totalCount: value['total_counts'] as int?,
        );

        return result;
      },
    );
  }

  @override
  Future<ResponseHandler<BaseResponse<void>>> callRemoveFromWishlistAPI(
      RemoveWishlistRequest removeWishlistRequest,
  ) async {
    ResponseHandler<Map<String, dynamic>?> response =
        await MainConfig.apiClient.handleApiCall<Map<String, dynamic>>(
      endUrl: Apis.removeFromWishlist,
      apiType: ApiType.delete,
      showLoader: true,
      data: removeWishlistRequest.toJson(),
    );
    return getParsedResponseHandler(
      responseHandler: response,
      parser: (Map<String, dynamic> value) {
        return BaseResponse<void>.fromJson(
          value, (_) {}, // No data expected, so return null
        );
      },
    );
  }
  @override
  Future<ResponseHandler<AddToCartModel>> addToCartProduct(
    AddToCartRequest addToCart, {
    bool showLoader = true,
  }) async {
    ResponseHandler<Map<String, dynamic>?> response =
        await MainConfig.apiClient.handleApiCall<Map<String, dynamic>>(
      endUrl: Apis.addToCartProduct,
      apiType: ApiType.post,
      params: addToCart.toJson(),
      showLoader: showLoader,
    );

    return getParsedResponseHandler(
      responseHandler: response,
      parser: AddToCartModel.fromJson,
    );
  }
}
