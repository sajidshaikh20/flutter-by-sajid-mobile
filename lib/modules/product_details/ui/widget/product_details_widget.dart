import '../../../../utils/exports.dart';
import '../../../../utils/refresh_helper.dart';

/// Main widget that displays complete product details with all sections.
class ProductDetailsWidget extends BaseResponsiveView {
  /// The entity ID of the product to display.
  final int entityId;

  /// The index of the product in a list (optional).
  final int? index;

  /// Creates a product details widget.
  const ProductDetailsWidget(
      {super.key, required this.entityId, this.index = -1});

  Widget _editProductDetailsPage(ScreenType device) {
    return BlocConsumer<ProductDetailsCubit, ProductDetailsState>(
      listener: (BuildContext context, ProductDetailsState state) {
        // Listen for wishlist status changes
        if (state.statusForAddToWishList == BaseStateStatus.success &&
            state.msg != null &&
            state.msg!.isNotEmpty) {
          displaySnackBar(state.msg!, context);
          // Clear status after showing message
          if (context.mounted) {
            context.read<ProductDetailsCubit>().clearWishlistStatus();
          }
        }
        // Listen for wishlist failure status changes
        if (state.statusForAddToWishList == BaseStateStatus.failure &&
            state.msg != null &&
            state.msg!.isNotEmpty) {
          displaySnackBar(state.msg!, context);
          // Clear status after showing message
          if (context.mounted) {
            context.read<ProductDetailsCubit>().clearWishlistStatus();
          }
        }
        // Listen for cart operation status changes
        if (state.statusForCartOperations == BaseStateStatus.success &&
            state.msg != null &&
            state.msg!.isNotEmpty) {
          displaySnackBar(state.msg!, context);
          // Clear status after showing message
          if (context.mounted) {
            context.read<ProductDetailsCubit>().clearCartOperationStatus();
          }
        }
        // Listen for cart operation failure status changes
        if (state.statusForCartOperations == BaseStateStatus.failure &&
            state.msg != null &&
            state.msg!.isNotEmpty) {
          displaySnackBar(state.msg!, context);
          // Clear status after showing message
          if (context.mounted) {
            context.read<ProductDetailsCubit>().clearCartOperationStatus();
          }
        }
      },
      builder: (BuildContext context, ProductDetailsState state) {
        double horizontalPadding = Dimens.space16;

        switch (device) {
          case ScreenType.tablet:
            horizontalPadding = Dimens.space24;

          default:
            break;
        }
        return PopScope(
            canPop: false,
            onPopInvokedWithResult: (bool didPop, Object? result) async {
              if (didPop) {
                return;
              }
              backNavigationWithResult(context, state);
            },
            child: NoInternetWidget(
              childWidget: Scaffold(
                resizeToAvoidBottomInset: false,
                body: Column(
                  children: <Widget>[
                    ProductDetailsAppBar(
                      titleText: state.detailsModel?.name ?? "",
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.only(
                                left: horizontalPadding,
                                right: horizontalPadding,
                                top: horizontalPadding,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  state.statusForProductDetails ==
                                          BaseStateStatus.success
                                      ? ProductHeaderWidget(
                                          state: state,
                                          device: device,
                                        )
                                      : const ProductDetailsCarouselShimmer(
                                          height: Dimens.size375,
                                        ),
                                  Dimens.size16.heightBox,
                                  BlocBuilder<ProductDetailsCubit,
                                      ProductDetailsState>(
                                    buildWhen: (ProductDetailsState previous,
                                            ProductDetailsState current) =>
                                        previous.isWishlistSelected !=
                                            current.isWishlistSelected ||
                                        previous.detailsModel?.isFavorite !=
                                            current.detailsModel?.isFavorite,
                                    builder: (BuildContext context,
                                        ProductDetailsState state) {
                                      return state.statusForProductDetails ==
                                              BaseStateStatus.success
                                          ? ProductDetailsNameWidget(
                                              isWishlistSelected: state
                                                      .detailsModel
                                                      ?.isFavorite ??
                                                  false,
                                              productName:
                                                  state.detailsModel?.name,
                                              isLoading: state
                                                      .statusForAddToWishList ==
                                                  BaseStateStatus.loading,
                                              onWishlistTap: () async {
                                                await context
                                                    .read<ProductDetailsCubit>()
                                                    .handleWishlistLikeDislike();
                                              },
                                            )
                                          : const ProductDetailsNameShimmerWidget();
                                    },
                                  ),

                                  // Show unit selection or display based on available units
                                  BlocBuilder<ProductDetailsCubit,
                                      ProductDetailsState>(
                                    buildWhen: (ProductDetailsState previous,
                                            ProductDetailsState current) =>
                                        previous.availableUnits !=
                                        current.availableUnits,
                                    builder: (BuildContext context,
                                        ProductDetailsState state) {
                                      if (state.statusForProductDetails ==
                                          BaseStateStatus.success) {
                                        if (state.availableUnits.length > 1) {
                                          // Multiple units - show selection
                                          return const ProductSelectUnitList();
                                        } else if (state
                                                .availableUnits.length ==
                                            1) {
                                          // Single unit - show display
                                          return Padding(
                                            padding: const EdgeInsets.only(
                                                top: Dimens.space10),
                                            child: ProductUnitDisplayWidget(
                                              unit: state.availableUnits.first,
                                            ),
                                          );
                                        } else {
                                          return const SizedBox.shrink();
                                        }
                                      } else {
                                        return const ProductSelectUnitListShimmer();
                                      }
                                    },
                                  ),

                                  if (state.statusForProductDetails ==
                                      BaseStateStatus.loading) ...<Widget>[
                                    Dimens.size12.heightBox,
                                    const DetailsExpandableCardShimmerWidget()
                                  ],
                                  if (state.statusForProductDetails ==
                                          BaseStateStatus.success &&
                                      (state.detailsModel?.description
                                              ?.isNotEmpty ??
                                          false)) ...<Widget>[
                                    Dimens.size16.heightBox,
                                    DetailsExpandableCardWidget(
                                      title: context.appString.descriptionKey,
                                      isExpanded: true,
                                      content: state
                                              .detailsModel?.description ??
                                          context.appString.dummyDescriptionKey,
                                    ),
                                    Dimens.size12.heightBox,
                                  ],
                                  // Show nutrition section only when it has content
                                  if (state.statusForProductDetails ==
                                          BaseStateStatus.success &&
                                      (state.detailsModel?.nutritions
                                              ?.isNotEmpty ??
                                          false))
                                    DetailsExpandableCardWidget(
                                      title: context.appString.nutritionsKey,
                                      content:
                                          state.detailsModel?.nutritions ?? "",
                                    ),
                                  if (state.statusForProductDetails ==
                                          BaseStateStatus.success &&
                                      (state.detailsModel?.nutritions
                                              ?.isNotEmpty ??
                                          false))
                                    Dimens.size12.heightBox,
                                  // Show key features section only when it has content
                                  if (state.statusForProductDetails ==
                                          BaseStateStatus.success &&
                                      (state.detailsModel?.keyFeatures
                                              ?.isNotEmpty ??
                                          false))
                                    DetailsExpandableCardWidget(
                                      title: context.appString.keyFeaturesKey,
                                      content:
                                          state.detailsModel?.keyFeatures ?? "",
                                    ),
                                ],
                              ),
                            ),
                            // Show related products header only if there's data
                            if (state.relatedProducts.isNotEmpty) ...<Widget>[
                              Dimens.size24.heightBox,
                              HeaderWidget(
                                device: device,
                                mainHeader:
                                    context.appString.relatedProductsKey,
                                viewAll: context.appString.viewAllKey,
                                viewAllOnclick: () async {
                                  await context.router.push(
                                    ProductListingWithFilterRoute(
                                      typeId: 0,
                                      type: 'related',
                                      label:
                                          context.appString.relatedProductsKey,
                                      productSku: state.detailsModel?.sku,
                                    ),
                                  );
                                },
                                isPaddingNeed: true,
                              ),
                            ],
                            // Show related products content with shimmer management
                            if (state.relatedProducts.isNotEmpty) ...<Widget>[
                              Dimens.size16.heightBox,
                              state.statusForRelatedProducts !=
                                      BaseStateStatus.success
                                  ? const HotDealsShimmer()
                                  : HotDealsWidget(
                                      likeDislikeItemPressed:
                                          (int index) async {
                                        if (index <
                                                state.relatedProducts.length &&
                                            state.relatedProducts[index].sku !=
                                                null) {
                                          final ProductListingResponse product =
                                              state.relatedProducts[index];
                                          await context
                                              .read<ProductDetailsCubit>()
                                              .handleRelatedProductWishlistLikeDislike(
                                                sku: product.sku!,
                                                productIndex: index,
                                                isCurrentlyFavorite:
                                                    product.isFavorite ?? false,
                                              );
                                        }
                                      },
                                      products: state.relatedProducts,
                                      onVariantCartOperation: (int productIndex,
                                          int variantIndex,
                                          CartOperation operation) async {
                                        await context
                                            .read<ProductDetailsCubit>()
                                            .handleRelatedProductCartOperation(
                                              productIndex: productIndex,
                                              operation: operation,
                                              variantIndex: variantIndex,
                                            );
                                      },
                                      onAddPressed: (int index) async {
                                        await context
                                            .read<ProductDetailsCubit>()
                                            .handleRelatedProductCartOperation(
                                              productIndex: index,
                                              operation: CartOperation.add,
                                            );
                                      },
                                      onPlusPressed: (int index) async {
                                        await context
                                            .read<ProductDetailsCubit>()
                                            .handleRelatedProductCartOperation(
                                              productIndex: index,
                                              operation: CartOperation.increase,
                                            );
                                      },
                                      onMinusPressed: (int index) async {
                                        await context
                                            .read<ProductDetailsCubit>()
                                            .handleRelatedProductCartOperation(
                                              productIndex: index,
                                              operation: CartOperation.decrease,
                                            );
                                      },
                                    ),
                            ],
                            // Show trending products header only if there's data
                            if (state.trendingProducts.isNotEmpty) ...<Widget>[
                              Dimens.size24.heightBox,
                              HeaderWidget(
                                device: device,
                                mainHeader:
                                    context.appString.trendingProductsKey,
                                viewAll: context.appString.viewAllKey,
                                viewAllOnclick: () async {
                                  await context.router
                                      .push(ProductListingWithFilterRoute(
                                    typeId: 0,
                                    type: 'trending',
                                    label:
                                        context.appString.trendingProductsKey,
                                  ));
                                },
                                isPaddingNeed: true,
                              ),
                            ],
                            // Show trending products content with shimmer management
                            if (state.trendingProducts.isNotEmpty) ...<Widget>[
                              Dimens.size16.heightBox,
                              state.statusForTrendingProducts !=
                                      BaseStateStatus.success
                                  ? const HotDealsShimmer()
                                  : HotDealsWidget(
                                      onVariantCartOperation: (int productIndex,
                                          int variantIndex,
                                          CartOperation operation) async {
                                        await context
                                            .read<ProductDetailsCubit>()
                                            .handleTrendingProductCartOperation(
                                              productIndex: productIndex,
                                              operation: operation,
                                              variantIndex: variantIndex,
                                            );
                                      },
                                      onAddPressed: (int index) async {
                                        await context
                                            .read<ProductDetailsCubit>()
                                            .handleTrendingProductCartOperation(
                                              productIndex: index,
                                              operation: CartOperation.add,
                                            );
                                      },
                                      onPlusPressed: (int index) async {
                                        await context
                                            .read<ProductDetailsCubit>()
                                            .handleTrendingProductCartOperation(
                                              productIndex: index,
                                              operation: CartOperation.increase,
                                            );
                                      },
                                      onMinusPressed: (int index) async {
                                        await context
                                            .read<ProductDetailsCubit>()
                                            .handleTrendingProductCartOperation(
                                              productIndex: index,
                                              operation: CartOperation.decrease,
                                            );
                                      },
                                      products: state.trendingProducts,
                                      likeDislikeItemPressed:
                                          (int index) async {
                                        if (index <
                                                state.trendingProducts.length &&
                                            state.trendingProducts[index].sku !=
                                                null) {
                                          final ProductListingResponse product =
                                              state.trendingProducts[index];
                                          await context
                                              .read<ProductDetailsCubit>()
                                              .handleTrendingProductWishlistLikeDislike(
                                                sku: product.sku!,
                                                productIndex: index,
                                                isCurrentlyFavorite:
                                                    product.isFavorite ?? false,
                                              );
                                        }
                                      },
                                    ),
                            ],

                            Dimens.size25.heightBox,
                            state.statusForReview == BaseStateStatus.success
                                ? Visibility(
                                    visible:
                                        (state.review?.reviewCount ?? 0) > 0,
                                    child: HeaderWidget(
                                      device: device,
                                      isViewAllVisible: false,
                                      mainHeader:
                                          context.appString.reviewRatingKey,
                                      viewAll: context.appString.viewAllKey,
                                      isPaddingNeed: true,
                                    ),
                                  )
                                : const HeaderWidgetShimmer(),
                            Dimens.size16.heightBox,
                            state.statusForReview == BaseStateStatus.success
                                ? ReviewWidget(
                                    device: device,
                                    entityId: entityId,
                                    review: state.review,
                                    productDetails: state.detailsModel,
                                  )
                                : const ReviewWidgetShimmer(),
                         if((state.review?.reviewCount ?? 0) > 0)
                            Dimens.size34.heightBox,
                            Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: horizontalPadding,
                              ),
                              child: CustomListView(
                                itemCount:
                                    _getReviewItemCount(state.review?.reviews),
                                isPadding: true,
                                isSeparator: true,
                                scrollPhysics:
                                    const NeverScrollableScrollPhysics(),
                                itemBuilder: (BuildContext context, int index) {
                                  return Padding(
                                    padding: EdgeInsets.only(
                                        bottom: index == 0
                                            ? Dimens.space16
                                            : Dimens.space0,
                                        top: index == 0
                                            ? Dimens.space0
                                            : Dimens.space16),
                                    child: state.statusForReview ==
                                            BaseStateStatus.success
                                        ? ReviewRatingDetailsCard(
                                            device: device,
                                            review:
                                                state.review?.reviews?[index],
                                          )
                                        : const ReviewRatingDetailsCardShimmer(),
                                  );
                                },
                              ),
                            ),
                            state.statusForReview == BaseStateStatus.success
                                ? _buildViewAllButton(
                                    context,
                                    state,
                                    state.review?.reviews,
                                    entityId,
                                    horizontalPadding)
                                : const SizedBox.shrink(),
                          ],
                        ),
                      ),
                    ),
                    //Bottom stick view
                    BlocBuilder<ProductDetailsCubit, ProductDetailsState>(
                      builder:
                          (BuildContext context, ProductDetailsState state) {
                        // Check product availability based on variants quantity
                        bool isProductAvailable() {
                          // Check product variants availability
                          if (state.detailsModel?.productVariant != null &&
                              state.detailsModel!.productVariant!.isNotEmpty) {
                            // Check if any variant has available quantity > 0
                            return state.detailsModel!.productVariant!.any(
                                (ProductVariantDukkan variant) =>
                                    (variant.availableQty ?? 0) > 0);
                          }
                          // If no variants, check main product availability
                          return state.detailsModel?.isAvailable ?? false;
                        }

                        final bool isOutOfStock = !isProductAvailable();

                        return state.statusForProductDetails ==
                                BaseStateStatus.success
                            ? TotalProceedView(
                                title: isOutOfStock
                                    ? context.appString.outOfStockKey
                                    : context.appString.addKey,
                                customGradientButtonPressed: isOutOfStock
                                    ? () {} // No action for out of stock
                                    : () async {
                                        await context
                                            .read<ProductDetailsCubit>()
                                            .handleMainProductCartOperation(
                                              operation: CartOperation.add,
                                            );
                                      },
                                cartCount: isOutOfStock ? 0 : state.cartCount,
                                onMinusPressed: isOutOfStock
                                    ? null // Disable minus for out of stock
                                    : () async {
                                        await context
                                            .read<ProductDetailsCubit>()
                                            .handleMainProductCartOperation(
                                              operation: CartOperation.decrease,
                                            );
                                      },
                                onPlusPressed: isOutOfStock
                                    ? null // Disable plus for out of stock
                                    : () async {
                                        await context
                                            .read<ProductDetailsCubit>()
                                            .handleMainProductCartOperation(
                                              operation: CartOperation.increase,
                                            );
                                      },
                                device: device,
                                isCheckoutAllowed: !isOutOfStock,
                                selectedUnit: state.selectedUnitIndex != null &&
                                        state.selectedUnitIndex! >= 0 &&
                                        state.selectedUnitIndex! <
                                            state.availableUnits.length
                                    ? _convertVariantToProductListing(
                                        state.availableUnits[
                                            state.selectedUnitIndex!])
                                    : state.availableUnits.isNotEmpty
                                        ? _convertVariantToProductListing(
                                            state.availableUnits.first)
                                        : null,
                              )
                            : const TotalProceedViewShimmer();
                      },
                    )
                  ],
                ),
              ),
            ));
      },
    );
  }

  /// Handles back navigation with result data for home refresh.
  void backNavigationWithResult(
      BuildContext context, ProductDetailsState state) {
    // Trigger home refresh when navigating back from PDP
    context.refreshHomeData();

    if (index == -1) {
      context.router.popForced(true);
    } else {
      context.router.popForced(UpdateCartQtyModel(
          index: index ?? 0,
          entityId: entityId.toString(),
          qty: context.read<ProductDetailsCubit>().state.quantity));
    }
  }

  /// Helper method to get the number of reviews to display (max 2)
  int _getReviewItemCount(List<ReviewCommon>? reviews) {
    if (reviews == null || reviews.isEmpty) return 0;
    return reviews.length > 2 ? 2 : reviews.length;
  }

  /// Helper method to convert ProductVariantDukkan to ProductListingResponse
  ProductListingResponse _convertVariantToProductListing(
      ProductVariantDukkan variant) {
    return ProductListingResponse(
      entityId: variant.entityId,
      name: variant.name,
      thumbNail: variant.thumbNail,
      imageLarge: variant.imageLarge,
      formattedPrice: variant.formattedPrice,
      price: variant.price,
      formattedFinalPrice: variant.formattedFinalPrice,
      finalPrice: variant.finalPrice,
      percentOff: variant.percentOff,
      isAvailable: variant.isAvailable,
      sku: variant.sku,
      cartQuantity: variant.cartQuantity ?? 0,
      isCart: variant.isCart ?? false,
      isSelected: variant.isSelected,
      quantityLabel: variant.quantityLabel,
      uom: variant.uom
    );
  }

  /// Helper method to build the View All button (only shown when there are more than 2 reviews)
  Widget _buildViewAllButton(BuildContext context, ProductDetailsState state,
      List<ReviewCommon>? reviews, int entityId, double horizontalPadding) {
    if (reviews == null || reviews.length <= 2) {
      return const SizedBox.shrink(); // Hide button if 2 or fewer reviews
    }

    return Column(
      children: <Widget>[
        Dimens.size24.heightBox,
        Padding(
          padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
          child: CustomButtonWidget(
            isPrimaryButton: false,
            borderColor: MainConfig.appColors.mainColor,
            title: context.appString.viewAllKey,
            hasBorder: true,
            backgroundColor: MainConfig.appColors.transparent,
            titleTextStyle: context.textTheme.headlineMedium?.copyWith(
              fontSize: Dimens.fontSize16,
              fontWeight: FontWeight.w700,
              height: Dimens.lineHeight24.toLineHeight(Dimens.fontSize16),
              color: MainConfig.appColors.mainColor,
            ),
            onTap: () async {
              ///
              await context.router.push(
                ReviewListingRoute(
                  entityId: entityId,
                  productDetails: state.detailsModel,
                  totalReviewCount: state.review?.reviewCount ?? 0,
                  reviewData: state.review,
                ),
              );
            },
          ),
        ),
        Dimens.size28.heightBox,
      ],
    );
  }

  @override
  Widget buildDesktopWidget(BuildContext context) {
    return _editProductDetailsPage(ScreenType.desktop);
  }

  @override
  Widget buildMobileWidget(BuildContext context) {
    return _editProductDetailsPage(ScreenType.mobile);
  }

  @override
  Widget buildTabletWidget(BuildContext context) {
    return _editProductDetailsPage(ScreenType.tablet);
  }
}
