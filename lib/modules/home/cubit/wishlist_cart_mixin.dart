import '../../../utils/exports.dart';

/// A mixin for handling wishlist and cart-related operations in a stateful Cubit.
mixin WishlistCartMixin<State> on Cubit<State> {
  ///Intialise
  late final WishlistCartRepository wishlistCartRepository;

  /// Helper method to get quoteId as int - handles both string and int types
  int getQuoteIdAsInt() {
    final dynamic quoteId = getIt<UserProfileService>().quoteId;
    
    if (quoteId is String) {
      return int.tryParse(quoteId) ?? 0;
    } else if (quoteId is int) {
      return quoteId;
    } else {
      return 0; // Default fallback
    }
  }

  /// Makes an API call to retrieve the wishlist data.
  Future<ResponseHandler<WishlistModel>> callWishlistListAPI() async =>
      wishlistCartRepository.callWishlistAPI(
        GetWishListRequest(
          customerToken: getIt<UserProfileService>().customerToken,
        ),
      );





  /// Makes an API call to add a product to the cart using the new API structure.
  Future<ResponseHandler<BaseResponse<CartOperationResponseModel>>> addToCartListApi({
    required String qty,
    required String entityId,
    required String sku,

  }) async =>
      wishlistCartRepository.addToCartProduct(
        AddToCartRequest(
          languageId:int.tryParse(getIt<LanguageService>().languageId) ?? 0  ,
          websiteId: int.tryParse(getIt<CountryService>().websiteId) ?? 0,
          storeId: getIt<CountryService>().store, // Default store ID as per API requirements
          customerToken: getIt<UserProfileService>().customerToken,
          quoteId: getQuoteIdAsInt(),
          sku: sku,
          platform: getPlatformName(),
          version: getIt<MainConfig>().packageInfo.version,
          productVariant: CartProductVariant(
            entityId: int.tryParse(entityId) ?? 0,
            qty: int.tryParse(qty) ?? 0,
          ),
        ),

      );

  /// Makes an API call to update a product's quantity in the cart using the new API structure.
  Future<ResponseHandler<BaseResponse<CartOperationResponseModel>>> updateToCartListApi({
    required String entityId,
    required String qty,
    required String sku,
  }) async =>
      wishlistCartRepository.callUpdateCartAPI(
        UpdateToCartRequest(
          languageId:int.tryParse(getIt<LanguageService>().languageId) ?? 0  ,
          websiteId: int.tryParse(getIt<CountryService>().websiteId) ?? 0,
          storeId: getIt<CountryService>().store, // Default store ID as per API requirements

          customerToken: getIt<UserProfileService>().customerToken,
          quoteId: getQuoteIdAsInt(),
          sku: sku,
          platform: getPlatformName(),
          version: getIt<MainConfig>().packageInfo.version,
          productVariant: CartProductVariant(
            entityId: int.tryParse(entityId) ?? 0,
            qty: int.tryParse(qty) ?? 0,
          ),
        ),

      );

  /// Makes an API call to remove a product from the cart using the new API structure.
  Future<ResponseHandler<BaseResponse<CartOperationResponseModel>>> removeToCartListApi({
    required String sku,
  }) async =>
      wishlistCartRepository.callRemoveCartAPI(
        RemoveToCartRequest(
          languageId: int.tryParse(getIt<LanguageService>().languageId) ?? 2,
          customerToken: getIt<UserProfileService>().customerToken,
          quoteId: getQuoteIdAsInt(),
          sku: sku,
          platform: getPlatformName(),
          version: getIt<MainConfig>().packageInfo.version,
        ),

      );

  /// Makes an API call to add a product to the wishlist using the new API structure.
  Future<ResponseHandler<AddWishlistModel>> addToWishlistAPI({
    required AddWishlistRequest wishListParams,
  }) async =>
      wishlistCartRepository.callAddToWishlistAPI(
        wishListParams: wishListParams,
      );

  /// Makes an API call to remove a product from the wishlist using the new API structure.
  Future<ResponseHandler<BaseResponse<void>>> removeFromWishlistAPI({
    required RemoveWishlistRequest removeWishlistParams,
  }) async =>
      wishlistCartRepository.callRemoveFromWishlistAPI(
        removeWishlistParams: removeWishlistParams,
      );



  /// Helper method to create AddWishlistRequest with proper parameters
  AddWishlistRequest createAddWishlistRequest(String sku) {
    return AddWishlistRequest(
      languageId: int.tryParse(getIt<LanguageService>().languageId) ?? 2,
      customerToken: getIt<UserProfileService>().customerToken,
      sku: sku,
      platform: getPlatformName(),
      version: getIt<MainConfig>().packageInfo.version,
    );
  }

  /// Helper method to create RemoveWishlistRequest with proper parameters
  RemoveWishlistRequest createRemoveWishlistRequest(String sku) {
    return RemoveWishlistRequest(
      languageId: int.tryParse(getIt<LanguageService>().languageId) ?? 2,
      customerToken: getIt<UserProfileService>().customerToken,
      sku: sku,
      platform: getPlatformName(),
      version: getIt<MainConfig>().packageInfo.version,
    );
  }
}
