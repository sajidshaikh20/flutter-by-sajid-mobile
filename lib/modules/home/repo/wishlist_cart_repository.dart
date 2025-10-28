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
}
