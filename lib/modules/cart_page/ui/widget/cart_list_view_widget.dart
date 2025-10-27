import '../../../../utils/exports.dart';

/// A widget representing a single item in the cart list.
///
/// This widget displays the cart item quantity, and provides callbacks
/// for incrementing, decrementing, deleting, and adding the item to a wishlist.
class CartListViewWidget extends StatelessWidget {
  /// The product variant data for this cart item.
  final ProductVariantDukkan productVariant;

  /// Callback when the minus button is pressed to decrease quantity.
  final VoidCallback? onMinusPressed;

  /// Callback when the plus button is pressed to increase quantity.
  final VoidCallback? onPlusPressed;

  /// Callback when the delete button is pressed to remove the item from cart.
  final VoidCallback? onDeletePressed;

  /// Callback when the wishlist button is pressed to move the item to wishlist.
  final VoidCallback? onWishlistPressed;

  /// The index of this item in the cart list.
  final int index;

  ///isReward
  final bool? isReward;

  /// Creates a [CartListViewWidget] instance.
  const CartListViewWidget({
    super.key,
    required this.productVariant,
    this.onMinusPressed,
    this.onPlusPressed,
    this.onDeletePressed,
    this.onWishlistPressed,
    required this.index,
    required this.isReward,
  });
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(Dimens.space8),
      child: Column(
        children: <Widget>[
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              // Product Image
              CustomNetworkImageWidget(
                imageUrl: productVariant.thumbNail ?? "",
                height: Dimens.size72,
                width: Dimens.size72,
                placeHolderImage: Assets.svgs.icPlaceHolderDukkan.svg(),
              ),
              // Right side content
              const SizedBox(width: Dimens.size16,),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    // Title and Wishlist row
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Flexible(
                          child: CustomTextLabelWidget(
                            maxLines: Dimens.maxLines02,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.start,
                            label: productVariant.name ?? "",
                            style: context.textTheme.headlineMedium?.copyWith(
                              height: Dimens.lineHeight18
                                  .toLineHeight(Dimens.fontSize14),
                              fontSize: Dimens.fontSize14,
                              color: AppColors.blackColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        const SizedBox(width: Dimens.size8,),
                        if (!(isReward ?? false))
                          GestureDetector(
                            onTap: onWishlistPressed,
                            child: (productVariant.isFavorite ?? false)
                                ? Assets.svgs.icWishlistSelected.svg()
                                : Assets.svgs.icWishlistUnselected.svg(),
                          )
                      ],
                    ),

                    Dimens.space4.heightBox,

                    // Pack size and Quantity controls

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(
                          height: Dimens.size22,
                          padding: const EdgeInsets.symmetric(
                            horizontal: Dimens.space4,
                            vertical: Dimens.space3,
                          ),
                          decoration: BoxDecoration(
                            color: MainConfig.appColors.iceBlueColor,
                            borderRadius: Dimens.radius4.borderRadius,
                          ),
                          child: CustomTextLabelWidget(
                            maxLines: Dimens.maxLines01,
                            overflow: TextOverflow.ellipsis,
                            label: productVariant.uom??"",
                            style: context.textTheme.headlineMedium?.copyWith(
                              height: Dimens.lineHeight16
                                  .toLineHeight(Dimens.fontSize12),
                              fontSize: Dimens.fontSize12,
                              color: MainConfig.appColors.mainColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),

                        if (!(isReward ?? false))
                          ProductCommonQtyButton(
                            buttonPaddingVertical: Dimens.space0,
                            endPaddingOfButton: Dimens.space7,
                          /*  startPaddingOfButton: Dimens.space8,*/
                            heightOfButton: Dimens.space24,
                            widthOfButton: Dimens.space75,
                            cartQty: productVariant.cartQuantity ?? 0,
                            onMinusPressed: onMinusPressed,
                            onPlusPressed: onPlusPressed,
                          ),
                      ],
                    ),

                    Dimens.space11.heightBox,

                    // Price and Delete row
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        // Price section
                        Row(
                          children: <Widget>[
                            CustomTextLabelWidget(
                              textDirection: TextDirection.ltr,
                              maxLines: Dimens.maxLines01,
                              overflow: TextOverflow.ellipsis,
                              label: '${productVariant.price.toString()}  ${getIt<LanguageService>().defaultCurrency}'  ,
                              style: context.textTheme.headlineMedium?.copyWith(
                                height: Dimens.lineHeight16
                                    .toLineHeight(Dimens.fontSize14),
                                fontSize: Dimens.fontSize14,
                                color: AppColors.blackColor,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            if (productVariant.finalPrice != null &&
                                productVariant.finalPrice! > 0 &&
                                productVariant.finalPrice != productVariant.price) ...<Widget>[
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: Dimens.space4),
                                child: CustomTextLabelWidget(
                                  textDirection: TextDirection.ltr,
                                  maxLines: Dimens.maxLines01,
                                  overflow: TextOverflow.ellipsis,
                                  label: '${productVariant.finalPrice!} ${getIt<LanguageService>().defaultCurrency}',
                                  style:
                                      context.textTheme.headlineMedium?.copyWith(
                                    decoration: TextDecoration.lineThrough,
                                    height: Dimens.lineHeight18
                                        .toLineHeight(Dimens.fontSize14),
                                    fontSize: Dimens.fontSize14,
                                    color: MainConfig.appColors.creyColor,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              if (productVariant.percentOff != null && productVariant.percentOff!.isNotEmpty)
                                CustomTextLabelWidget(
                                  maxLines: Dimens.maxLines01,
                                  overflow: TextOverflow.ellipsis,
                                  label:"${productVariant.percentOff} ${context.appString.oFFKey}",
                                  style: context.textTheme.headlineMedium?.copyWith(
                                    height: Dimens.lineHeight14
                                        .toLineHeight(Dimens.fontSize12),
                                    fontSize: Dimens.fontSize12,
                                    color: MainConfig.appColors.greenColor,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                            ],
                          ],
                        ),
                        // Delete button
                        if (!(isReward ?? false))
                          Padding(
                            padding: const EdgeInsets.only(right: Dimens.space5),
                            child: GestureDetector(
                              onTap: onDeletePressed,
                              child: CustomTextLabelWidget(
                                maxLines: Dimens.maxLines01,
                                overflow: TextOverflow.ellipsis,
                                label: context.appString.deleteKey,
                                style: context.textTheme.headlineMedium?.copyWith(
                                  decoration: TextDecoration.underline,
                                  decorationColor: MainConfig.appColors.redColor,
                                  height: Dimens.lineHeight14
                                      .toLineHeight(Dimens.fontSize12),
                                  fontSize: Dimens.fontSize12,
                                  color: MainConfig.appColors.redColor,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          if (index  != 1 && isReward!) ...<Widget>[
            // Hide for the last item
            Dimens.size14.heightBox,
            CustomDivider(
              width: double.infinity,
              height: Dimens.size1,
              color: MainConfig.appColors.dividerColor,
            ),
          ],
        ],
      ),
    );
  }
}
