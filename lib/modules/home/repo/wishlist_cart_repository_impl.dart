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



  @override
  Future<ResponseHandler<BaseResponse<CartOperationResponseModel>>> addToCartProduct(
    AddToCartRequest addToCart, {
    bool showLoader = true,
  }) async {
    ResponseHandler<Map<String, dynamic>?> response =
        await MainConfig.apiClient.handleApiCall<Map<String, dynamic>>(
      endUrl: Apis.addToCart, // Updated endpoint
      apiType: ApiType.post,
      data: addToCart.toJson(), // Changed from FormData to JSON data
      showLoader: showLoader,
    );
    return getParsedResponseHandler(
      responseHandler: response,
      parser: (Map<String, dynamic> value) {
        // Parse using BaseResponse structure
        return BaseResponse<CartOperationResponseModel>.fromJson(
          value,
              (Object? json) => CartOperationResponseModel.fromJson(json as Map<String, dynamic>),
        );
      },
    );

  }

  @override
  Future<ResponseHandler<BaseResponse<CartOperationResponseModel>>> callUpdateCartAPI(
    UpdateToCartRequest updateToCart, {
    bool showLoader = true,
  }) async {
    ResponseHandler<Map<String, dynamic>?> response =
        await MainConfig.apiClient.handleApiCall<Map<String, dynamic>>(
      endUrl: Apis.updateToCart , // Updated endpoint
      apiType: ApiType.post,
      data: updateToCart.toJson(), // Changed from params to data
      showLoader: showLoader,
    );

    return getParsedResponseHandler(
      responseHandler: response,
      parser: (Map<String, dynamic> value) {
        // Parse using BaseResponse structure
        return BaseResponse<CartOperationResponseModel>.fromJson(
          value,
              (Object? json) => CartOperationResponseModel.fromJson(json as Map<String, dynamic>),
        );
      },
    );
  }

  @override
  Future<ResponseHandler<BaseResponse<CartOperationResponseModel>>> callRemoveCartAPI(
    RemoveToCartRequest removeToCart, {
    bool showLoader = true,
  }) async {
    ResponseHandler<Map<String, dynamic>?> response =
        await MainConfig.apiClient.handleApiCall<Map<String, dynamic>>(
      endUrl: Apis.removeToCart,
      apiType: ApiType.post,
      data: removeToCart.toJson(), // Changed from params to data
      showLoader: showLoader,
    );

    return getParsedResponseHandler(
      responseHandler: response,
      parser: (Map<String, dynamic> value) {
        // Parse using BaseResponse structure
        return BaseResponse<CartOperationResponseModel>.fromJson(
          value,
              (Object? json) => CartOperationResponseModel.fromJson(json as Map<String, dynamic>),
        );
      },
    );
  }

  @override
  Future<ResponseHandler<BaseResponse<CartDetailsListingResponseModel>>> getCartListing(CartListingRequest request, {bool showLoader = true}) async{
    // Make the API call to fetch cart listing data
    ResponseHandler<Map<String, dynamic>?> response =
        await MainConfig.apiClient.handleApiCall<Map<String, dynamic>>(
      endUrl: Apis.cartDetails,
      data: request.toJson(),
      showLoader: showLoader,
    );

    // Parse and return the response using the response handler
    return getParsedResponseHandler(
      responseHandler: response,
      parser: (Map<String, dynamic> json) => BaseResponse<CartDetailsListingResponseModel>.fromJson(
        json,
        (Object? data) {
          // Handle both cases: when data is an array (empty cart) or an object (cart with items)
          if (data is List) {
            // Empty cart case - create a CartDetailsListingResponseModel with empty data
            return const CartDetailsListingResponseModel(
              cartItems: <ProductListingResponse>[],
              finalTotal: 0.0,
              subTotal: 0.0,
              deliveryCharge: 0.0,
              loyaltyPointsApplied: 0.0,
              walletApplied: 0.0,
              couponCodeApplied: 0.0,
              totalSaved: 0.0,
            );
          } else if (data is Map<String, dynamic>) {
            // Cart with items case - parse normally
            return CartDetailsListingResponseModel.fromJson(data);
          } else {
            // Fallback for unexpected data type
            throw Exception('Unexpected data type in cart listing response: ${data.runtimeType}');
          }
        },
      ),
    );
  }





}
