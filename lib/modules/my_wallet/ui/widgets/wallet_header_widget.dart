import '../../../../utils/exports.dart';

/// A widget that displays the wallet header with a logo, title,
/// and wallet amount.
class WalletHeaderWidget extends StatelessWidget {
  /// A widget that displays the wallet header with a logo, title,
  /// and wallet amount.

  const WalletHeaderWidget({
    required this.walletAmount, // The amount displayed in the wallet
    super.key,
    this.device = ScreenType
        .mobile, // The device type for UI adjustments (mobile, tablet, desktop)
  });

  /// The amount of money in the wallet
  final String walletAmount;

  /// The device type for responsive UI
  final ScreenType device;

  @override
  Widget build(BuildContext context) {
    bool isEnglish = context.isEnglishLanguage;

    // The widget builds a container with the logo, title, and wallet amount
    return SizedBox(
      width: context.width,
      height: Dimens.size182,
      // Sets the width of the container to match the screen width
      child: Stack(
        children: <Widget>[
          Positioned.fill(
            child: FlippableSvgBackground(
                assetPath: Assets.svgs.bgGradientWalletHistory.path),
          ),
          Positioned(
              bottom: Dimens.space5,
              right: isEnglish ? 0 : null,
              left: isEnglish ? null : 0,
              child: SvgPicture.asset(
                height: Dimens.size128,
                width: Dimens.size128,
                Assets.svgs.icWalletHeader.path,
                fit: BoxFit.cover, // Adjust the fit as per your requirement
              )),
          Column(
            children: <Widget>[
              ProductDetailsAppBar(
                backgroundProductDetails: MainConfig.appColors.transparent,
                titleText: context.appString.myWalletKey,
                isLastWidgetDisplay: false,
                isShadowDisplay: false,
                titleColors: MainConfig.appColors.textWhiteColor,
                prefixIcon: Assets.svgs.icBack.svg(
                    colorFilter: ColorFilter.mode(
                        MainConfig.appColors.backgroundWhite, BlendMode.srcIn)),
              ),
              //  const SizedBox(height: Dimens.size13,),
              CustomTextLabelWidget(
                textDirection: TextDirection.ltr,
                maxLines: Dimens.maxLines01,
                overflow: TextOverflow.ellipsis,
                label: AppConstant.dummyProductPrice3,
                style: context.textTheme.bodyMedium?.copyWith(
                  color: MainConfig.appColors.darkYellowTextColor,
                  fontWeight: FontWeight.w700,
                  height: Dimens.lineHeight28.toLineHeight(Dimens.fontSize24),
                  fontSize: Dimens.fontSize24,
                ),
              ),
              const SizedBox(
                height: Dimens.size8,
              ),
              CustomTextLabelWidget(
                maxLines: Dimens.maxLines01,
                overflow: TextOverflow.ellipsis,
                label: context.appString.yourWalletBalanceKey,
                style: context.textTheme.bodyMedium?.copyWith(
                  color: MainConfig.appColors.textWhiteColor,
                  fontWeight: FontWeight.w500,
                  height: Dimens.lineHeight14.toLineHeight(Dimens.fontSize12),
                  fontSize: Dimens.fontSize12,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
