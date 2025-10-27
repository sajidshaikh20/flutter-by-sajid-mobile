import '../../../../utils/exports.dart';

/// A widget that displays a shimmer effect for loading address-related data.
/// It adapts the layout based on the device type (mobile, tablet, or desktop).
class AddressShimmerShimmer extends StatelessWidget {

  /// Constructor for creating an `AddressShimmerShimmer` widget.
  /// The [device] argument determines the screen type (mobile, tablet, desktop).
  const AddressShimmerShimmer({super.key, this.device = ScreenType.mobile});

  /// The type of screen for adjusting the layout. Defaults to mobile.
  final ScreenType device;

  @override
  Widget build(BuildContext context) {
    EdgeInsetsGeometry outerMargin = Dimens.space10.padding;
    double shimmerMargin = Dimens.space10;

    switch (device) {
      case ScreenType.tablet:
        shimmerMargin = Dimens.space20;
        outerMargin = Dimens.space20.padding;
      case ScreenType.mobile:
      case ScreenType.desktop:
    }

    return ShimmerEffect(
      child: SizedBox(
        child: Column(
          children: <Widget>[
            Dimens.size10.heightBox,
            Container(
              margin: outerMargin,
              width: double.infinity,
              height: Dimens.size25,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  // First item with two elements
                  Row(
                    children: <Widget>[
                      Container(
                        width: Dimens.size120,
                        // Adjust the size as needed
                        height: Dimens.size25,
                        color: MainConfig.appColors.backgroundWhiteColor,
                      ),
                    ],
                  ),
                  // Last item with one element
                  Container(
                    width: Dimens.size70, // Adjust the size as needed
                    height: Dimens.size25,
                    color: MainConfig.appColors.backgroundWhiteColor,
                  ),
                ],
              ),
            ),
            Dimens.size5.heightBox,
            SizedBox(
              child: Padding(
                padding: EdgeInsets.only(
                  top: shimmerMargin,
                  left: shimmerMargin,
                  right: shimmerMargin,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const CheckOutCommonContainer(),
                    Dimens.size10.heightBox,
                    const CheckOutCommonContainer(),
                    Dimens.size10.heightBox,
                    const CheckOutCommonContainer(
                      width: Dimens.size200,
                    ),
                    Dimens.size10.heightBox,
                    const CheckOutCommonContainer(width: Dimens.size200),
                    Dimens.size10.heightBox,
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
