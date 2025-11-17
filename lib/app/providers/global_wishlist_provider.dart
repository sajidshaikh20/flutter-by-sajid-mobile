import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../utils/exports.dart';
import 'global_wishlist_state.dart';

/// Notifier for managing global wishlist and cart state (Riverpod version).
class GlobalWishlistNotifier extends StateNotifier<GlobalWishlistState> {
  /// Creates a [GlobalWishlistNotifier] instance.
  GlobalWishlistNotifier() : super(GlobalWishlistState.initial());

  /// Toggle wishlist status for a specific SKU
  void toggleWishlist(String sku, bool isFavorite) {
    DebugLog.instance.d('🔄 GLOBAL WISHLIST: Toggle $sku to $isFavorite');

    final Map<String, bool> updatedWishlist =
        Map<String, bool>.from(state.wishlistMap);

    // Always store the status - don't remove false values, set them explicitly
    updatedWishlist[sku] = isFavorite;

    state = state.copyWith(wishlistMap: updatedWishlist);
    DebugLog.instance
        .d('🔄 GLOBAL WISHLIST: Updated wishlist: $updatedWishlist');
  }

  /// Check if SKU is in wishlist
  bool isInWishlist(String sku) {
    return state.wishlistMap[sku] ?? false;
  }

  /// Get wishlist count
  int get wishlistCount =>
      state.wishlistMap.values.where((bool isFavorite) => isFavorite).length;

  /// Clear all wishlist
  void clearWishlist() {
    state = state.copyWith(
      cartMap: <String, int>{},
      wishlistMap: <String, bool>{},
    );
  }

  // ==================== CART METHODS ====================

  /// Update cart quantity for a specific SKU
  void updateCartQuantity(String sku, int quantity) {
    DebugLog.instance.d('🔄 GLOBAL CART: Update $sku to quantity $quantity');

    final Map<String, int> updatedCart = Map<String, int>.from(state.cartMap);

    if (quantity > 0) {
      updatedCart[sku] = quantity;
    } else {
      updatedCart.remove(sku);
    }

    state = state.copyWith(cartMap: updatedCart);
    DebugLog.instance.d('🔄 GLOBAL CART: Updated cart: $updatedCart');
  }

  /// Add to cart quantity for a specific SKU
  void addToCart(String sku, int quantity) {
    final int currentQuantity = getCartQuantity(sku);
    updateCartQuantity(sku, currentQuantity + quantity);
  }

  /// Remove from cart for a specific SKU
  void removeFromCart(String sku) {
    updateCartQuantity(sku, 0);
  }

  /// Get cart quantity for a specific SKU
  int getCartQuantity(String sku) {
    return state.cartMap[sku] ?? 0;
  }

  /// Check if SKU is in cart
  bool isInCart(String sku) {
    return state.cartMap.containsKey(sku) && (state.cartMap[sku] ?? 0) > 0;
  }
}

/// Provider for GlobalWishlistNotifier.
final StateNotifierProvider<GlobalWishlistNotifier, GlobalWishlistState> globalWishlistProvider =
    StateNotifierProvider<GlobalWishlistNotifier, GlobalWishlistState>((StateNotifierProviderRef<GlobalWishlistNotifier, GlobalWishlistState> ref) {
  return GlobalWishlistNotifier();
});

