import '../../../../utils/exports.dart';

/// Widget that displays the main loyalty points page with header and content.
class LoyaltyPointsPageWidget extends BaseResponsiveView {
  /// Creates a loyalty points page widget.
  const LoyaltyPointsPageWidget({super.key});

  Widget _buildView(BuildContext context) {
    return
      Scaffold(
        backgroundColor: MainConfig.appColors.background,
        body: Column(
          children: <Widget>[
            // Sticky Header
            const LoyaltyPointsHeaderWidget(),

            // Scrollable content
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      color: MainConfig.appColors.iceBlueColor,
                      width: double.infinity,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(
                              right: Dimens.space16,
                              left: Dimens.space16,
                              top: Dimens.space3,
                              bottom: Dimens.space10,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    CustomTextLabelWidget(
                                      textAlign: TextAlign.start,
                                      label: context.appString.pointsHistoryKey,
                                      style: context.textTheme.headlineMedium
                                          ?.copyWith(
                                        color:
                                        MainConfig.appColors.textBlackColor,
                                        fontWeight: FontWeight.w700,
                                        fontSize: Dimens.fontSize16,
                                        height: Dimens.lineHeight24
                                            .toLineHeight(Dimens.fontSize16),
                                      ),
                                    ),
                                    CustomTextLabelWidget(
                                      textAlign: TextAlign.start,
                                      label: context.appString.lastActivitiesKey,
                                      style: context.textTheme.headlineMedium
                                          ?.copyWith(
                                        color:
                                        MainConfig.appColors.textBlackColor,
                                        fontWeight: FontWeight.w400,
                                        fontSize: Dimens.fontSize12,
                                        height: Dimens.lineHeight14
                                            .toLineHeight(Dimens.fontSize12),
                                      ),
                                    ),
                                  ],
                                ),
                                CustomTextLabelWidget(
                                  onTap: () async {
                                    await context.router
                                        .push(const PointsHistoryRoute());
                                  },
                                  textAlign: TextAlign.start,
                                  label: context.appString.seeAllActivitiesKey,
                                  style:
                                  context.textTheme.headlineMedium?.copyWith(
                                    color: MainConfig.appColors.mainColor,
                                    fontWeight: FontWeight.w500,
                                    fontSize: Dimens.fontSize14,
                                    height: Dimens.lineHeight18
                                        .toLineHeight(Dimens.fontSize14),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Dimens.size11.heightBox,
                          Padding(
                            padding: EdgeInsets.only(
                                left: context.isEnglishLanguage
                                    ? Dimens.space16
                                    : Dimens.space0,
                                right: context.isEnglishLanguage
                                    ? Dimens.space0
                                    : Dimens.space16),
                            child: const PointsHistoryHorizontalList(),
                          ),
                          Dimens.size11.heightBox,
                          Padding(
                            padding: const EdgeInsets.only(
                              right: Dimens.space16,
                              left: Dimens.space16,
                              top: Dimens.space3,
                              bottom: Dimens.space10,
                            ),
                            child: CustomTextLabelWidget(
                              textAlign: TextAlign.start,
                              label: AppConstant.pointsExpiryDate,
                              style: context.textTheme.headlineMedium?.copyWith(
                                color: MainConfig.appColors.textBlackColor,
                                fontWeight: FontWeight.w400,
                                fontSize: Dimens.fontSize12,
                                height: Dimens.lineHeight14
                                    .toLineHeight(Dimens.fontSize12),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Dimens.space24.heightBox,
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: Dimens.space17,
                      ),
                      child: CustomTextLabelWidget(
                        textAlign: TextAlign.start,
                        label: context.appString.howItWorksKey,
                        style: context.textTheme.headlineMedium?.copyWith(
                          color: MainConfig.appColors.textBlackColor,
                          fontWeight: FontWeight.w700,
                          fontSize: Dimens.fontSize16,
                          height:
                          Dimens.lineHeight24.toLineHeight(Dimens.fontSize16),
                        ),
                      ),
                    ),
                    Dimens.space21.heightBox,
                    CustomListView(
                      isPadding: true,
                      scrollPhysics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (BuildContext p0, int p1) {
                        return Padding(
                          padding: EdgeInsets.only(
                            left: Dimens.space16,
                            right: Dimens.space16,
                            top: (p1 == 0) ? Dimens.space0 : Dimens.space14,
                            bottom: (p1 ==
                                AppConstant.membershipTiers.length - 1)
                                ? Dimens.space0
                                : Dimens.space14,
                          ),
                          child: HowItsWorkedCardWidget(
                            membershipTierModelTier:
                            AppConstant.membershipTiers[p1],
                          ),
                        );
                      },
                      itemCount: AppConstant.membershipTiers.length,
                    ),
                    Dimens.size29.heightBox,
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: Dimens.space17,
                      ),
                      child: CustomTextLabelWidget(
                        textAlign: TextAlign.start,
                        label: context.appString.pointExpiryNoteKey,
                        style: context.textTheme.headlineMedium?.copyWith(
                          color: MainConfig.appColors.textBlackColor,
                          fontWeight: FontWeight.w700,
                          fontSize: Dimens.fontSize12,
                          height:
                          Dimens.lineHeight14.toLineHeight(Dimens.fontSize12),
                        ),
                      ),
                    ),
                    Dimens.space5.heightBox,
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: Dimens.space17,
                      ),
                      child: CustomTextLabelWidget(
                        textAlign: TextAlign.start,
                        label:
                       AppConstant.pointsExpiryNote ,
                        style: context.textTheme.headlineMedium?.copyWith(
                          color: MainConfig.appColors.textBlackColor,
                          fontWeight: FontWeight.w400,
                          fontSize: Dimens.fontSize12,
                          height:
                          Dimens.lineHeight14.toLineHeight(Dimens.fontSize12),
                        ),
                      ),
                    ),
                    Dimens.space20.heightBox,
                  ],
                ),
              ),
            ),
          ],
        ),
      );
  }

  @override
  Widget buildDesktopWidget(BuildContext context) {
   return  _buildView(context);
  }

  @override
  Widget buildMobileWidget(BuildContext context) {
    return  _buildView(context);
  }

  @override
  Widget buildTabletWidget(BuildContext context) {
    return  _buildView(context);
  }
}
