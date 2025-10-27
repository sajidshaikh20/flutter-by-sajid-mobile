import '../../../utils/exports.dart';

/// Widget that displays the refer a friend interface with sharing options.
class ReferFriendView extends StatelessWidget {
  /// Creates a refer friend view widget.
  const ReferFriendView({super.key, this.device = ScreenType.mobile});

  /// The screen type for responsive design.
  final ScreenType device;

  @override
  Widget build(BuildContext context) {
    switch (device) {
      case ScreenType.tablet:
        break;
      default:
        break;
    }

    return Scaffold(
      backgroundColor: MainConfig.appColors.backgroundWhiteColor,
      resizeToAvoidBottomInset: false,
      body: Column(
        children: <Widget>[
          ProductDetailsAppBar(
            titleText: context.appString.inviteFriendKey,
            isLastWidgetDisplay: false,
            titleColors: AppColors.whiteColor,
            prefixIcon: Assets.svgs.icBack.svg(colorFilter: const ColorFilter.mode(AppColors.whiteColor, BlendMode.srcIn)),
            backgroundProductDetails: MainConfig.appColors.mainColor,
          ),
          FlippableSvgBackground(assetPath: Assets.svgs.icNewRefer.path),
          Expanded(
              child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                ProductCodeView(
                  device: device,
                ),
                Dimens.size47.heightBox,
                CustomTextLabelWidget(
                  label: "${context.appString.termsAndConditionKey}*",
                  style: context.textTheme.titleLarge?.copyWith(
                      height:
                          Dimens.lineHeight16.toLineHeight(Dimens.fontSize12),
                      fontWeight: FontWeight.w600,
                      color: MainConfig.appColors.textBlackColor,
                      fontSize: Dimens.fontSize12),
                ),
                Dimens.size2.heightBox,
                Padding(
                  padding: const EdgeInsets.only(
                    left: Dimens.size32,
                    right: Dimens.size32,
                    bottom: Dimens.space10
                  ),
                  child: CustomTextLabelWidget(
                    style: context.textTheme.titleLarge?.copyWith(
                        height:
                            Dimens.lineHeight14.toLineHeight(Dimens.fontSize12),
                        fontWeight: FontWeight.w400,
                        color: MainConfig.appColors.textBlackColor,
                        fontSize: Dimens.fontSize12),
                    label: context.appString.refCodeDescKey,
                  ),
                )
              ],
            ),
          ))
        ],
      ),
    );
  }
}
