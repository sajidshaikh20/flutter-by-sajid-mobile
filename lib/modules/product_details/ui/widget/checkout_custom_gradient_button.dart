import '../../../../utils/exports.dart';

/// Custom gradient button widget for checkout functionality.
class CheckoutCustomGradientButton extends StatelessWidget {
  /// The title text displayed on the button.
  final String? title;

  /// The width of the button.
  final double btnWidth;

  /// Callback function called when the button is pressed.
  final VoidCallback? onButtonPressed;

  /// The amount with currency to display on the button.
  final String? amountWithCurrency;

  /// Whether the button is enabled for interaction.
  final bool isButtonEnabled;

  /// Creates a custom gradient button for checkout.
  const CheckoutCustomGradientButton({
    super.key,
    this.title,
    this.onButtonPressed,
    this.btnWidth = Dimens.size138,
    this.amountWithCurrency,
    this.isButtonEnabled = true,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isButtonEnabled ? onButtonPressed : null,
      child: SizedBox(
        height: Dimens.size44,
        width: btnWidth,
        child: ClipRRect(
          borderRadius: Dimens.space6.borderRadius,
          child: isButtonEnabled
              ? Stack(
                  fit: StackFit.expand,
                  children: <Widget>[
                    // SVG Background
                    FlippableSvgBackground(assetPath: Assets.svgs.bgGradient.path),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: Dimens.space14, ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              CustomTextLabelWidget(
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.start,
                                maxLines: Dimens.maxLines01,
                                label: context.appString.totalKey,
                                style: context.textTheme.displayMedium?.copyWith(
                                  fontWeight: FontWeight.w500,
                                  fontSize: Dimens.fontSize12,
                                  height: Dimens.lineHeight14
                                      .toLineHeight(Dimens.fontSize12),
                                  color: AppColors.whiteColor,
                                ),
                              ),
                              CustomTextLabelWidget(
                                maxLines: Dimens.maxLines01,
                                overflow: TextOverflow.ellipsis,
                                label: amountWithCurrency ?? "",
                                style: context.textTheme.headlineMedium?.copyWith(
                                  fontSize: Dimens.fontSize12,
                                  fontWeight: FontWeight.w700,
                                  height: Dimens.lineHeight14
                                      .toLineHeight(Dimens.fontSize12),
                                  color: AppColors.whiteColor,
                                ),
                              ),
                            ],
                          ),
                          buttonTextWidget(context,isEnabled:  true)
                        ],
                      ),
                    )
                  ],
                )
              : DecoratedBox(
                  decoration: BoxDecoration(
                    color: MainConfig.appColors.disablegreyColor,
                    borderRadius: Dimens.space6.borderRadius,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: Dimens.space14, ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            CustomTextLabelWidget(
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.start,
                              maxLines: Dimens.maxLines01,
                              label: context.appString.totalKey,
                              style: context.textTheme.displayMedium?.copyWith(
                                fontWeight: FontWeight.w500,
                                fontSize: Dimens.fontSize12,
                                height: Dimens.lineHeight14
                                    .toLineHeight(Dimens.fontSize12),
                                color: MainConfig.appColors.disableTextColor,
                              ),
                            ),
                            CustomTextLabelWidget(
                              maxLines: Dimens.maxLines01,
                              overflow: TextOverflow.ellipsis,
                              label: amountWithCurrency ?? "",
                              style: context.textTheme.headlineMedium?.copyWith(
                                fontSize: Dimens.fontSize12,
                                fontWeight: FontWeight.w700,
                                height: Dimens.lineHeight14
                                    .toLineHeight(Dimens.fontSize12),
                                color: MainConfig.appColors.disableTextColor,
                              ),
                            ),
                          ],
                        ),
                        buttonTextWidget(context,isEnabled:  false)
                      ],
                    ),
                  ),
                ),
        ),
      ),
    );
  }

  /// Builds the text widget for the button based on enabled state.
  Widget buttonTextWidget(BuildContext context, {required bool isEnabled}) {
    return Center(
      child: CustomTextLabelWidget(
        maxLines: Dimens.maxLines01,
        label: title ?? "",
        overflow: TextOverflow.ellipsis,
        style: context.textTheme.headlineMedium?.copyWith(
          color: isEnabled
              ? MainConfig.appColors.backgroundWhiteColor
              : MainConfig.appColors.disableTextColor,
          fontWeight: FontWeight.w700,
          height: Dimens.lineHeight24.toLineHeight(Dimens.fontSize16),
          fontSize: Dimens.fontSize16,
        ),
      ),
    );
  }

}
