import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../utils/exports.dart';
import '../state/wishlist_state.dart';

/// Notifier for managing wishlist state (Riverpod version).
class WishListNotifier extends StateNotifier<WishListState> {
  /// Creates a [WishListNotifier] instance.
  WishListNotifier()
      : super(
          WishListState(
            status: BaseStateStatus.success,
            scrollController: ScrollController(),
          ),
        ) {
    // Initialize the mixin's dependency here
    // unawaited(getWishlistData());
    // _setUpScrollListener();
  }

  /// Fetches the data for the user's wish list by calling the API.
  Future<void> getWishlistData() async {
    // Business logic commented out for base template
  }

  /// Clears the current message from the wishlist state
  void clearMessage() {
    if (state.message.isNotEmpty) {
      state = state.copyWith(message: '');
    }
  }

  /// Refresh wishlist data
  Future<void> refreshWishlist() async {
    await getWishlistData();
  }
}

/// Provider for WishListNotifier.
final AutoDisposeStateNotifierProvider<WishListNotifier, WishListState> wishListNotifierProvider =
    StateNotifierProvider.autoDispose<WishListNotifier, WishListState>(
  (AutoDisposeStateNotifierProviderRef<WishListNotifier, WishListState> ref) {
    return WishListNotifier();
  },
);

