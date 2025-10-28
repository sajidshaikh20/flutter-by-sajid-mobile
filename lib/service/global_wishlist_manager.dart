import '../utils/exports.dart';

/// Simple global wishlist and cart manager
/// Manages wishlist and cart state across all screens using SKU as unique key
class GlobalWishlistManager extends Cubit<GlobalWishlistState> {
  ///GlobalWishlistManager
  GlobalWishlistManager() : super(GlobalWishlistState.initial());

  /// Toggle wishlist status for a specific SKU
  void toggleWishlist(String sku, bool isFavorite) {
    DebugLog.instance.d('🔄 GLOBAL WISHLIST: Toggle $sku to $isFavorite');

    final Map<String, bool> updatedWishlist =
        Map<String, bool>.from(state.wishlistMap);

    // Always store the status - don't remove false values, set them explicitly
    updatedWishlist[sku] = isFavorite;

    emit(state.copyWith(wishlistMap: updatedWishlist));
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
    emit(state
        .copyWith(cartMap: <String, int>{}, wishlistMap: <String, bool>{}));
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

    emit(state.copyWith(cartMap: updatedCart));
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

/// Global wishlist and cart state
class GlobalWishlistState extends Equatable {
  /// wishlistMap variable
  final Map<String, bool> wishlistMap;

  ///cartMap variable
  final Map<String, int> cartMap;

  ///constructor
  const GlobalWishlistState({
    required this.wishlistMap,
    required this.cartMap,
  });

  ///initial
  factory GlobalWishlistState.initial() {
    return const GlobalWishlistState(
      wishlistMap: <String, bool>{},
      cartMap: <String, int>{},
    );
  }

  ///copyWith
  GlobalWishlistState copyWith({
    Map<String, bool>? wishlistMap,
    Map<String, int>? cartMap,
  }) {
    return GlobalWishlistState(
      wishlistMap: wishlistMap ?? this.wishlistMap,
      cartMap: cartMap ?? this.cartMap,
    );
  }

  @override
  List<Object?> get props => <Object?>[wishlistMap, cartMap];
}
