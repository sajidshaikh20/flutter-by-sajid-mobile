import '../../../../utils/exports.dart';

/// A stateless widget that displays a shimmer effect for the bottom part of the cart page.
class BottomShimmerWidget extends StatelessWidget {
  /// Creates a [BottomShimmerWidget].
  ///
  /// The [device] parameter determines the layout based on the screen type.
  const BottomShimmerWidget({
    super.key,
    this.device = ScreenType.mobile,
  });
/// Determines the layout based on the screen type.
  final ScreenType device;

  @override
  Widget build(BuildContext context) {
    double widthMobTab100_150 = Dimens.size100;
    double btnHeight = Dimens.size50;
    double btnWidth = double.infinity;

    EdgeInsets padding = const EdgeInsets.symmetric(horizontal: Dimens.space12, vertical: Dimens.space5);
    switch (device) {
      case ScreenType.tablet:
        widthMobTab100_150 = Dimens.size150;
        padding = const EdgeInsets.symmetric(horizontal: Dimens.space24, vertical: Dimens.space20);
        btnHeight = Dimens.size87;
        btnWidth = Dimens.size220;
       
      default:
        break;
    }

    return ShimmerEffectWidget(
      child: Container(
        width: btnWidth,
        height: btnHeight,
        padding: padding,
        decoration: BoxDecoration(
          borderRadius: Dimens.radius4.borderRadius,
          border:  Border.symmetric(
            horizontal: BorderSide(
              color: MainConfig.appColors.borderLightWhiteColor,
            ),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            // First item with two elements
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Container(
                      width: widthMobTab100_150,
                      // Adjust the size as needed
                      height: Dimens.size15,
                      color: MainConfig.appColors.backgroundWhiteColor,
                    ),
                  ],
                ),
                Row(
                  children: <Widget>[
                    Container(
                      width: Dimens.size70, // Adjust the size as needed
                      height: Dimens.size15,
                      color: MainConfig.appColors.backgroundWhiteColor,
                    ),
                    Dimens.size5.widthBox,
                    // Add spacing between the two items
                    Container(
                      width: Dimens.size70, // Adjust the size as needed
                      height: Dimens.size15,
                      color: MainConfig.appColors.backgroundWhiteColor,
                    ),
                  ],
                ),
              ],
            ),
            // Last item with one element
            Container(
              width: widthMobTab100_150, // Adjust the size as needed
              height: Dimens.size18,
              color: MainConfig.appColors.backgroundWhiteColor,
            ),
          ],
        ),
      ),
    );
  }
}
