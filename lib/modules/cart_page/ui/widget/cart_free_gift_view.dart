import '../../../../utils/exports.dart';

/// A single free gift item row, styled similar to CartListViewWidget
/// but without wishlist, quantity controls, or delete. Shows struck-through
/// original price and a bold red "Free" label.
class CartFreeGiftView extends StatelessWidget {

  ///CartFreeGiftView
  const CartFreeGiftView({
    super.key,
    required this.product,
    this.index,
  });

  /// The free gift product to display.
  final ProductListingResponse product;
  /// The index of this item in the free gift list (for divider display logic)
  final int? index;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(Dimens.space8),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              // Product Image
              CustomNetworkImageWidget(
                imageUrl: product.thumbNail ?? "",
                height: Dimens.size72,
                width: Dimens.size72,
                placeHolderImage: Assets.svgs.icPlaceHolderDukkan.svg(),
              ),
              const SizedBox(width: Dimens.size16,),
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
                        height: Dimens.lineHeight18.toLineHeight(Dimens.fontSize14),
                        fontSize: Dimens.fontSize14,
                        color: AppColors.blackColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),

                    Dimens.space4.heightBox,

                    // UOM chip
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
                        label: product.uom ?? "",
                        style: context.textTheme.headlineMedium?.copyWith(
                          height: Dimens.lineHeight16.toLineHeight(Dimens.fontSize12),
                          fontSize: Dimens.fontSize12,
                          color: MainConfig.appColors.mainColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),

                    Dimens.space11.heightBox,

                    // Price (strikethrough) and Free label
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        if ((product.formattedFinalPrice ?? product.formattedPrice) != null)
                          CustomTextLabelWidget(
                            textDirection: TextDirection.ltr,
                            maxLines: Dimens.maxLines01,
                            overflow: TextOverflow.ellipsis,
                            label: (product.formattedFinalPrice ?? product.formattedPrice)!,
                            style: context.textTheme.headlineMedium?.copyWith(
                              decoration: TextDecoration.lineThrough,
                              height: Dimens.lineHeight18.toLineHeight(Dimens.fontSize14),
                              fontSize: Dimens.fontSize14,
                              color: MainConfig.appColors.creyColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        CustomTextLabelWidget(
                          maxLines: Dimens.maxLines01,
                          overflow: TextOverflow.ellipsis,
                          label: context.appString.freeKey.toUpperCase(),
                          style: context.textTheme.headlineMedium?.copyWith(
                            height: Dimens.lineHeight16.toLineHeight(Dimens.fontSize14),
                            fontSize: Dimens.fontSize14,
                            color: MainConfig.appColors.redColor,
                            fontWeight: FontWeight.w700,
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
        if ((index ?? -1) != 1) ...<Widget>[
          Dimens.size14.heightBox,
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: Dimens.space16),
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
