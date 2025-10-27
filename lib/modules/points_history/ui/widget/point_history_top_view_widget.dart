import '../../../../utils/exports.dart';

/// Widget that displays the top view of points history with header and balance.
class PointHistoryTopViewWidget extends StatelessWidget {
  /// Creates a point history top view widget.
  const PointHistoryTopViewWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: MainConfig.appColors.mainColor,
      width: double.infinity,
      child: Column(
        children: <Widget>[
          ProductDetailsAppBar(
            titleText: context.appString.pointsHistoryKey,
            isLastWidgetDisplay: false,
            isShadowDisplay: false,
            titleColors: MainConfig.appColors.backgroundWhite,
            backgroundProductDetails: MainConfig.appColors.mainColor,
            prefixIcon: Assets.svgs.icBack
                .svg(colorFilter: ColorFilter.mode(MainConfig.appColors.backgroundWhite, BlendMode.srcIn)),
          ),
          // Dimens.size20.heightBox,
          Padding(
            padding: const EdgeInsets.only(
                top: Dimens.space23, bottom: Dimens.space22),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Column(
                    children: <Widget>[
                      Directionality(
                        textDirection: TextDirection.ltr,
                        child: CustomTextLabelWidget(
                          textAlign: TextAlign.start,
                          label: AppConstant.pointsHistory,
                          style: context.textTheme.headlineMedium?.copyWith(
                            color: MainConfig.appColors.textWhiteColor,
                            fontWeight: FontWeight.w700,
                            fontSize: Dimens.fontSize24,
                            height: Dimens.lineHeight28
                                .toLineHeight(Dimens.fontSize24),
                          ),
                        ),
                      ),
                      Dimens.size8.heightBox,
                      CustomTextLabelWidget(
                        textAlign: TextAlign.start,
                        label: context.appString.totalPointsKey,
                        style: context.textTheme.headlineMedium?.copyWith(
                          color: MainConfig.appColors.textWhiteColor,
                          fontWeight: FontWeight.w500,
                          fontSize: Dimens.fontSize12,
                          height: Dimens.lineHeight14
                              .toLineHeight(Dimens.fontSize12),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
