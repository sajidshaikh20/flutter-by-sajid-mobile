import '../../../utils/exports.dart';

/// Common mixin for handling cart operations across different cubits
/// This mixin provides reusable cart operation logic for both main products and variants
mixin CartOperationMixin<T extends BaseState> on BaseCubit<T> {
  /// Helper method to get the correct cart quantity based on variant index
  int _getCurrentCartQuantity(
      ProductListingResponse product, int? variantIndex) {
    if (variantIndex != null &&
        product.productVariant != null &&
        variantIndex < product.productVariant!.length) {
      // Use specific variant cart quantity
      final int quantity =
          product.productVariant![variantIndex].cartQuantity ?? 0;
      DebugLog.instance.e(
          'Using specific variant cart quantity: $quantity for variant index: $variantIndex');
      return quantity;
    } else if (product.productVariant != null &&
        product.productVariant!.isNotEmpty) {
      // Use first variant cart quantity when variantIndex is null
      final int quantity = product.productVariant![0].cartQuantity ?? 0;
      DebugLog.instance.e(
          'Using first variant cart quantity: $quantity (variantIndex is null)');
      return quantity;
    } else {
      // Use main product cart quantity as fallback
      final int quantity = product.cartQuantity ?? 0;
      DebugLog.instance.e(
          'Using main product cart quantity: $quantity (no variants available)');
      return quantity;
    }
  }

  /// Handle cart operations for products
  /// This method handles add, increase, decrease, and remove cart operations
  /// Can be called for main product or specific variant
  Future<void> handleCartOperation({
    required int productIndex,
    required List<ProductListingResponse> products,
    required CartOperation operation,
    int? variantIndex, // Optional: specify which variant to use
    required Function(
            int productIndex,
            int cartQuantity,
            BaseStateStatus status,
            String message,
            int? variantIndex,
            int? apiCartCount)
        updateProductCartQuantity,
    required Future<ResponseHandler<BaseResponse<CartOperationResponseModel>>> Function(
            {required String qty,
            required String entityId,
            required String sku})
        updateToCartApi,
    required Future<ResponseHandler<BaseResponse<CartOperationResponseModel>>> Function(
            {required String qty,
            required String entityId,
            required String sku})
        addToCartApi,
    required Future<ResponseHandler<BaseResponse<CartOperationResponseModel>>>
            Function({required String sku})
        removeFromCartApi,
  }) async {
    try {
      if (productIndex < 0 || productIndex >= products.length) {
        DebugLog.instance.e('Invalid product index: $productIndex');
        return;
      }

      final ProductListingResponse product = products[productIndex];
      if (product.sku == null || product.sku!.isEmpty) {
        DebugLog.instance.e('Product SKU is null or empty');
        return;
      }

      // Determine which entityId to use based on variantIndex
      String? entityId;
      String? sku;

      if (variantIndex != null &&
          product.productVariant != null &&
          variantIndex < product.productVariant!.length) {
        // Use specific variant data
        final ProductVariantDukkan variant =
            product.productVariant![variantIndex];
        entityId = variant.entityId?.toString();
        sku = product.sku; // Use main product SKU for variants

        if (entityId == null || entityId.isEmpty) {
          DebugLog.instance.e(
              'Variant entityId is null or empty for variant index: $variantIndex');
          return;
        }
        DebugLog.instance.e(
            'Using specific variant entityId: $entityId for variant index: $variantIndex');
      } else if (product.productVariant != null &&
          product.productVariant!.isNotEmpty) {
        // Use first variant data when variantIndex is null
        final ProductVariantDukkan firstVariant = product.productVariant![0];
        entityId = firstVariant.entityId?.toString();
        sku = product.sku; // Use main product SKU for variants

        if (entityId == null || entityId.isEmpty) {
          DebugLog.instance.e('First variant entityId is null or empty');
          return;
        }
        DebugLog.instance.e(
            'Using first variant entityId: $entityId (variantIndex is null)');
      } else {
        // Use main product data as fallback when no variants exist
        entityId = product.entityId?.toString();
        sku = product.sku;
        DebugLog.instance.e(
            'Using main product entityId: $entityId (no variants available)');
      }

      // Get current cart quantity using helper method
      final int currentQuantity =
          _getCurrentCartQuantity(product, variantIndex);
      DebugLog.instance.e(
          'Current cart quantity: $currentQuantity (variantIndex: $variantIndex)');

      // Determine the effective variant index for API calls
      int? effectiveVariantIndex;
      if (variantIndex != null) {
        effectiveVariantIndex = variantIndex;
        DebugLog.instance
            .e('Using provided variantIndex: $effectiveVariantIndex');
      } else if (product.productVariant != null &&
          product.productVariant!.isNotEmpty) {
        effectiveVariantIndex =
            0; // Use first variant when variantIndex is null
        DebugLog.instance.e(
            'Using first variant as effectiveVariantIndex: $effectiveVariantIndex (variantIndex was null)');
      } else {
        DebugLog.instance
            .e('No variants available, effectiveVariantIndex remains null');
      }

      // Validate quantity for add and increase operations
      if (operation == CartOperation.add ||
          operation == CartOperation.increase) {
        // Check if we're dealing with a variant (either specific or first variant)
        ProductVariantDukkan? variantToValidate;
        int? variantIndexForValidation;

        if (variantIndex != null &&
            product.productVariant != null &&
            variantIndex < product.productVariant!.length) {
          // Use specific variant
          variantToValidate = product.productVariant![variantIndex];
          variantIndexForValidation = variantIndex;
        } else if (product.productVariant != null &&
            product.productVariant!.isNotEmpty) {
          // Use first variant when variantIndex is null
          variantToValidate = product.productVariant![0];
          variantIndexForValidation = 0;
        }

        if (variantToValidate != null) {
          final int quantityToAdd = 1; // We're always adding 1 item at a time

          if (quantityToAdd > 0) {
            final QuantityValidationResult validation =
                variantToValidate.validateQuantity(quantityToAdd);

            if (!validation.isValid) {
              // Show error message and return early
              updateProductCartQuantity(
                productIndex,
                currentQuantity,
                BaseStateStatus.failure,
                validation.message,
                variantIndexForValidation,
                null,
              );
              return;
            }

            // If validation passes but we can add fewer items than requested
            if (validation.maxAllowedQuantity <
                currentQuantity + quantityToAdd) {
              final int maxAllowedTotal = validation.maxAllowedQuantity;
              updateProductCartQuantity(
                productIndex,
                currentQuantity,
                BaseStateStatus.failure,
                "Only $maxAllowedTotal items can be added. Available: ${variantToValidate.availableQty?.toInt() ?? 0}, Allowed: ${(variantToValidate.allowedQty ?? 0).toInt()}",
                variantIndexForValidation,
                null,
              );
              return;
            }
          }
        }
      }

      // Simple math operations based on variant cart quantity
      switch (operation) {
        case CartOperation.add:
          if (currentQuantity == 0) {
            // If quantity is 0, call add API with quantity 1
            await _addToCart(
              product,
              productIndex,
              1,
              entityId!,
              sku!,
              variantIndex: effectiveVariantIndex,
              updateProductCartQuantity: updateProductCartQuantity,
              addToCartApi: addToCartApi,
            );
          } else {
            // If quantity > 0, increment by 1 using update API
            await _updateCartQuantity(
              product,
              productIndex,
              currentQuantity + 1,
              entityId!,
              sku!,
              variantIndex: effectiveVariantIndex,
              updateProductCartQuantity: updateProductCartQuantity,
              updateToCartApi: updateToCartApi,
              removeFromCartApi: removeFromCartApi,
            );
          }

        case CartOperation.increase:
          if (currentQuantity == 0) {
            // If quantity is 0, call add API with quantity 1
            await _addToCart(
              product,
              productIndex,
              1,
              entityId!,
              sku!,
              variantIndex: effectiveVariantIndex,
              updateProductCartQuantity: updateProductCartQuantity,
              addToCartApi: addToCartApi,
            );
          } else {
            // Increment by 1 using update API
            await _updateCartQuantity(
              product,
              productIndex,
              currentQuantity + 1,
              entityId!,
              sku!,
              variantIndex: effectiveVariantIndex,
              updateProductCartQuantity: updateProductCartQuantity,
              updateToCartApi: updateToCartApi,
              removeFromCartApi: removeFromCartApi,
            );
          }

        case CartOperation.decrease:
          if (currentQuantity > 0) {
            final int newQuantity = currentQuantity - 1;
            if (newQuantity == 0) {
              // If new quantity is 0, remove from cart
              await _removeFromCart(
                product,
                productIndex,
                entityId!,
                sku!,
                variantIndex: effectiveVariantIndex,
                updateProductCartQuantity: updateProductCartQuantity,
                removeFromCartApi: removeFromCartApi,
              );
            } else {
              // Decrement by 1 using update API
              await _updateCartQuantity(
                product,
                productIndex,
                newQuantity,
                entityId!,
                sku!,
                variantIndex: effectiveVariantIndex,
                updateProductCartQuantity: updateProductCartQuantity,
                updateToCartApi: updateToCartApi,
                removeFromCartApi: removeFromCartApi,
              );
            }
          }

        case CartOperation.remove:
          if (currentQuantity > 0) {
            // Remove from cart
            await _removeFromCart(
              product,
              productIndex,
              entityId!,
              sku!,
              variantIndex: effectiveVariantIndex,
              updateProductCartQuantity: updateProductCartQuantity,
              removeFromCartApi: removeFromCartApi,
            );
          }
      }
    } on Exception catch (e) {
      DebugLog.instance.e('Error in handleCartOperation: $e');
      // Let the calling code handle error state updates
      // The mixin should not assume specific state implementations
    }
  }

  /// Add product to cart
  Future<void> _addToCart(
    ProductListingResponse product,
    int productIndex,
    int quantity,
    String entityId,
    String sku, {
    int? variantIndex,
    required Function(
            int productIndex,
            int cartQuantity,
            BaseStateStatus status,
            String message,
            int? variantIndex,
            int? apiCartCount)
        updateProductCartQuantity,
    required Future<ResponseHandler<BaseResponse<CartOperationResponseModel>>> Function(
            {required String qty,
            required String entityId,
            required String sku})
        addToCartApi,
  }) async {
    try {
      final ResponseHandler<BaseResponse<CartOperationResponseModel>> response =
          await addToCartApi(
        qty: quantity.toString(),
        entityId: entityId,
        sku: sku,
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

          // Calculate cart count change

          // Update the product's cart quantity in the state
          updateProductCartQuantity(
            productIndex,
            quantity,
            BaseStateStatus.success,
            responseData?.message ?? 'Product added to cart successfully',
            variantIndex,
            responseData?.data?.cartCount,
          );

          // Update global cart manager
          final String cartKey = '${sku}_$entityId';
          getIt<GlobalWishlistManager>().updateCartQuantity(cartKey, quantity);

          // Update cart count based on quantity change
        } else {
          final int currentQuantity =
              _getCurrentCartQuantity(product, variantIndex);
          updateProductCartQuantity(
            productIndex,
            currentQuantity,
            BaseStateStatus.failure,
            responseData?.message ?? 'Failed to add product to cart',
            variantIndex,
            null,
          );
        }
      } else if (response.isFailure()) {
        final int currentQuantity =
            _getCurrentCartQuantity(product, variantIndex);
        updateProductCartQuantity(
          productIndex,
          currentQuantity,
          BaseStateStatus.failure,
          response.getFailureInstance()?.error?.errorMessage ??
              'Failed to add product to cart',
          variantIndex,
          null,
        );
      }
    } on Exception catch (e) {
      DebugLog.instance.e('Error in _addToCart: $e');
      final int currentQuantity =
          _getCurrentCartQuantity(product, variantIndex);
      updateProductCartQuantity(
        productIndex,
        currentQuantity,
        BaseStateStatus.failure,
        'An error occurred while adding to cart',
        variantIndex,
        null,
      );
    }
  }

  /// Update cart quantity
  Future<void> _updateCartQuantity(
    ProductListingResponse product,
    int productIndex,
    int quantity,
    String entityId,
    String sku, {
    int? variantIndex,
    required Function(
            int productIndex,
            int cartQuantity,
            BaseStateStatus status,
            String message,
            int? variantIndex,
            int? apiCartCount)
        updateProductCartQuantity,
    required Future<ResponseHandler<BaseResponse<CartOperationResponseModel>>> Function(
            {required String qty,
            required String entityId,
            required String sku})
        updateToCartApi,
    required Future<ResponseHandler<BaseResponse<CartOperationResponseModel>>>
            Function({required String sku})
        removeFromCartApi,
  }) async {
    try {
      if (quantity <= 0) {
        // Remove from cart if quantity is 0 or less
        await _removeFromCart(
          product,
          productIndex,
          entityId,
          sku,
          variantIndex: variantIndex,
          updateProductCartQuantity: updateProductCartQuantity,
          removeFromCartApi: removeFromCartApi,
        );
        return;
      }

      // For now, we'll use the same API as add to cart since update cart API structure is similar
      final ResponseHandler<BaseResponse<CartOperationResponseModel>> response =
          await updateToCartApi(
        qty: quantity.toString(),
        entityId: entityId,
        sku: sku,
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

          // Update the product's cart quantity in the state
          updateProductCartQuantity(
            productIndex,
            quantity,
            BaseStateStatus.success,
            responseData?.message ?? 'Cart updated successfully',
            variantIndex,
            responseData?.data?.cartCount,
          );

          // Update global cart manager
          final String cartKey = '${sku}_$entityId';
          getIt<GlobalWishlistManager>().updateCartQuantity(cartKey, quantity);

          // Update cart count based on quantity change
        } else {
          final int currentQuantity =
              _getCurrentCartQuantity(product, variantIndex);
          updateProductCartQuantity(
            productIndex,
            currentQuantity,
            BaseStateStatus.failure,
            responseData?.message ?? 'Failed to update cart',
            variantIndex,
            null,
          );
        }
      } else if (response.isFailure()) {
        final int currentQuantity =
            _getCurrentCartQuantity(product, variantIndex);
        updateProductCartQuantity(
          productIndex,
          currentQuantity,
          BaseStateStatus.failure,
          response.getFailureInstance()?.error?.errorMessage ??
              'Failed to update cart',
          variantIndex,
          null,
        );
      }
    } on Exception catch (e) {
      DebugLog.instance.e('Error in _updateCartQuantity: $e');
      final int currentQuantity =
          _getCurrentCartQuantity(product, variantIndex);
      updateProductCartQuantity(
        productIndex,
        currentQuantity,
        BaseStateStatus.failure,
        'An error occurred while updating cart',
        variantIndex,
        null,
      );
    }
  }

  /// Remove product from cart
  Future<void> _removeFromCart(
    ProductListingResponse product,
    int productIndex,
    String entityId,
    String sku, {
    int? variantIndex,
    required Function(
            int productIndex,
            int cartQuantity,
            BaseStateStatus status,
            String message,
            int? variantIndex,
            int? apiCartCount)
        updateProductCartQuantity,
    required Future<ResponseHandler<BaseResponse<CartOperationResponseModel>>>
            Function({required String sku})
        removeFromCartApi,
  }) async {
    try {
      final ResponseHandler<BaseResponse<CartOperationResponseModel>> response =
          await removeFromCartApi(
        sku: sku,
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
// Always negative

          // Update the product's cart quantity in the state
          updateProductCartQuantity(
            productIndex,
            0,
            BaseStateStatus.success,
            responseData?.message ?? 'Product removed from cart successfully',
            variantIndex,
            responseData?.data?.cartCount,
          );

          // Update global cart manager
          final String cartKey = '${sku}_$entityId';
          getIt<GlobalWishlistManager>().removeFromCart(cartKey);

          // Update cart count based on quantity change
        } else {
          final int currentQuantity =
              _getCurrentCartQuantity(product, variantIndex);
          updateProductCartQuantity(
            productIndex,
            currentQuantity,
            BaseStateStatus.failure,
            responseData?.message ?? 'Failed to remove product from cart',
            variantIndex,
            null,
          );
        }
      } else if (response.isFailure()) {
        final int currentQuantity =
            _getCurrentCartQuantity(product, variantIndex);
        updateProductCartQuantity(
          productIndex,
          currentQuantity,
          BaseStateStatus.failure,
          response.getFailureInstance()?.error?.errorMessage ?? 'Failed to remove product from cart',
          variantIndex,
          null,
        );
      }
    } on Exception catch (e) {
      DebugLog.instance.e('Error in _removeFromCart: $e');
      final int currentQuantity = _getCurrentCartQuantity(product, variantIndex);
      updateProductCartQuantity(
        productIndex,
        currentQuantity,
        BaseStateStatus.failure,
        'An error occurred while removing from cart',
        variantIndex,
        null,
      );
    }
  }
}
