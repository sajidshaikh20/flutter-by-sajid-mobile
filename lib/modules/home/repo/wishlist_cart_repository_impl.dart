import '../../../utils/exports.dart';

/// Wish list cart repository implementation
class WishlistCartRepositoryImpl extends WishlistCartRepository {
  @override
  Future<ResponseHandler<AddWishlistModel>> callAddToWishlistAPI({
    required AddWishlistRequest wishListParams,
  }) async {
    ResponseHandler<Map<String, dynamic>?> response =
        await MainConfig.apiClient.handleApiCall<Map<String, dynamic>>(
      endUrl: Apis.addToWishlist,
      apiType: ApiType.post,
      showLoader: true,
      data: wishListParams.toJson(),
    );

    return getParsedResponseHandler(
      responseHandler: response,
      parser: AddWishlistModel.fromJson,
    );
  }

  @override
  Future<ResponseHandler<BaseResponse<void>>> callRemoveFromWishlistAPI({
    required RemoveWishlistRequest removeWishlistParams,
  }) async {
    ResponseHandler<Map<String, dynamic>?> response =
    await MainConfig.apiClient.handleApiCall<Map<String, dynamic>>(
      endUrl: Apis.removeFromWishlist,
      apiType: ApiType.delete,
      showLoader: true,
      data: removeWishlistParams.toJson(),
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
  Future<ResponseHandler<WishlistModel>> callDeleteWishlistAPI(
    DeleteWishlistRequest deleteWishlist,
  ) async {
    ResponseHandler<Map<String, dynamic>?> response =
        await MainConfig.apiClient.handleApiCall<Map<String, dynamic>>(
      endUrl: Apis.removeFromWishlist,
      apiType: ApiType.delete,
      params: deleteWishlist.toJson(),
    );

    return getParsedResponseHandler(
      responseHandler: response,
      parser: WishlistModel.fromJson,
    );
  }

  @override
  Future<ResponseHandler<WishlistModel>> callWishlistAPI(
    GetWishListRequest getWishList,
  ) async {
    ResponseHandler<Map<String, dynamic>?> response =
        await MainConfig.apiClient.handleApiCall<Map<String, dynamic>>(
      endUrl: Apis.getWishlist,
      params: getWishList.toJson(),

    );

    return getParsedResponseHandler(
      responseHandler: response,
      parser: WishlistModel.fromJson,
    );
  }

}
