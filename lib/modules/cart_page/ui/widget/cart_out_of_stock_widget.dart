import '../../../../utils/exports.dart';

/// [CartOutOfStockWidget] class is a stateless widget used to display the
/// out of stock widget on the cart page.
class CartOutOfStockWidget extends StatelessWidget {
  /// Constructor for [CartOutOfStockWidget].
  /// [key] is an optional parameter that can be used to identify this widget.
  const CartOutOfStockWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
          left: Dimens.space16,
          right: Dimens.space16,
          top: Dimens.space16,
          bottom: Dimens.space10),
      decoration: BoxDecorationExtension.customDecoration(
        color: MainConfig.appColors.backgroundWhiteShade,
        borderRadius: Dimens.radius8.borderRadius,
        border:
            Border.all(color: MainConfig.appColors.redColor, width: Dimens.borderWidth05),
      ),
      child: Column(
        children: <Widget>[
          Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              CustomTextLabelWidget(
                label: context.appString.outOfStockMsgKey,
                style: context.textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w700,
                  color: MainConfig.appColors.redColor,
                  fontSize: Dimens.fontSize14,
                  height: Dimens.lineHeight16.toLineHeight(Dimens.fontSize14),
                ),
              ),
              const Spacer(),
              GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  onTap: () {},
                  child: Assets.svgs.icCloseIcon
                      .svg(height: Dimens.size16, width: Dimens.size16))
            ],
          ),
          const SizedBox(
            height: Dimens.size20,
          ),
          const OutOfStockRowItem(),
          const SizedBox(
            height: Dimens.size14,
          ),
          CustomDivider(
            height: Dimens.borderWidth05,
            color: MainConfig.appColors.dividerGreyColor,
          ),
          const SizedBox(
            height: Dimens.size14,
          ),
          CustomTextLabelWidget(
              onTap: () async {
                await showCustomBottomSheetView(
                    titleStyle: context.textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w700,
                      fontSize: Dimens.fontSize16,
                      height:
                          Dimens.lineHeight24.toLineHeight(Dimens.fontSize16),
                      color: AppColors.blackColor,
                    ),
                    backgroundColor: MainConfig.appColors.backgroundLightPinkColor,
                    context: context,
                    isFullScreenBottomSheet: true,
                    title: context.appString.outOfStockKey,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: Dimens.space16, vertical: Dimens.space27),
                      child: const OutOfStockRowItem(
                        itemCount: 16,
                        gapBetweenItem: Dimens.space16,
                      ),
                    ),
                    bothExtremeEnd: true);
              },
              label: context.appString.viewAllKey,
              style: context.textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w600,
                fontSize: Dimens.fontSize14,
                height: Dimens.lineHeight20.toLineHeight(Dimens.fontSize14),
                color: MainConfig.appColors.mainColor,
              ))
        ],
      ),
    );
  }
}
