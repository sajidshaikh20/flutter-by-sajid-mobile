import '../../../utils/exports.dart';

/// Manages the state of the cart page, including cart
/// and wishlist functionality.
class CartPageCubit extends BaseCubit<CartPageState>
    with WishlistCartMixin<CartPageState>, CartOperationMixin<CartPageState> {
  /// Manages the state of the cart page, including cart
  /// and wishlist functionality.
  CartPageCubit({
    required WishlistCartRepository wishlistCartRepository,
    required this.cartPageRepository,
    required this.countCubit,
    required this.homeRepository,
  }) : super(CartPageState.initial()) {
    this.wishlistCartRepository = wishlistCartRepository;
    // Initialize data
    unawaited(initData());

    // Listen to global wishlist and cart changes
    scheduleMicrotask(() {
      final GlobalWishlistManager globalWishlistManager =
          getIt<GlobalWishlistManager>();
      _globalWishlistSubscription = globalWishlistManager.stream.listen((GlobalWishlistState newState) {
        // Sync wishlist status (always needed)
        _syncWithGlobalWishlist();

        // Sync cart quantities (only refreshes API if cart quantities actually changed)
        _syncWithGlobalCart();
      });
    });
  }

  /// Update delivery instructions in state
  void setDeliveryInstructions(String? value) {
    emit(state.copyWith(deliveryInstructions: (value?.trim().isNotEmpty ?? false) ? value!.trim() : null));
  }

  /// Initializes the cart page data by making asynchronous API calls
  /// to fetch cart items, time slots, and payment methods.
  Future<void> initData() async {
    // Reset timing variables
    _firstApiStartTime = DateTime.now();
    _completedApiCount = 0;
    _lastApiEndTime = null;

    DebugLog.instance.d(
        '🚀 CART PAGE API TIMING: First API call started at ${_firstApiStartTime!.toIso8601String()}');

    try {
      // Call cart listing API first
      await _callCartListingApi();

      // Sync with global wishlist after cart listing is loaded
      _syncWithGlobalWishlist();
    } on Exception catch (e) {
      DebugLog.instance.e('CartPageCubit: Error in _callCartListingApi: $e');
    }

    // Only call time slots API if delivery type is pickup
    String deliveryType = SharedPref.instance.getDeliveryType();
    if (deliveryType == 'pickup') {
      try {
        // Call time slots API
        await callTimeSlotsApi();
      } on Exception catch (e) {
        DebugLog.instance.e('CartPageCubit: Error in callTimeSlotsApi: $e');
      }
    } else {
      // For delivery mode, set time slots status to success to avoid shimmer
      emit(state.copyWith(statusForTimeSlots: BaseStateStatus.success));
    }

    try {
      // Call payment methods API
      await callPaymentMethodsApi();
    } on Exception catch (e) {
      DebugLog.instance.e('CartPageCubit: Error in callPaymentMethodsApi: $e');
    }
  }

  /// Repository for managing cart page data.
  final CartPageRepository cartPageRepository;

  /// Repository for handling home-related API calls and data.
  final HomeRepository homeRepository;

  /// Cubit for handling the count of items in the cart.
  final CartCountCubit countCubit;

  /// Stream subscription for global wishlist manager
  StreamSubscription<GlobalWishlistState>? _globalWishlistSubscription;

  /// Last known cart state to track changes
  Map<String, int> _lastKnownCartState = <String, int>{};

  /// Variables to track API timing
  DateTime? _firstApiStartTime;
  DateTime? _lastApiEndTime;
  int _completedApiCount = 0;
  final int _totalApiCount =
      5; // Total number of APIs called in initData (cart listing, time slots, payment methods, deals, you may also like)

  /// Flattens a list of ProductListingResponse into individual ProductVariantDukkan items.
  /// This allows each product variant to be displayed as a separate cart item.
  List<ProductVariantDukkan> _flattenProductVariants(
      List<ProductListingResponse> products) {
    List<ProductVariantDukkan> flattenedVariants = <ProductVariantDukkan>[];

    for (final ProductListingResponse product in products) {
      if (product.productVariant != null &&
          product.productVariant!.isNotEmpty) {
        // Add all variants of this product with parent SKU
        for (final ProductVariantDukkan variant in product.productVariant!) {
          flattenedVariants.add(variant.copyWith(
            sku: product.sku,
            isFavorite: product.isFavorite,
          ));
        }
      } else {
        // If no variants, create a default variant from the main product
        flattenedVariants.add(ProductVariantDukkan(
          entityId: product.entityId,
          name: product.name,
          thumbNail: product.thumbNail,
          imageLarge: product.imageLarge,
          formattedPrice: product.formattedPrice,
          price: product.price,
          formattedFinalPrice: product.formattedFinalPrice,
          finalPrice: product.finalPrice,
          percentOff: product.percentOff,
          isAvailable: product.isAvailable,
          isSelected: product.isSelected,
          quantityLabel: product.quantityLabel,
          cartQuantity: product.cartQuantity,
          isCart: product.isCart,
          isFavorite: product.isFavorite,
          sku: product.sku,
        ));
      }
    }

    return flattenedVariants;
  }

  @override
  CartPageState getResetErrorState() => state.copyWith(
        msg: '',
        status: BaseStateStatus.initial,
      );

  @override
  void resetError() {
    const String err = '';
    emit(
      state.copyWith(
        msg: err,
        status: BaseStateStatus.initial,
      ),
    );
  }

  @override
  CartPageState getResetRedirectionState() => state.copyWith();

  @override
  void resetRedirection() {
    emit(state.copyWith());
  }

  /// Helper method to check if two cart maps are equal
  bool _areCartMapsEqual(Map<String, int> oldCart, Map<String, int> newCart) {
    if (oldCart.length != newCart.length) {
      return false;
    }

    for (final String key in oldCart.keys) {
      if (oldCart[key] != newCart[key]) {
        return false;
      }
    }

    return true;
  }

  /// Helper method to track API completion and calculate total time
  void _trackApiCompletion(String apiName) {
    _completedApiCount++;
    _lastApiEndTime = DateTime.now();

    if (_completedApiCount == _totalApiCount && _firstApiStartTime != null) {
      final Duration totalTime =
          _lastApiEndTime!.difference(_firstApiStartTime!);
      DebugLog.instance.d(
          '🎯 CART PAGE API TIMING: ALL APIs completed! Total time: ${totalTime.inMilliseconds}ms (${totalTime.inSeconds}s)');
      DebugLog.instance.d(
          '📊 CART PAGE API TIMING: First API started at ${_firstApiStartTime!.toIso8601String()}');
      DebugLog.instance.d(
          '📊 CART PAGE API TIMING: Last API ended at ${_lastApiEndTime!.toIso8601String()}');
    }
  }

  /// Manages the visibility of the keyboard and updates the coupon code.
  void manageVisibility(String code, {required bool isKeyboardVisible}) {
    emit(
      state.copyWith(
        isKeyboardOpen: isKeyboardVisible,
        couponCode: code,
      ),
    );
  }

  /// Clears snackbar flags and message
  void clearSnackBar() {
    emit(state.copyWith(isSnackBarDisplay: false, displayMessage: ''));
  }

  /// Applies coupon to the current cart
  Future<void> applyCoupon() async {
    final String code = state.couponCode?.trim() ?? '';


    emit(state.copyWith(status: BaseStateStatus.loading));

    try {
      final UserProfileService userProfileService = getIt<UserProfileService>();
      final int? orderId = int.tryParse(userProfileService.quoteId);

      final ResponseHandler<BaseResponse<ApplyCouponResponseModel>> response =
          await cartPageRepository.applyCoupon(orderId, code);

      if (response.isSuccess()) {
        final BaseResponse<ApplyCouponResponseModel>? res = response.getSuccessInstance()?.response;
        if (res?.success ?? false) {
          emit(state.copyWith(
            status: BaseStateStatus.success,
            isCouponApplied: false,
            isSnackBarDisplay: false,
            defaultRewardIds: res?.data?.defaultRewardIds,
          ));

        } else {
          emit(state.copyWith(
            status: BaseStateStatus.failure,
            isCouponApplied: false,
            displayMessage: res?.message ?? 'Failed to apply coupon',
            isSnackBarDisplay: true,
          ));
        }
      } else if (response.isFailure()) {
        emit(state.copyWith(
          status: BaseStateStatus.failure,
          isCouponApplied: false,
          displayMessage: response.getFailureInstance()?.error?.errorMessage ?? 'Failed to apply coupon',
          isSnackBarDisplay: true,
        ));
      }
    } on Exception catch (e) {
      emit(state.copyWith(
        status: BaseStateStatus.failure,
        isCouponApplied: false,
        displayMessage: 'Error applying coupon',
        isSnackBarDisplay: true,
      ));
      DebugLog.instance.e('applyCoupon error: $e');
    }
  }

  /// Applies coupon to the current cart
  Future<void> applyRewards() async {
    final int? selectedReward = state.selectedReward;

    final String code = state.couponCode?.trim() ?? '';

    emit(state.copyWith(status: BaseStateStatus.loading));

    try {
      final UserProfileService userProfileService = getIt<UserProfileService>();
      final int? orderId = int.tryParse(userProfileService.quoteId);

      final ResponseHandler<BaseResponse<dynamic>> response =
      await cartPageRepository.applyReward(orderId, selectedReward,code);

      if (response.isSuccess()) {
        final BaseResponse<dynamic>? res =
            response.getSuccessInstance()?.response;
        if (res?.success ?? false) {
          emit(state.copyWith(
            status: BaseStateStatus.success,
            isCouponApplied: true,
            displayMessage: res?.message ?? 'Coupon applied successfully',
            isSnackBarDisplay: true,
          ));
          // Refresh cart to update totals
          unawaited(_callCartListingApi());
        } else {
          emit(state.copyWith(
            status: BaseStateStatus.failure,
            isCouponApplied: false,
            displayMessage: res?.message ?? 'Failed to apply coupon',
            isSnackBarDisplay: true,
          ));
        }
      } else if (response.isFailure()) {
        emit(state.copyWith(
          status: BaseStateStatus.failure,
          isCouponApplied: false,
          displayMessage: response.getFailureInstance()?.error?.errorMessage ??
              'Failed to apply coupon',
          isSnackBarDisplay: true,
        ));
      }
    } on Exception catch (e) {
      emit(state.copyWith(
        status: BaseStateStatus.failure,
        isCouponApplied: false,
        displayMessage: 'Error applying coupon',
        isSnackBarDisplay: true,
      ));
      DebugLog.instance.e('applyCoupon error: $e');
    }
  }

  /// Select a reward and apply it
  Future<void> selectRewardAndApply(DefaultRewardIds reward) async {
    emit(state.copyWith(selectedReward: reward.id));
    await applyRewards();
  }

  /// Select a reward without applying (for UI selection changes)
  void selectRewardOnly(int? rewardId) {
    emit(state.copyWith(selectedReward: rewardId));
  }


  /// API call for getting cart listing
  /// This method fetches the cart items from the server
  Future<void> _callCartListingApi() async {
    final DateTime startTime = DateTime.now();
    DebugLog.instance.d(
        '🔄 CART PAGE API TIMING: Cart Listing API started at ${startTime.toIso8601String()}');
    DebugLog.instance.i('CartPageCubit: _callCartListingApi called - STARTING');
    emit(state.copyWith(statusForCartListing: BaseStateStatus.loading));

    final UserProfileService userProfileService = getIt<UserProfileService>();
    final CountryService countryService = getIt<CountryService>();
    final MainConfig mainConfig = getIt<MainConfig>();

    // Create cart listing request model
    final CartListingRequest cartListingRequest = CartListingRequest(
      languageId: int.tryParse(getIt<LanguageService>().languageId) ?? 1,
      websiteId: 1,
      // Default website ID
      storeId: countryService.store,
      customerToken: userProfileService.customerToken,
      quoteId: userProfileService.quoteId != 0 ? userProfileService.quoteId : 0,
      platform: getPlatformName(),
      version: mainConfig.packageInfo.version,
    );

    // Call the repository to get cart listing
    final ResponseHandler<BaseResponse<CartDetailsListingResponseModel>>
        response = await wishlistCartRepository
            .getCartListing(cartListingRequest, showLoader: false);

    if (response.isSuccess()) {
      final OnSuccessResponse<BaseResponse<CartDetailsListingResponseModel>>?
          successInstance = response.getSuccessInstance();

      if (successInstance != null) {
        final BaseResponse<CartDetailsListingResponseModel>
            cartListingResponse = successInstance.response;

        // Check if the API call was successful
        if (cartListingResponse.success) {
          // Update quoteId in UserProfileService if it's different
          if (cartListingResponse.quoteId != null &&
              cartListingResponse.quoteId!.isNotEmpty) {
            await userProfileService.updateUserProfile(
              quoteId: cartListingResponse.quoteId,
            );
            DebugLog.instance.i(
                'Updated quoteId in UserProfileService from cart listing: ${cartListingResponse.quoteId}');
          }
          // Get cart items from the response
          final List<ProductListingResponse> cartItems =
              cartListingResponse.data?.cartItems ?? <ProductListingResponse>[];
          final List<ProductVariantDukkan> flattenedVariants =
              _flattenProductVariants(cartItems);

          // Determine if there is any reward item in the cart
          final bool hasRewardItem = cartItems.any((ProductListingResponse e) => e.isReward ?? false);

          // Update state with flattened variants and free gift dialog flag
          emit(state.copyWith(
            statusForCartListing: BaseStateStatus.success,
            cartDetailsListingResponse: cartListingResponse.data,
            flattenedVariants: flattenedVariants,
            cartCount: cartListingResponse.cartCount,
            showFreeGiftDialog: hasRewardItem,
          ));

          // Update cart count in CartCountCubit
          if (cartListingResponse.cartCount != null) {
            countCubit.updateCount(cartListingResponse.cartCount!);
            DebugLog.instance.i(
                'Updated cart count in CartCountCubit from cart page: ${cartListingResponse.cartCount}');
          }
          // Chain the deals API calls after successful cart listing
          DebugLog.instance
              .i('CartPageCubit: About to call deals API methods directly');

          try {
            DebugLog.instance.i('CartPageCubit: Calling _callHomeDeals');
            await _callHomeDeals();
            DebugLog.instance.i('CartPageCubit: _callHomeDeals completed');
          } on Exception catch (e) {
            DebugLog.instance.e('CartPageCubit: Error in _callHomeDeals: $e');
          }
          try {
            DebugLog.instance
                .i('CartPageCubit: Calling callYouMayAlsoLikeDeals');
            await callYouMayAlsoLikeDeals();
            DebugLog.instance
                .i('CartPageCubit: callYouMayAlsoLikeDeals completed');
          } on Exception catch (e) {
            DebugLog.instance
                .e('CartPageCubit: Error in callYouMayAlsoLikeDeals: $e');
          }

          DebugLog.instance
              .i('Cart listing API successful, chained deals API calls');
        } else {
          emit(state.copyWith(
            statusForCartListing: BaseStateStatus.failure,
            msg: cartListingResponse.message,
          ));
          DebugLog.instance
              .e('Cart listing API failed: ${cartListingResponse.message}');
        }
      } else {
        emit(state.copyWith(
          statusForCartListing: BaseStateStatus.failure,
          msg: 'No response data received',
        ));
        DebugLog.instance.e('Cart listing API failed: No success instance');
      }
    } else if (response.isFailure()) {
      final OnFailureResponse<BaseResponse<CartDetailsListingResponseModel>>?
          failureInstance = response.getFailureInstance();
      final String errorMessage =
          failureInstance?.error?.errorMessage ?? 'Cart listing API failed';

      emit(state.copyWith(
        statusForCartListing: BaseStateStatus.failure,
        msg: errorMessage,
      ));
      DebugLog.instance.e('Cart listing API failed: $errorMessage');
    }

    // Track API completion
    final DateTime endTime = DateTime.now();
    final Duration duration = endTime.difference(startTime);
    DebugLog.instance.d(
        '⏱️ CART PAGE API TIMING: Cart Listing API completed in ${duration.inMilliseconds}ms');
    _trackApiCompletion('Cart Listing API');
  }

  /// Handle cart operations for cart page items
  /// This method handles add, increase, decrease, and remove cart operations
  /// for items displayed in the cart page
  Future<void> handleCartOperationForCartPage({
    required int variantIndex,
    required CartOperation operation,
  }) async {
    final List<ProductVariantDukkan> currentVariants =
        state.flattenedVariants ?? <ProductVariantDukkan>[];

    if (variantIndex < 0 || variantIndex >= currentVariants.length) {
      DebugLog.instance.e('Invalid variant index: $variantIndex');
      return;
    }

    final ProductVariantDukkan variant = currentVariants[variantIndex];

    // Get current cart quantity
    final int currentQuantity = variant.cartQuantity ?? 0;
    int newQuantity = currentQuantity;

    // Determine new quantity based on operation
    switch (operation) {
      case CartOperation.add:
        if (currentQuantity == 0) {
          newQuantity = 1;
        } else {
          newQuantity = currentQuantity + 1;
        }
      case CartOperation.increase:
        newQuantity = currentQuantity + 1;
      case CartOperation.decrease:
        newQuantity = currentQuantity > 0 ? currentQuantity - 1 : 0;
      case CartOperation.remove:
        newQuantity = 0;
    }

    // Validate quantity for add and increase operations
    if (operation == CartOperation.add || operation == CartOperation.increase) {
      final int quantityToAdd = newQuantity - currentQuantity;

      if (quantityToAdd > 0) {
        final QuantityValidationResult validation =
            variant.validateQuantity(quantityToAdd);

        if (!validation.isValid) {
          // Show error message and return early
          emit(state.copyWith(
            status: BaseStateStatus.failure,
            displayMessage: validation.message,
          ));
          return;
        }

        // If validation passes but we can add fewer items than requested
        if (validation.maxAllowedQuantity < newQuantity) {
          newQuantity = currentQuantity + validation.maxAllowedQuantity;
          emit(state.copyWith(
            status: BaseStateStatus.failure,
            displayMessage:
                "Added ${validation.maxAllowedQuantity} items (max available)",
          ));
        }
      }
    }

    // Handle API calls based on operation
    if (operation == CartOperation.add && currentQuantity == 0) {
      // Add to cart
      await _addVariantToCart(variant, variantIndex, newQuantity);
    } else if (operation == CartOperation.increase ||
        operation == CartOperation.decrease) {
      if (currentQuantity > 0) {
        // Update cart quantity
        await _updateVariantCartQuantity(variant, variantIndex, newQuantity);
      } else if (operation == CartOperation.increase) {
        // Add to cart if quantity was 0
        await _addVariantToCart(variant, variantIndex, newQuantity);
      }
    } else if (operation == CartOperation.remove && currentQuantity > 0) {
      // Remove from cart
      await _removeVariantFromCart(variant, variantIndex);
    }
  }

  /// Add variant to cart
  Future<void> _addVariantToCart(
      ProductVariantDukkan variant, int variantIndex, int quantity) async {
    try {
      if (variant.entityId == null || variant.sku == null) {
        DebugLog.instance.e('Variant entityId or sku is null');
        return;
      }

      final ResponseHandler<BaseResponse<CartOperationResponseModel>> response =
          await addToCartListApi(
        qty: quantity.toString(),
        entityId: variant.entityId.toString(),
        sku: variant.sku!,
      );

      if (response.isSuccess()) {
        final BaseResponse<CartOperationResponseModel>? responseData =
            response.getSuccessInstance()?.response;

        if (responseData?.success ?? false) {
          // Update quoteId in UserProfileService if available
          if (responseData?.data?.quoteId != null &&
              responseData!.data!.quoteId!.isNotEmpty) {
            final UserProfileService userProfileService =
                getIt<UserProfileService>();
            await userProfileService.updateUserProfile(
              quoteId: responseData.data!.quoteId,
            );
            DebugLog.instance.i(
                'Updated quoteId in UserProfileService from addToCart: ${responseData.data!.quoteId}');
          }

          // Update the variant's cart quantity in the state
          _updateVariantCartQuantityInState(
            variantIndex: variantIndex,
            cartQuantity: quantity,
            status: BaseStateStatus.success,
            message: responseData?.message ?? 'Added to cart successfully',
          );

          // Update global cart manager
          final GlobalWishlistManager globalWishlistManager = getIt<GlobalWishlistManager>();
          final String cartKey = '${variant.sku}_${variant.entityId}';
          globalWishlistManager.updateCartQuantity(cartKey, quantity);
          DebugLog.instance.d('🔄 CART: Added to global cart manager with key $cartKey and quantity $quantity');

          // Update cart count from API response if available
          if (responseData?.data?.cartCount != null) {
            countCubit.updateCount(responseData!.data!.cartCount!);
            DebugLog.instance.i(
                'Updated cart count from API in cart page add: ${responseData.data!.cartCount}');
          } else {
            // Fallback: update cart count by adding 1
            final int currentCount = countCubit.state;
            countCubit.updateCount(currentCount + 1);
          }

          // Refresh cart listing to update totals and amounts
          await _callCartListingApi();
        } else {
          _updateVariantCartQuantityInState(
            variantIndex: variantIndex,
            cartQuantity: variant.cartQuantity ?? 0,
            status: BaseStateStatus.failure,
            message: responseData?.message ?? 'Failed to add to cart',
          );
        }
      } else if (response.isFailure()) {
        _updateVariantCartQuantityInState(
          variantIndex: variantIndex,
          cartQuantity: variant.cartQuantity ?? 0,
          status: BaseStateStatus.failure,
          message: response.getFailureInstance()?.error?.errorMessage ??
              'Failed to add to cart',
        );
      }
    } on Exception catch (e) {
      DebugLog.instance.e('Error adding variant to cart: $e');
      _updateVariantCartQuantityInState(
        variantIndex: variantIndex,
        cartQuantity: variant.cartQuantity ?? 0,
        status: BaseStateStatus.failure,
        message: 'An error occurred while adding to cart',
      );
    }
  }

  /// Update variant cart quantity
  Future<void> _updateVariantCartQuantity(
      ProductVariantDukkan variant, int variantIndex, int quantity) async {
    try {
      if (quantity <= 0) {
        // Remove from cart if quantity is 0 or less
        await _removeVariantFromCart(variant, variantIndex);
        return;
      }

      if (variant.entityId == null || variant.sku == null) {
        DebugLog.instance.e('Variant entityId or sku is null');
        return;
      }

      final ResponseHandler<BaseResponse<CartOperationResponseModel>> response =
          await updateToCartListApi(
        qty: quantity.toString(),
        entityId: variant.entityId.toString(),
        sku: variant.sku!,
      );

      if (response.isSuccess()) {
        final BaseResponse<CartOperationResponseModel>? responseData =
            response.getSuccessInstance()?.response;

        if (responseData?.success ?? false) {
          // Update quoteId in UserProfileService if available
          if (responseData?.data?.quoteId != null &&
              responseData!.data!.quoteId!.isNotEmpty) {
            final UserProfileService userProfileService =
                getIt<UserProfileService>();
            await userProfileService.updateUserProfile(
              quoteId: responseData.data!.quoteId,
            );
            DebugLog.instance.i(
                'Updated quoteId in UserProfileService from updateCart: ${responseData.data!.quoteId}');
          }

          // Calculate cart count change
          final int oldQuantity = variant.cartQuantity ?? 0;
          final int quantityChange = quantity - oldQuantity;

          // Update the variant's cart quantity in the state
          _updateVariantCartQuantityInState(
            variantIndex: variantIndex,
            cartQuantity: quantity,
            status: BaseStateStatus.success,
            message: responseData?.message ?? 'Cart updated successfully',
          );

          // Update global cart manager
          final GlobalWishlistManager globalWishlistManager = getIt<GlobalWishlistManager>();
          final String cartKey = '${variant.sku}_${variant.entityId}';
          globalWishlistManager.updateCartQuantity(cartKey, quantity);
          DebugLog.instance.d('🔄 CART: Updated global cart manager with key $cartKey and quantity $quantity');
          // Update cart count from API response if available
          if (responseData?.data?.cartCount != null) {
            countCubit.updateCount(responseData!.data!.cartCount!);
            DebugLog.instance.i(
                'Updated cart count from API in cart page update: ${responseData.data!.cartCount}');
          } else {
            // Fallback: update cart count based on quantity change
            final int currentCount = countCubit.state;
            countCubit.updateCount(currentCount + quantityChange);
          }

          // Refresh cart listing to update totals and amounts
          await _callCartListingApi();
        } else {
          _updateVariantCartQuantityInState(
            variantIndex: variantIndex,
            cartQuantity: variant.cartQuantity ?? 0,
            status: BaseStateStatus.failure,
            message: responseData?.message ?? 'Failed to update cart',
          );
        }
      } else if (response.isFailure()) {
        _updateVariantCartQuantityInState(
          variantIndex: variantIndex,
          cartQuantity: variant.cartQuantity ?? 0,
          status: BaseStateStatus.failure,
          message: response.getFailureInstance()?.error?.errorMessage ??
              'Failed to update cart',
        );
      }
    } on Exception catch (e) {
      DebugLog.instance.e('Error updating variant cart quantity: $e');
      _updateVariantCartQuantityInState(
        variantIndex: variantIndex,
        cartQuantity: variant.cartQuantity ?? 0,
        status: BaseStateStatus.failure,
        message: 'An error occurred while updating cart',
      );
    }
  }

  /// Remove variant from cart
  Future<void> _removeVariantFromCart(
      ProductVariantDukkan variant, int variantIndex) async {
    try {
      if (variant.sku == null) {
        DebugLog.instance.e('Variant sku is null');
        return;
      }

      final ResponseHandler<BaseResponse<CartOperationResponseModel>> response =
          await removeToCartListApi(
        sku: variant.sku!,
      );

      if (response.isSuccess()) {
        final BaseResponse<CartOperationResponseModel>? responseData =
            response.getSuccessInstance()?.response;

        if (responseData?.success ?? false) {
          // Update quoteId in UserProfileService if available
          if (responseData?.data?.quoteId != null &&
              responseData!.data!.quoteId!.isNotEmpty) {
            final UserProfileService userProfileService =
                getIt<UserProfileService>();
            await userProfileService.updateUserProfile(
              quoteId: responseData.data!.quoteId,
            );
            DebugLog.instance.i(
                'Updated quoteId in UserProfileService from removeFromCart: ${responseData.data!.quoteId}');
          }

          // Calculate cart count change
          final int oldQuantity = variant.cartQuantity ?? 0;

          // Update the variant's cart quantity in the state
          _updateVariantCartQuantityInState(
            variantIndex: variantIndex,
            cartQuantity: 0,
            status: BaseStateStatus.success,
            message: responseData?.message ?? 'Removed from cart successfully',
          );

          // Update global cart manager
          final GlobalWishlistManager globalWishlistManager = getIt<GlobalWishlistManager>();
          final String cartKey = '${variant.sku}_${variant.entityId}';
          globalWishlistManager.removeFromCart(cartKey);
          DebugLog.instance.d('🔄 CART: Removed from global cart manager with key $cartKey');

          // Update cart count from API response if available
          if (responseData?.data?.cartCount != null) {
            countCubit.updateCount(responseData!.data!.cartCount!);
            DebugLog.instance.i(
                'Updated cart count from API in cart page remove: ${responseData.data!.cartCount}');
          } else {
            // Fallback: update cart count based on quantity change
            final int currentCount = countCubit.state;
            countCubit.updateCount(currentCount - oldQuantity);
          }

          // Refresh cart listing to update totals and amounts
          await _callCartListingApi();
        } else {
          _updateVariantCartQuantityInState(
            variantIndex: variantIndex,
            cartQuantity: variant.cartQuantity ?? 0,
            status: BaseStateStatus.failure,
            message: responseData?.message ?? 'Failed to remove from cart',
          );
        }
      } else if (response.isFailure()) {
        _updateVariantCartQuantityInState(
          variantIndex: variantIndex,
          cartQuantity: variant.cartQuantity ?? 0,
          status: BaseStateStatus.failure,
          message: response.getFailureInstance()?.error?.errorMessage ??
              'Failed to remove from cart',
        );
      }
    } on Exception catch (e) {
      DebugLog.instance.e('Error removing variant from cart: $e');
      _updateVariantCartQuantityInState(
        variantIndex: variantIndex,
        cartQuantity: variant.cartQuantity ?? 0,
        status: BaseStateStatus.failure,
        message: 'An error occurred while removing from cart',
      );
    }
  }

  /// Handle cart operations for deals/you may also like sections (Hot Deals in Cart)
  /// This mirrors HomeCubit's behavior, scoped to CartPageCubit state.
  Future<void> handleCartOperationForDeals({
    required int productIndex,
    required bool isDealsSection,
    required CartOperation operation,
    int? variantIndex,
  }) async {
    final List<ProductListingResponse> currentProducts = isDealsSection
        ? (state.dealsModel?.firstOrNull?.productListModel ??
            <ProductListingResponse>[])
        : (state.youMayAlsoLikeDealsModel?.firstOrNull?.productListModel ??
            <ProductListingResponse>[]);

    await handleCartOperation(
      productIndex: productIndex,
      products: currentProducts,
      operation: operation,
      variantIndex: variantIndex,
      updateProductCartQuantity: (int pIndex,
          int cartQuantity,
          BaseStateStatus status,
          String message,
          int? vIndex,
          int? apiCartCount) async {
        _updateDealsProductCartQuantity(
          productIndex: pIndex,
          cartQuantity: cartQuantity,
          status: status,
          message: message,
          isDealsSection: isDealsSection,
          variantIndex: vIndex,
          apiCartCount: apiCartCount,
        );

        // After successful operation, refresh cart listing for accurate totals
        if (status == BaseStateStatus.success) {
          await _callCartListingApi();
        }
      },
      addToCartApi: addToCartListApi,
      removeFromCartApi: removeToCartListApi,
      updateToCartApi: updateToCartListApi,
    );
  }

  /// Update product cart quantity within deals/you-may-also-like lists
  void _updateDealsProductCartQuantity({
    required int productIndex,
    required int cartQuantity,
    required BaseStateStatus status,
    required String message,
    required bool isDealsSection,
    int? variantIndex,
    int? apiCartCount, // Cart count from API response
  }) {
    // Update global cart count from API response if available
    if (status == BaseStateStatus.success && apiCartCount != null) {
      countCubit.updateCount(apiCartCount);
      DebugLog.instance
          .i('Updated cart count from API in cart page: $apiCartCount');
    }
    if (isDealsSection) {
      final List<DealsResponseModel> currentDealsList =
          state.dealsModel ?? <DealsResponseModel>[];
      if (currentDealsList.isEmpty) return;
      final DealsResponseModel firstDeal = currentDealsList.first;
      final List<ProductListingResponse> currentProductList =
          firstDeal.productListModel;
      if (productIndex < 0 || productIndex >= currentProductList.length) return;

      final List<ProductListingResponse> updatedProductList =
          List<ProductListingResponse>.from(currentProductList);
      final ProductListingResponse product = updatedProductList[productIndex];

      ProductListingResponse updatedProduct;
      if (variantIndex != null &&
          product.productVariant != null &&
          variantIndex < product.productVariant!.length) {
        final List<ProductVariantDukkan> updatedVariants =
            List<ProductVariantDukkan>.from(product.productVariant!);
        updatedVariants[variantIndex] =
            updatedVariants[variantIndex].copyWith(cartQuantity: cartQuantity);
        updatedProduct = product.copyWith(productVariant: updatedVariants);
      } else {
        updatedProduct = product.copyWith(
            cartQuantity: cartQuantity, isCart: cartQuantity > 0);
      }

      updatedProductList[productIndex] = updatedProduct;
      final List<DealsResponseModel> updatedDealsList =
          List<DealsResponseModel>.from(currentDealsList);
      updatedDealsList[0] = DealsResponseModel(
        id: firstDeal.id,
        type: firstDeal.type,
        label: firstDeal.label,
        redirectUrl: firstDeal.redirectUrl,
        productListModel: updatedProductList,
      );

      emit(state.copyWith(
        status: status,
        msg: message,
        dealsModel: updatedDealsList,
      ));
    } else {
      final List<DealsResponseModel> currentList =
          state.youMayAlsoLikeDealsModel ?? <DealsResponseModel>[];
      if (currentList.isEmpty) return;
      final DealsResponseModel firstDeal = currentList.first;
      final List<ProductListingResponse> currentProductList =
          firstDeal.productListModel;
      if (productIndex < 0 || productIndex >= currentProductList.length) return;

      final List<ProductListingResponse> updatedProductList =
          List<ProductListingResponse>.from(currentProductList);
      final ProductListingResponse product = updatedProductList[productIndex];

      ProductListingResponse updatedProduct;
      if (variantIndex != null &&
          product.productVariant != null &&
          variantIndex < product.productVariant!.length) {
        final List<ProductVariantDukkan> updatedVariants =
            List<ProductVariantDukkan>.from(product.productVariant!);
        updatedVariants[variantIndex] =
            updatedVariants[variantIndex].copyWith(cartQuantity: cartQuantity);
        updatedProduct = product.copyWith(productVariant: updatedVariants);
      } else {
        updatedProduct = product.copyWith(
            cartQuantity: cartQuantity, isCart: cartQuantity > 0);
      }

      updatedProductList[productIndex] = updatedProduct;
      final List<DealsResponseModel> updatedList =
          List<DealsResponseModel>.from(currentList);
      updatedList[0] = DealsResponseModel(
        id: firstDeal.id,
        type: firstDeal.type,
        label: firstDeal.label,
        redirectUrl: firstDeal.redirectUrl,
        productListModel: updatedProductList,
      );

      emit(state.copyWith(
        status: status,
        msg: message,
        youMayAlsoLikeDealsModel: updatedList,
      ));
    }
  }

  /// Update variant cart quantity in state
  void _updateVariantCartQuantityInState({
    required int variantIndex,
    required int cartQuantity,
    required BaseStateStatus status,
    required String message,
  }) {
    final List<ProductVariantDukkan> currentVariants =
        state.flattenedVariants ?? <ProductVariantDukkan>[];

    if (variantIndex >= 0 && variantIndex < currentVariants.length) {
      final List<ProductVariantDukkan> updatedVariants =
          List<ProductVariantDukkan>.from(currentVariants);
      updatedVariants[variantIndex] = updatedVariants[variantIndex].copyWith(
        cartQuantity: cartQuantity,
        isCart: cartQuantity > 0,
      );

      emit(
        state.copyWith(
          status: status,
          msg: message,
          flattenedVariants: updatedVariants,
        ),
      );
    }
  }

  /// API call for getting deals listing
  Future<void> _callHomeDeals({
    DealsTagName tagName = DealsTagName.bestDeals,
    DealsScreen screen = DealsScreen.home,
  }) async {
    final DateTime startTime = DateTime.now();
    DebugLog.instance.d(
        '🔄 CART PAGE API TIMING: Home Deals API started at ${startTime.toIso8601String()}');

    emit(state.copyWith(apiCallForHomeDeals: BaseStateStatus.loading));

    final UserProfileService userProfileService = getIt<UserProfileService>();
    final LanguageService languageService = getIt<LanguageService>();
    final CountryService countryService = getIt<CountryService>();
    final MainConfig mainConfig = getIt<MainConfig>();

    // Create deals request model
    final DealsRequestModel dealsRequest = DealsRequestModel(
        languageId: int.tryParse(languageService.languageId) ?? 1,
        quoteId: userProfileService.quoteId,
        customerToken: userProfileService.customerToken,
        platform: getPlatformName(),
        version: mainConfig.packageInfo.version,
        limit: AppConstant.limitDeal,
        currency: languageService.defaultCurrency,
        storeId: countryService.store,
        tagName: tagName.value,
        screen: screen.value);

    // Call the repository to get deals list
    final ResponseHandler<BaseResponse<List<DealsResponseModel>>> response =
        await homeRepository.getHomeDealsList(dealsRequest);

    if (response.isSuccess()) {
      final OnSuccessResponse<BaseResponse<List<DealsResponseModel>>>?
          successInstance = response.getSuccessInstance();

      if (successInstance != null) {
        final BaseResponse<List<DealsResponseModel>> saveResponse =
            successInstance.response;

        // Check if the save operation was successful
        if (saveResponse.success) {
          emit(state.copyWith(
            apiCallForHomeDeals: BaseStateStatus.success,
            dealsModel: saveResponse.data, // Store the deals data in state
          ));

          // Debug log the deals data
          if (saveResponse.data != null && saveResponse.data!.isNotEmpty) {
            for (int i = 0; i < saveResponse.data!.length; i++) {
              final DealsResponseModel deals = saveResponse.data![i];
              // Log child categories if they exist
              if (deals.productListModel.isNotEmpty) {
                for (int j = 0; j < deals.productListModel.length; j++) {
                  final ProductListingResponse productListModel =
                      deals.productListModel[j];

                  if (productListModel.productVariant?.isNotEmpty ?? false) {
                    for (int k = 0;
                        k < productListModel.productVariant!.length;
                        k++) {
                      // Process variant if needed
                      // final ProductVariantDukkan variant = productListModel
                      //     .productVariant?[k] as ProductVariantDukkan;
                    }
                  }
                }
              }
            }
          }
        } else {
          emit(state.copyWith(
            apiCallForHomeDeals: BaseStateStatus.failure,
            msg: saveResponse.error,
          ));
        }
      } else {
        emit(state.copyWith(
          apiCallForHomeDeals: BaseStateStatus.failure,
          msg: response.getFailureInstance()?.error?.errorMessage ?? '',
        ));
      }
    }

    // Track API completion
    final DateTime endTime = DateTime.now();
    final Duration duration = endTime.difference(startTime);
    DebugLog.instance.d(
        '⏱️ CART PAGE API TIMING: Home Deals API completed in ${duration.inMilliseconds}ms');
    _trackApiCompletion('Home Deals API');
  }

  /// Call deals API for "You May Also Like" section
  Future<void> callYouMayAlsoLikeDeals() async {
    final DateTime startTime = DateTime.now();
    DebugLog.instance.d(
        '🔄 CART PAGE API TIMING: You May Also Like Deals API started at ${startTime.toIso8601String()}');

    emit(
        state.copyWith(apiCallForYouMayAlsoLikeDeals: BaseStateStatus.loading));

    final UserProfileService userProfileService = getIt<UserProfileService>();
    final LanguageService languageService = getIt<LanguageService>();
    final CountryService countryService = getIt<CountryService>();
    final MainConfig mainConfig = getIt<MainConfig>();

    // Create deals request model
    final DealsRequestModel dealsRequest = DealsRequestModel(
        languageId: int.tryParse(languageService.languageId) ?? 1,
        quoteId: userProfileService.quoteId,
        customerToken: userProfileService.customerToken,
        platform: getPlatformName(),
        version: mainConfig.packageInfo.version,
        currency: languageService.defaultCurrency,
        storeId: countryService.store,
        limit: AppConstant.limitDeal,
        tagName: DealsTagName.youMayAlsoLike.value,
        screen: DealsScreen.home.value);
    final ResponseHandler<BaseResponse<List<DealsResponseModel>>> response =
        await homeRepository.getHomeDealsList(dealsRequest);

    if (response.isSuccess()) {
      final OnSuccessResponse<BaseResponse<List<DealsResponseModel>>>?
          successInstance = response.getSuccessInstance();

      if (successInstance != null) {
        final BaseResponse<List<DealsResponseModel>> saveResponse =
            successInstance.response;

        // Check if the save operation was successful
        if (saveResponse.success) {
          emit(state.copyWith(
            apiCallForYouMayAlsoLikeDeals: BaseStateStatus.success,
            youMayAlsoLikeDealsModel:
                saveResponse.data, // Store the deals data in state
          ));

          // Debug log the deals data
          if (saveResponse.data != null && saveResponse.data!.isNotEmpty) {
            for (int i = 0; i < saveResponse.data!.length; i++) {
              final DealsResponseModel deals = saveResponse.data![i];
              // Log child categories if they exist
              if (deals.productListModel.isNotEmpty) {
                for (int j = 0; j < deals.productListModel.length; j++) {
                  final ProductListingResponse productListModel =
                      deals.productListModel[j];

                  if (productListModel.productVariant?.isNotEmpty ?? false) {
                    for (int k = 0;
                        k < productListModel.productVariant!.length;
                        k++) {
                      // Process variant if needed
                      // final ProductVariantDukkan variant = productListModel
                      //     .productVariant?[k] as ProductVariantDukkan;
                    }
                  }
                }
              }
            }
          }
        } else {
          emit(state.copyWith(
            apiCallForYouMayAlsoLikeDeals: BaseStateStatus.failure,
            msg: saveResponse.error,
          ));
        }
      } else {
        emit(state.copyWith(
          apiCallForYouMayAlsoLikeDeals: BaseStateStatus.failure,
          msg: response.getFailureInstance()?.error?.errorMessage ?? '',
        ));
      }
    }

    // Track API completion
    final DateTime endTime = DateTime.now();
    final Duration duration = endTime.difference(startTime);
    DebugLog.instance.d(
        '⏱️ CART PAGE API TIMING: You May Also Like Deals API completed in ${duration.inMilliseconds}ms');
    _trackApiCompletion('You May Also Like Deals API');
  }

  /// API call for getting payment methods
  /// This method fetches the available payment methods from the server
  Future<void> callPaymentMethodsApi() async {
    final DateTime startTime = DateTime.now();
    DebugLog.instance.d(
        '🔄 CART PAGE API TIMING: Payment Methods API started at ${startTime.toIso8601String()}');

    emit(state.copyWith(statusForPaymentMethods: BaseStateStatus.loading));
    final UserProfileService userProfileService = getIt<UserProfileService>();
    final LanguageService languageService = getIt<LanguageService>();
    final CountryService countryService = getIt<CountryService>();
    final MainConfig mainConfig = getIt<MainConfig>();

    // Create payment methods request model
    final PaymentMethodRequest paymentMethodRequest = PaymentMethodRequest(
      customerToken: userProfileService.customerToken,
      platform: getPlatformName(),
      version: mainConfig.packageInfo.version,
      languageId: int.tryParse(languageService.languageId) ?? 1,
      storeId: countryService.store,
    );

    // Call the repository to get payment methods
    final ResponseHandler<BaseResponse<List<PaymentMethodResponse>>> response =
        await cartPageRepository.getPaymentMethods(
            request: paymentMethodRequest);

    if (response.isSuccess()) {
      final OnSuccessResponse<BaseResponse<List<PaymentMethodResponse>>>?
          successInstance = response.getSuccessInstance();

      if (successInstance != null) {
        final BaseResponse<List<PaymentMethodResponse>> paymentMethodsResponse =
            successInstance.response;

        // Check if the API call was successful
        if (paymentMethodsResponse.success) {
          // Emit the payment methods to state
          emit(state.copyWith(
            statusForPaymentMethods: BaseStateStatus.success,
            availablePaymentMethods: paymentMethodsResponse.data,
          ));
        } else {
          emit(state.copyWith(
            statusForPaymentMethods: BaseStateStatus.failure,
            msg: paymentMethodsResponse.message,
          ));
        }
      } else {
        DebugLog.instance.e('Payment methods API failed: No success instance');
      }
    } else if (response.isFailure()) {
      final OnFailureResponse<BaseResponse<List<PaymentMethodResponse>>>?
          failureInstance = response.getFailureInstance();
      final String errorMessage =
          failureInstance?.error?.errorMessage ?? 'Payment methods API failed';

      emit(state.copyWith(
        statusForPaymentMethods: BaseStateStatus.failure,
        msg: errorMessage,
      ));
      DebugLog.instance.e('Payment methods API failed: $errorMessage');
    }

    // Track API completion
    final DateTime endTime = DateTime.now();
    final Duration duration = endTime.difference(startTime);
    DebugLog.instance.d(
        '⏱️ CART PAGE API TIMING: Payment Methods API completed in ${duration.inMilliseconds}ms');
    _trackApiCompletion('Payment Methods API');
  }

  /// API call for getting time slots
  /// This method fetches the available time slots from the server
  Future<void> callTimeSlotsApi() async {
    final DateTime startTime = DateTime.now();
    DebugLog.instance.d(
        '🔄 CART PAGE API TIMING: Time Slots API started at ${startTime.toIso8601String()}');

    emit(state.copyWith(statusForTimeSlots: BaseStateStatus.loading));

    final UserProfileService userProfileService = getIt<UserProfileService>();
    final CountryService countryService = getIt<CountryService>();
    final LanguageService languageService = getIt<LanguageService>();
    final MainConfig mainConfig = getIt<MainConfig>();

    // Create time slots request model
    final TimeSlotsRequest timeSlotsRequest = TimeSlotsRequest(
        customerToken: userProfileService.customerToken,
        platform: getPlatformName(),
        version: mainConfig.packageInfo.version,
        storeId: countryService.store,
        languageId: int.tryParse(languageService.languageId) ?? 1);

    // Call the repository to get time slots
    final ResponseHandler<BaseResponse<List<TimeSlotsResponse>>> response =
        await cartPageRepository.getTimeSlots(request: timeSlotsRequest);

    if (response.isSuccess()) {
      final OnSuccessResponse<BaseResponse<List<TimeSlotsResponse>>>?
          successInstance = response.getSuccessInstance();

      if (successInstance != null) {
        final BaseResponse<List<TimeSlotsResponse>> timeSlotsResponse =
            successInstance.response;

        // Check if the API call was successful
        if (timeSlotsResponse.success) {
          // Emit the time slots to state
          emit(state.copyWith(
            statusForTimeSlots: BaseStateStatus.success,
            availableTimeSlots: timeSlotsResponse.data,
          ));
        } else {
          emit(state.copyWith(
            statusForTimeSlots: BaseStateStatus.failure,
            msg: timeSlotsResponse.message,
          ));
        }
      } else {
        emit(state.copyWith(
          statusForTimeSlots: BaseStateStatus.failure,
          msg: '',
        ));
      }
    } else if (response.isFailure()) {
      final OnFailureResponse<BaseResponse<List<TimeSlotsResponse>>>?
          failureInstance = response.getFailureInstance();
      final String errorMessage = failureInstance?.error?.errorMessage ?? '';

      emit(state.copyWith(
        statusForTimeSlots: BaseStateStatus.failure,
        msg: errorMessage,
      ));
    }

    // Track API completion
    final DateTime endTime = DateTime.now();
    final Duration duration = endTime.difference(startTime);
    DebugLog.instance.d(
        '⏱️ CART PAGE API TIMING: Time Slots API completed in ${duration.inMilliseconds}ms');
    _trackApiCompletion('Time Slots API');
  }

  /// Selects a time slot by index
  void selectTimeSlot(int index) {
    emit(state.copyWith(selectedTimeSlot: index));
  }

  /// Selects a payment method
  void selectPaymentMethod(PaymentMethodResponse paymentMethod) {
    emit(state.copyWith(selectedPaymentMethod: paymentMethod));
  }

  /// Validates pickup order requirements
  /// Returns true if all pickup requirements are met, false otherwise
  bool _validatePickupOrderRequirements() {
    final String deliveryType = SharedPref.instance.getDeliveryType();
    final bool isPickupOrder = deliveryType == 'pickup';

    if (!isPickupOrder) {
      return true; // Not a pickup order, no pickup-specific validation needed
    }

    // Validate store ID
    final CountryService countryService = getIt<CountryService>();
    if (countryService.store == null || countryService.store == 0) {
      emit(state.copyWith(
        status: BaseStateStatus.failure,
        msg: 'Store information is required for pickup orders',
      ));
      return false;
    }

    // Validate timeslot selection
    if (state.selectedTimeSlot == null) {
      emit(state.copyWith(
        status: BaseStateStatus.failure,
        msg: 'Please select a pickup time slot',
      ));
      return false;
    }

    // Validate that timeslots are available
    if (state.availableTimeSlots == null || state.availableTimeSlots!.isEmpty) {
      emit(state.copyWith(
        status: BaseStateStatus.failure,
        msg: 'No pickup time slots are available',
      ));
      return false;
    }

    // Validate selected timeslot index is within bounds
    if (state.selectedTimeSlot! < 0 ||
        state.selectedTimeSlot! >= state.availableTimeSlots!.length) {
      emit(state.copyWith(
        status: BaseStateStatus.failure,
        msg: 'Selected time slot is invalid',
      ));
      return false;
    }

    return true;
  }

  /// Creates a pickup order from the current cart
  Future<void> addPickupOrderFromCart() async {
    // Basic validations
    if ((state.cartCount ?? 0) <= 0) {
      emit(state.copyWith(
        status: BaseStateStatus.failure,
        msg: 'Your cart is empty',
      ));
      return;
    }

    if (state.selectedPaymentMethod?.id == null) {
      emit(state.copyWith(
        status: BaseStateStatus.failure,
        msg: 'Please select a payment method',
      ));
      return;
    }

    // Validate pickup order requirements
    if (!_validatePickupOrderRequirements()) {
      return; // Validation failed, error message already emitted
    }

    emit(state.copyWith(status: BaseStateStatus.loading));

    try {
      final UserProfileService userProfileService = getIt<UserProfileService>();
      final LanguageService languageService = getIt<LanguageService>();
      final CountryService countryService = getIt<CountryService>();
      final MainConfig mainConfig = getIt<MainConfig>();

      final dynamic quoteId = userProfileService.quoteId;

      // Build pickup order request
      final CartCheckoutRequest request = CartCheckoutRequest(
        languageId: int.tryParse(languageService.languageId) ?? 1,
        storeId: countryService.store,
        customerToken: userProfileService.customerToken,
        quoteId: (quoteId is String && quoteId.isNotEmpty) ? quoteId : null,
        platform: getPlatformName(),
        version: mainConfig.packageInfo.version,

        // No delivery address for pickup
        orderType: 'pickup',
        websiteId: 1,
        paymentMethod: state.selectedPaymentMethod?.id,
        deliveryInstructions: state.deliveryInstructions,
        // Can be added later if needed for pickup instructions
        couponCode:
            (state.couponCode?.isNotEmpty ?? false) ? state.couponCode : null,
        timeslot:
            state.selectedTimeSlot != null ? state.selectedTimeSlot! + 1 : null,
        loyaltyPointsRedeem:
            state.cartDetailsListingResponse?.loyaltyPointsApplied ?? 0.0,
        walletAmount: state.cartDetailsListingResponse?.walletApplied ?? 0.0,
      );

      final ResponseHandler<BaseResponse<OrderResponse>> response =
          await cartPageRepository.addOrder(request: request);

      if (response.isSuccess()) {
        final BaseResponse<OrderResponse>? base =
            response.getSuccessInstance()?.response;
        if (base?.success ?? false) {
          // Reset quoteId to zero after successful order placement
          await userProfileService.updateUserProfile(quoteId: '0');
          DebugLog.instance
              .i('Reset quoteId to 0 after successful pickup order placement');

          emit(state.copyWith(
            status: BaseStateStatus.success,
            msg: base?.message ?? 'Pickup order placed successfully',
            showOrderSuccessDialog: true,
            orderId: base?.data?.orderId,
            transactionId: base?.data?.transactionId,
            orderDateTime: base?.data?.dateTime,
            orderTotalAmount: base?.data?.totalAmount,
            msgCoupon: base?.data?.msgCoupon,
          ));
        } else {
          emit(state.copyWith(
            status: BaseStateStatus.failure,
            msg: base?.message ?? 'Failed to place pickup order',
          ));
        }
      } else {
        emit(state.copyWith(
          status: BaseStateStatus.failure,
          msg: response.getFailureInstance()?.error?.errorMessage ??
              'Failed to place pickup order',
        ));
      }
    } on Exception catch (e) {
      DebugLog.instance.e('addPickupOrderFromCart error: $e');
      emit(state.copyWith(
        status: BaseStateStatus.failure,
        msg: 'An error occurred while placing pickup order',
      ));
    }
  }

  /// Creates a delivery order from the current cart
  Future<void> addDeliveryOrderFromCart() async {
    // Basic validations
    if ((state.cartCount ?? 0) <= 0) {
      emit(state.copyWith(
        status: BaseStateStatus.failure,
        msg: 'Your cart is empty',
      ));
      return;
    }

    if (state.selectedPaymentMethod?.id == null) {
      emit(state.copyWith(
        status: BaseStateStatus.failure,
        msg: 'Please select a payment method',
      ));
      return;
    }

    emit(state.copyWith(status: BaseStateStatus.loading));

    try {
      final UserProfileService userProfileService = getIt<UserProfileService>();
      final LanguageService languageService = getIt<LanguageService>();
      final CountryService countryService = getIt<CountryService>();
      final MainConfig mainConfig = getIt<MainConfig>();
      final dynamic quoteId = userProfileService.quoteId;
      // Build delivery order request
      final CartCheckoutRequest request = CartCheckoutRequest(
        languageId: int.tryParse(languageService.languageId) ?? 1,
        storeId: countryService.store,
        customerToken: userProfileService.customerToken,
        quoteId: (quoteId is String && quoteId.isNotEmpty) ? quoteId : null,
        platform: getPlatformName(),
        version: mainConfig.packageInfo.version,
        // Can be wired from address selection when available
        orderType: 'delivery',
        websiteId: 1,
        paymentMethod: state.selectedPaymentMethod?.id,
        deliveryInstructions: state.deliveryInstructions,
        // Can be added later if needed
        couponCode:
            (state.couponCode?.isNotEmpty ?? false) ? state.couponCode : null,
        // No timeslot required for delivery
        loyaltyPointsRedeem:
            state.cartDetailsListingResponse?.loyaltyPointsApplied ?? 0.0,
        walletAmount: state.cartDetailsListingResponse?.walletApplied ?? 0.0,
      );

      final ResponseHandler<BaseResponse<OrderResponse>> response =
          await cartPageRepository.addOrder(request: request);

      if (response.isSuccess()) {
        final BaseResponse<OrderResponse>? base =
            response.getSuccessInstance()?.response;
        if (base?.success ?? false) {
          // Reset quoteId to zero after successful order placement
          await userProfileService.updateUserProfile(quoteId: '0');
          DebugLog.instance.i(
              'Reset quoteId to 0 after successful delivery order placement');

          emit(state.copyWith(
            status: BaseStateStatus.success,
            msg: base?.message ?? 'Delivery order placed successfully',
            showOrderSuccessDialog: true,
            orderId: base?.data?.orderId,
            transactionId: base?.data?.transactionId,
            orderDateTime: base?.data?.dateTime,
            orderTotalAmount: base?.data?.totalAmount,
            msgCoupon: base?.data?.msgCoupon,
          ));
        } else {
          emit(state.copyWith(
            status: BaseStateStatus.failure,
            msg: base?.message ?? 'Failed to place delivery order',
          ));
        }
      } else {
        emit(state.copyWith(
          status: BaseStateStatus.failure,
          msg: response.getFailureInstance()?.error?.errorMessage ??
              'Failed to place delivery order',
        ));
      }
    } on Exception catch (e) {
      DebugLog.instance.e('addDeliveryOrderFromCart error: $e');
      emit(state.copyWith(
        status: BaseStateStatus.failure,
        msg: 'An error occurred while placing delivery order',
      ));
    }
  }

  /// Creates an order from the current cart - routes to appropriate method based on delivery type
  Future<void> addOrderFromCart() async {
    final String deliveryType = SharedPref.instance.getDeliveryType();

    if (deliveryType == 'pickup') {
      await addPickupOrderFromCart();
    } else {
      await addDeliveryOrderFromCart();
    }
  }

  /// Resets the order success dialog state
  void resetOrderSuccessDialog() {
    emit(state.copyWith(showOrderSuccessDialog: false));
  }

  /// Resets the free gift dialog state
  void resetFreeGiftDialog() {
    emit(state.copyWith(showFreeGiftDialog: false));
  }
  /// set the Next Order Coupon dialog state
  void setNextOrderCouponDialog() {
    emit(state.copyWith(showNextOrderCouponDialog: true));
  }

  /// reset the Next Order Coupon dialog state
  void resetNextOrderCouponDialog() {
    emit(state.copyWith(showNextOrderCouponDialog: false));
  }


  /// Handle like/dislike functionality for wishlist items in cart
  /// This method adds or removes items from wishlist based on current status
  Future<void> handleWishlistLikeDislikeForCart({
    required String sku,
    required int variantIndex,
    required bool isCurrentlyFavorite,
  }) async {
    try {
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

            // Update the variant's favorite status in the cart
            _updateCartVariantWishlistStatus(
              variantIndex: variantIndex,
              isFavorite: false,
              status: BaseStateStatus.success,
              message: responseData?.message ?? '',
            );
          } else {
            _updateCartVariantWishlistStatus(
              variantIndex: variantIndex,
              isFavorite: isCurrentlyFavorite, // Keep current status
              status: BaseStateStatus.failure,
              message: responseData?.message ?? '',
            );
          }
        } else if (response.isFailure()) {
          _updateCartVariantWishlistStatus(
            variantIndex: variantIndex,
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

            // Update the variant's favorite status in the cart
            _updateCartVariantWishlistStatus(
              variantIndex: variantIndex,
              isFavorite: true,
              status: BaseStateStatus.success,
              message: responseData?.message ?? '',
            );
          } else {
            _updateCartVariantWishlistStatus(
              variantIndex: variantIndex,
              isFavorite: isCurrentlyFavorite, // Keep current status
              status: BaseStateStatus.failure,
              message: responseData?.message ?? '',
            );
          }
        } else if (response.isFailure()) {
          _updateCartVariantWishlistStatus(
            variantIndex: variantIndex,
            isFavorite: isCurrentlyFavorite, // Keep current status
            status: BaseStateStatus.failure,
            message: response.getFailureInstance()?.error?.errorMessage ??
                'Failed to add to wishlist',
          );
        }
      }
    } on Exception {
      _updateCartVariantWishlistStatus(
        variantIndex: variantIndex,
        isFavorite: isCurrentlyFavorite, // Keep current status
        status: BaseStateStatus.failure,
        message: 'An error occurred while updating wishlist',
      );
    }
  }

  /// Update variant wishlist status in cart
  void _updateCartVariantWishlistStatus({
    required int variantIndex,
    required bool isFavorite,
    required BaseStateStatus status,
    required String message,
  }) {
    final List<ProductVariantDukkan> currentVariants =
        state.flattenedVariants ?? <ProductVariantDukkan>[];

    if (variantIndex >= 0 && variantIndex < currentVariants.length) {
      final List<ProductVariantDukkan> updatedVariants =
          List<ProductVariantDukkan>.from(currentVariants);
      updatedVariants[variantIndex] = updatedVariants[variantIndex].copyWith(
        isFavorite: isFavorite,
      );

      emit(
        state.copyWith(
          status: status,
          msg: message,
          flattenedVariants: updatedVariants,
        ),
      );
    }
  }

  /// Handle like/dislike functionality for wishlist items in deals/you may also like sections
  /// This method adds or removes items from wishlist based on current status
  Future<void> handleWishlistLikeDislikeForDeals({
    required String sku,
    required int productIndex,
    required bool isCurrentlyFavorite,
    required bool isDealsSection, // true for deals, false for you may also like
  }) async {
    try {
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

            // Update the product's favorite status in the deals/you may also like section
            _updateDealsProductWishlistStatus(
              productIndex: productIndex,
              isFavorite: false,
              status: BaseStateStatus.success,
              message: responseData?.message ?? '',
              isDealsSection: isDealsSection,
            );
          } else {
            _updateDealsProductWishlistStatus(
              productIndex: productIndex,
              isFavorite: isCurrentlyFavorite,
              // Keep current status
              status: BaseStateStatus.failure,
              message: responseData?.message ?? '',
              isDealsSection: isDealsSection,
            );
          }
        } else if (response.isFailure()) {
          _updateDealsProductWishlistStatus(
            productIndex: productIndex,
            isFavorite: isCurrentlyFavorite,
            // Keep current status
            status: BaseStateStatus.failure,
            message: response.getFailureInstance()?.error?.errorMessage ?? '',
            isDealsSection: isDealsSection,
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

            // Update the product's favorite status in the deals/you may also like section
            _updateDealsProductWishlistStatus(
              productIndex: productIndex,
              isFavorite: true,
              status: BaseStateStatus.success,
              message: responseData?.message ?? '',
              isDealsSection: isDealsSection,
            );
          } else {
            _updateDealsProductWishlistStatus(
              productIndex: productIndex,
              isFavorite: isCurrentlyFavorite,
              // Keep current status
              status: BaseStateStatus.failure,
              message: responseData?.message ?? '',
              isDealsSection: isDealsSection,
            );
          }
        } else if (response.isFailure()) {
          _updateDealsProductWishlistStatus(
            productIndex: productIndex,
            isFavorite: isCurrentlyFavorite,
            // Keep current status
            status: BaseStateStatus.failure,
            message: response.getFailureInstance()?.error?.errorMessage ?? '',
            isDealsSection: isDealsSection,
          );
        }
      }
    } on Exception {
      _updateDealsProductWishlistStatus(
        productIndex: productIndex,
        isFavorite: isCurrentlyFavorite,
        // Keep current status
        status: BaseStateStatus.failure,
        message: 'An error occurred while updating wishlist',
        isDealsSection: isDealsSection,
      );
    }
  }

  /// Update product wishlist status in deals/you may also like sections
  void _updateDealsProductWishlistStatus({
    required int productIndex,
    required bool isFavorite,
    required BaseStateStatus status,
    required String message,
    required bool isDealsSection,
  }) {
    if (isDealsSection) {
      // Update deals section
      final List<DealsResponseModel> currentDealsList =
          state.dealsModel ?? <DealsResponseModel>[];
      if (currentDealsList.isNotEmpty) {
        final DealsResponseModel firstDeal = currentDealsList.first;
        final List<ProductListingResponse> currentProductList =
            firstDeal.productListModel;

        if (productIndex >= 0 && productIndex < currentProductList.length) {
          final List<ProductListingResponse> updatedProductList =
              List<ProductListingResponse>.from(currentProductList);
          final ProductListingResponse product =
              updatedProductList[productIndex];

          // Update the product's favorite status
          updatedProductList[productIndex] = product.copyWith(
            isFavorite: isFavorite,
          );

          // Create updated deals list
          final List<DealsResponseModel> updatedDealsList =
              List<DealsResponseModel>.from(currentDealsList);
          updatedDealsList[0] = DealsResponseModel(
            id: firstDeal.id,
            type: firstDeal.type,
            label: firstDeal.label,
            redirectUrl: firstDeal.redirectUrl,
            productListModel: updatedProductList,
          );

          // Emit the updated state
          emit(
            state.copyWith(
              status: status,
              msg: message,
              dealsModel: updatedDealsList,
            ),
          );
        }
      }
    } else {
      // Update you may also like section
      final List<DealsResponseModel> currentList =
          state.youMayAlsoLikeDealsModel ?? <DealsResponseModel>[];
      if (currentList.isNotEmpty) {
        final DealsResponseModel firstDeal = currentList.first;
        final List<ProductListingResponse> currentProductList =
            firstDeal.productListModel;

        if (productIndex >= 0 && productIndex < currentProductList.length) {
          final List<ProductListingResponse> updatedProductList =
              List<ProductListingResponse>.from(currentProductList);
          final ProductListingResponse product =
              updatedProductList[productIndex];

          // Update the product's favorite status
          updatedProductList[productIndex] = product.copyWith(
            isFavorite: isFavorite,
          );

          // Create updated you may also like list
          final List<DealsResponseModel> updatedList =
              List<DealsResponseModel>.from(currentList);
          updatedList[0] = DealsResponseModel(
            id: firstDeal.id,
            type: firstDeal.type,
            label: firstDeal.label,
            redirectUrl: firstDeal.redirectUrl,
            productListModel: updatedProductList,
          );

          // Emit the updated state
          emit(
            state.copyWith(
              status: status,
              msg: message,
              youMayAlsoLikeDealsModel: updatedList,
            ),
          );
        }
      }
    }
  }

  /// Simple sync with global cart
  void _syncWithGlobalCart() {
    DebugLog.instance.d('🔄 CART: Syncing with global cart');

    try {
      final GlobalWishlistManager globalWishlistManager =
          getIt<GlobalWishlistManager>();
      final Map<String, int> globalCart = globalWishlistManager.state.cartMap;

      DebugLog.instance.d('🔄 CART: Global cart: $globalCart');

      // Check if cart quantities actually changed
      final bool cartQuantitiesChanged = !_areCartMapsEqual(_lastKnownCartState, globalCart);

      // Update last known cart state
      _lastKnownCartState = Map<String, int>.from(globalCart);

      List<DealsResponseModel>? updatedDeals;
      List<DealsResponseModel>? updatedYouMayAlsoLike;

      // Update deals section
      if (state.dealsModel?.isNotEmpty ?? false) {
        updatedDeals =
            _updateDealsWithGlobalCart(state.dealsModel!, globalCart);
      }

      // Update "You may also like" section
      if (state.youMayAlsoLikeDealsModel?.isNotEmpty ?? false) {
        updatedYouMayAlsoLike = _updateDealsWithGlobalCart(
            state.youMayAlsoLikeDealsModel!, globalCart);
      }

      // Emit updates for deals sections
      if (updatedDeals != null || updatedYouMayAlsoLike != null) {
        emit(state.copyWith(
          dealsModel: updatedDeals,
          youMayAlsoLikeDealsModel: updatedYouMayAlsoLike,
        ));
        DebugLog.instance.d('🔄 CART: Successfully synced deals with global cart');
      }

      // Only refresh cart listing if cart quantities actually changed
      // This prevents unnecessary API calls when only wishlist status changes
      if (cartQuantitiesChanged) {
        unawaited(_callCartListingApi());
        DebugLog.instance.d('🔄 CART: Cart quantities changed, triggered cart listing API refresh for totals and payment data');
      } else {
        DebugLog.instance.d('🔄 CART: Cart quantities unchanged, skipping cart listing API refresh');
      }

    } on Exception catch (e) {
      DebugLog.instance.e('🔄 CART: Error syncing with global cart: $e');
    }
  }

  /// Simple sync with global wishlist
  void _syncWithGlobalWishlist() {
    DebugLog.instance.d('🔄 CART: Syncing with global wishlist');

    try {
      final GlobalWishlistManager globalWishlistManager =
          getIt<GlobalWishlistManager>();
      final Map<String, bool> globalWishlist =
          globalWishlistManager.state.wishlistMap;

      DebugLog.instance.d('🔄 CART: Global wishlist: $globalWishlist');

      List<DealsResponseModel>? updatedDeals;
      List<DealsResponseModel>? updatedYouMayAlsoLike;
      List<ProductVariantDukkan>? updatedFlattenedVariants;

      // Update cart items
      if (state.flattenedVariants?.isNotEmpty ?? false) {
        updatedFlattenedVariants = _updateCartVariantsWithGlobalWishlist(
            state.flattenedVariants!, globalWishlist);
      }

      // Update deals section
      if (state.dealsModel?.isNotEmpty ?? false) {
        updatedDeals =
            _updateDealsWithGlobalWishlist(state.dealsModel!, globalWishlist);
      }

      // Update "You may also like" section
      if (state.youMayAlsoLikeDealsModel?.isNotEmpty ?? false) {
        updatedYouMayAlsoLike = _updateDealsWithGlobalWishlist(
            state.youMayAlsoLikeDealsModel!, globalWishlist);
      }
      // Emit updates
      if (updatedFlattenedVariants != null ||
          updatedDeals != null ||
          updatedYouMayAlsoLike != null) {
        emit(state.copyWith(
          flattenedVariants: updatedFlattenedVariants,
          dealsModel: updatedDeals,
          youMayAlsoLikeDealsModel: updatedYouMayAlsoLike,
        ));
        DebugLog.instance.d('🔄 CART: Successfully synced with global wishlist');
      }
    } on Exception catch (e) {
      DebugLog.instance.e('🔄 CART: Error syncing with global wishlist: $e');
    }
  }

  /// Update cart variants with global wishlist
  List<ProductVariantDukkan> _updateCartVariantsWithGlobalWishlist(
    List<ProductVariantDukkan> variants,
    Map<String, bool> globalWishlist,
  ) {
    return variants.map((ProductVariantDukkan variant) {
      if (variant.sku == null || variant.sku!.isEmpty) {
        return variant;
      }

      final bool isInGlobalWishlist = globalWishlist[variant.sku] ?? false;

      if (variant.isFavorite != isInGlobalWishlist) {
        DebugLog.instance.d('🔄 CART: Update variant ${variant.sku} from ${variant.isFavorite} to $isInGlobalWishlist');
        return variant.copyWith(isFavorite: isInGlobalWishlist);
      }

      return variant;
    }).toList();
  }

  /// Update deals with global wishlist
  List<DealsResponseModel> _updateDealsWithGlobalWishlist(
    List<DealsResponseModel> deals,
    Map<String, bool> globalWishlist,
  ) {
    return deals.map((DealsResponseModel deal) {
      final List<ProductListingResponse> updatedProducts =
          deal.productListModel.map((ProductListingResponse product) {
        if (product.sku == null || product.sku!.isEmpty) {
          return product;
        }
        final bool isInGlobalWishlist = globalWishlist[product.sku] ?? false;

        if (product.isFavorite != isInGlobalWishlist) {
          DebugLog.instance.d('🔄 CART: Update product ${product.sku} from ${product.isFavorite} to $isInGlobalWishlist');
          return product.copyWith(isFavorite: isInGlobalWishlist);
        }

        return product;
      }).toList();

      return DealsResponseModel(
        id: deal.id,
        type: deal.type,
        label: deal.label,
        redirectUrl: deal.redirectUrl,
        productListModel: updatedProducts,
      );
    }).toList();
  }

  /// Update deals with global cart
  List<DealsResponseModel> _updateDealsWithGlobalCart(
    List<DealsResponseModel> deals,
    Map<String, int> globalCart,
  ) {
    return deals.map((DealsResponseModel deal) {
      final List<ProductListingResponse> updatedProducts =
          deal.productListModel.map((ProductListingResponse product) {
        if (product.sku == null || product.sku!.isEmpty) {
          return product;
        }

        // Update product variants with global cart quantities (each variant has its own key)
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
                  '🔄 CART: Update variant ${variant.name} cart quantity from $currentCartQuantity to $globalCartQuantity');
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

      return DealsResponseModel(
        id: deal.id,
        type: deal.type,
        label: deal.label,
        redirectUrl: deal.redirectUrl,
        productListModel: updatedProducts,
      );
    }).toList();
  }

  /// Force sync wishlist and cart state - used when navigating back to cart
  void forceSyncWishlistOnResume() {
    DebugLog.instance.d('🔄 CART: Force syncing wishlist and cart on resume');
    _syncWithGlobalWishlist();
    _syncWithGlobalCart();
  }


  @override
  Future<void> close() async {
    await _globalWishlistSubscription?.cancel();
    await super.close();
  }
}
