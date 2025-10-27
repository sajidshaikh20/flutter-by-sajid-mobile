import '../../../../utils/exports.dart';

/// Widget that displays the header section of the loyalty points screen.
class LoyaltyPointsHeaderWidget extends StatelessWidget {
  /// Creates a loyalty points header widget.
  const LoyaltyPointsHeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: MainConfig.appColors.mainColor,
      width: double.infinity,
      child: Column(
        children: <Widget>[
          ProductDetailsAppBar(
            titleText: context.appString.loyaltyPointsKey,
            isLastWidgetDisplay: false,
            isShadowDisplay: false,
            titleColors: MainConfig.appColors.backgroundWhite,
            backgroundProductDetails: MainConfig.appColors.mainColor,
            prefixIcon: Assets.svgs.icBack
                .svg(colorFilter: ColorFilter.mode(MainConfig.appColors.backgroundWhite, BlendMode.srcIn)),
          ),
          Dimens.size20.heightBox,
          BlocBuilder<LoyaltyPointsCubit, LoyaltyPointsState>(
            buildWhen: (LoyaltyPointsState previous, LoyaltyPointsState current) {
              // Only rebuild when status changes
              return previous.status != current.status;
            },
            builder: (BuildContext context, LoyaltyPointsState state) {
              return Padding(
                padding: const EdgeInsets.only(
                    right: Dimens.space16,
                    left: Dimens.space16,
                    bottom: Dimens.space16),
                child: state.status==BaseStateStatus.success ?

                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Assets.svgs.icSilverCoin.svg(
                      height: Dimens.size75,
                      width: Dimens.size75,
                    ),
                    Dimens.size12.widthBox,
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          CustomTextLabelWidget(
                            textAlign: TextAlign.start,
                            label: context.appString.silverKey,
                            style: context.textTheme.headlineMedium?.copyWith(
                              color: MainConfig.appColors.textWhiteColor,
                              fontWeight: FontWeight.w700,
                              fontSize: Dimens.fontSize24,
                              height: Dimens.lineHeight28
                                  .toLineHeight(Dimens.fontSize24),
                            ),
                          ),
                          Directionality(
                            textDirection: TextDirection.ltr,
                            // Forces the text to stay LTR
                            child: CustomTextLabelWidget(
                              textAlign: TextAlign.start,
                              // Keep alignment consistent
                              label: AppConstant.pointsHistory,
                              style: context.textTheme.headlineMedium?.copyWith(
                                color: MainConfig.appColors.textWhiteColor,
                                fontWeight: FontWeight.w600,
                                fontSize: Dimens.fontSize18,
                                height: Dimens.lineHeight33
                                    .toLineHeight(Dimens.fontSize18),
                              ),
                            ),
                          ),
                          Dimens.size1.heightBox,
                          ProgressBar(
                            height: Dimens.size10,
                            color: MainConfig.appColors.secondaryColor,
                            max: AppConstant.max,
                            current: 20,
                          ),
                          Dimens.size8.heightBox,
                          createSpannableText(
                              defaultTextStyle:
                                  context.textTheme.headlineMedium?.copyWith(
                                color: MainConfig.appColors.textWhiteColor,
                                fontWeight: FontWeight.w400,
                                fontSize: Dimens.fontSize14,
                                height: Dimens.lineHeight18
                                    .toLineHeight(Dimens.fontSize14),
                              ),
                              boldTextStyle:
                                  context.textTheme.headlineMedium?.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.w700,
                                fontSize: Dimens.fontSize16,
                                height: Dimens.lineHeight16
                                    .toLineHeight(Dimens.fontSize16),
                              ),
                              context: context,
                              content:
                              AppConstant.loyaltyPointheaderNotes,
                              boldPhrases: <String>[AppConstant.loyaltyPointheaderBold2, AppConstant.loyaltyPointheaderBold1]),
                        ],
                      ),
                    )
                  ],
                ):const SilverPointsShimmerWidget(),
              );
            },
          ),
        ],
      ),
    );
  }
}
