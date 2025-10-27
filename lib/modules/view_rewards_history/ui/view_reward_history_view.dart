
import '../../../utils/exports.dart';

/// Widget that displays the reward history view.
class ViewRewardHistoryView extends StatelessWidget {
  /// Creates a reward history view.
  const ViewRewardHistoryView({super.key, this.device = ScreenType.mobile});

  /// The screen type for responsive design.
  final ScreenType device;
  @override
  Widget build(BuildContext context) {
    double topHeight = Dimens.size20;
    double heightMobTab12_20 = Dimens.size12;
    double imageWidth = Dimens.size280;
    double rewardHistoryFontSize = Dimens.fontSize20;
    double totalRewardFontSize = Dimens.fontSize26;
    double heightMobTab20_50 = Dimens.size20;
    double noDataAvailableFontSize = Dimens.fontSize16;
    switch (device) {

      case ScreenType.tablet:
        topHeight = Dimens.size55;
        imageWidth = Dimens.size350;
        rewardHistoryFontSize = Dimens.fontSize26;
        totalRewardFontSize = Dimens.fontSize30;
        heightMobTab12_20 = Dimens.size20;
        heightMobTab20_50 = Dimens.size50;
        noDataAvailableFontSize = Dimens.fontSize20;
      default:
        break;
    }

    return PopScope(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: CustomAppBar(
          device: device,
          isLogoVisible: false,
        ),
        body: Column(
          children: <Widget>[
            Container(
              width: context.width,
              decoration:
                   BoxDecoration(color: MainConfig.appColors.mainColor),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  topHeight.heightBox,
                  Assets.svgs.icDukanSplashLogo
                      .svg(width: imageWidth),
                  heightMobTab12_20.heightBox,
                  CustomTextLabelWidget(
                    label: MainConfig.dynamicString(
                        JsonServiceString.keyRewardHistory),
                    style: context.textTheme.titleSmall?.copyWith(
                        fontSize: rewardHistoryFontSize,
                        color: MainConfig.appColors.textWhiteColor),
                  ),
                  Dimens.size3.heightBox,
                  BlocBuilder<ViewRewardHistoryCubit, ViewRewardHistoryState>(
                    builder: (BuildContext context, ViewRewardHistoryState state) {
                      return CustomTextLabelWidget(
                        label:
                            "${MainConfig.dynamicString(JsonServiceString.keyTotalRewards)} : ${state.count}",
                        style: context.textTheme.bodySmall?.copyWith(
                            fontSize: totalRewardFontSize,
                            color: MainConfig.appColors.textWhiteColor),
                      );
                    },
                  ),
                  heightMobTab20_50.heightBox,
                ],
              ),
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    height: context.height * Dimens.ratio02,
                  ),
                  SizedBox(
                    height: context.height * Dimens.ratio015,
                    child: CommonLottieAnimation(
                      assetPath: Assets.json.noOffer,
                      repeat: false,
                      fit: BoxFit.contain,
                    ),
                  ),
                  Container(
                    height: context.height * Dimens.ratio01,
                  ),
                  CustomTextLabelWidget(
                      label: MainConfig.dynamicString(
                          JsonServiceString.keyNoTransaction),
                      style: context.textTheme.headlineMedium?.copyWith(
                          fontSize: noDataAvailableFontSize,
                          color: MainConfig.appColors.textColorGreyBlack)),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
