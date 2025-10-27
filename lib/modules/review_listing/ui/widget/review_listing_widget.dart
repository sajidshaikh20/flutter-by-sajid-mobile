import '../../../../utils/exports.dart';

/// Widget that displays a list of product reviews with ratings and summaries.
class ReviewListingWidget extends StatelessWidget {
  /// The product details for which reviews are being displayed.
  final ProductDetailsResponse? productDetails;

  /// The screen type for responsive design.
  final ScreenType device;

  /// The total number of reviews for the product.
  final int totalReviewCount;

  /// The review summary data including ratings and statistics.
  final GetReviewSummaryResponse? reviewData;

  /// Creates a review listing widget.
  const ReviewListingWidget({
    super.key,
    this.productDetails,
    this.device = ScreenType.mobile,
    this.totalReviewCount = 0,
    this.reviewData,
  });

  /// Get the review summary response with updated review count
  GetReviewSummaryResponse? _getUpdatedReviewSummary() {
    if (reviewData == null) return null;

    // Use the passed review data but update the review count with the totalReviewCount
    return reviewData!.copyWith(reviewCount: totalReviewCount);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: MainConfig.appColors.backgroundWhiteColor,
        body: Column(
          children: <Widget>[
            ProductDetailsAppBar(
              titleText: context.appString.reviewsKey,
              isLastWidgetDisplay: false,
              prefixIcon: Assets.svgs.icBack.svg(),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Dimens.size16.heightBox,

                    ReviewWidget(
                        device: device,
                        entityId: 2,
                        review: _getUpdatedReviewSummary(),
                        productDetails: productDetails,
                      ),
                    Dimens.size34.heightBox,
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: Dimens.space16,
                      ),
                      child: CustomListView(
                        itemCount: reviewData?.reviews?.length ?? 0,
                        isPadding: true,
                        isSeparator: true,
                        scrollPhysics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (BuildContext context, int index) {
                          bool isFirst = index == 0;
                          final bool isLast = index == (reviewData?.reviews?.length ?? 0) - 1;
                          return Padding(
                            padding: EdgeInsets.only(
                              bottom: isLast ? Dimens.space0 : Dimens.space16,
                              top: isFirst ? Dimens.space0 : Dimens.space16,
                            ),
                            child: ReviewRatingDetailsCard(
                                device: device,
                                review: reviewData?.reviews?[index],
                              ),
                          );
                        },
                      ),
                    ),
                    Dimens.size25.heightBox,
                  ],
                ),
              ),
            ),
          ],
        ));
  }
}
