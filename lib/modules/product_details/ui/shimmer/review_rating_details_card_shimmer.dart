import '../../../../utils/exports.dart';

/// Shimmer version of the ReviewRatingDetailsCard
class ReviewRatingDetailsCardShimmer extends StatelessWidget {
  /// The screen type for responsive design.
  final ScreenType device;

  /// Creates a shimmer loading widget for review rating details card.
  const ReviewRatingDetailsCardShimmer({
    super.key,
    this.device = ScreenType.mobile,
  });

  @override
  Widget build(BuildContext context) {
    // You can adjust these sizes as needed.
    double sizeMobTab8_16 = Dimens.size8;
    double iconSize = Dimens.size24;
    double textHeight = Dimens.fontSize14;
    double smallTextHeight = Dimens.fontSize12;
    double ratingIndicatorSize = Dimens.size16;

    return ShimmerEffectWidget(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          // Top row: User icon and info
          Row(
            children: <Widget>[
              // Circular shimmer for user icon.
              Container(
                width: iconSize,
                height: iconSize,
                color: Colors.white,
              ),
              sizeMobTab8_16.widthBox,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    // Shimmer for the username text.
                    Container(
                      width: Dimens.size100, // approximate width for the username
                      height: textHeight,
                      color: Colors.white,
                    ),
                    Dimens.size4.heightBox,
                    Row(
                      children: <Widget>[
                        // Shimmer for rating indicator (a row of stars).
                        Row(
                          children: List<Widget>.generate(
                            5, // assuming 5 stars
                            (int index) => Padding(
                              padding:
                                  const EdgeInsets.only(left: Dimens.space4),
                              child: Container(
                                width: ratingIndicatorSize,
                                height: ratingIndicatorSize,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        Dimens.size4.widthBox,
                        // Shimmer for "mins ago" text.
                        Container(
                          width: Dimens.size40,
                          height: smallTextHeight,
                          color: Colors.white,
                        ),
                      ],
                    ),
                    Dimens.size1.heightBox,
                  ],
                ),
              ),
            ],
          ),
          Dimens.size8.heightBox,
          // Shimmer for the review title.
          Container(
            width: double.infinity,
            height: textHeight,
            color: Colors.white,
          ),
          Dimens.size8.heightBox,
          // Shimmer for the review description.
          Container(
            width: double.infinity,
            height: textHeight,
            color: Colors.white,
          ),
        ],
      ),
    );
  }
}
