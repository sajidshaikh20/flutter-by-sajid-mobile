import '../../../utils/exports.dart';

/// A Cubit class for managing the state of the user's wish list.
class WishListCubit extends BaseCubit<WishListState>
    {
  /// Constructor for WishListCubit, initializes with loading state and
  /// fetches data.
  WishListCubit()
      : super(
          WishListState(
            status: BaseStateStatus.loading,
            scrollController: ScrollController(),
          ),
        ) {
    // Initialize the mixin's dependency here

    unawaited(getWishlistData());
    _setUpScrollListener();

    // Listen to global wishlist and cart changes
    scheduleMicrotask(() {
      final GlobalWishlistManager globalWishlistManager =
          getIt<GlobalWishlistManager>();
      _globalWishlistSubscription = globalWishlistManager.stream.listen((GlobalWishlistState newState) {
        DebugLog.instance.d('🔄 WISHLIST: Global state changed, syncing wishlist and cart');
        // Always sync with cart changes (wishlist items need to show cart status)
        // But do it safely without interfering with ongoing operations

        // Only sync wishlist if wishlist data actually changed
      });
    });
  }

  /// Fetches the data for the user's wish list by calling the API.
  Future<void> getWishlistData() async {

  }



  final WishlistRepository _repository = WishlistRepositoryImpl();

  /// Stream subscription for global wishlist manager
  StreamSubscription<GlobalWishlistState>? _globalWishlistSubscription;




  /// Handle cart operations for wishlist items
  /// This method handles add, increase, decrease, and remove cart operations
  /// Can be called for main product or specific variant
  Future<void> handleCartOperationForWishlist({
    required int productIndex,
    required CartOperation operation,
    int? variantIndex, // Optional: specify which variant to use
  }) async {
    // Don't perform cart operations if wishlist is empty
    if (state.action == WishListAction.wishListNoData ||
        state.wishlistModelWithProducts == null) {
      return;
    }
  }


  /// Handle variant cart operations for wishlist items
  /// This method handles cart operations for specific variants
  Future<void> handleVariantCartOperationForWishlist({
    required int productIndex,
    required int variantIndex,
    required CartOperation operation,
  }) async {
    await handleCartOperationForWishlist(
      productIndex: productIndex,
      operation: operation,
      variantIndex: variantIndex,
    );
  }

  /// Clears the current message from the wishlist state
  void clearMessage() {
    if (state.message.isNotEmpty) {
      emit(state.copyWith(message: ''));
    }
  }

  /// Refresh wishlist data
  Future<void> refreshWishlist() async {
    // DebugLog.instance.d('Wishlist: Refreshing wishlist');

    // Set refreshing state to true
    emit(state.copyWith(isRefreshing: true));


    // Set refreshing state to false after API call completes
    emit(state.copyWith(isRefreshing: false));
  }

  @override
  WishListState getResetErrorState() {
    return state.copyWith(
      message: '',
      status: BaseStateStatus.initial,
    );
  }

  @override
  WishListState getResetRedirectionState() => state.copyWith();

  /// Sets up a scroll listener to handle infinite scrolling
  void _setUpScrollListener() {
    state.scrollController.addListener(_onScroll);
  }

  /// Handle scroll events for infinite scroll pagination
  void _onScroll() {
    if (state.scrollController.position.pixels >= state.scrollController.position.maxScrollExtent - 200) {
      // Load more when user is 200 pixels from the bottom
      if (state.hasMore && !state.isLoadingMore) {

      }
    }
  }



  /// Disposes resources when the cubit is closed.
  @override
  Future<void> close() async {
    await _globalWishlistSubscription?.cancel();
    state.scrollController.dispose();
    await super.close();
  }
}
