import '../../../../utils/exports.dart';

/// A responsive widget for displaying the cart list page.
///
/// This page shows all items in the user's cart, along with options
/// to update quantities, remove items, apply coupons, and proceed
/// to checkout. The layout adapts to mobile, tablet, and desktop screens
/// using [BaseResponsiveView].
class CartListPageWidget extends BaseResponsiveView {
  /// Creates a [CartListPageWidget] instance.
  const CartListPageWidget({super.key});

  Widget _buildView(ScreenType device) {
    DebugLog.instance
        .i('CartListPageWidget: Building view for device: $device');
    return _cartListPageView(device);
  }

  BlocConsumer<CartPageCubit, CartPageState> _cartListPageView(
      ScreenType device) {
    switch (device) {
      case ScreenType.tablet:
      default:
        break;
    }

    return BlocConsumer<CartPageCubit, CartPageState>(
      listenWhen: (CartPageState previous, CartPageState current) {
        return previous.isSnackBarDisplay != current.isSnackBarDisplay ||
            previous.displayMessage != current.displayMessage ||
            previous.status != current.status;
      },
      listener: (BuildContext context, CartPageState state) {
        if (state.isSnackBarDisplay &&
            (state.displayMessage?.isNotEmpty ?? false)) {
          displaySnackBar(state.displayMessage!, context);
          context.read<CartPageCubit>().clearSnackBar();
        }
        if (state.isCouponApplied) {
          state.stateTextEditingController.text = state.couponCode ?? "";
        }
      },
      builder: (BuildContext context, CartPageState state) {
        // Debug logging to track state changes
        DebugLog.instance.i(
            'CartListPageWidget - statusForCartListing: ${state.statusForCartListing}');

        return Scaffold(
            backgroundColor: MainConfig.appColors.backgroundWhiteColor,
            extendBody: true,
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                ProductDetailsAppBar(
                  titleText: state.cartCount != null && state.cartCount! > 0
                      ? '${context.appString.cartKey} (${state.cartCount} ${state.cartCount == 1 ? context.appString.itemKey : context.appString.itemsKey})'
                      : '',
                  isLastWidgetDisplay: false,
                  prefixIcon: Assets.svgs.icCloseIcon
                      .svg(height: Dimens.size24, width: Dimens.size24),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        state.statusForTimeSlots == BaseStateStatus.success
                            ? const CartListHeaderWidget()
                            : const PickupAddressShimmer(),
                        //#TODO commented out right now future development
                        /* Padding(
                          padding: Dimens.space16.padding,
                          child :*/ /*state.status==BaseStateStatus.success?*/ /* const CartOutOfStockWidget()*/ /*:const CartOutOfStockShimmer()*/ /*,
                        ),*/

                        Padding(
                          padding: const EdgeInsets.only(
                            left: Dimens.space16,
                            right: Dimens.space16,
                            top: Dimens.space8,
                          ),
                          child: DecoratedBox(
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: MainConfig.appColors.lightGreyColor,
                                  width: Dimens.borderWidth05,
                                ),
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(Dimens.space8)),
                                color: MainConfig.appColors.backgroundWhite,
                              ),
                              child: state.statusForCartListing ==
                                      BaseStateStatus.success
                                  ? CustomListView(
                                      scrollPhysics:
                                          const NeverScrollableScrollPhysics(),
                                      isPadding: true,
                                      itemBuilder: (BuildContext context,
                                          int index) {
                                        final List<ProductVariantDukkan>
                                            flattenedVariants =
                                            state.flattenedVariants ??
                                                <ProductVariantDukkan>[];
                                        // Filter out variants with cart quantity 0 or less
                                        final List<ProductVariantDukkan>
                                            activeVariants = flattenedVariants
                                                .where((ProductVariantDukkan
                                                        variant) =>
                                                    (variant.cartQuantity ??
                                                        0) >
                                                    0)
                                                .toList();

                                        if (index < activeVariants.length) {
                                          final ProductVariantDukkan variant =
                                              activeVariants[index];
                                          // Find the original index in the flattenedVariants list
                                          final int originalIndex =
                                              flattenedVariants
                                                  .indexOf(variant);
                                          // Determine reward item by matching SKU with cartItems that have isReward=true
                                          final bool isRewardItem = state
                                                  .cartDetailsListingResponse
                                                  ?.cartItems
                                                  ?.any((ProductListingResponse
                                                          e) =>
                                                      (e.isReward ?? false) &&
                                                      e.sku == variant.sku) ??
                                              false;
                                          if (isRewardItem) {
                                            return const SizedBox.shrink();
                                          }
                                          return CartListViewWidget(
                                            productVariant: variant,
                                            index: index,
                                            isReward: isRewardItem,
                                            onMinusPressed: () async {
                                              // Handle minus button press for variant
                                              final int currentQty =
                                                  variant.cartQuantity ?? 0;
                                              if (currentQty > 1) {
                                                // Decrease quantity if more than 1
                                                await context
                                                    .read<CartPageCubit>()
                                                    .handleCartOperationForCartPage(
                                                      variantIndex:
                                                          originalIndex,
                                                      operation: CartOperation
                                                          .decrease,
                                                    );
                                              } else if (currentQty == 1) {
                                                // Remove item if quantity is 1
                                                await context
                                                    .read<CartPageCubit>()
                                                    .handleCartOperationForCartPage(
                                                      variantIndex:
                                                          originalIndex,
                                                      operation:
                                                          CartOperation.remove,
                                                    );
                                              }
                                            },
                                            onPlusPressed: () async {
                                              // Handle plus button press for variant
                                              await context
                                                  .read<CartPageCubit>()
                                                  .handleCartOperationForCartPage(
                                                    variantIndex: originalIndex,
                                                    operation:
                                                        CartOperation.increase,
                                                  );
                                            },
                                            onDeletePressed: () async {
                                              // Handle delete button press for variant
                                              await context
                                                  .read<CartPageCubit>()
                                                  .handleCartOperationForCartPage(
                                                    variantIndex: originalIndex,
                                                    operation:
                                                        CartOperation.remove,
                                                  );
                                            },
                                            onWishlistPressed: () async {
                                              // Handle wishlist button press for variant
                                              if (variant.sku != null) {
                                                await context
                                                    .read<CartPageCubit>()
                                                    .handleWishlistLikeDislikeForCart(
                                                      sku: variant.sku!,
                                                      variantIndex:
                                                          originalIndex,
                                                      isCurrentlyFavorite:
                                                          variant.isFavorite ??
                                                              false,
                                                    );
                                              }
                                            },
                                          );
                                        }
                                        return const SizedBox.shrink();
                                      },
                                      itemCount: (state.flattenedVariants ??
                                              <ProductVariantDukkan>[])
                                          .where(
                                              (ProductVariantDukkan variant) =>
                                                  (variant.cartQuantity ?? 0) >
                                                  0)
                                          .length)
                                  : const CartListViewShimmerWidget()),
                        ),
                        Dimens.space16.heightBox,
                        // Delivery Instruction (only for delivery)
                        BlocBuilder<HomeCubit, HomeState>(
                          builder: (BuildContext context, HomeState homeState) {
                            final bool isDelivery = homeState.deliveryType == 'delivery';
                            if (!isDelivery) return const SizedBox.shrink();
                            return const Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: Dimens.space16),
                              child: DeliveryInstructionWidget(),
                            );
                          },
                        ),
                        Dimens.space12.heightBox,
                        // Show reward items list styled like the main cart list
                        if (state.cartDetailsListingResponse?.cartItems?.any(
                          (ProductListingResponse e) => e.isReward ?? false,
                        ) ?? false) ...<Widget>[
                          Padding(
                            padding: const EdgeInsets.only(
                              left: Dimens.space16,
                              right: Dimens.space16,
                            ),
                            child: CustomTextLabelWidget(
                              maxLines: Dimens.maxLines01,
                              overflow: TextOverflow.ellipsis,
                              label: context.appString.freeKey.toUpperCase(),
                              style: context.textTheme.headlineMedium?.copyWith(
                                height: Dimens.lineHeight16
                                    .toLineHeight(Dimens.fontSize14),
                                fontSize: Dimens.fontSize14,
                                color: MainConfig.appColors.redColor,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                          Dimens.space16.heightBox,
                          Padding(
                            padding: const EdgeInsets.only(
                              left: Dimens.space16,
                              right: Dimens.space16,
                            ),
                            child: DecoratedBox(
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: MainConfig.appColors.lightGreyColor,
                                  width: Dimens.borderWidth05,
                                ),
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(Dimens.space8)),
                                color: MainConfig.appColors.backgroundWhite,
                              ),
                              child: state.statusForCartListing ==
                                      BaseStateStatus.success
                                  ? CustomListView(
                                      scrollPhysics:
                                          const NeverScrollableScrollPhysics(),
                                      isPadding: true,
                                      itemBuilder:
                                          (BuildContext context, int rIndex) {
                                        final List<ProductListingResponse>
                                            rewardItems = state
                                                    .cartDetailsListingResponse
                                                    ?.cartItems
                                                    ?.where(
                                                        (ProductListingResponse e) =>
                                                            e.isReward ?? false)
                                                    .toList() ??
                                                <ProductListingResponse>[];
                                        if (rIndex < rewardItems.length) {
                                          final ProductListingResponse rewardProduct =
                                              rewardItems[rIndex];
                                          return CartFreeGiftView(
                                              product: rewardProduct,
                                              index: rIndex);
                                        }
                                        return const SizedBox.shrink();
                                      },
                                      itemCount: state
                                              .cartDetailsListingResponse
                                              ?.cartItems
                                              ?.where((ProductListingResponse e) =>
                                                  e.isReward ?? false)
                                              .length ??
                                          0,
                                    )
                                  : const CartListViewShimmerWidget(),
                            ),
                          ),
                          Dimens.space16.heightBox,
                        ],
                        const Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: Dimens.space8),
                          child:  DiscountLoyaltyCartWidget(),
                          // DecoratedBox(
                          //     decoration: BoxDecoration(
                          //       border: Border.all(
                          //         color: MainConfig.appColors.lightGreyColor,
                          //         width: Dimens.borderWidth05,
                          //       ),
                          //       borderRadius: const BorderRadius.all(
                          //           Radius.circular(Dimens.space8)),
                          //       color: MainConfig.appColors.backgroundWhite,
                          //     ),
                          //     child: /*state.status==BaseStateStatus.success ?*/
                          //         const DiscountLoyaltyCartWidget() /*:const DiscountLoyaltyCartShimmerWidget()*/),
                        ),

                        // Only show "You May Also Like" section if there are products and API call was successful
                        if (state.apiCallForYouMayAlsoLikeDeals ==
                                BaseStateStatus.success &&
                            (state.youMayAlsoLikeDealsModel?.firstOrNull
                                    ?.productListModel.isNotEmpty ??
                                false))
                          ProductSectionWidget(
                            headerText: context.appString.youMayAlsoLikeKey,
                            products: state.youMayAlsoLikeDealsModel
                                    ?.firstOrNull?.productListModel ??
                                <ProductListingResponse>[],
                            state: state.apiCallForYouMayAlsoLikeDeals,
                            isDealsSection: false,
                            dealsType: DealsTagName.youMayAlsoLike.name,
                          ),
                        // Only show "Buy It Again" section if there are products and API call was successful
                        if (state.apiCallForHomeDeals ==
                                BaseStateStatus.success &&
                            (state.dealsModel?.firstOrNull?.productListModel
                                    .isNotEmpty ??
                                false))
                          ProductSectionWidget(
                            headerText: context.appString.buyItAgainKey,
                            products: state.dealsModel?.firstOrNull
                                    ?.productListModel ??
                                <ProductListingResponse>[],
                            state: state.apiCallForHomeDeals,
                            isDealsSection: true,
                            dealsType: DealsTagName.bestDeals.name,
                          ),

                        Dimens.size24.heightBox,
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: Dimens.space16),
                          child: state.statusForCartListing ==
                                  BaseStateStatus.success
                              ? OrderDetailSummaryView(
                                  isFromCartScreen: false,
                                  onItemTap: () {},
                                  cartDetailsModel:
                                      state.cartDetailsListingResponse,
                                  totalDiscountString:
                                      AppConstant.totalDiscountString,
                                  device: device,
                                )
                              : const OrderDetailSummaryShimmerView(),
                        ),
                        Dimens.size20.heightBox,
                      ],
                    ),
                  ),
                ),
                /* state.status==BaseStateStatus.success ?*/
                BlocListener<CartPageCubit, CartPageState>(
                  listenWhen: (CartPageState previous, CartPageState current) {
                    return previous.showOrderSuccessDialog != current.showOrderSuccessDialog ||
                        previous.showFreeGiftDialog != current.showFreeGiftDialog ||
                        previous.showNextOrderCouponDialog != current.showNextOrderCouponDialog
                    ;
                  },
                  listener: (BuildContext context, CartPageState state) {
                    if (state.showOrderSuccessDialog) {
                      // Create dynamic title3 with paid amount
                      final String paidAmountText = state.orderTotalAmount !=
                              null
                          ? '${context.appString.paidAmountKey} ${formatPrice(state.orderTotalAmount!, getIt<LanguageService>().defaultCurrency)}'
                          : context.appString.paidAmountKey;

                      unawaited(showCustomDialogWithLottie(
                        "",
                        barrierDismissible: false,
                        title1: context.appString.thankYouKey,
                        title2: context.appString
                            .yourOrderSuccesfullyPlacedAndYouEarnedKey,
                        title3: paidAmountText,
                        okBtnTitle: context.appString.okayKey,
                        isDialogHideOnClick: true,
                        child: BlocProvider<CartPageCubit>.value(
                          value: context.read<CartPageCubit>(),
                          child: const OrderDetailsBottomSheet(),
                        ),
                        onOkClicked: () {
                          final CartPageCubit cubit = context.read<CartPageCubit>();
                          DebugLog.instance.e("msg_coupon, ${state.msgCoupon}");
                          if (state.msgCoupon.isNotNullOrEmpty) {
                            // Hide success dialog first, then trigger coupon dialog on next microtask/frame
                            cubit.resetOrderSuccessDialog();
                            unawaited(Future<void>.microtask(() => cubit.setNextOrderCouponDialog()));
                          } else {
                            cubit.resetOrderSuccessDialog();
                            context.router.popForced();
                          }
                        },
                        lottieAnimationFilePath: Assets.gif.icSuccessRight.path,
                      ));
                    }

                    if (state.showFreeGiftDialog) {
                      final List<ProductListingResponse> rewardItems = state
                              .cartDetailsListingResponse?.cartItems
                              ?.where((ProductListingResponse e) =>
                                  e.isReward ?? false)
                              .toList() ??
                          <ProductListingResponse>[];
                      if (rewardItems.isNotEmpty) {
                        final CartPageCubit cartCubit = context.read<CartPageCubit>();
                        unawaited(showFreeGiftDialog(
                          freeGifts: rewardItems,
                          device: device,
                        ).whenComplete(() {
                          cartCubit.resetFreeGiftDialog();
                        }));
                      }
                    }

                    if(state.showNextOrderCouponDialog){
                      showCustomDialog(
                        "${state.msgCoupon}",
                        title:  context.appString.hurrayKey,
                        okBtnTitle: context.appString.okayKey,
                        isDialogHideOnClick: true,
                        barrierDismissible: false,
                        onOkClicked: () {
                          context.read<CartPageCubit>().resetNextOrderCouponDialog();
                          context.router.popForced();
                        },
                      );
                    }
                  },
                  child: CartListBottomView(
                    title: context.appString.checkoutKey,
                    isCheckoutAllowed: (state.cartCount ?? 0) > 0,
                    customGradientButtonPressed: () async {
                      await context.read<CartPageCubit>().addOrderFromCart();
                    },
                    btnWidth: Dimens.size225,
                    device: device,
                  ),
                ) /*:const CartListBottomViewShimmer()*/,
              ],
            ));
      },
    );
  }

  @override
  Widget buildDesktopWidget(BuildContext context) {
    return _buildView(ScreenType.desktop);
  }

  @override
  Widget buildMobileWidget(BuildContext context) {
    return _buildView(ScreenType.mobile);
  }

  @override
  Widget buildTabletWidget(BuildContext context) {
    return _buildView(ScreenType.tablet);
  }
}
