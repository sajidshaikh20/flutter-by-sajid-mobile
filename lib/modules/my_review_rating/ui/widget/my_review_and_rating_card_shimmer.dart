

import '../../../../utils/exports.dart';

/// Shimmer loading widget for review and rating cards.
class MyReviewAndRatingCardShimmer extends StatelessWidget {
  /// Creates a shimmer loading widget for review and rating cards.
  const MyReviewAndRatingCardShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    // Define base and highlight colors for the shimmer effect.


    return ShimmerEffectWidget(

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          // Top row with image and title/date placeholders
          Row(
            children: <Widget>[
              // Image placeholder (simulate the app logo or product image)
              Container(
                width: Dimens.size40,
                height: Dimens.size40,
                color: Colors.white,
              ),
              Dimens.size8.widthBox,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    // Title placeholder
                    Container(
                      width: double.infinity,
                      height: Dimens.fontSize14,
                      color: Colors.white,
                    ),
                    Dimens.size4.heightBox,
                    // Rating indicator and date placeholder
                    Row(
                      children: <Widget>[
                        Container(
                          width: Dimens.size16,
                          height: Dimens.size16,
                          color: Colors.white,
                        ),
                        Dimens.size4.widthBox,
                        Container(
                          width: Dimens.size80,
                          height: Dimens.fontSize12,
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
          // Review text placeholder (simulate multiple lines of text)
          Container(
            width: double.infinity,
            height: Dimens.fontSize14 * 3,
            color: Colors.white,
          ),
        ],
      ),
    );
  }
}
