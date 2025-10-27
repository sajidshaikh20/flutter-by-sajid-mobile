import '../../../utils/exports.dart';

/// A custom rating indicator widget that displays a row of star icons to
/// represent a rating value.
class CommonRatingIndicator extends StatelessWidget {
  /// The rating value to display, typically between 0.0 and 5.0.
  final double rating;

  /// The size of each star icon.
  final double itemSize;

  /// The padding around each star icon.
  ///
  /// If not provided, defaults to `EdgeInsets.only(left: Dimens.space4)`.
  final EdgeInsets? itemPadding;

  /// The total number of star icons to display.
  ///
  /// If not provided, defaults to 5.
  final int? itemCount;

  /// Creates a [CommonRatingIndicator].
  ///
  const CommonRatingIndicator({
    super.key,
    required this.rating,
    this.itemSize = Dimens.size24,
    this.itemPadding, // itemPadding is now optional
    this.itemCount, // itemCount is now optional
  });

  @override
  Widget build(BuildContext context) {
    return RatingBarIndicator(
      rating: rating,
      itemBuilder: (BuildContext context, int index) => Assets.svgs.icDStarRating.svg(),
      itemCount: itemCount ?? 5,
      // Use the provided itemCount or default to 5
      itemPadding: itemPadding ?? const EdgeInsets.only(left: Dimens.space4),
      // Use default if null
      itemSize: itemSize,

      unratedColor: MainConfig.appColors.greyExtraLightColor,
    );
  }
}
