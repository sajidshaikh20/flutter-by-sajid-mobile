import '../../../utils/exports.dart';

/// Widget that displays a horizontal list of store listings.
class StoreListingPage extends StatelessWidget {
  /// Creates a store listing page widget.
  const StoreListingPage({super.key});

  @override
  Widget build(BuildContext context) => MediaQuery.removePadding(
        context: context,
        removeLeft: true,
        child: NoInternetWidget(
          childWidget: ListView.builder(
            itemCount: AppConstant.recentLength,
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            itemBuilder: (BuildContext context, int index) => Container(
              margin: const EdgeInsets.only(
                bottom: Dimens.space35,
                right: Dimens.space10,
                left: Dimens.space15,
              ),
              height: Dimens.space140,
              width: Dimens.radius350,
              decoration: BoxDecoration(
                color: MainConfig.appColors.backgroundWhiteColor,
                borderRadius: Dimens.space20.borderRadius,
                border: Border.all(
                  color: MainConfig.appColors.borderColorWhite,
                ),
              ),
              child: Row(
                children: <Widget>[
                  Assets.svgs.icDukanSplashLogo
                      .svg(fit: BoxFit.fill, width: Dimens.space124),
                  Dimens.size10.widthBox,
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Dimens.size5.heightBox,
                        CustomTextLabelWidget(
                          label: MainConfig.dynamicString(
                            JsonServiceString.keyAlokozayShop,
                          ),
                          style: context.textTheme.headlineSmall?.copyWith(
                            fontSize: Dimens.space18,
                            color: MainConfig.appColors.textDarkBlueColor,
                          ),
                        ),
                        Dimens.size3.heightBox,
                        CustomTextLabelWidget(
                          label: AppConstant.staticAddress,
                          style: context.textTheme.bodySmall?.copyWith(
                            fontSize: Dimens.space14,
                            color: MainConfig.appColors.textLabelGreyColor,
                          ),
                          textAlign: TextAlign.start,
                        ),
                        Dimens.size15.heightBox,
                        CustomTextLabelWidget(
                          label: AppConstant.staticMiles,
                          style: context.textTheme.headlineSmall?.copyWith(
                            fontSize: Dimens.space13,
                            color: MainConfig.appColors.textLightBlueColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Dimens.size10.widthBox,
                ],
              ),
            ),
          ),
        ),
      );
}
