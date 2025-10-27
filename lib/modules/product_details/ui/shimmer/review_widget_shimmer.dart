
import '../../../../utils/exports.dart';

/// Shimmer version of the ReviewWidget
class ReviewWidgetShimmer extends StatelessWidget {
  /// The screen type for responsive design.
  final ScreenType device;

  /// Creates a shimmer loading widget for review widget.
  const ReviewWidgetShimmer({super.key, this.device = ScreenType.mobile});

  @override
  Widget build(BuildContext context) {
    double ratingIconSize = Dimens.space16;
    double ratingTextFontSize = Dimens.fontSize14;

    // You can customize the shimmer colors or use your MainConfig colors
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Dimens.space16),
      child: Container(
        height: Dimens.size136,
        decoration: BoxDecoration(
          color: MainConfig.appColors.lightestGreyColor,
          borderRadius: BorderRadius.circular(Dimens.space8),
        ),
        child: ShimmerEffectWidget(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              // Left column shimmer for rating number, star indicator, and text
              Padding(
                padding: EdgeInsets.only(
                  left: isLanguageAlignmentLTR ? Dimens.space8 : Dimens.space0,
                  right: isLanguageAlignmentLTR ? 0 : Dimens.space8,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    // Placeholder for rating number
                    Container(
                      width: Dimens.size60,
                      height: Dimens.size40,
                      color: Colors.white,
                    ),
                    const SizedBox(height: Dimens.size8),
                    // Placeholder for rating star indicator
                    Container(
                      width: ratingIconSize,
                      height: ratingIconSize,
                      color: Colors.white,
                    ),
                    const SizedBox(height: Dimens.size8),
                    // Placeholder for reviews text
                    Container(
                      width: Dimens.size80,
                      height: ratingTextFontSize,
                      color: Colors.white,
                    ),
                  ],
                ),
              ),
              const SizedBox(width: Dimens.size24),
          
              // Right side shimmer list for review rows
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(right: Dimens.size21),
                  child: ListView.builder(
                    padding:  EdgeInsets.zero,
                      shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: AppConstant.itemCount5 ,
                    itemBuilder: (BuildContext context, int index) {
                      return ReviewRowShimmerWidget(device: device);
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Shimmer version of a single review row
class ReviewRowShimmerWidget extends StatelessWidget {
  /// The screen type for responsive design.
  final ScreenType device;

  /// Creates a shimmer loading widget for review row.
  const ReviewRowShimmerWidget({super.key, this.device = ScreenType.mobile});

  @override
  Widget build(BuildContext context) {
    double widthOfTheReviewText = Dimens.size20;
    double starRatingTextFontSize = Dimens.fontSize14;

    if (device == ScreenType.tablet) {
      widthOfTheReviewText = Dimens.size60;
      starRatingTextFontSize = Dimens.fontSize22;
    }

    return Padding(
      padding: const EdgeInsets.only(bottom: Dimens.space4),
      child: SizedBox(
        height: Dimens.size19,
        child: 
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // Placeholder for the rating number and star icon
            Row(
              

              children: <Widget>[
                Container(
                  width: Dimens.size20,
                  height: starRatingTextFontSize,
                  color: Colors.white,
                ),
                const SizedBox(width: Dimens.size5),
                Container(
                  width: starRatingTextFontSize,
                  height: starRatingTextFontSize,
                  color: Colors.white,
                ),
              ],
            ),
            const SizedBox(width: Dimens.size4),
            // Placeholder for the progress bar
            Expanded(
              child: Container(
                height: Dimens.size6,
                color: Colors.white,
              ),
            ),
            const SizedBox(width: Dimens.size4),
            // Placeholder for the review count text
            SizedBox(
              width: widthOfTheReviewText,
              child: Center(
                child: Container(
                  width: widthOfTheReviewText,
                  height: Dimens.fontSize12,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
