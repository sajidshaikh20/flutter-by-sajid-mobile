import '../../../../utils/exports.dart';

/// A widget that displays a single review row representing a specific rating level.
///
/// Each row typically shows a rating value (e.g., 5 stars), a progress indicator
/// representing how many reviews have that rating, and possibly a count.
///
/// Example usage:
/// ```dart
/// ReviewRowWidget(
///   itemIndex: 5,
///   count: 40,
///   maxCount: 100,
///   device: ScreenType.web,
/// )
/// ```
class ReviewRowWidget extends StatelessWidget {
  /// The rating value (e.g., 1–5) represented by this row.
  final int itemIndex;

  /// The number of reviews that correspond to this rating.
  final int count;

  /// The maximum count among all rating levels, used to determine
  /// the width or progress ratio for the progress indicator.
  final int maxCount;

  /// The type of screen the widget is being built for.
  ///
  /// Used to apply responsive layout adjustments for mobile, tablet, or web.
  final ScreenType device;

  /// Creates a [ReviewRowWidget].
  const ReviewRowWidget({
    super.key,
    required this.itemIndex,
    required this.count,
    required this.maxCount,
    this.device = ScreenType.mobile,
  });


  @override
  Widget build(BuildContext context) {
    double widthOfTheReviewText = Dimens.size20;
    double starRatingTextFontSize = Dimens.fontSize14;

    switch (device) {
      case ScreenType.tablet:
        widthOfTheReviewText = Dimens.size60;
        starRatingTextFontSize = Dimens.fontSize22;

      default:
        break;
    }
    
    // Calculate progress percentage based on count
    final double progressPercentage = maxCount > 0 ? (count / maxCount) * 100 : 0.0;
    
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: SizedBox(
        height: Dimens.size19,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(

              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                CustomTextLabelWidget(
                  label: itemIndex.toString(),
                  maxLines: Dimens.maxLines01,
                  style: context.textTheme.displayMedium?.copyWith(
                    fontSize: starRatingTextFontSize,
                    fontWeight: FontWeight.w600,
                    height:
                        Dimens.lineHeight18.toLineHeight(starRatingTextFontSize),
                  ),
                  textAlign:
                      isLanguageAlignmentLTR ? TextAlign.right : TextAlign.left,
                ),
                Dimens.size5.widthBox,
                Assets.svgs.icDStarRating.svg(),
              ],
            ),
            Dimens.size4.widthBox,
            Expanded(
              child: ProgressBar(
              max: 100,
              current: progressPercentage,
            )),
            SizedBox(
              width: widthOfTheReviewText,
              child: Center(
                child: CustomTextLabelWidget(
                  label: count.toString(),
                  maxLines: Dimens.maxLines01,
                  style: context.textTheme.displayMedium?.copyWith(
                    fontSize: Dimens.fontSize12,
                    fontWeight: FontWeight.w400,
                    height: Dimens.lineHeight18.toLineHeight(Dimens.fontSize12),
                  ),
                  textAlign:
                      isLanguageAlignmentLTR ? TextAlign.left : TextAlign.right,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
