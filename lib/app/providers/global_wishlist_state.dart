import '../../utils/exports.dart';

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

