import '../../../../utils/exports.dart';

/// Shimmer loading widget for the entire product details screen.
class ProDuctDetailsShimmer extends StatelessWidget {
  /// Creates a shimmer loading widget for product details.
  const ProDuctDetailsShimmer({super.key,this.device=ScreenType.mobile});

  /// The screen type for responsive design.
  final ScreenType device;
  @override
  Widget build(BuildContext context) {
    double spaceMobTab10_15=Dimens.space10;
    double sizeMobTab40_50=Dimens.size40;
    double sizeMobTab30_40=Dimens.size30;
    double sizeMobTab20_28=Dimens.size20;
    double sizeMobTab100_140=Dimens.size100;
double sizeMobTab10_15=Dimens.size10;
double sizeMobTab250_350=Dimens.size250;
    switch(device){
      case ScreenType.tablet:
        sizeMobTab250_350=Dimens.size350;
        sizeMobTab10_15=Dimens.size15;
        spaceMobTab10_15=Dimens.space15;
        sizeMobTab40_50=Dimens.size50;
        sizeMobTab30_40=Dimens.size40;
        sizeMobTab20_28=Dimens.size28;
        sizeMobTab100_140=Dimens.size140;

      default:
        break;
    }
    return ShimmerEffectWidget(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            // Top Placeholder for Text
            Padding(
              padding: spaceMobTab10_15.padding,
              child: containerGreyColor300(sizeMobTab40_50),
            ),
            // Large Image Placeholder
            Padding(
              padding:  EdgeInsets.symmetric(horizontal: spaceMobTab10_15),
              child: Container(
                height: sizeMobTab250_350, // Adjust according to design
                color: AppColors.shimmerBaseDarkColor
                    , // Placeholder for image
              ),
            ),
            // Text beside a block, as seen on the right
            Padding(
              padding:  EdgeInsets.only(
                  top: spaceMobTab10_15,
                  left: spaceMobTab10_15,
                  right: spaceMobTab10_15),
              child: Row(
                children: <Widget>[
                  Expanded(
                    flex: Dimens.flex3,
                    child: Container(
                      height: sizeMobTab40_50, // Adjust height
                      color: Colors.transparent, // Empty space
                    ),
                  ),
                  Expanded(

                    child: containerGreyColor300(
                      sizeMobTab30_40, // Adjust height
                    ),
                  ),
                ],
              ),
            ),
            // Full-width Text Placeholder
            Padding(
              padding: spaceMobTab10_15.padding,
              child: containerGreyColor300(
                sizeMobTab30_40,
              ),
            ),
            // Row for buttons or options
            Padding(
              padding:  EdgeInsets.symmetric(horizontal: spaceMobTab10_15),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: containerGreyColor300(sizeMobTab40_50),
                  ),
                  sizeMobTab10_15.widthBox,
                  Expanded(
                    child: containerGreyColor300(sizeMobTab40_50),
                  ),
                  sizeMobTab10_15.widthBox,
                  Expanded(
                    child: containerGreyColor300(sizeMobTab40_50),
                  ),
                ],
              ),
            ),
            // Another Text or Section Placeholder
            Padding(
              padding: spaceMobTab10_15.padding,
              child: containerGreyColor300(
                sizeMobTab30_40,
              ),
            ),
            // A wide text block (similar to a large paragraph)
            Padding(
              padding:  EdgeInsets.symmetric(horizontal: spaceMobTab10_15),
              child: Container(
                height: sizeMobTab100_140, // Adjust height
                color: MainConfig.appColors.backgroundShimmerGreyColor[
                    400], // Placeholder for large text section
              ),
            ),
            // Multiple Text Rows (smaller text)
            Padding(
              padding: spaceMobTab10_15.padding,
              child: Column(
                children: <Widget>[
                  containerGreyColor300(
                    sizeMobTab20_28,
                  ),
                  sizeMobTab10_15.heightBox,
                  containerGreyColor300(sizeMobTab20_28),
                ],
              ),
            ),
            // Bottom Slider or Controls Placeholder
            Padding(
              padding: spaceMobTab10_15.padding,
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: containerGreyColor300(sizeMobTab40_50),
                  ),
                ],
              ),
            ),
            // Extra Spacing for any additional widgets or controls
            sizeMobTab20_28.heightBox,
          ],
        ),
      ),
    );
  }

  /// Creates a container with grey background color for shimmer effect.
  Container containerGreyColor300(double size) {
    return Container(
      height: size, // Adjust height
      color:AppColors.shimmerBaseColor
          , // Placeholder for button 1
    );
  }
}
