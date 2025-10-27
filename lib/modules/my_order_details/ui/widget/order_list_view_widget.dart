import '../../../../utils/exports.dart';

/// A widget that displays an item in the order list with action callbacks.
///
/// This widget provides UI and callbacks for actions such as incrementing/decrementing
/// quantities, writing a review, and adding/removing from wishlist.
class OrderListViewWidget extends StatelessWidget {
  /// Callback triggered when the minus button is pressed.
  final VoidCallback? onMinusPressed;

  /// Callback triggered when the plus button is pressed.
  final VoidCallback? onPlusPressed;

  /// Callback triggered when the "Write Review" button is pressed.
  final VoidCallback? onWriteReviewPressed;

  /// Callback triggered when the wishlist button is pressed.
  final VoidCallback? onWishlistPressed;

  /// The index of the item in the list.
  final int? index;

  /// Indicates if the widget is displayed in a "Write Review" context.
  final bool isFromWriteReview;

  /// The product data to be displayed in the widget.
  final ProductListingResponse? product;

  /// Indicates if this item is the last in the list.
  final bool isLastItem;

  /// Creates an [OrderListViewWidget].
  ///
  /// All callbacks are optional. The [isFromWriteReview] defaults to `false`.
  /// The [isLastItem] defaults to `false`.
  const OrderListViewWidget({
    super.key,
    this.onMinusPressed,
    this.onPlusPressed,
    this.onWriteReviewPressed,
    this.onWishlistPressed,
    this.isFromWriteReview = false,
    this.index,
    this.product,
    this.isLastItem = false,
  });

  /// Returns the original price of the product.
  ///
  /// Uses `finalPrice` if available, otherwise falls back to `price`.
  double get productOriginalPrice =>
      (product?.finalPrice ?? product?.price ?? 0).toDouble();

  /// Returns the discount percentage of the product as an integer.
  ///
  /// Parses the `percentOff` field of the product. Returns `0` if parsing fails.
  int get productDiscountPercentage =>
      int.tryParse(product?.percentOff ?? '0') ?? 0;

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
              Container(
                height: Dimens.size64,
                width: Dimens.size64,
                decoration: BoxDecorationExtension.customDecoration(
                  color: MainConfig.appColors.backgroundWhite, // Background color
                ),
                child:
                FastCachedCustomNetwork(
                  imageUrl: product?.thumbNail.toString() ?? "",
                  fit: BoxFit.fill,
                  placeHolderImage: Assets.svgs.icPlaceHolderDukkan.svg(),
                  isShowPlaceHolder: true,
                ),

                // Assets.png.icProductDetails.image(),
              ),
              Dimens.space12.widthBox,

              // Right side content
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
                            label: product?.name?.toString() ?? '',
                            style: context.textTheme.headlineMedium?.copyWith(
                              height: Dimens.lineHeight18
                                  .toLineHeight(Dimens.fontSize14),
                              fontSize: Dimens.fontSize14,
                              color: MainConfig.appColors.textBlackColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Dimens.space4.heightBox,
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
                            label: product?.uom?.toString() ?? '',
                            style: context.textTheme.headlineMedium?.copyWith(
                              height: Dimens.lineHeight16
                                  .toLineHeight(Dimens.fontSize12),
                              fontSize: Dimens.fontSize12,
                              color: MainConfig.appColors.mainColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Dimens.space4.heightBox,
                    // Price and Delete row
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        // Price section
                        //Free label for product
                       /* index == 0
                            ? CustomTextLabelWidget(
                                maxLines: Dimens.maxLines01,
                                overflow: TextOverflow.ellipsis,
                                label: context.appString.freeKey,
                                style:
                                    context.textTheme.headlineMedium?.copyWith(
                                  height: Dimens.lineHeight16
                                      .toLineHeight(Dimens.fontSize14),
                                  fontSize: Dimens.fontSize14,
                                  color: MainConfig.appColors.redColor,
                                  fontWeight: FontWeight.w700,
                                ),
                              )
                            :*/
                        Row(
                                children: <Widget>[
                                  CustomTextLabelWidget(
                                    textDirection: TextDirection.ltr,
                                    maxLines: Dimens.maxLines01,
                                    overflow: TextOverflow.ellipsis,
                                    label: '$productOriginalPrice ${getIt<LanguageService>().defaultCurrency}',
                                    style: context.textTheme.headlineMedium
                                        ?.copyWith(
                                      height: Dimens.lineHeight16
                                          .toLineHeight(Dimens.fontSize14),
                                      fontSize: Dimens.fontSize14,
                                      color:
                                          MainConfig.appColors.textBlackColor,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  if(product?.percentOff?.isNotEmpty ?? false)
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: Dimens.space4),
                                    child: CustomTextLabelWidget(
                                      maxLines: Dimens.maxLines01,
                                      overflow: TextOverflow.ellipsis,
                                      label: '$productDiscountPercentage% ${context.appString.oFFKey}',
                                      style: context.textTheme.headlineMedium
                                          ?.copyWith(
                                        decoration: TextDecoration.lineThrough,
                                        height: Dimens.lineHeight18
                                            .toLineHeight(Dimens.fontSize14),
                                        fontSize: Dimens.fontSize14,
                                        color: MainConfig.appColors.creyColor,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                        if (!isFromWriteReview)
                          // index == 1
                          product?.reviewCount == "0"
                              ? Padding(
                                  padding: const EdgeInsets.only(
                                      right: Dimens.space5),
                                  child: GestureDetector(
                                    onTap: onWriteReviewPressed,
                                    child: CustomTextLabelWidget(
                                      maxLines: Dimens.maxLines01,
                                      overflow: TextOverflow.ellipsis,
                                      label: context.appString.writeAReviewKey,
                                      style: context.textTheme.headlineMedium
                                          ?.copyWith(
                                        decoration: TextDecoration.underline,
                                        decorationColor:
                                            MainConfig.appColors.mainColor,
                                        height: Dimens.lineHeight14
                                            .toLineHeight(Dimens.fontSize12),
                                        fontSize: Dimens.fontSize12,
                                        color: MainConfig.appColors.mainColor,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ),
                                )
                              : CommonRatingIndicator(
                                  rating: product?.ratings ?? 0.0,
                                  itemSize: AppConstant.itemCount16,
                                ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          if (index != null && !isLastItem) ...<Widget>[
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
