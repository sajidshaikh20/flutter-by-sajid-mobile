
import '../../../utils/exports.dart';

/// Extension methods for ProductList to handle updates.
extension ProductListExtension on ProductList {
  /// Returns a copy of ProductList with updates based on the update type.
  ProductList productReturnFromCopy({
     required ProductListUpdateType productListType,
    int? newQty,
    String? itemId,
    StatusOfCart? statusOfCart,
    bool? wishListUpdate,
    String? wishlistId,
  }) {
    switch (productListType) {
      case ProductListUpdateType.qty:
        return copyWith(
          cartQty: newQty,
          itemId: itemId,
          statusOfCart: statusOfCart,
        );
      case ProductListUpdateType.loader:
        return copyWith(statusOfCart: statusOfCart);
      default:
        return copyWith(
          isAddedToWishlist: wishListUpdate,
          wishListItemid: wishlistId,
        );
    }
  }
}
