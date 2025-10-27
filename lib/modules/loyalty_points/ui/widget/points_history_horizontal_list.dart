import '../../../../utils/exports.dart';

/// Widget that displays a horizontal list of points history items.
class PointsHistoryHorizontalList extends StatelessWidget {
  /// Creates a points history horizontal list widget.
  const PointsHistoryHorizontalList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoyaltyPointsCubit, LoyaltyPointsState>(
      buildWhen: (LoyaltyPointsState previous, LoyaltyPointsState current) {
        // Only rebuild when status changes
        return previous.status != current.status;
      },
      builder: (BuildContext context, LoyaltyPointsState state) {
        return state.status==BaseStateStatus.success ?
        SizedBox(
          height: Dimens.size80,
          child: CustomListView(
            scrollDirection: Axis.horizontal,
            itemBuilder: (BuildContext context, int index) {
              return Padding(
                padding: EdgeInsets.only(
                    right: context.isEnglishLanguage ? Dimens.size8 : Dimens
                        .size0,
                    left: context.isEnglishLanguage ? Dimens.size0 : Dimens
                        .size8),
                child:
                Container(
                  width: Dimens.space131,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: MainConfig.appColors.lightGreyColor,
                      width: Dimens.borderWidth05,
                    ),
                    borderRadius:
                    const BorderRadius.all(Radius.circular(Dimens.space8)),
                    color: MainConfig.appColors.backgroundWhite,
                  ),
                  child: Row(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(
                            top: Dimens.space10, bottom: Dimens.space11),
                        child: Container(
                          width: Dimens.size1,
                          decoration: BoxDecoration(
                            color: index == 2
                                ? MainConfig.appColors.redColor
                                : MainConfig.appColors.greenColor,
                            borderRadius: BorderRadius.only(
                                topRight: context.isEnglishLanguage
                                    ? Dimens.radius8.circularRadius
                                    : Radius.zero,
                                // Top-right corner radius
                                bottomRight: context.isEnglishLanguage
                                    ? Dimens.radius8.circularRadius
                                    : Radius.zero,
                                bottomLeft: context.isEnglishLanguage
                                    ? Radius.zero
                                    : Dimens.radius8.circularRadius,
                                topLeft: context.isEnglishLanguage
                                    ? Radius.zero
                                    : Dimens.radius8.circularRadius),
                          ),
                        ),
                      ),
                      Dimens.size5.widthBox,
                      Padding(
                        padding: const EdgeInsets.only(top: Dimens.size7),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            CustomTextLabelWidget(
                              textDirection: TextDirection.ltr,
                              textAlign: TextAlign.start,
                              label: index == 2
                                  ? '- 20'
                                  : '+ 20',
                              style: context.textTheme.headlineMedium?.copyWith(
                                fontWeight: FontWeight.w700,
                                fontSize: Dimens.fontSize14,
                                color: index == 2
                                    ? MainConfig.appColors.redColor
                                    : MainConfig.appColors.greenColor,
                                height: Dimens.lineHeight16
                                    .toLineHeight(Dimens.fontSize14),
                              ),
                            ),
                            CustomTextLabelWidget(
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.start,
                              label: index == 2
                                  ? context.appString.pointsRedeemedKey
                                  : context.appString.pointsEarnedKey,
                              style: context.textTheme.headlineMedium?.copyWith(
                                fontWeight: FontWeight.w600,
                                color: index == 2
                                    ? MainConfig.appColors.redColor
                                    : MainConfig.appColors.textBlackColor,
                                fontSize: Dimens.fontSize14,
                                height: Dimens.lineHeight18
                                    .toLineHeight(Dimens.fontSize14),
                              ),
                            ),
                            CustomTextLabelWidget(
                              textDirection: TextDirection.ltr,
                              textAlign: getTextAlign(context),
                              label: AppConstant.pointsHistoryDate,
                              style: context.textTheme.headlineMedium?.copyWith(
                                fontWeight: FontWeight.w400,
                                color: MainConfig.appColors.creyColor,
                                fontSize: Dimens.fontSize11,
                                height: Dimens.lineHeight14
                                    .toLineHeight(Dimens.fontSize11),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
            itemCount: Dimens.itemCount3,
          ),
        ) : const HorizontalPointsShimmerWidget();
      },
    );
  }
}
