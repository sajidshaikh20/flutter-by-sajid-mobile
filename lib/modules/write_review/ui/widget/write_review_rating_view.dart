import '../../../../utils/exports.dart';

/// A widget that displays a star-based rating input for submitting product reviews.
///
/// This widget uses a `RatingBar` to allow the user to select a rating.
/// The selected value is converted to a string (1-5 for star ratings)
/// and returned to the parent widget through the [onRatingChanged] callback.
class WriteReviewRatingView extends StatelessWidget {
  /// Callback function triggered when the rating changes.
  ///
  /// The parameter is the selected rating value as a `String`.
  final Function(String) onRatingChanged;

  /// The device type to determine rating star size (mobile, tablet, etc.).
  ///
  /// Defaults to [ScreenType.mobile].
  final ScreenType device;

  /// The current rating value to display.
  ///
  /// Defaults to 0 (no rating selected).
  final int currentRating;

  /// Creates a [WriteReviewRatingView].
  ///
  /// The [onRatingChanged] callback is required.
  const WriteReviewRatingView({
    super.key,
    required this.onRatingChanged,
    this.device = ScreenType.mobile,
    this.currentRating = 0,
  });

  @override
  Widget build(BuildContext context) {
    double itemSize=Dimens.size40;
    switch(device){

      case ScreenType.tablet:
        itemSize=Dimens.size60;

      default:
        break;
    }
    return RatingBar.builder(
      initialRating: currentRating.toDouble(),
      maxRating: AppConstant.maxRating,
      itemSize: itemSize,
      unratedColor: MainConfig.appColors.greyExtraLightColor,
      glow: false,
      wrapAlignment: WrapAlignment.spaceBetween,
      itemPadding: const EdgeInsets.symmetric(horizontal: Dimens.space2),
      itemBuilder: (BuildContext context, _) =>  Icon(
        Icons.star,
        color: MainConfig.appColors.ratingYellowColor,
      ),
      onRatingUpdate: (double rating) {
        onRatingChanged(_getValue(rating.toInt()));
      },
    );
  }

  /// Converts a numeric [rating] to its corresponding string value.
  ///
  /// Returns the rating as a string (1-5 for star ratings).
  /// Returns `"0"` if the rating is invalid.
  String _getValue(int rating) {
    return (rating >= 1 && rating <= 5)
        ? rating.toString()
        : "0";
  }
}
