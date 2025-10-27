import '../../../../utils/exports.dart';

/// Widget that displays a single product unit/variant with selection and quantity controls.
class ProductSelectUnitWidget extends StatelessWidget {
  /// The label showing the quantity/unit information.
  final String? quantityLabel;

  /// The price of the unit.
  final String? price;

  /// Whether this unit is currently selected.
  final bool isSelect;

  /// Callback function called when the unit is tapped.
  final VoidCallback? onTap;

  /// The current count/quantity of this unit.
  final int? count;

  /// Creates a product select unit widget.
  const   ProductSelectUnitWidget({
    super.key,
    this.quantityLabel,
    this.price,
    this.isSelect = false,
    this.count = 0,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Dismiss keyboard before handling tap
        FocusScope.of(context).unfocus();
        onTap?.call();
      }, // Trigger the callback when the container is tapped
      child: Stack(
        clipBehavior: Clip.none,
        // Allow the badge to overflow the parent bounds
        children: <Widget>[
          Container(
            padding: const EdgeInsets.all(Dimens.space8),
            decoration: BoxDecoration(
              border: Border.all(
                color:
                    isSelect ? MainConfig.appColors.mainColor : MainConfig.appColors.lightGreyColor,
              ),
              borderRadius: Dimens.space4.borderRadius,
              color: isSelect ? MainConfig.appColors.iceBlueColor : MainConfig.appColors.backgroundWhite,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                CustomTextLabelWidget(
                  textAlign: TextAlign.start,
                  label: quantityLabel ?? '',
                  style: context.textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                    fontSize: Dimens.fontSize14,
                    color: MainConfig.appColors.mainColor,
                    height: Dimens.lineHeight20.toLineHeight(Dimens.fontSize14),
                  ),
                ),
                CustomTextLabelWidget(
                  textDirection: TextDirection.ltr,
                  textAlign: TextAlign.start,
                  label: price ?? "",
                  style: context.textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                    color: MainConfig.appColors.mainColor,
                    fontSize: Dimens.fontSize14,
                    height: Dimens.lineHeight16.toLineHeight(Dimens.fontSize14),
                  ),
                ),
              ],
            ),
          ),
          if ((count ?? 0) > 0 &&
              isSelect) // Show the badge only if the item is selected
            Positioned(
              top: -Dimens.space8, // Adjust as needed
              right: context.isEnglishLanguage ? 0 : null,
              left: context.isEnglishLanguage ? null : 0,
              child: Padding(
                padding: EdgeInsets.only(
                  right: context.isEnglishLanguage ? Dimens.space3 : 0,
                  left: context.isEnglishLanguage ? 0 : Dimens.space3,
                ),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: Dimens.space4, vertical: Dimens.space1),
                  decoration:  BoxDecoration(
                    shape: BoxShape.circle,
                    color: MainConfig.appColors.mainColor,
                  ),
                  alignment: Alignment.center,
                  child: CustomTextLabelWidget(
                    label: count.toString(),
                    style: context.textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.w700,
                      color: MainConfig.appColors.backgroundWhite,
                      fontSize: Dimens.fontSize12,
                      height:
                          Dimens.lineHeight14.toLineHeight(Dimens.fontSize12),
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
