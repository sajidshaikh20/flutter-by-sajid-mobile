import '../../../utils/exports.dart';

/// Abstract class defining methods for wishlist-related operations.
abstract class WishlistRepository extends BaseRepository {
  /// Constructor for WishlistRepository, initializes repository instance.
  WishlistRepository();

  /// Calls the wishlist API with the provided request model and returns the
  /// response.
  Future<ResponseHandler<BaseResponse<List<ProductListingResponse>>>> callWishlistAPI(
      CallWishlistRequestModel callWishlistRequestModel,
  );

  /// Calls the API to remove an item from the wishlist using the new API structure.
  Future<ResponseHandler<BaseResponse<void>>> callRemoveFromWishlistAPI(
      RemoveWishlistRequest removeWishlistRequest,
  );



  /// Adds a product to the cart with the given request model, optionally
  /// showing a loader.
  Future<ResponseHandler<AddToCartModel>> addToCartProduct(
    AddToCartRequest addToCart, {
    bool showLoader = true,
  });
}
