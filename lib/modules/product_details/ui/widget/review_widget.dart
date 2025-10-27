import '../../../../utils/exports.dart';

/// Widget that displays product reviews and ratings.
class ReviewWidget extends StatelessWidget {
  /// The review summary data containing ratings and statistics.
  final GetReviewSummaryResponse? review;

  /// The product details containing basic product information.
  final ProductDetailsResponse? productDetails;

  /// The entity ID of the product.
  final int entityId;

  /// The screen type for responsive design.
  final ScreenType device;

  /// Creates a review widget for displaying product reviews.
  const ReviewWidget(
      {super.key,
      this.review,
      this.productDetails,
      required this.entityId,
      this.device = ScreenType.mobile});

  @override
  Widget build(BuildContext context) {
    double ratingIconSize = Dimens.space16;
    double ratingTextFontSize = Dimens.fontSize14;

    switch (device) {
      case ScreenType.tablet:
        break;
      default:
        break;
    }
    // Get actual data from API response
    final Map<String, int>? ratingArray = review?.ratingArray;
    final int? backendReviewCount = review?.reviewCount;
    final double? backendRating = review?.ratings;
    
    // Use backend data directly since backend team confirmed perfect data
    final int finalReviewCount = backendReviewCount ?? 0;
    final double finalRating = backendRating ?? 0.0;

    return
      Visibility(
        visible: finalReviewCount > 0,
        child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: Dimens.space16),
        child: Container(
          height: Dimens.size136,
          decoration: BoxDecoration(
              color: MainConfig.appColors.lightestGreyColor,
              borderRadius: BorderRadius.circular(Dimens.space8)),
          child: Column(
            children: <Widget>[
              Dimens.size12.heightBox,
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(
                        left: isLanguageAlignmentLTR
                            ? Dimens.space8
                            : Dimens.space0,
                        right: isLanguageAlignmentLTR ? 0 : Dimens.space8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        CustomTextLabelWidget(
                          label: finalRating.toStringAsFixed(1),
                          textAlign: TextAlign.right,
                          style: context.textTheme.headlineMedium?.copyWith(
                            fontSize: Dimens.size40,
                            fontWeight: FontWeight.w700,
                            height:
                                Dimens.lineHeight54.toLineHeight(Dimens.size40),
                          ),
                        ),
                        Dimens.size8.heightBox,
                        Align(
                            child: CommonRatingIndicator(
                              rating: finalRating,
                              itemSize: ratingIconSize,
                            )),
                        Dimens.size8.heightBox,
                        CustomTextLabelWidget(
                          label:
                              "$finalReviewCount ${context.appString.reviewsKey}",
                          style: context.textTheme.headlineSmall?.copyWith(
                              color: AppColors.blackColor,
                              fontWeight: FontWeight.w600,
                              height: Dimens.lineHeight18
                                  .toLineHeight(ratingTextFontSize),
                              fontSize: ratingTextFontSize),
                        ),
                      ],
                    ),
                  ),
                  Dimens.size24.widthBox,
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(right: Dimens.size21),
                      child: ProductRatingReviewWidget(
                        device: device,
                        review: review,
                        productDetails: productDetails,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
            ),
      ) ;
  }
}
