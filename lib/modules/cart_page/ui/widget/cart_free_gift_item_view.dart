import '../../../../../utils/exports.dart';

/// A single free gift item row, styled similar to CartListViewWidget
/// but without wishlist, quantity controls, or delete. Shows struck-through
/// original price and a bold red "Free" label.
class CartFreeGiftItemView extends StatelessWidget {
  ///CartFreeGiftItemView constructor
  const CartFreeGiftItemView({
    super.key,
    required this.product,
    this.index,
    this.isLast = false,
  });

  /// The free gift product to display.
  final ProductListingResponse product;
  /// The index of this item in the free gift list (for divider display logic)
  final int? index;
  /// Whether this item is the last item in the list
  final bool isLast;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(
            left: Dimens.space8,
            right: Dimens.space8,
            top: Dimens.space8,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              // Product Image
              CustomNetworkImageWidget(
                imageUrl: product.thumbNail ?? "",
                height: Dimens.size50,
                width: Dimens.size50,
                placeHolderImage: Assets.svgs.icPlaceHolderDukkan.svg(),
              ),
              const SizedBox(width: Dimens.size8,),
              // Right side content
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    // Title
                    CustomTextLabelWidget(
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.start,
                      label: product.name ?? "",
                      style: context.textTheme.headlineMedium?.copyWith(
                        height: Dimens.lineHeight14.toLineHeight(Dimens.fontSize12),
                        fontSize: Dimens.fontSize12,
                        fontWeight: FontWeight.w500,
                        color: AppColors.blackColor,
                      ),
                    ),

                    Dimens.space7.heightBox,
                    // Price (strikethrough) and Free label
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        if ((product.productVariant?.first.finalPrice ?? product.productVariant?.first.price) != 0)
                          CustomTextLabelWidget(
                            maxLines: Dimens.maxLines01,
                            overflow: TextOverflow.ellipsis,
                            label: context.appString.freeKey.toUpperCase(),
                            style: context.textTheme.headlineMedium?.copyWith(
                              height: Dimens.lineHeight14.toLineHeight(Dimens.fontSize12),
                              fontSize: Dimens.fontSize12,
                              fontWeight: FontWeight.w500,
                              color: MainConfig.appColors.redColor,
                            ),
                          ),
                        const SizedBox(width: Dimens.size4),
                        CustomTextLabelWidget(
                            textDirection: TextDirection.ltr,
                            maxLines: Dimens.maxLines01,
                            overflow: TextOverflow.ellipsis,
                            label: '${(product.productVariant?.first.finalPrice ?? product.productVariant?.first.price)!}  ${getIt<LanguageService>().defaultCurrency}',
                            style: context.textTheme.headlineMedium?.copyWith(
                              decoration: TextDecoration.lineThrough,
                              height: Dimens.lineHeight14.toLineHeight(Dimens.fontSize12),
                              fontSize: Dimens.fontSize12,
                              fontWeight: FontWeight.w500,
                              color: MainConfig.appColors.creyColor,
                            ),
                          ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        if (!isLast) ...<Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: Dimens.space8),
            child: CustomDivider(
              width: double.infinity,
              height: Dimens.size1,
              color: MainConfig.appColors.dividerColor,
            ),
          ),
        ],
      ],
    );
  }
}
