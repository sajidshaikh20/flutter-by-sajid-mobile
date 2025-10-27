
import '../../../utils/exports.dart';

/// Widget that displays a single product item in the listing with quantity controls.
class ProductListingUnitRowItem extends StatelessWidget {
  /// The product variant data to display.
  final ProductVariantDukkan? productVariant;

  /// The index of this item in the list.
  final int index;

  /// Callback when the add button is pressed.
  final VoidCallback? onAddPressed;

  /// Callback when the plus button is pressed to increase quantity.
  final VoidCallback? onPlusPressed;

  /// Callback when the minus button is pressed to decrease quantity.
  final VoidCallback? onMinusPressed;

  ///ProductListingUnitRowItem
  const ProductListingUnitRowItem({
    super.key,
    this.productVariant,
    required this.index,
    this.onAddPressed,
    this.onPlusPressed,
    this.onMinusPressed,
  });

  @override
  Widget build(BuildContext context) {
    // Use productVariant data if available, otherwise fallback to dummy data
    final String productName = productVariant?.name ?? AppConstant.dummyCartonName;
    final String productImage = productVariant?.thumbNail ?? productVariant?.imageLarge ?? '';
    final String currentPrice = productVariant?.formattedFinalPrice ?? "";
    final String originalPrice = productVariant?.formattedPrice ?? "";
    final String discountPercentage = productVariant?.percentOff ?? "";
    final bool isAvailable = productVariant?.isAvailable ?? true;
    final int cartQuantity = productVariant?.cartQuantity ?? 0;
    
    return Container(
      margin: const EdgeInsets.only(bottom: Dimens.space8),
      decoration: BoxDecorationExtension.customDecoration(
        color: MainConfig.appColors.backgroundWhite, // Background color
        border: Border.all(
          color: MainConfig.appColors.dividerGreyColor, // Border color
          width: Dimens.borderWidth05, // Border width
        ),
        borderRadius: Dimens.radius8.borderRadius, // Rounded corners
      ),
      padding: const EdgeInsets.only(
          left: Dimens.space4,
          right: Dimens.space8,
          bottom: Dimens.space4,
          top: Dimens.space4),
      child: Row(
        children: <Widget>[
          Container(
            height: Dimens.size58,
            width: Dimens.size58,
            decoration: BoxDecorationExtension.customDecoration(
              color: MainConfig.appColors.backgroundWhite, // Background color
              border: Border.all(
                color: MainConfig.appColors.dividerGreyColor, // Border color
                width: Dimens.borderWidth05, // Border width
              ),
              borderRadius: Dimens.radius8.borderRadius, // Rounded corners
            ),
            child: productImage.isNotEmpty
                ? ClipRRect(
                    borderRadius: Dimens.radius8.borderRadius,
                    child: Image.network(
                      productImage,
                      fit: BoxFit.cover,
                      errorBuilder: (BuildContext context, Object error, StackTrace? stackTrace) {
                        return Assets.png.icProductDetails.image();
                      },
                    ),
                  )
                : Assets.png.icProductDetails.image(),
          ),
          const SizedBox(
            width: Dimens.size13,
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                CustomTextLabelWidget(
                  label: productName,
                  style: context.textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w500,
                      color: MainConfig.appColors.textBlackColor,
                      fontSize: Dimens.fontSize14,
                      height:
                          Dimens.lineHeight18.toLineHeight(Dimens.fontSize14)),
                ),
                const SizedBox(
                  height: Dimens.size6,
                ),
                Row(
                  children: <Widget>[
                    CustomTextLabelWidget(
                      textDirection: TextDirection.ltr,
                      label: currentPrice,
                      style: context.textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w700,
                          color: MainConfig.appColors.textBlackColor,
                          fontSize: Dimens.fontSize14,
                          height: Dimens.lineHeight16
                              .toLineHeight(Dimens.fontSize14)),
                    ),
                    const SizedBox(
                      width: Dimens.size2,
                    ),
                    CustomTextLabelWidget(
                      textDirection: TextDirection.ltr,
                      label: originalPrice,
                      style: context.textTheme.bodyMedium?.copyWith(
                          decoration: TextDecoration.lineThrough,
                          fontWeight: FontWeight.w600,
                          color: MainConfig.appColors.creyColor,
                          fontSize: Dimens.fontSize14,
                          height: Dimens.lineHeight18
                              .toLineHeight(Dimens.fontSize14)),
                    ),
                    const SizedBox(
                      width: Dimens.size4,
                    ),
                    CustomTextLabelWidget(
                      textDirection: TextDirection.ltr,
                      label: '$discountPercentage% OFF',
                      style: context.textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w500,
                          color: MainConfig.appColors.greenColor,
                          fontSize: Dimens.fontSize12,
                          height: Dimens.lineHeight14
                              .toLineHeight(Dimens.fontSize12)),
                    ),
                  ],
                )
              ],
            ),
          ),
          // Show Add button or Quantity button based on cart quantity
          cartQuantity == 0
              ? CustomGradientButtonWidget(
                  titleTextStyle: context.textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: isAvailable ? AppColors.whiteColor : MainConfig.appColors.creyColor,
                      fontSize: Dimens.fontSize14,
                      height: Dimens.lineHeight16.toLineHeight(Dimens.fontSize14)),
                  height: Dimens.size32,
                  width: Dimens.size70,
                  isButtonEnabled: isAvailable,
                  title: !isAvailable ? context.appString.outOfStockKey : context.appString.addButtonKey,
                  onTap:() async {
                    onAddPressed?.call();
                  }
                  ,
                )
              : ProductCommonQtyButton(
                  cartQty: cartQuantity,
                  onMinusPressed: onMinusPressed,
                  onPlusPressed: onPlusPressed,
                  heightOfButton: Dimens.size32,
                  widthOfButton: Dimens.size70,
                  endPaddingOfButton: Dimens.space8,
                ),
        ],
      ),
    );
  }
}
