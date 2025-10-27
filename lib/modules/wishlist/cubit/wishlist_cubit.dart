import '../../../utils/exports.dart';

/// A Cubit class for managing the state of the user's wish list.
class WishListCubit extends BaseCubit<WishListState>
    with WishlistCartMixin<WishListState>, CartOperationMixin<WishListState> {
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
    wishlistCartRepository = WishlistCartRepositoryImpl();
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
         _syncWithGlobalCart();
        _syncWithGlobalWishlist();
        // Only sync wishlist if wishlist data actually changed
      });
    });
  }

  /// Fetches the data for the user's wish list by calling the API.
  Future<void> getWishlistData() async {
    await _callWishlistAPI();
  }

  /// Loads more wishlist items for pagination
  Future<void> loadMoreWishlistItems() async {
    if (!state.hasMore || state.isLoadingMore) {
      return;
    }

    // DebugLog.instance.i('Wishlist: Loading more items - Page: ${state.currentPage + 1}');

    // Set loading more state
    emit(state.copyWith(isLoadingMore: true));

    // Calculate next offset based on current page
    final int nextOffset = state.currentPage * AppConstant.limitProduct;

    try {
      final UserProfileService userProfileService = getIt<UserProfileService>();
      final CallWishlistRequestModel requestModel = CallWishlistRequestModel(
        customerToken: userProfileService.customerToken,
        platform: getPlatformName(),
        version: getIt<MainConfig>().packageInfo.version,
        languageId: int.tryParse(getIt<LanguageService>().languageId) ?? 1,
        storeId: getIt<CountryService>().store,
        limit: AppConstant.limitProduct,
        offset: nextOffset,
        quoteId: userProfileService.quoteId is int
            ? userProfileService.quoteId
            : int.tryParse(userProfileService.quoteId?.toString() ?? '') ?? 0,
      );
      final ResponseHandler<BaseResponse<List<ProductListingResponse>>> value =
          await _repository.callWishlistAPI(requestModel);

      if (value.isSuccess()) {
        final BaseResponse<List<ProductListingResponse>>? response =
            value.getSuccessInstance()?.response;

        if (response?.success ?? false) {
          final List<ProductListingResponse> products =
              response?.data ?? <ProductListingResponse>[];

          // Combine with existing products
          final List<ProductListingResponse> updatedProducts =
              <ProductListingResponse>[
            ...(state.wishlistModelWithProducts?.products ??
                <ProductListingResponse>[]),
            ...products,
          ];

          // Calculate pagination info
          final int apiTotalCount = response?.totalCount ?? 0;
          final bool hasMoreData = updatedProducts.length < apiTotalCount;

          // Create WishlistModelWithProducts with the products
          final WishlistModelWithProducts wishlistModel =
              WishlistModelWithProducts(
            success: true,
            message: response?.message ?? "",
            totalCount: apiTotalCount,
            products: updatedProducts,
          );

          // Update global wishlist manager with the new products
          getIt<GlobalWishlistManager>().storeProductsFromAPI(products);
          DebugLog.instance.d('🔄 WISHLIST: Updated global manager with additional ${products.length} wishlist items');

          emit(state.copyWith(
            status: BaseStateStatus.success,
            wishlistModelWithProducts: wishlistModel,
            isLoadingMore: false,
            currentPage: state.currentPage + 1,
            hasMore: hasMoreData,
            totalCount: apiTotalCount,
          ));

          DebugLog.instance.d(
              'Wishlist Load More Complete - Page: ${state.currentPage + 1}, Products: ${updatedProducts.length}, Has More: $hasMoreData');
        } else {
          emit(state.copyWith(
            status: BaseStateStatus.failure,
            isLoadingMore: false,
            error: response?.message ?? '',
          ));
        }
      } else if (value.isFailure()) {
        emit(state.copyWith(
          status: BaseStateStatus.failure,
          isLoadingMore: false,
          error: value.getFailureInstance()?.error?.errorMessage ?? '',
        ));
      }
    } on Exception catch (e) {
      emit(state.copyWith(
        status: BaseStateStatus.failure,
        isLoadingMore: false,
        error: e.toString(),
      ));
    }
  }

  final WishlistRepository _repository = WishlistRepositoryImpl();

  /// Stream subscription for global wishlist manager
  StreamSubscription<GlobalWishlistState>? _globalWishlistSubscription;

  /// Call the API to get wishlist data
  Future<void> _callWishlistAPI() async {
    emit(state.copyWith(
      status: BaseStateStatus.loading,
      action: WishListAction.wishListInitial,
    ));

    try {
      final UserProfileService userProfileService = getIt<UserProfileService>();
      final CallWishlistRequestModel requestModel = CallWishlistRequestModel(
        customerToken: userProfileService.customerToken,
        platform: getPlatformName(),
        version: getIt<MainConfig>().packageInfo.version,
        languageId: int.tryParse(getIt<LanguageService>().languageId) ?? 1,
        storeId: getIt<CountryService>().store,
        limit: AppConstant.limitProduct,
        offset: 0, // Always start from 0 for fresh load
        quoteId: userProfileService.quoteId is int
            ? userProfileService.quoteId
            : int.tryParse(userProfileService.quoteId?.toString() ?? '') ?? 0,
      );

      final ResponseHandler<BaseResponse<List<ProductListingResponse>>> value =
          await _repository.callWishlistAPI(requestModel);

      if (value.isSuccess()) {
        final BaseResponse<List<ProductListingResponse>>? response =
            value.getSuccessInstance()?.response;

        // Check if API returned success: false (like "Wishlist not Found")
        if (response?.success == false) {
          // API returned success: false with empty data - treat as no data state
          emit(
            state.copyWith(
              status: BaseStateStatus.success,
              wishlistModelWithProducts: WishlistModelWithProducts(
                success: false,
                message: response?.message ?? '',
                totalCount: 0,
                products: <ProductListingResponse>[],
              ),
              action: WishListAction.wishListNoData,
              totalCount: 0,
              currentPage: 1,
              hasMore: false,
              isLoadingMore: false,
            ),
          );
        } else {
          // API returned success: true - process data
          final List<ProductListingResponse> products =
              response?.data ?? <ProductListingResponse>[];

          // Get pagination info from API
          final int apiTotalCount = response?.totalCount ?? 0;
          final bool hasMoreData = products.length < apiTotalCount;

          // If we have data, set loaded action, otherwise set no data action
          final WishListAction action = products.isNotEmpty
              ? WishListAction.wishListLoaded
              : WishListAction.wishListNoData;

          // Create WishlistModelWithProducts with the products
          final WishlistModelWithProducts wishlistModel =
              WishlistModelWithProducts(
            success: true,
            message: response?.message ?? "",
            totalCount: apiTotalCount,
            products: products,
          );

          // Update global wishlist manager with the loaded products
          if (products.isNotEmpty) {
            getIt<GlobalWishlistManager>().storeProductsFromAPI(products);
            DebugLog.instance.d('🔄 WISHLIST: Updated global manager with ${products.length} wishlist items');
          }

          emit(
            state.copyWith(
              status: BaseStateStatus.success,
              wishlistModelWithProducts: wishlistModel,
              action: action,
              totalCount: apiTotalCount,
              currentPage: 1,
              // Fresh load always starts from page 1
              hasMore: hasMoreData,
              isLoadingMore: false,
            ),
          );
        }
      } else if (value.isFailure()) {
        emit(
          state.copyWith(
            status: BaseStateStatus.failure,
            error: value.getFailureInstance()?.error?.errorMessage ?? '',
            isLoadingMore: false,
          ),
        );
      }
    } on Exception catch (e) {
      // Provide more user-friendly error messages for common exceptions
      String errorMessage = 'Unable to load wishlist. Please try again.';
      if (e.toString().contains('DioException') && e.toString().contains('500')) {
        errorMessage = 'Server error occurred. Please try again later.';
      } else if (e.toString().contains('SocketException') || e.toString().contains('Connection refused')) {
        errorMessage = 'No internet connection. Please check your connection and try again.';
      } else if (e.toString().contains('TimeoutException')) {
        errorMessage = 'Request timed out. Please try again.';
      }

      emit(
        state.copyWith(
          status: BaseStateStatus.failure,
          error: errorMessage,
          isLoadingMore: false,
        ),
      );
    }
  }

  /// Call the API to delete an item from the wishlist and update the state
  /// accordingly
  Future<void> callDeleteWishlistAPI(
    String selectedItemIndex,
    String sku,
  ) async {
    try {
      // Use the new remove from wishlist API
      final RemoveWishlistRequest removeRequest = RemoveWishlistRequest(
        languageId: int.tryParse(getIt<LanguageService>().languageId) ?? 1,
        customerToken: getIt<UserProfileService>().customerToken,
        sku: sku,
        platform: getPlatformName(),
        version: getIt<MainConfig>().packageInfo.version,
      );

      await _repository.callRemoveFromWishlistAPI(removeRequest).then(
        (ResponseHandler<BaseResponse<void>> value) {
          if (value.isSuccess()) {
            final BaseResponse<void>? response =
                value.getSuccessInstance()?.response;

            if (response?.success ?? false) {
              // Get current wishlist data from state
              final WishlistModelWithProducts? currentWishlist =
                  state.wishlistModelWithProducts;

              if (currentWishlist?.products != null &&
                  currentWishlist!.products!.isNotEmpty) {
                // Find the product by SKU instead of index for more reliable deletion
                final List<ProductListingResponse> updatedProducts =
                    List<ProductListingResponse>.from(
                        currentWishlist.products!);
                final int indexToRemove = updatedProducts.indexWhere(
                    (ProductListingResponse product) => product.sku == sku);

                if (indexToRemove != -1) {
                  updatedProducts.removeAt(indexToRemove);

                  // Create updated wishlist model
                  final WishlistModelWithProducts updatedWishlist =
                      WishlistModelWithProducts(
                    success: currentWishlist.success,
                    message: currentWishlist.message,
                    totalCount: currentWishlist.totalCount,
                    products: updatedProducts,
                  );

                  if (updatedProducts.isEmpty) {
                    // No items left in wishlist
                    emit(
                      state.copyWith(
                        status: BaseStateStatus.success,
                        action: WishListAction.wishListNoData,
                        message: response?.message ?? '',
                      ),
                    );
                  } else {
                    // Still have items in wishlist
                    emit(
                      state.copyWith(
                        status: BaseStateStatus.success,
                        action: WishListAction.wishListDeletedSuccessfully,
                        wishlistModelWithProducts: updatedWishlist,
                        message: response?.message ?? '',
                      ),
                    );
                  }
                } else {
                  // Product not found by SKU, refresh the wishlist
                  unawaited(_callWishlistAPI());
                }
              } else {
                // No current wishlist data, refresh
                unawaited(_callWishlistAPI());
              }
            } else {
              emit(
                state.copyWith(
                  status: BaseStateStatus.failure,
                  action: WishListAction.wishListFailed,
                  error: response?.message ?? '',
                ),
              );
            }
          } else if (value.isFailure()) {
            emit(
              state.copyWith(
                status: BaseStateStatus.failure,
                action: WishListAction.wishListFailed,
                error: value.getFailureInstance()?.error?.errorMessage ?? '',
              ),
            );
          }
        },
      );
    } on Exception catch (e) {
      // Provide more user-friendly error messages for common exceptions
      String errorMessage = 'Failed to remove item from wishlist. Please try again.';
      if (e.toString().contains('DioException') && e.toString().contains('500')) {
        errorMessage = 'Server error occurred. Item could not be removed.';
      } else if (e.toString().contains('SocketException') || e.toString().contains('Connection refused')) {
        errorMessage = 'No internet connection. Please check your connection and try again.';
      } else if (e.toString().contains('TimeoutException')) {
        errorMessage = 'Request timed out. Please try again.';
      }

      emit(
        state.copyWith(
          status: BaseStateStatus.failure,
          action: WishListAction.wishListFailed,
          error: errorMessage,
        ),
      );
    }
  }

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

    // Get current wishlist products from state
    final List<ProductListingResponse> currentProducts =
        state.wishlistModelWithProducts?.products ?? <ProductListingResponse>[];

    // Use the common mixin method
    await handleCartOperation(
        productIndex: productIndex,
        products: currentProducts,
        operation: operation,
        variantIndex: variantIndex,
        updateProductCartQuantity: (int productIndex,
            int cartQuantity,
            BaseStateStatus cartOperationStatus,
            String message,
            int? variantIndex,
            int? apiCartCount) {
          _updateWishlistProductCartQuantity(
            productIndex: productIndex,
            cartQuantity: cartQuantity,
            cartOperationStatus: cartOperationStatus,
            message: message,
            variantIndex: variantIndex,
            apiCartCount: apiCartCount,
          );
        },
        addToCartApi: addToCartListApi,
        removeFromCartApi: removeToCartListApi,
        updateToCartApi: updateToCartListApi);
  }

  /// Update product cart quantity in wishlist
  void _updateWishlistProductCartQuantity({
    required int productIndex,
    required int cartQuantity,
    required BaseStateStatus cartOperationStatus,
    required String message,
    int? variantIndex, // Optional: specify which variant to update
    int? apiCartCount, // Cart count from API response
  }) {
    final WishlistModelWithProducts? currentWishlist =
        state.wishlistModelWithProducts;
// Don't update if wishlist is empty or if we're in no data state
    if (currentWishlist?.products == null ||
        productIndex < 0 ||
        productIndex >= currentWishlist!.products!.length ||
        state.action == WishListAction.wishListNoData) {
      return;
    }

    final List<ProductListingResponse> currentProductList =
        List<ProductListingResponse>.from(currentWishlist.products!);
    final ProductListingResponse product = currentProductList[productIndex];

    ProductListingResponse updatedProduct;

    if (variantIndex != null &&
        product.productVariant != null &&
        variantIndex < product.productVariant!.length) {
      // Update specific variant cart quantity
      final List<ProductVariantDukkan> updatedVariants =
          List<ProductVariantDukkan>.from(product.productVariant!);
      updatedVariants[variantIndex] = updatedVariants[variantIndex].copyWith(
        cartQuantity: cartQuantity,
      );

      // Update the product with updated variants
      updatedProduct = product.copyWith(
        productVariant: updatedVariants,
      );
    } else {
      // Update main product cart quantity
      updatedProduct = product.copyWith(
        cartQuantity: cartQuantity,
        isCart: cartQuantity > 0,
      );
    }

    currentProductList[productIndex] = updatedProduct;

    // Create updated wishlist model
    final WishlistModelWithProducts updatedWishlist = WishlistModelWithProducts(
      success: currentWishlist.success,
      message: currentWishlist.message,
      totalCount: currentWishlist.totalCount,
      products: currentProductList,
    );

    // Update cart count from API response if available, otherwise use local calculation
    if (cartOperationStatus == BaseStateStatus.success) {
      if (apiCartCount != null) {
        // Use the cart count from API response (this is the correct approach)
        getIt<CartCountCubit>().updateCount(apiCartCount);
        DebugLog.instance.i('Updated cart count from API: $apiCartCount');
      } else {
        // Fallback: calculate total cart count from all products
        int totalCartCount = 0;
        for (final ProductListingResponse product in currentProductList) {
          totalCartCount += product.cartQuantity ?? 0;
          // Add variant cart quantities if they exist
          if (product.productVariant != null) {
            for (final ProductVariantDukkan variant
                in product.productVariant!) {
              totalCartCount += variant.cartQuantity ?? 0;
            }
          }
        }
        getIt<CartCountCubit>().updateCount(totalCartCount);
        DebugLog.instance
            .i('Updated cart count from local calculation: $totalCartCount');
      }
    }

    // Emit the updated state - use cartOperationStatus for cart operations, keep main status as success
    emit(
      state.copyWith(
        wishlistModelWithProducts: updatedWishlist,
        message: message,
        // Use cartOperationStatus for cart operations, keep main status as success to prevent page reload
        cartOperationStatus: cartOperationStatus,
      ),
    );
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

    await _callWishlistAPI();

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
        unawaited(loadMoreWishlistItems());
      }
    }
  }

  /// Simple sync with global cart
  void _syncWithGlobalCart() {
    DebugLog.instance.d('🔄 WISHLIST: Syncing with global cart');

    try {
      final GlobalWishlistManager globalWishlistManager =
          getIt<GlobalWishlistManager>();
      final Map<String, int> globalCart = globalWishlistManager.state.cartMap;

      DebugLog.instance.d('🔄 WISHLIST: Global cart: $globalCart');

      final WishlistModelWithProducts? currentWishlist =
          state.wishlistModelWithProducts;

      if (currentWishlist?.products == null ||
          currentWishlist!.products!.isEmpty) {
        DebugLog.instance.d('🔄 WISHLIST: No current wishlist data to sync cart');
        return;
      }

      // Update products with global cart quantities
      final List<ProductListingResponse> updatedProducts =
          currentWishlist.products!.map((ProductListingResponse product) {
        if (product.sku == null || product.sku!.isEmpty) {
          return product; // Keep products without SKU as-is
        }

        // Update product variants with global cart quantities
        if (product.productVariant != null &&
            product.productVariant!.isNotEmpty) {
          final List<ProductVariantDukkan> updatedVariants =
              product.productVariant!.map((ProductVariantDukkan variant) {
            final String? variantEntityId = variant.entityId?.toString();
            final int currentCartQuantity = variant.cartQuantity ?? 0;
            int globalCartQuantity = 0;

            if (variantEntityId != null && variantEntityId.isNotEmpty) {
              final String cartKey = '${product.sku}_$variantEntityId';
              globalCartQuantity = globalCart[cartKey] ?? 0;
            }

          if (currentCartQuantity != globalCartQuantity) {
          DebugLog.instance.d(
              '🔄 WISHLIST: Update variant $variant.name cart quantity from $currentCartQuantity to $globalCartQuantity');
              return variant.copyWith(
                cartQuantity: globalCartQuantity,
                isCart: globalCartQuantity > 0,
              );
            }
            return variant;
          }).toList();

          return product.copyWith(productVariant: updatedVariants);
        }

        return product;
      }).toList();

      // Emit updated wishlist with cart quantities
      final WishlistModelWithProducts updatedWishlist =
          WishlistModelWithProducts(
            success: currentWishlist.success,
            message: currentWishlist.message,
            totalCount: currentWishlist.totalCount,
            products: updatedProducts,
          );

      emit(state.copyWith(wishlistModelWithProducts: updatedWishlist));
      DebugLog.instance.d('🔄 WISHLIST: Successfully synced with global cart');

    } on Exception catch (e) {
      DebugLog.instance.e('🔄 WISHLIST: Error syncing with global cart: $e');
    }
  }

  /// Sync wishlist with global wishlist state
  /// This method ensures that when items are removed from wishlist in other screens,
  /// they are also removed from the current wishlist screen
  /// Also handles when new items are added to wishlist from other screens
  void _syncWithGlobalWishlist() {
    DebugLog.instance.d('🔄 WISHLIST: Syncing with global wishlist');

    try {
      final GlobalWishlistManager globalWishlistManager =
          getIt<GlobalWishlistManager>();
      final Map<String, bool> globalWishlist =
          globalWishlistManager.state.wishlistMap;

      DebugLog.instance.d('🔄 WISHLIST: Global wishlist: $globalWishlist');

      final WishlistModelWithProducts? currentWishlist =
          state.wishlistModelWithProducts;

      if (currentWishlist?.products == null ||
          currentWishlist!.products!.isEmpty) {
        // If we have no local wishlist data but global wishlist has items,
        // refresh the wishlist to get the latest data
        if (globalWishlist.isNotEmpty) {
          DebugLog.instance.d('🔄 WISHLIST: No local data but global has items, refreshing wishlist');
          unawaited(_callWishlistAPI());
          return;
        }
        DebugLog.instance.d('🔄 WISHLIST: No current wishlist data to sync');
        return;
      }

      // Get current wishlist SKUs
      final Set<String> currentWishlistSkus = currentWishlist.products!
          .where((ProductListingResponse product) => product.sku != null && product.sku!.isNotEmpty)
          .map((ProductListingResponse product) => product.sku!)
          .toSet();

      // Check if there are new items in global wishlist that aren't in local wishlist
      final Set<String> newItemsInGlobal = globalWishlist.keys
          .where((String sku) => globalWishlist[sku] ?? false)
          .toSet()
          .difference(currentWishlistSkus);

      // If new items were added to global wishlist, refresh to get complete data
      if (newItemsInGlobal.isNotEmpty) {
        DebugLog.instance.d('🔄 WISHLIST: New items added to global wishlist: $newItemsInGlobal, refreshing wishlist');
        unawaited(_callWishlistAPI());
        return;
      }

      // Check if any products in the current wishlist are no longer in the global wishlist
      // Only remove items that are explicitly marked as false in global wishlist
      // If an item is not in the global wishlist map at all, keep it (it might be from a different screen/context)
      final List<ProductListingResponse> updatedProducts =
          currentWishlist.products!.where((ProductListingResponse product) {
        if (product.sku == null || product.sku!.isEmpty) {
          return true; // Keep products without SKU
        }

        // Only remove if explicitly marked as false in global wishlist
        // If not present in global wishlist or marked as true, keep the item
        final bool? isInGlobalWishlist = globalWishlist[product.sku];
        if (isInGlobalWishlist == false) {
          DebugLog.instance.d('🔄 WISHLIST: Removing ${product.sku} from wishlist (explicitly marked as not favorite in global)');
          return false; // Remove this item
        }
        // Keep items that are either not in global wishlist or marked as true
        return true;
      }).toList();

      // If products were removed, update the wishlist
      if (updatedProducts.length != currentWishlist.products!.length) {
        final WishlistModelWithProducts updatedWishlist =
            WishlistModelWithProducts(
          success: currentWishlist.success,
          message: currentWishlist.message,
          totalCount: updatedProducts.length,
          products: updatedProducts,
        );

        if (updatedProducts.isEmpty) {
          // No items left in wishlist
          emit(
            state.copyWith(
              status: BaseStateStatus.success,
              action: WishListAction.wishListNoData,
              wishlistModelWithProducts: updatedWishlist,
            ),
          );
          DebugLog.instance.d('🔄 WISHLIST: Wishlist is now empty after sync');
        } else {
          // Still have items in wishlist
          emit(
            state.copyWith(
              status: BaseStateStatus.success,
              action: WishListAction.wishListLoaded,
              wishlistModelWithProducts: updatedWishlist,
            ),
          );
          DebugLog.instance.d(
              '🔄 WISHLIST: Updated wishlist with ${updatedProducts.length} items after sync');
        }
      } else {
        DebugLog.instance.d('🔄 WISHLIST: No changes needed after sync');
      }
    } on Exception catch (e) {
      DebugLog.instance
          .e('🔄 WISHLIST: Error syncing with global wishlist: $e');
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
