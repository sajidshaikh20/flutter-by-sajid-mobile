import '../../../utils/exports.dart';
/// Shimmer widget for displaying a placeholder of the category section.
///
/// This widget is used while category data is loading. It provides a
/// skeleton UI to indicate that content is being fetched.
///
/// [device] determines the screen type (mobile, tablet, web) to adjust
/// the layout accordingly.
class CategoryWidgetShimmer extends StatelessWidget {
  ///CategoryWidgetShimmer
  const CategoryWidgetShimmer({super.key, this.device = ScreenType.mobile});


  ///device
  final ScreenType? device;

  @override
  Widget build(BuildContext context) {
    double heightMobTab100_140 = Dimens.size110;
    double categoryImageSize = Dimens.size65;

    switch (device) {
      case ScreenType.tablet:
        heightMobTab100_140 = Dimens.size140;
        categoryImageSize = Dimens.size97;

      default:
        break;
    }

    return ShimmerEffectWidget(
      child: SizedBox(
        height: heightMobTab100_140,
        child: Align(
          alignment: Alignment.centerLeft,
          child: ListView.builder(
            itemBuilder: (BuildContext context, int index) {
              return Padding(
                padding: EdgeInsets.only(
                  left: index == AppConstant.zero
                      ? Dimens.space16
                      : Dimens.space4,
                  right: index == (AppConstant.shimmerCategoryLength - 1)
                      ? Dimens.space16
                      : Dimens.space4,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    SizedBox(
                      width: categoryImageSize,
                      child: Card(
                        surfaceTintColor: MainConfig.appColors.backgroundWhiteColor,
                        elevation: Dimens.elevation4,
                        clipBehavior: Clip.hardEdge,
                        color: MainConfig.appColors.backgroundWhiteColor
                            .withValues(alpha:Dimens.opacity06),
                        shadowColor: MainConfig.appColors.backgroundGreyColor
                            .withValues(alpha:Dimens.opacity06),
                        child: SizedBox(
                          height: categoryImageSize,
                          width: categoryImageSize,
                        ),
                      ),
                    ),
                    Dimens.size5.heightBox,
                    Container(
                      height: Dimens.size10,
                      width: categoryImageSize / 2,
                      color: MainConfig.appColors.backGroundShimmerBaseColor,
                    ),
                  ],
                ),
              );
            },
            itemCount: AppConstant.shimmerCategoryLength,
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
          ),
        ),
      ),
    );
  }
}
