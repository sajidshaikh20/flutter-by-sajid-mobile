import '../../../../utils/exports.dart';

/// A widget that displays a shimmer effect for the delivery section.
/// This widget serves as a loading placeholder while
/// delivery data is being fetched.
class DeliveryShimmerWidget extends StatelessWidget {
  /// Constructor for the `DeliveryShimmerWidget` widget.
  /// It takes an optional `device` parameter to
  /// adjust layout based on the screen type.
  const DeliveryShimmerWidget({super.key, this.device = ScreenType.mobile});

  ///device type for the screen type
  final ScreenType device;

  @override
  Widget build(BuildContext context) {
    // Define default sizes for mobile and tablet screen types
    double widthMobtab2040 = Dimens.size20;
    double widthMobtab80160 = Dimens.size80;
    double heightboxMobtab1020 = Dimens.size10;

    // Adjust sizes based on device type
    switch (device) {
      case ScreenType.tablet:
        widthMobtab80160 = Dimens.size160;
        widthMobtab2040 = Dimens.size40;
        heightboxMobtab1020 = Dimens.size20;

      case ScreenType.mobile:
      case ScreenType.desktop:
    }

    // Return shimmer effect with padding and a column of placeholder containers
    return ShimmerEffect(
      child: Padding(
        padding: Dimens.space20.padding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // Placeholder for the first delivery item
            CommonContainer(
              padding: EdgeInsets.zero,
              height: widthMobtab2040,
              width: widthMobtab80160,
              backgroundColor: MainConfig.appColors.backgroundWhiteColor,
            ),
            Dimens.space12.heightBox,
            // Placeholder for the second delivery item
            CommonContainer(
              padding: EdgeInsets.zero,
              height: heightboxMobtab1020,
              width: double.maxFinite,
              backgroundColor: MainConfig.appColors.backgroundWhiteColor,
            ),
            Dimens.space12.heightBox,
            // Placeholder for the third delivery item
            CommonContainer(
              padding: EdgeInsets.zero,
              height: heightboxMobtab1020,
              width: double.maxFinite,
              backgroundColor: MainConfig.appColors.backgroundWhiteColor,
            ),
          ],
        ),
      ),
    );
  }
}
