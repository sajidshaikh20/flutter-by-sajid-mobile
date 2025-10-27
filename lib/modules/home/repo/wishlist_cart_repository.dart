import '../../../utils/exports.dart';

/// Abstract repository for wishlist and cart operations.
abstract class WishlistCartRepository extends BaseRepository {
  /// Creates an instance of [WishlistCartRepository].
  WishlistCartRepository();

  /// Calls the get wishlist API.
  ///
  /// [getWishList] The request parameters for getting wishlist.
  ///
  /// Returns a [ResponseHandler] containing [WishlistModel] with the wishlist data.
  Future<ResponseHandler<WishlistModel>> callWishlistAPI(GetWishListRequest getWishList);

  /// Calls the add to wishlist API.
  ///
  /// [wishListParams] The request parameters for adding to wishlist.
  ///
  /// Returns a [ResponseHandler] containing [AddWishlistModel] with the operation result.
  Future<ResponseHandler<AddWishlistModel>> callAddToWishlistAPI(
      {required AddWishlistRequest wishListParams});

  /// Calls the remove from wishlist API.
  ///
  /// [removeWishlistParams] The request parameters for removing from wishlist.
  ///
  /// Returns a [ResponseHandler] containing [BaseResponse<void>] with the operation result.
  Future<ResponseHandler<BaseResponse<void>>> callRemoveFromWishlistAPI(
      {required RemoveWishlistRequest removeWishlistParams});

  /// Calls the delete wishlist API.
  ///
  /// [deleteWishlist] The request parameters for deleting wishlist.
  ///
  /// Returns a [ResponseHandler] containing [WishlistModel] with the updated wishlist data.
  Future<ResponseHandler<WishlistModel>> callDeleteWishlistAPI(DeleteWishlistRequest deleteWishlist);



  /// Calls the add to cart API.
  ///
  /// [addToCart] The request parameters for adding to cart.
  /// [showLoader] Whether to show loading indicator. Defaults to true.
  ///
  /// Returns a [ResponseHandler] containing [BaseResponse<CartOperationResponseModel>]
  /// with the cart operation result.
  Future<ResponseHandler<BaseResponse<CartOperationResponseModel>>> addToCartProduct(
      AddToCartRequest addToCart,{bool showLoader = true});

  /// Calls the update cart API.
  ///
  /// [updateToCart] The request parameters for updating cart.
  /// [showLoader] Whether to show loading indicator. Defaults to true.
  ///
  /// Returns a [ResponseHandler] containing [BaseResponse<CartOperationResponseModel>]
  /// with the cart operation result.
  Future<ResponseHandler<BaseResponse<CartOperationResponseModel>>> callUpdateCartAPI(
      UpdateToCartRequest updateToCart,{bool showLoader = true});

  /// Calls the remove from cart API.
  ///
  /// [removeToCart] The request parameters for removing from cart.
  /// [showLoader] Whether to show loading indicator. Defaults to true.
  ///
  /// Returns a [ResponseHandler] containing [BaseResponse<CartOperationResponseModel>]
  /// with the cart operation result.
  Future<ResponseHandler<BaseResponse<CartOperationResponseModel>>> callRemoveCartAPI(
      RemoveToCartRequest removeToCart,
      {bool showLoader = true}
      );

  /// Calls the get cart listing API.
  ///
  /// [removeToCart] The request parameters for cart listing.
  /// [showLoader] Whether to show loading indicator. Defaults to true.
  ///
  /// Returns a [ResponseHandler] containing [BaseResponse<CartDetailsListingResponseModel>]
  /// with the cart listing data.
  Future<ResponseHandler<BaseResponse<CartDetailsListingResponseModel>>> getCartListing(
      CartListingRequest removeToCart,
      {bool showLoader = true}
      );
}
