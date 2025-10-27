import '../../../utils/exports.dart';

/// ProductDetailsCubit
class ProductDetailsCubit extends BaseCubit<ProductDetailsState>
    with
        WishlistCartMixin<ProductDetailsState>,
        CartOperationMixin<ProductDetailsState> {
  ///
  ProductDetailsCubit({
    required this.entityId,
    required WishlistCartRepository wishlistCartRepository,
    required this.detailsRepository,
  }) : super(ProductDetailsState.initial()) {
    this.wishlistCartRepository = wishlistCartRepository;
    scheduleMicrotask(() async =>
        getProductDetails(entityId)); // Load initial data on startup

    // Listen to global wishlist changes
    scheduleMicrotask(() {
      final GlobalWishlistManager globalWishlistManager =
          getIt<GlobalWishlistManager>();
      _globalWishlistSubscription = globalWishlistManager.stream.listen((GlobalWishlistState newState) {
        DebugLog.instance.d('🔄 PDP: Global state changed, syncing PDP');
        // Always sync with cart changes
        _syncWithGlobalCart();
        _syncRelatedProductsWithGlobalCart();
        _syncTrendingProductsWithGlobalCart();
        // Only sync wishlist if wishlist data actually changed
          _syncWithGlobalWishlist();
          _syncRelatedProductsWithGlobalWishlist();
          _syncTrendingProductsWithGlobalWishlist();
      });
    });
  }

  /// The ID of the entity for which to fetch product details.
  final int entityId;

  /// The repository used to fetch product details.
  final ProductDetailsRepository detailsRepository;

  /// Stream subscription for global wishlist manager
  StreamSubscription<GlobalWishlistState>? _globalWishlistSubscription;

  /// Variables to track API timing
  DateTime? _firstApiStartTime;
  DateTime? _lastApiEndTime;
  int _completedApiCount = 0;
  final int _totalApiCount =
      4; // Total number of APIs called in product details

  ///emit error state
  void _emitError(String error) {
    emit(
      state.copyWith(
        statusForProductDetails: BaseStateStatus.failure,
        msg: error,
      ),
    );
  }

  /// Helper method to track API completion and calculate total time
  void _trackApiCompletion(String apiName) {
    _completedApiCount++;
    _lastApiEndTime = DateTime.now();


    if (_completedApiCount == _totalApiCount && _firstApiStartTime != null) {
      final Duration totalTime =
          _lastApiEndTime!.difference(_firstApiStartTime!);
      DebugLog.instance.d(
          '🎯 PRODUCT DETAILS API TIMING: ALL APIs completed! Total time: ${totalTime.inMilliseconds}ms (${totalTime.inSeconds}s)');
      DebugLog.instance.d(
          '📊 PRODUCT DETAILS API TIMING: First API started at ${_firstApiStartTime!.toIso8601String()}');
      DebugLog.instance.d(
          '📊 PRODUCT DETAILS API TIMING: Last API ended at ${_lastApiEndTime!.toIso8601String()}');
    }
  }

/// api call for the get product details
  Future<void> getProductDetails(int entityId) async {
    emit(
      state.copyWith(
        statusForProductDetails: BaseStateStatus.loading,
        entityId: entityId.toString(),
      ),
    );

    await detailsRepository.getProductDetails(entityId.toString()).then(
        (ResponseHandler<BaseResponse<ProductDetailsResponse>> value) async {
      if (value.isSuccess()) {
        int qty = 1;
        bool isWishList =
            value.getSuccessInstance()?.response.data?.isFavorite ?? false;
        String itemId = '';
        String wishListItemid = '';
        bool isBottomVisible = true;
        bool isButtonEnabled = true;
        if (value.getSuccessInstance()?.response.data?.isComingSoon == 1 &&
            value.getSuccessInstance()?.response.data?.isHolyQuran == 0) {
          isButtonEnabled = false;
        } else if (value.getSuccessInstance()?.response.data?.isHolyQuran ==
            1) {
          isBottomVisible = false;
        } else if (value.getSuccessInstance()?.response.data?.isAvailable ==
            false) {
          isButtonEnabled = false;
          isBottomVisible = false;
        }

        emit(
          state.copyWith(
            isButtonEnabled: isButtonEnabled,
            isBottomVisible: isBottomVisible,
            isAddedToWishlist: isWishList,
            itemId: itemId,
            wishListItemid: wishListItemid,
            quantity: qty,
            initialquantity: qty,
            detailsModel: value.getSuccessInstance()?.response.data,
            statusForProductDetails: BaseStateStatus.success,
            isWishlistSelected:
                value.getSuccessInstance()?.response.data?.isFavorite ?? false,
          ),
        );

        // Generate available units after product details are loaded
        _generateAvailableUnits();

        // Calculate initial cart count from the loaded variants
        final int initialCartCount = _calculateSelectedVariantCartCount();

        // Update state with initial cart count
        emit(state.copyWith(cartCount: initialCartCount));

        // Load related products after product details are loaded
        if (value.getSuccessInstance()?.response.data?.sku != null) {
          scheduleMicrotask(() async => getRelatedProducts(value
              .getSuccessInstance()!
              .response
              .data!
              .sku!)); // Load initial data on startup
        }
        // Load trending products after related products are loaded
        scheduleMicrotask(() async => getTrendingProducts());
        scheduleMicrotask(() async => getProductReview(entityId));
      } else if (value.isFailure()) {
        _emitError(
          value.getFailureInstance()?.error?.errorMessage ?? '',
        );
      }
    });
  }
///shareIconClick
  Future<void> shareIconClick(Size size) async {
    await Share.share(
      sharePositionOrigin: Rect.fromLTWH(0, 0, size.width, size.height / 2),
      state.detailsModel?.shareUrl ?? '',
      subject: AppConstant.shareDetails,
    );
  }

  @override
  Future<void> close() async {
    await _globalWishlistSubscription?.cancel();
    await super.close();
  }

  /// Selects a unit by its index.
  ///
  /// [index] The index of the selected unit.
  void selectUnit(int index) {
    if (index >= 0 && index < state.availableUnits.length) {
      // Update the selected unit and mark it as selected
      final List<ProductVariantDukkan> updatedUnits =
          state.availableUnits.map((ProductVariantDukkan unit) {
        return unit.copyWith(isSelected: false);
      }).toList();

      if (index < updatedUnits.length) {
        updatedUnits[index] = updatedUnits[index].copyWith(isSelected: true);
      }

      emit(state.copyWith(
        selectedUnitIndex: index,
        availableUnits: updatedUnits,
      ));
    }
  }

  /// Generates available units from product data
  void _generateAvailableUnits() {
    final ProductDetailsResponse? product = state.detailsModel;
    if (product == null) return;

    final List<ProductVariantDukkan> units = <ProductVariantDukkan>[];

    // If product has variants, use them
    if (product.productVariant?.isNotEmpty ?? false) {
      for (int i = 0; i < product.productVariant!.length; i++) {
        final ProductVariantDukkan variant = product.productVariant![i];
        units.add(variant.copyWith(isSelected: i == 0));
      }
    } else {
      // Single product - create a single unit from main product
      units.add(ProductVariantDukkan(
        entityId: product.entityId,
        name: product.name,
        thumbNail: product.thumbNail,
        imageLarge: product.imageGallery?.isNotEmpty ?? false
            ? product.imageGallery!.first.url
            : null,
        formattedPrice: product.formattedPrice,
        price: product.price,
        formattedFinalPrice: product.formattedFinalPrice,
        finalPrice: product.finalPrice,
        percentOff: product.percentOff,
        isAvailable: product.isAvailable,
        isSelected: true,
        // Single product is always selected
        quantityLabel: product.sku ?? '',
        sku: product.sku ?? '',
      ));
    }
    emit(state.copyWith(
      availableUnits: units,
      selectedUnitIndex: units.isNotEmpty ? 0 : -1,
    ));
  }

  /// Gets the currently selected unit
  ProductVariantDukkan? getSelectedUnit() {
    if (state.selectedUnitIndex != null &&
        state.selectedUnitIndex! >= 0 &&
        state.selectedUnitIndex! < state.availableUnits.length) {
      return state.availableUnits[state.selectedUnitIndex!];
    }
    return null;
  }

  /// Updates the wishlist selection status.
  ///
  /// [isWishlistSelected] The current wishlist selection status.
  void updateIsWishlistSelected({required bool isWishlistSelected}) {
    emit(state.copyWith(isWishlistSelected: !isWishlistSelected));
  }

  /// Handles wishlist like/dislike functionality for product details
  /// Now uses GlobalWishlistCubit for consistent state management
  Future<void> handleWishlistLikeDislike() async {
    try {
      final String? sku = state.detailsModel?.sku;
      if (sku == null) return;
      emit(state.copyWith(statusForAddToWishList: BaseStateStatus.loading));

      final bool isCurrentlyFavorite = state.detailsModel?.isFavorite ?? false;

      // Use global wishlist manager for state management
      final GlobalWishlistManager globalWishlistManager =
          getIt<GlobalWishlistManager>();

      if (isCurrentlyFavorite) {
        final ResponseHandler<BaseResponse<void>> response =
            await removeFromWishlistAPI(
          removeWishlistParams: createRemoveWishlistRequest(sku),
        );
        if (response.isSuccess()) {
          final BaseResponse<void>? responseData =
              response.getSuccessInstance()?.response;
          if (responseData?.success ?? false) {
            // Update global wishlist state
            globalWishlistManager.toggleWishlist(sku, false);
            DebugLog.instance.d('🔄 PDP: Removed $sku from wishlist');

            emit(
              state.copyWith(
                detailsModel: state.detailsModel?.copyWith(isFavorite: false),
                statusForAddToWishList: BaseStateStatus.success,
                msg: responseData?.message ?? '',
              ),
            );
          } else {
            emit(
              state.copyWith(
                statusForAddToWishList: BaseStateStatus.failure,
                msg: responseData?.message ?? '',
              ),
            );
          }
        } else if (response.isFailure()) {
          emit(
            state.copyWith(
              statusForAddToWishList: BaseStateStatus.failure,
              msg: response.getFailureInstance()?.error?.errorMessage ?? '',
            ),
          );
        }
      } else {
        final ResponseHandler<AddWishlistModel> response =
            await addToWishlistAPI(
          wishListParams: createAddWishlistRequest(sku),
        );

        if (response.isSuccess()) {
          final AddWishlistModel? responseData =
              response.getSuccessInstance()?.response;

          if (responseData?.success ?? false) {
            // Update global wishlist state
            globalWishlistManager.toggleWishlist(sku, true);
            DebugLog.instance.d('🔄 PDP: Added $sku to wishlist');

            emit(
              state.copyWith(
                detailsModel: state.detailsModel?.copyWith(isFavorite: true),
                statusForAddToWishList: BaseStateStatus.success,
                msg: responseData?.message ?? '',
              ),
            );

            // Refresh wishlist data when adding to wishlist
            _refreshWishlistData();
          } else {
            emit(
              state.copyWith(
                statusForAddToWishList: BaseStateStatus.failure,
                msg: responseData?.message ?? '',
              ),
            );
          }
        } else if (response.isFailure()) {
          emit(
            state.copyWith(
              statusForAddToWishList: BaseStateStatus.failure,
              msg: response.getFailureInstance()?.error?.errorMessage ?? '',
            ),
          );
        }
      }
    } on Exception catch (e, stackTrace) {
      DebugLog.instance.e("=== EXCEPTION CAUGHT ===");
      DebugLog.instance.e("Error: $e");
      DebugLog.instance.e("Stack Trace: $stackTrace");

      emit(
        state.copyWith(
          statusForAddToWishList: BaseStateStatus.failure,
          msg: "Exception: $e",
        ),
      );
    }
  }

  /// Clears the wishlist status and message
  void clearWishlistStatus() {
    emit(state.copyWith(
      statusForAddToWishList: BaseStateStatus.initial,
      msg: '',
    ));
  }

  /// api call for the get product review
  Future<void> getProductReview(int entityId) async {
    final DateTime startTime = DateTime.now();
    DebugLog.instance.d(
        '🔄 PRODUCT DETAILS API TIMING: Product Review API started at ${startTime.toIso8601String()}');
    DebugLog.instance.e("=== getProductReview STARTED ===");
    DebugLog.instance.e("Entity ID: $entityId");

    emit(
      state.copyWith(
        statusForReview: BaseStateStatus.loading,
      ),
    );

    DebugLog.instance.e("Calling repository getProductReview...");

    try {
      await detailsRepository.getProductReview(entityId.toString()).then(
          (ResponseHandler<BaseResponse<GetReviewSummaryResponse>> value) {
        if (value.isSuccess()) {
          emit(
            state.copyWith(
              review: value.getSuccessInstance()?.response.data,
              statusForReview: BaseStateStatus.success,
            ),
          );
        } else if (value.isFailure()) {
          emit(
            state.copyWith(
              statusForReview: BaseStateStatus.failure,
              msg: value.getFailureInstance()?.error?.errorMessage ?? '',
            ),
          );
        }
      });
    } on Exception catch (e, stackTrace) {
      DebugLog.instance.e("=== EXCEPTION CAUGHT ===");
      DebugLog.instance.e("Error: $e");
      DebugLog.instance.e("Stack Trace: $stackTrace");

      emit(
        state.copyWith(
          statusForReview: BaseStateStatus.failure,
          msg: "Exception: $e",
        ),
      );
    }

    // Track API completion
    final DateTime endTime = DateTime.now();
    final Duration duration = endTime.difference(startTime);
    DebugLog.instance.d(
        '⏱️ PRODUCT DETAILS API TIMING: Product Review API completed in ${duration.inMilliseconds}ms');
    _trackApiCompletion('Product Review API');

    DebugLog.instance.e("=== getProductReview COMPLETED ===");
  }

  /// api call for the get related products
  Future<void> getRelatedProducts(String productSku) async {
    final DateTime startTime = DateTime.now();
    DebugLog.instance.d(
        '🔄 PRODUCT DETAILS API TIMING: Related Products API started at ${startTime.toIso8601String()}');

    emit(
      state.copyWith(
        statusForRelatedProducts: BaseStateStatus.loading,
      ),
    );
    DebugLog.instance.e("Calling repository getRelatedProducts...");

    try {
      await detailsRepository.getRelatedProducts(productSku).then(
          (ResponseHandler<BaseResponse<List<ProductListingResponse>>> value) {
        DebugLog.instance.e("Repository response received: $value");
        DebugLog.instance.e("Is Success: ${value.isSuccess()}");
        DebugLog.instance.e("Is Failure: ${value.isFailure()}");

        if (value.isSuccess()) {
          DebugLog.instance.e("=== SUCCESS RESPONSE ===");
          DebugLog.instance
              .e("Success Instance: ${value.getSuccessInstance()}");
          DebugLog.instance
              .e("Response: ${value.getSuccessInstance()?.response}");
          DebugLog.instance
              .e("Response Data: ${value.getSuccessInstance()?.response.data}");

          final BaseResponse<List<ProductListingResponse>>? response =
              value.getSuccessInstance()?.response;
          if (response?.data != null) {
            DebugLog.instance
                .e("Related Products Count: ${response!.data!.length}");
            DebugLog.instance.e(
                "Full Related Products Data: ${response.data!.map((ProductListingResponse e) => e.toJson())}");
          } else {
            DebugLog.instance.e("ERROR: Response data is null!");
          }

          emit(
            state.copyWith(
              relatedProducts: value.getSuccessInstance()?.response.data ??
                  <ProductListingResponse>[],
              statusForRelatedProducts: BaseStateStatus.success,
            ),
          );

          // Store related products in global wishlist
          if (value.getSuccessInstance()?.response.data != null) {
            final GlobalWishlistManager globalWishlistManager =
                getIt<GlobalWishlistManager>();
            final List<ProductListingResponse> responseData =
                value.getSuccessInstance()!.response.data!;
            globalWishlistManager.storeProductsFromAPI(responseData);
            DebugLog.instance.d(
                '🔄 PDP: Stored ${responseData.length} related products in global wishlist');
          }

          DebugLog.instance.e("State updated successfully");
        } else if (value.isFailure()) {
          DebugLog.instance.e("=== FAILURE RESPONSE ===");
          DebugLog.instance
              .e("Failure Instance: ${value.getFailureInstance()}");
          DebugLog.instance.e(
              "Error Message: ${value.getFailureInstance()?.error?.errorMessage}");

          emit(
            state.copyWith(
              statusForRelatedProducts: BaseStateStatus.failure,
              msg: value.getFailureInstance()?.error?.errorMessage ?? '',
            ),
          );
        }
      });
    } on Exception catch (e, stackTrace) {
      DebugLog.instance.e("=== EXCEPTION CAUGHT ===");
      DebugLog.instance.e("Error: $e");
      DebugLog.instance.e("Stack Trace: $stackTrace");

      emit(
        state.copyWith(
          statusForRelatedProducts: BaseStateStatus.failure,
          msg: "Exception: $e",
        ),
      );
    }

    // Track API completion
    final DateTime endTime = DateTime.now();
    final Duration duration = endTime.difference(startTime);
    DebugLog.instance.d(
        '⏱️ PRODUCT DETAILS API TIMING: Related Products API completed in ${duration.inMilliseconds}ms');
    _trackApiCompletion('Related Products API');

    DebugLog.instance.e("=== getRelatedProducts COMPLETED ===");
  }

  /// api call for the get trending products
  Future<void> getTrendingProducts() async {
    final DateTime startTime = DateTime.now();
    DebugLog.instance.d(
        '🔄 PRODUCT DETAILS API TIMING: Trending Products API started at ${startTime.toIso8601String()}');

    emit(
      state.copyWith(
        statusForTrendingProducts: BaseStateStatus.loading,
      ),
    );

    DebugLog.instance.e("Calling repository getTrendingProducts...");

    try {
      await detailsRepository.getTrendingProducts().then(
          (ResponseHandler<BaseResponse<List<ProductListingResponse>>> value) {
        if (value.isSuccess()) {
          final BaseResponse<List<ProductListingResponse>>? response =
              value.getSuccessInstance()?.response;
          if (response?.data != null) {
            DebugLog.instance
                .e("Trending Products Count: ${response!.data!.length}");
            DebugLog.instance.e(
                "Full Trending Products Data: ${response.data!.map((ProductListingResponse e) => e.toJson())}");
          } else {
            DebugLog.instance.e("ERROR: Response data is null!");
          }

          emit(
            state.copyWith(
              trendingProducts: value.getSuccessInstance()?.response.data ??
                  <ProductListingResponse>[],
              statusForTrendingProducts: BaseStateStatus.success,
            ),
          );

          // Store trending products in global wishlist
          if (value.getSuccessInstance()?.response.data != null) {
            final GlobalWishlistManager globalWishlistManager =
                getIt<GlobalWishlistManager>();
            final List<ProductListingResponse> responseData =
                value.getSuccessInstance()!.response.data!;
            globalWishlistManager.storeProductsFromAPI(responseData);
            DebugLog.instance.d(
                '🔄 PDP: Stored ${responseData.length} trending products in global wishlist');
          }

          DebugLog.instance.e("State updated successfully");
        } else if (value.isFailure()) {
          DebugLog.instance.e("=== FAILURE RESPONSE ===");
          DebugLog.instance
              .e("Failure Instance: ${value.getFailureInstance()}");
          DebugLog.instance.e(
              "Error Message: ${value.getFailureInstance()?.error?.errorMessage}");

          // Handle 401 status (Trending Products not found) by setting empty list
          if (value.getFailureInstance()?.statusCode == 401) {
            emit(
              state.copyWith(
                trendingProducts: <ProductListingResponse>[],
                statusForTrendingProducts: BaseStateStatus.success,
              ),
            );
          } else {
            emit(
              state.copyWith(
                statusForTrendingProducts: BaseStateStatus.failure,
                msg: value.getFailureInstance()?.error?.errorMessage ?? '',
              ),
            );
          }
        }
      });
    } on Exception catch (e, stackTrace) {
      DebugLog.instance.e("=== EXCEPTION CAUGHT ===");
      DebugLog.instance.e("Error: $e");
      DebugLog.instance.e("Stack Trace: $stackTrace");

      emit(
        state.copyWith(
          statusForTrendingProducts: BaseStateStatus.failure,
          msg: "Exception: $e",
        ),
      );
    }

    // Track API completion
    final DateTime endTime = DateTime.now();
    final Duration duration = endTime.difference(startTime);
    DebugLog.instance.d(
        '⏱️ PRODUCT DETAILS API TIMING: Trending Products API completed in ${duration.inMilliseconds}ms');
    _trackApiCompletion('Trending Products API');

    DebugLog.instance.e("=== getTrendingProducts COMPLETED ===");
  }

  /// Handle like/dislike functionality for related products
  Future<void> handleRelatedProductWishlistLikeDislike({
    required String sku,
    required int productIndex,
    required bool isCurrentlyFavorite,
  }) async {
    try {
      // Use global wishlist manager for state management
      final GlobalWishlistManager globalWishlistManager =
          getIt<GlobalWishlistManager>();

      if (isCurrentlyFavorite) {
        // Remove from wishlist (dislike)
        final ResponseHandler<BaseResponse<void>> response =
            await removeFromWishlistAPI(
          removeWishlistParams: createRemoveWishlistRequest(sku),
        );

        if (response.isSuccess()) {
          final BaseResponse<void>? responseData =
              response.getSuccessInstance()?.response;

          if (responseData?.success ?? false) {
            // Update global wishlist state
            globalWishlistManager.toggleWishlist(sku, false);
            DebugLog.instance
                .d('🔄 PDP: Removed $sku from wishlist (Related Product)');

            // Update the product's favorite status in related products
            _updateRelatedProductWishlistStatus(
              productIndex: productIndex,
              isFavorite: false,
              status: BaseStateStatus.success,
              message: responseData?.message ?? '',
            );
          } else {
            _updateRelatedProductWishlistStatus(
              productIndex: productIndex,
              isFavorite: isCurrentlyFavorite, // Keep current status
              status: BaseStateStatus.failure,
              message: responseData?.message ?? '',
            );
          }
        } else if (response.isFailure()) {
          _updateRelatedProductWishlistStatus(
            productIndex: productIndex,
            isFavorite: isCurrentlyFavorite, // Keep current status
            status: BaseStateStatus.failure,
            message: response.getFailureInstance()?.error?.errorMessage ?? '',
          );
        }
      } else {
        // Add to wishlist (like)
        final ResponseHandler<AddWishlistModel> response =
            await addToWishlistAPI(
          wishListParams: createAddWishlistRequest(sku),
        );

        if (response.isSuccess()) {
          final AddWishlistModel? responseData =
              response.getSuccessInstance()?.response;

          if (responseData?.success ?? false) {
            // Update global wishlist state
            globalWishlistManager.toggleWishlist(sku, true);
            DebugLog.instance
                .d('🔄 PDP: Added $sku to wishlist (Related Product)');

            // Update the product's favorite status in related products
            _updateRelatedProductWishlistStatus(
              productIndex: productIndex,
              isFavorite: true,
              status: BaseStateStatus.success,
              message: responseData?.message ?? '',
            );
          } else {
            _updateRelatedProductWishlistStatus(
              productIndex: productIndex,
              isFavorite: isCurrentlyFavorite, // Keep current status
              status: BaseStateStatus.failure,
              message: responseData?.message ?? '',
            );
          }
        } else if (response.isFailure()) {
          _updateRelatedProductWishlistStatus(
            productIndex: productIndex,
            isFavorite: isCurrentlyFavorite, // Keep current status
            status: BaseStateStatus.failure,
            message: response.getFailureInstance()?.error?.errorMessage ?? '',
          );
        }
      }
    } on Exception {
      _updateRelatedProductWishlistStatus(
        productIndex: productIndex,
        isFavorite: isCurrentlyFavorite, // Keep current status
        status: BaseStateStatus.failure,
        message: 'An error occurred while updating wishlist',
      );
    }
  }

  /// Handle like/dislike functionality for trending products
  Future<void> handleTrendingProductWishlistLikeDislike({
    required String sku,
    required int productIndex,
    required bool isCurrentlyFavorite,
  }) async {
    try {
      // Use global wishlist manager for state management
      final GlobalWishlistManager globalWishlistManager =
          getIt<GlobalWishlistManager>();

      if (isCurrentlyFavorite) {
        // Remove from wishlist (dislike)
        final ResponseHandler<BaseResponse<void>> response =
            await removeFromWishlistAPI(
          removeWishlistParams: createRemoveWishlistRequest(sku),
        );

        if (response.isSuccess()) {
          final BaseResponse<void>? responseData =
              response.getSuccessInstance()?.response;

          if (responseData?.success ?? false) {
            // Update global wishlist state
            globalWishlistManager.toggleWishlist(sku, false);
            DebugLog.instance
                .d('🔄 PDP: Removed $sku from wishlist (Trending Product)');

            // Update the product's favorite status in trending products
            _updateTrendingProductWishlistStatus(
              productIndex: productIndex,
              isFavorite: false,
              status: BaseStateStatus.success,
              message: responseData?.message ?? '',
            );
          } else {
            _updateTrendingProductWishlistStatus(
              productIndex: productIndex,
              isFavorite: isCurrentlyFavorite, // Keep current status
              status: BaseStateStatus.failure,
              message: responseData?.message ?? '',
            );
          }
        } else if (response.isFailure()) {
          _updateTrendingProductWishlistStatus(
            productIndex: productIndex,
            isFavorite: isCurrentlyFavorite, // Keep current status
            status: BaseStateStatus.failure,
            message: response.getFailureInstance()?.error?.errorMessage ?? '',
          );
        }
      } else {
        // Add to wishlist (like)
        final ResponseHandler<AddWishlistModel> response =
            await addToWishlistAPI(
          wishListParams: createAddWishlistRequest(sku),
        );

        if (response.isSuccess()) {
          final AddWishlistModel? responseData =
              response.getSuccessInstance()?.response;

          if (responseData?.success ?? false) {
            // Update global wishlist state
            globalWishlistManager.toggleWishlist(sku, true);
            DebugLog.instance
                .d('🔄 PDP: Added $sku to wishlist (Trending Product)');

            // Update the product's favorite status in trending products
            _updateTrendingProductWishlistStatus(
              productIndex: productIndex,
              isFavorite: true,
              status: BaseStateStatus.success,
              message: responseData?.message ?? '',
            );
          } else {
            _updateTrendingProductWishlistStatus(
              productIndex: productIndex,
              isFavorite: isCurrentlyFavorite, // Keep current status
              status: BaseStateStatus.failure,
              message: responseData?.message ?? '',
            );
          }
        } else if (response.isFailure()) {
          _updateTrendingProductWishlistStatus(
            productIndex: productIndex,
            isFavorite: isCurrentlyFavorite, // Keep current status
            status: BaseStateStatus.failure,
            message: response.getFailureInstance()?.error?.errorMessage ?? '',
          );
        }
      }
    } on Exception {
      _updateTrendingProductWishlistStatus(
        productIndex: productIndex,
        isFavorite: isCurrentlyFavorite, // Keep current status
        status: BaseStateStatus.failure,
        message: '',
      );
    }
  }

  /// Update related product wishlist status
  void _updateRelatedProductWishlistStatus({
    required int productIndex,
    required bool isFavorite,
    required BaseStateStatus status,
    required String message,
  }) {
    final List<ProductListingResponse> currentRelatedProducts =
        state.relatedProducts;

    if (productIndex >= 0 && productIndex < currentRelatedProducts.length) {
      final List<ProductListingResponse> updatedRelatedProducts =
          List<ProductListingResponse>.from(currentRelatedProducts);
      final ProductListingResponse product =
          updatedRelatedProducts[productIndex];

      // Update the product's favorite status
      updatedRelatedProducts[productIndex] = product.copyWith(
        isFavorite: isFavorite,
      );

      // Emit the updated state
      emit(
        state.copyWith(
          status: status,
          msg: message,
          relatedProducts: updatedRelatedProducts,
        ),
      );
    }
  }

  /// Update trending product wishlist status
  void _updateTrendingProductWishlistStatus({
    required int productIndex,
    required bool isFavorite,
    required BaseStateStatus status,
    required String message,
  }) {
    final List<ProductListingResponse> currentTrendingProducts =
        state.trendingProducts;

    if (productIndex >= 0 && productIndex < currentTrendingProducts.length) {
      final List<ProductListingResponse> updatedTrendingProducts =
          List<ProductListingResponse>.from(currentTrendingProducts);
      final ProductListingResponse product =
          updatedTrendingProducts[productIndex];

      // Update the product's favorite status
      updatedTrendingProducts[productIndex] = product.copyWith(
        isFavorite: isFavorite,
      );

      // Emit the updated state
      emit(
        state.copyWith(
          status: status,
          msg: message,
          trendingProducts: updatedTrendingProducts,
        ),
      );
    }
  }

  /// Handle cart operations for related products
  Future<void> handleRelatedProductCartOperation({
    required int productIndex,
    required CartOperation operation,
    int? variantIndex,
  }) async {
    final List<ProductListingResponse> currentRelatedProducts =
        state.relatedProducts;

    // Use the common mixin method
    await handleCartOperation(
        productIndex: productIndex,
        products: currentRelatedProducts,
        operation: operation,
        variantIndex: variantIndex,
        updateProductCartQuantity: (int productIndex,
            int cartQuantity,
            BaseStateStatus status,
            String message,
            int? variantIndex,
            int? apiCartCount) {
          _updateRelatedProductCartQuantity(
            productIndex: productIndex,
            cartQuantity: cartQuantity,
            status: status,
            message: message,
            variantIndex: variantIndex,
            apiCartCount: apiCartCount,
          );
        },
        addToCartApi: addToCartListApi,
        removeFromCartApi: removeToCartListApi,
        updateToCartApi: updateToCartListApi);
  }

  /// Handle cart operations for trending products
  Future<void> handleTrendingProductCartOperation({
    required int productIndex,
    required CartOperation operation,
    int? variantIndex,
  }) async {
    final List<ProductListingResponse> currentTrendingProducts =
        state.trendingProducts;

    // Use the common mixin method
    await handleCartOperation(
        productIndex: productIndex,
        products: currentTrendingProducts,
        operation: operation,
        variantIndex: variantIndex,
        updateProductCartQuantity: (int productIndex,
            int cartQuantity,
            BaseStateStatus status,
            String message,
            int? variantIndex,
            int? apiCartCount) {
          _updateTrendingProductCartQuantity(
            productIndex: productIndex,
            cartQuantity: cartQuantity,
            status: status,
            message: message,
            variantIndex: variantIndex,
            apiCartCount: apiCartCount,
          );
        },
        addToCartApi: addToCartListApi,
        removeFromCartApi: removeToCartListApi,
        updateToCartApi: updateToCartListApi);
  }

  /// Update related product cart quantity
  void _updateRelatedProductCartQuantity({
    required int productIndex,
    required int cartQuantity,
    required BaseStateStatus status,
    required String message,
    int? variantIndex,
    int? apiCartCount, // Cart count from API response
  }) {
    // Update global cart count from API response if available
    if (status == BaseStateStatus.success && apiCartCount != null) {
      getIt<CartCountCubit>().updateCount(apiCartCount);
      DebugLog.instance.i(
          'Updated cart count from API in product details related: $apiCartCount');
    }
    final List<ProductListingResponse> currentRelatedProducts =
        state.relatedProducts;

    if (productIndex >= 0 && productIndex < currentRelatedProducts.length) {
      final ProductListingResponse product =
          currentRelatedProducts[productIndex];

      // Determine which entityId to synchronize
      int? entityIdToSync;

      if (variantIndex != null &&
          product.productVariant != null &&
          variantIndex < product.productVariant!.length) {
        // Use variant entityId
        entityIdToSync = product.productVariant![variantIndex].entityId;
      } else {
        // Use main product entityId
        entityIdToSync = product.entityId;
      }

      // Synchronize across all product lists if entityId matches
      if (entityIdToSync != null) {
        _synchronizeCartQuantityForEntityId(entityIdToSync, cartQuantity);

        // Emit with status and message
        emit(
          state.copyWith(
            statusForCartOperations: status,
            msg: message,
          ),
        );
      } else {
        // Fallback to original logic if no entityId found
        final List<ProductListingResponse> updatedRelatedProducts =
            List<ProductListingResponse>.from(currentRelatedProducts);

        if (variantIndex != null &&
            product.productVariant != null &&
            variantIndex < product.productVariant!.length) {
          // Update variant cart quantity
          final List<ProductVariantDukkan> updatedVariants =
              List<ProductVariantDukkan>.from(product.productVariant!);
          updatedVariants[variantIndex] =
              updatedVariants[variantIndex].copyWith(
            cartQuantity: cartQuantity,
            isCart: cartQuantity > 0,
          );

          updatedRelatedProducts[productIndex] = product.copyWith(
            productVariant: updatedVariants,
          );
        } else {
          // Update main product cart quantity
          updatedRelatedProducts[productIndex] = product.copyWith(
            cartQuantity: cartQuantity,
            isCart: cartQuantity > 0,
          );
        }

        // Calculate cart count for selected variant only from current state
        final int selectedVariantCartCount =
            _calculateSelectedVariantCartCount();

        // Emit the updated state
        emit(
          state.copyWith(
            statusForCartOperations: status,
            msg: message,
            relatedProducts: updatedRelatedProducts,
            cartCount: selectedVariantCartCount,
          ),
        );
      }
    }
  }

  /// Update trending product cart quantity
  void _updateTrendingProductCartQuantity({
    required int productIndex,
    required int cartQuantity,
    required BaseStateStatus status,
    required String message,
    int? variantIndex,
    int? apiCartCount, // Cart count from API response
  }) {
    // Update global cart count from API response if available
    if (status == BaseStateStatus.success && apiCartCount != null) {
      getIt<CartCountCubit>().updateCount(apiCartCount);
      DebugLog.instance.i(
          'Updated cart count from API in product details trending: $apiCartCount');
    }
    final List<ProductListingResponse> currentTrendingProducts =
        state.trendingProducts;

    if (productIndex >= 0 && productIndex < currentTrendingProducts.length) {
      final ProductListingResponse product =
          currentTrendingProducts[productIndex];

      // Determine which entityId to synchronize
      int? entityIdToSync;

      if (variantIndex != null &&
          product.productVariant != null &&
          variantIndex < product.productVariant!.length) {
        // Use variant entityId
        entityIdToSync = product.productVariant![variantIndex].entityId;
      } else {
        // Use main product entityId
        entityIdToSync = product.entityId;
      }

      // Synchronize across all product lists if entityId matches
      if (entityIdToSync != null) {
        _synchronizeCartQuantityForEntityId(entityIdToSync, cartQuantity);

        // Emit with status and message
        emit(
          state.copyWith(
            statusForCartOperations: status,
            msg: message,
          ),
        );
      } else {
        // Fallback to original logic if no entityId found
        final List<ProductListingResponse> updatedTrendingProducts =
            List<ProductListingResponse>.from(currentTrendingProducts);

        if (variantIndex != null &&
            product.productVariant != null &&
            variantIndex < product.productVariant!.length) {
          // Update variant cart quantity
          final List<ProductVariantDukkan> updatedVariants =
              List<ProductVariantDukkan>.from(product.productVariant!);
          updatedVariants[variantIndex] =
              updatedVariants[variantIndex].copyWith(
            cartQuantity: cartQuantity,
            isCart: cartQuantity > 0,
          );

          updatedTrendingProducts[productIndex] = product.copyWith(
            productVariant: updatedVariants,
          );
        } else {
          // Update main product cart quantity
          updatedTrendingProducts[productIndex] = product.copyWith(
            cartQuantity: cartQuantity,
            isCart: cartQuantity > 0,
          );
        }

        // Calculate cart count for selected variant only from current state
        final int selectedVariantCartCount =
            _calculateSelectedVariantCartCount();

        // Emit the updated state
        emit(
          state.copyWith(
            statusForCartOperations: status,
            msg: message,
            trendingProducts: updatedTrendingProducts,
            cartCount: selectedVariantCartCount,
          ),
        );
      }
    }
  }

  /// Handle cart operations for main product details
  Future<void> handleMainProductCartOperation({
    required CartOperation operation,
  }) async {
    final ProductDetailsResponse? product = state.detailsModel;
    if (product == null) return;

    // Get the selected unit or default to first available unit
    final ProductVariantDukkan? selectedUnit = getSelectedUnit();
    if (selectedUnit == null) {
      DebugLog.instance.e('Selected unit is null for cart operation');
      return;
    }

    // Use the main product's SKU if variant SKU is null
    final String sku = selectedUnit.sku ?? product.sku ?? '';
    DebugLog.instance.e(
        'Cart operation - Selected unit SKU: ${selectedUnit.sku}, Main product SKU: ${product.sku}, Final SKU: $sku');

    if (sku.isEmpty) {
      DebugLog.instance.e('Product SKU is null or empty for cart operation');
      return;
    }

    // Update the productVariant array to reflect current cart quantities
    List<ProductVariantDukkan>? updatedProductVariants;
    if (product.productVariant != null) {
      updatedProductVariants =
          product.productVariant!.map((ProductVariantDukkan variant) {
        if (variant.entityId == selectedUnit.entityId) {
          // Update the selected variant with current cart quantity
          return variant.copyWith(
            cartQuantity: selectedUnit.cartQuantity ?? 0,
            isCart: (selectedUnit.cartQuantity ?? 0) > 0,
          );
        }
        return variant;
      }).toList();
    }

    // Convert ProductVariantDukkan to ProductListingResponse for the mixin
    final ProductListingResponse productForCart = ProductListingResponse(
        entityId: selectedUnit.entityId,
        name: selectedUnit.name,
        thumbNail: selectedUnit.thumbNail,
        imageLarge: selectedUnit.imageLarge,
        formattedPrice: selectedUnit.formattedPrice,
        price: selectedUnit.price,
        formattedFinalPrice: selectedUnit.formattedFinalPrice,
        finalPrice: selectedUnit.finalPrice,
        percentOff: selectedUnit.percentOff,
        isAvailable: selectedUnit.isAvailable,
        sku: sku,
        cartQuantity: selectedUnit.cartQuantity ?? 0,
        isCart: selectedUnit.isCart ?? false,
        productVariant: updatedProductVariants);

    // Use the common mixin method
    await handleCartOperation(
      productIndex: 0,
      // Main product is always at index 0
      products: <ProductListingResponse>[productForCart],
      operation: operation,
      updateProductCartQuantity: (int productIndex,
          int cartQuantity,
          BaseStateStatus status,
          String message,
          int? variantIndex,
          int? apiCartCount) {
        _updateMainProductCartQuantity(
          cartQuantity: cartQuantity,
          status: status,
          message: message,
          apiCartCount: apiCartCount,
        );
      },
      addToCartApi: addToCartListApi,
      removeFromCartApi: removeToCartListApi,
      updateToCartApi: updateToCartListApi,
    );
  }

  /// Update main product cart quantity and synchronize with trending products
  void _updateMainProductCartQuantity({
    required int cartQuantity,
    required BaseStateStatus status,
    required String message,
    int? apiCartCount, // Cart count from API response
  }) {
    // Update global cart count from API response if available
    if (status == BaseStateStatus.success && apiCartCount != null) {
      getIt<CartCountCubit>().updateCount(apiCartCount);
      DebugLog.instance.i(
          'Updated cart count from API in product details main: $apiCartCount');
    }
    DebugLog.instance.e(
        '_updateMainProductCartQuantity called with cartQuantity: $cartQuantity, status: $status');

    // Get the selected unit's entityId for synchronization
    final ProductVariantDukkan? selectedUnit = getSelectedUnit();
    if (selectedUnit != null) {
      DebugLog.instance.e(
          'Selected unit entityId: ${selectedUnit.entityId}, using centralized sync');
      // Use the centralized synchronization method
      _synchronizeCartQuantityForEntityId(selectedUnit.entityId, cartQuantity);

      // Emit with status and message
      emit(
        state.copyWith(
          statusForCartOperations: status,
          msg: message,
        ),
      );
    } else {
      DebugLog.instance.e('No selected unit found, using fallback logic');
      // Fallback: update only available units if no selected unit
      final List<ProductVariantDukkan> updatedAvailableUnits =
          state.availableUnits.map((ProductVariantDukkan unit) {
        // Only update the selected unit
        if (state.selectedUnitIndex != null &&
            state.availableUnits.indexOf(unit) == state.selectedUnitIndex) {
          return unit.copyWith(
            cartQuantity: cartQuantity,
            isCart: cartQuantity > 0,
          );
        }
        return unit;
      }).toList();

      // Calculate cart count for selected variant only from updated units
      int selectedVariantCartCount = 0;
      if (state.selectedUnitIndex != null &&
          state.selectedUnitIndex! >= 0 &&
          state.selectedUnitIndex! < updatedAvailableUnits.length) {
        final ProductVariantDukkan selectedUnit =
            updatedAvailableUnits[state.selectedUnitIndex!];
        selectedVariantCartCount = selectedUnit.cartQuantity ?? 0;
        DebugLog.instance.e(
            '_updateMainProductCartQuantity fallback - Selected unit count: $selectedVariantCartCount for variant: ${selectedUnit.name}');
      } else if (updatedAvailableUnits.isNotEmpty) {
        final ProductVariantDukkan firstUnit = updatedAvailableUnits.first;
        selectedVariantCartCount = firstUnit.cartQuantity ?? 0;
        DebugLog.instance.e(
            '_updateMainProductCartQuantity fallback - No selected unit, using first unit count: $selectedVariantCartCount for variant: ${firstUnit.name}');
      }

      // Emit the updated state
      emit(
        state.copyWith(
          statusForCartOperations: status,
          msg: message,
          availableUnits: updatedAvailableUnits,
          cartCount: selectedVariantCartCount,
        ),
      );
    }
  }

  /// Calculate cart count for the selected product variant only
  int _calculateSelectedVariantCartCount() {
    // Only return the cart quantity of the currently selected variant
    if (state.selectedUnitIndex != null &&
        state.selectedUnitIndex! >= 0 &&
        state.selectedUnitIndex! < state.availableUnits.length) {
      final ProductVariantDukkan selectedUnit =
          state.availableUnits[state.selectedUnitIndex!];
      final int selectedUnitCount = selectedUnit.cartQuantity ?? 0;
      DebugLog.instance.e(
          '_calculateSelectedVariantCartCount - Selected unit count: $selectedUnitCount for variant: ${selectedUnit.name}');
      return selectedUnitCount;
    }

    // Fallback: if no selected unit but we have available units, use the first one
    if (state.availableUnits.isNotEmpty) {
      final ProductVariantDukkan firstUnit = state.availableUnits.first;
      final int firstUnitCount = firstUnit.cartQuantity ?? 0;
      DebugLog.instance.e(
          '_calculateSelectedVariantCartCount - No selected unit, using first unit count: $firstUnitCount for variant: ${firstUnit.name}');
      return firstUnitCount;
    }

    // Final fallback: return 0
    DebugLog.instance.e(
        '_calculateSelectedVariantCartCount - No available units, returning 0');
    return 0;
  }

  /// Synchronize cart quantity across all product lists for a specific entityId
  void _synchronizeCartQuantityForEntityId(int? entityId, int cartQuantity) {
    DebugLog.instance.e(
        '_synchronizeCartQuantityForEntityId called with entityId: $entityId, cartQuantity: $cartQuantity');

    // Update available units
    final List<ProductVariantDukkan> updatedAvailableUnits =
        state.availableUnits.map((ProductVariantDukkan unit) {
      if (unit.entityId == entityId) {
        return unit.copyWith(
          cartQuantity: cartQuantity,
          isCart: cartQuantity > 0,
        );
      }
      return unit;
    }).toList();

    // Update trending products
    final List<ProductListingResponse> updatedTrendingProducts =
        state.trendingProducts.map((ProductListingResponse product) {
      if (product.entityId == entityId) {
        return product.copyWith(
          cartQuantity: cartQuantity,
          isCart: cartQuantity > 0,
        );
      }

      // Check variants
      if (product.productVariant != null) {
        final List<ProductVariantDukkan> updatedVariants =
            product.productVariant!.map((ProductVariantDukkan variant) {
          if (variant.entityId == entityId) {
            return variant.copyWith(
              cartQuantity: cartQuantity,
              isCart: cartQuantity > 0,
            );
          }
          return variant;
        }).toList();

        return product.copyWith(productVariant: updatedVariants);
      }

      return product;
    }).toList();

    // Update related products
    final List<ProductListingResponse> updatedRelatedProducts =
        state.relatedProducts.map((ProductListingResponse product) {
      if (product.entityId == entityId) {
        return product.copyWith(
          cartQuantity: cartQuantity,
          isCart: cartQuantity > 0,
        );
      }

      // Check variants
      if (product.productVariant != null) {
        final List<ProductVariantDukkan> updatedVariants =
            product.productVariant!.map((ProductVariantDukkan variant) {
          if (variant.entityId == entityId) {
            return variant.copyWith(
              cartQuantity: cartQuantity,
              isCart: cartQuantity > 0,
            );
          }
          return variant;
        }).toList();

        return product.copyWith(productVariant: updatedVariants);
      }

      return product;
    }).toList();

    // Calculate cart count for selected variant only from updated units
    int selectedVariantCartCount = 0;
    if (state.selectedUnitIndex != null &&
        state.selectedUnitIndex! >= 0 &&
        state.selectedUnitIndex! < updatedAvailableUnits.length) {
      final ProductVariantDukkan selectedUnit =
          updatedAvailableUnits[state.selectedUnitIndex!];
      selectedVariantCartCount = selectedUnit.cartQuantity ?? 0;
      DebugLog.instance.e(
          '_synchronizeCartQuantityForEntityId - Selected unit count: $selectedVariantCartCount for variant: ${selectedUnit.name}');
    } else if (updatedAvailableUnits.isNotEmpty) {
      final ProductVariantDukkan firstUnit = updatedAvailableUnits.first;
      selectedVariantCartCount = firstUnit.cartQuantity ?? 0;
      DebugLog.instance.e(
          '_synchronizeCartQuantityForEntityId - No selected unit, using first unit count: $selectedVariantCartCount for variant: ${firstUnit.name}');
    }

    // Emit the updated state
    emit(
      state.copyWith(
        availableUnits: updatedAvailableUnits,
        trendingProducts: updatedTrendingProducts,
        relatedProducts: updatedRelatedProducts,
        cartCount: selectedVariantCartCount,
      ),
    );
  }

  /// Clear cart operation status and message
  void clearCartOperationStatus() {
    emit(state.copyWith(
      statusForCartOperations: BaseStateStatus.initial,
      msg: '',
    ));
  }

  /// Refresh wishlist data when adding items to wishlist
  void _refreshWishlistData() {
    DebugLog.instance.d('🔄 PDP: Refreshing wishlist data after adding item');

    try {
      // Get the global wishlist manager
      final GlobalWishlistManager globalWishlistManager =
          getIt<GlobalWishlistManager>();

      // Create a special refresh trigger in the global wishlist state
      // This will cause the wishlist screen to refresh its API data
      final GlobalWishlistState currentState = globalWishlistManager.state;
      final GlobalWishlistState refreshState = GlobalWishlistState(
        wishlistMap: currentState.wishlistMap,
        cartMap: currentState.cartMap,
      );

      // Emit the state to trigger wishlist screen refresh
      globalWishlistManager.emit(refreshState);

      DebugLog.instance.d('🔄 PDP: Successfully triggered wishlist refresh');
    } on Exception catch (e) {
      DebugLog.instance.e('🔄 PDP: Error refreshing wishlist data: $e');
    }
  }

  @override
  ProductDetailsState getResetErrorState() => state.copyWith(
        msg: '',
      );

  @override
  ProductDetailsState getResetRedirectionState() => state.copyWith();

  /// Sync PDP with global wishlist
  void _syncWithGlobalWishlist() {
    DebugLog.instance.d('🔄 PDP: Syncing with global wishlist');

    try {
      final GlobalWishlistManager globalWishlistManager =
          getIt<GlobalWishlistManager>();
      final Map<String, bool> globalWishlist =
          globalWishlistManager.state.wishlistMap;

      DebugLog.instance.d('🔄 PDP: Global wishlist: $globalWishlist');

      final ProductDetailsResponse? currentProduct = state.detailsModel;
      if (currentProduct?.sku == null || currentProduct!.sku!.isEmpty) return;

      final bool isInGlobalWishlist =
          globalWishlist[currentProduct.sku] ?? false;

      if (currentProduct.isFavorite != isInGlobalWishlist) {
        DebugLog.instance.d(
            '🔄 PDP: Update ${currentProduct.sku} from ${currentProduct.isFavorite} to $isInGlobalWishlist');
        emit(state.copyWith(
          detailsModel: currentProduct.copyWith(isFavorite: isInGlobalWishlist),
        ));
        DebugLog.instance.d('🔄 PDP: Successfully synced with global wishlist');
      }
    } on Exception catch (e) {
      DebugLog.instance.e('🔄 PDP: Error syncing with global wishlist: $e');
    }
  }

  /// Sync related products with global wishlist
  void _syncRelatedProductsWithGlobalWishlist() {
    try {
      final GlobalWishlistManager globalWishlistManager =
          getIt<GlobalWishlistManager>();
      final Map<String, bool> globalWishlist =
          globalWishlistManager.state.wishlistMap;

      DebugLog.instance
          .d('🔄 PDP: Syncing related products with global wishlist');

      if (state.relatedProducts.isNotEmpty) {
        final List<ProductListingResponse> updatedRelatedProducts =
            state.relatedProducts.map((ProductListingResponse product) {
          if (product.sku != null && product.sku!.isNotEmpty) {
            final bool isInGlobalWishlist =
                globalWishlist[product.sku] ?? false;
            if (product.isFavorite != isInGlobalWishlist) {
              return product.copyWith(isFavorite: isInGlobalWishlist);
            }
          }
          return product;
        }).toList();

        emit(state.copyWith(relatedProducts: updatedRelatedProducts));
        DebugLog.instance.d(
            '🔄 PDP: Successfully synced related products with global wishlist');
      }
    } on Exception catch (e) {
      DebugLog.instance
          .e('🔄 PDP: Error syncing related products with global wishlist: $e');
    }
  }

  /// Sync trending products with global wishlist
  void _syncTrendingProductsWithGlobalWishlist() {
    try {
      final GlobalWishlistManager globalWishlistManager =
          getIt<GlobalWishlistManager>();
      final Map<String, bool> globalWishlist =
          globalWishlistManager.state.wishlistMap;

      DebugLog.instance
          .d('🔄 PDP: Syncing trending products with global wishlist');

      if (state.trendingProducts.isNotEmpty) {
        final List<ProductListingResponse> updatedTrendingProducts =
            state.trendingProducts.map((ProductListingResponse product) {
          if (product.sku != null && product.sku!.isNotEmpty) {
            final bool isInGlobalWishlist =
                globalWishlist[product.sku] ?? false;
            if (product.isFavorite != isInGlobalWishlist) {
              return product.copyWith(isFavorite: isInGlobalWishlist);
            }
          }
          return product;
        }).toList();

        emit(state.copyWith(trendingProducts: updatedTrendingProducts));
        DebugLog.instance.d(
            '🔄 PDP: Successfully synced trending products with global wishlist');
      }
    } on Exception catch (e) {
      DebugLog.instance.e(
          '🔄 PDP: Error syncing trending products with global wishlist: $e');
    }
  }

  /// Sync PDP with global cart
  void _syncWithGlobalCart() {
    DebugLog.instance.d('🔄 PDP: Syncing with global cart');

    try {
      final GlobalWishlistManager globalWishlistManager =
          getIt<GlobalWishlistManager>();
      final Map<String, int> globalCart = globalWishlistManager.state.cartMap;

      DebugLog.instance.d('🔄 PDP: Global cart: $globalCart');

      // Get the main product SKU for cart lookup
      final String? productSku = state.detailsModel?.sku;
      if (productSku == null || productSku.isEmpty) return;

      // Update available units with global cart quantities (each unit has its own key)
      final List<ProductVariantDukkan> updatedAvailableUnits =
          state.availableUnits.map((ProductVariantDukkan unit) {
        final String? variantEntityId = unit.entityId?.toString();
        final int currentCartQuantity = unit.cartQuantity ?? 0;
        int globalCartQuantity = 0;

        if (variantEntityId != null && variantEntityId.isNotEmpty) {
          final String cartKey = '${productSku}_$variantEntityId';
          globalCartQuantity = globalCart[cartKey] ?? 0;
        }

        if (currentCartQuantity != globalCartQuantity) {
          DebugLog.instance.d(
              '🔄 PDP: Update unit ${unit.name} cart quantity from $currentCartQuantity to $globalCartQuantity');
          return unit.copyWith(
            cartQuantity: globalCartQuantity,
            isCart: globalCartQuantity > 0,
          );
        }
        return unit;
      }).toList();

      // Calculate updated cart count for selected variant
      int updatedCartCount = 0;
      if (state.selectedUnitIndex != null &&
          state.selectedUnitIndex! >= 0 &&
          state.selectedUnitIndex! < updatedAvailableUnits.length) {
        updatedCartCount =
            updatedAvailableUnits[state.selectedUnitIndex!].cartQuantity ?? 0;
      }

      emit(state.copyWith(
        availableUnits: updatedAvailableUnits,
        cartCount: updatedCartCount,
      ));

      DebugLog.instance.d('🔄 PDP: Successfully synced with global cart');
    } on Exception catch (e) {
      DebugLog.instance.e('🔄 PDP: Error syncing with global cart: $e');
    }
  }

  /// Sync related products with global cart
  void _syncRelatedProductsWithGlobalCart() {
    try {
      final GlobalWishlistManager globalWishlistManager =
          getIt<GlobalWishlistManager>();
      final Map<String, int> globalCart = globalWishlistManager.state.cartMap;

      DebugLog.instance.d('🔄 PDP: Syncing related products with global cart');

      if (state.relatedProducts.isNotEmpty) {
        final List<ProductListingResponse> updatedRelatedProducts =
            state.relatedProducts.map((ProductListingResponse product) {
          return _syncProductWithGlobalCart(product, globalCart);
        }).toList();

        emit(state.copyWith(relatedProducts: updatedRelatedProducts));
        DebugLog.instance
            .d('🔄 PDP: Successfully synced related products with global cart');
      }
    } on Exception catch (e) {
      DebugLog.instance
          .e('🔄 PDP: Error syncing related products with global cart: $e');
    }
  }

  /// Sync trending products with global cart
  void _syncTrendingProductsWithGlobalCart() {
    try {
      final GlobalWishlistManager globalWishlistManager =
          getIt<GlobalWishlistManager>();
      final Map<String, int> globalCart = globalWishlistManager.state.cartMap;

      DebugLog.instance.d('🔄 PDP: Syncing trending products with global cart');

      if (state.trendingProducts.isNotEmpty) {
        final List<ProductListingResponse> updatedTrendingProducts =
            state.trendingProducts.map((ProductListingResponse product) {
          return _syncProductWithGlobalCart(product, globalCart);
        }).toList();

        emit(state.copyWith(trendingProducts: updatedTrendingProducts));
        DebugLog.instance.d(
            '🔄 PDP: Successfully synced trending products with global cart');
      }
    } on Exception catch (e) {
      DebugLog.instance
          .e('🔄 PDP: Error syncing trending products with global cart: $e');
    }
  }

  /// Helper method to sync individual product with global cart
  ProductListingResponse _syncProductWithGlobalCart(
      ProductListingResponse product, Map<String, int> globalCart) {
    if (product.sku != null && product.sku!.isNotEmpty) {
      // Update variants if they exist (each variant has its own key)
      if (product.productVariant != null) {
        final List<ProductVariantDukkan> updatedVariants =
            product.productVariant!.map((ProductVariantDukkan variant) {
          final String? variantEntityId = variant.entityId?.toString();
          final int variantCurrentCartQuantity = variant.cartQuantity ?? 0;
          int globalCartQuantity = 0;

          if (variantEntityId != null && variantEntityId.isNotEmpty) {
            final String cartKey = '${product.sku}_$variantEntityId';
            globalCartQuantity = globalCart[cartKey] ?? 0;
          }

          if (variantCurrentCartQuantity != globalCartQuantity) {
            DebugLog.instance.d(
                '🔄 PDP: Update variant ${variant.name} cart quantity from $variantCurrentCartQuantity to $globalCartQuantity');
            return variant.copyWith(
              cartQuantity: globalCartQuantity,
              isCart: globalCartQuantity > 0,
            );
          }
          return variant;
        }).toList();

        return product.copyWith(productVariant: updatedVariants);
      }
    }
    return product;
  }
}
