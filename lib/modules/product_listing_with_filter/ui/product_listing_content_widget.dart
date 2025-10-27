import '../../../utils/exports.dart';

/// Widget that displays the main content of product listing with grid layout.
class ProductListingContentWidget extends StatelessWidget {
  /// Creates a product listing content widget.
  const ProductListingContentWidget({
    super.key,
    required this.itemWidth,
    required this.itemHeight,
    required this.crossAxisSpacing,
    required this.paddingForView,
  });

  /// The width of each product item in the grid.
  final double itemWidth;

  /// The height of each product item in the grid.
  final double itemHeight;

  /// The spacing between items in the cross axis.
  final double crossAxisSpacing;

  /// The padding around the entire view.
  final double paddingForView;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductListingWithFilterCubit, ProductListingWithFilterState>(
      builder: (BuildContext context, ProductListingWithFilterState state) {
        // Show empty state if API returns success with empty data - check this FIRST
        if (state.status == BaseStateStatus.success &&
            (state.productList == null || state.productList!.isEmpty)) {
          return CustomNoDataWidget(
            key: ValueKey<String>('empty_products_${state.hashCode}'),
            asset: Assets.svgs.noProductFound.svg(),
            message: 'No products found',
            // Using hardcoded text as requested by user
            buttonText: context.appString.tryAgainKey,
            onButtonPressed: () async {
              // Clear filters and refresh to show all products
              final ProductListingWithFilterCubit cubit = context.read<ProductListingWithFilterCubit>()
              ..clearSelectedFilters();
              await cubit.refreshProducts();
            },
          );
        }

        // Show shimmer for initial load and sorting (not for pagination)
        if (state.status == BaseStateStatus.loading && !state.isLoadingMore) {
          return const ShimmerWishListView();
        }

        // Show products with pagination loader when we have products (success state or loading more)
        if (state.productList != null && state.productList!.isNotEmpty) {
          return SingleChildScrollView(
            controller: state.scrollController, // Attach scroll controller for pagination
            child: Padding(
              padding: EdgeInsets.only(
                bottom: Dimens.space20,
                left: paddingForView,
                right: paddingForView,
                top: Dimens.space16,
              ),
              child: Column(
                children: <Widget>[
                  GridView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    padding: EdgeInsets.zero,
                    itemCount: state.productList?.length ?? 0,
                    // Dynamic item count from API response
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      childAspectRatio: itemWidth / itemHeight,
                      crossAxisCount: AppConstant.crossAxisCount2,
                      // Fixed number of columns
                      crossAxisSpacing: crossAxisSpacing,
                      mainAxisSpacing: crossAxisSpacing, // Vertical space between items
                    ),
                    itemBuilder: (BuildContext context, int index) {
                      final ProductListingResponse? product = state.productList?[index];
                      return ProductCommonItem.fromProductListing(
                        productListingResponse: product,
                        onVariantCartOperation: (int variantIndex, CartOperation operation) async {
                          // Handle variant cart operations
                          await context
                              .read<ProductListingWithFilterCubit>()
                              .handleProductCartOperation(
                                productIndex: index,
                                operation: operation,
                                variantIndex: variantIndex,
                              );
                        },
                        onAddPressed: () async {
                          // Check if product has variants
                          if (product?.productVariant != null &&
                              product!.productVariant!.length > 1) {
                            // Show SelectUnit for variants
                            await showCustomBottomSheetView(
                              context: context,
                              child: SelectUnit(
                                productVariants: product.productVariant,
                                onVariantCartOperation: (int variantIndex, CartOperation operation) async {
                                  // Handle variant cart operations
                                  await context
                                      .read<ProductListingWithFilterCubit>()
                                      .handleProductCartOperation(
                                        productIndex: index,
                                        operation: operation,
                                        variantIndex: variantIndex,
                                      );
                                },
                                onAddPressed: (int variantIndex) async {
                                  // Handle add to cart for specific variant
                                  await context
                                      .read<ProductListingWithFilterCubit>()
                                      .handleProductCartOperation(
                                        productIndex: index,
                                        operation: CartOperation.add,
                                        variantIndex: variantIndex,
                                      );
                                },
                                onPlusPressed: (int variantIndex) async {
                                  // Handle increase quantity for specific variant
                                  await context
                                      .read<ProductListingWithFilterCubit>()
                                      .handleProductCartOperation(
                                        productIndex: index,
                                        operation: CartOperation.increase,
                                        variantIndex: variantIndex,
                                      );
                                },
                                onMinusPressed: (int variantIndex) async {
                                  // Handle decrease quantity for specific variant
                                  await context
                                      .read<ProductListingWithFilterCubit>()
                                      .handleProductCartOperation(
                                        productIndex: index,
                                        operation: CartOperation.decrease,
                                        variantIndex: variantIndex,
                                      );
                                },
                              ),
                              title: product.name ?? "",
                              isCloseIconVisible: true,
                              titleStyle: context.textTheme.displayMedium?.copyWith(
                                color: MainConfig.appColors.textBlackColor,
                                fontSize: Dimens.fontSize18,
                                fontWeight: FontWeight.w700,
                                height: Dimens.lineHeight22.toLineHeight(Dimens.fontSize18),
                              ),
                            );
                          } else {
                            // Handle main product cart operation
                            await context
                                .read<ProductListingWithFilterCubit>()
                                .handleProductCartOperation(
                                  productIndex: index,
                                  operation: CartOperation.add,
                                );
                          }
                        },
                        onPlusPressed: () async {
                          await context
                              .read<ProductListingWithFilterCubit>()
                              .handleProductCartOperation(
                                productIndex: index,
                                operation: CartOperation.increase,
                              );
                        },
                        onMinusPressed: () async {
                          await context
                              .read<ProductListingWithFilterCubit>()
                              .handleProductCartOperation(
                                productIndex: index,
                                operation: CartOperation.decrease,
                              );
                        },
                        likeDislikeItemPressed: () async {
                          if (product?.sku != null) {
                            await context
                                .read<ProductListingWithFilterCubit>()
                                .handleWishlistLikeDislike(
                                  sku: product!.sku!,
                                  productIndex: index,
                                  isCurrentlyFavorite: product.isFavorite ?? false,
                                );
                          }
                        },
                        heightOfItem: itemHeight,
                        widthOfItem: itemWidth,
                      );
                    },
                  ),
                  // Show pagination loader when loading more products
                  BlocBuilder<ProductListingWithFilterCubit, ProductListingWithFilterState>(
                    builder: (BuildContext context, ProductListingWithFilterState state) {
                      return Visibility(
                        visible: state.isLoadingMore,
                        child: const CustomPaginationLoaderWidget(),
                      );
                    },
                  ),
                ],
              ),
            ),
          );
        }

        // Default fallback - show shimmer for any other states (like loading with no products)
        return const ShimmerWishListView(isRemovePadding: true);
      },
    );
  }
}
