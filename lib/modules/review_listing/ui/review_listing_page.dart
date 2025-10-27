import '../../../utils/exports.dart';

/// A responsive page that displays the product review listing.
@RoutePage()
class ReviewListingPage extends BaseResponsiveView {
  /// Creates a page to display product reviews for the given entity ID.
  const ReviewListingPage({
    required this.entityId,
    super.key,
    this.productDetails,
    this.totalReviewCount = 0,
    this.reviewData,
  });

  /// Optional product details for the review page.
  final ProductDetailsResponse? productDetails;

  /// Unique identifier for the product being reviewed.
  final int entityId;

  /// Total number of reviews available for this product.
  final int totalReviewCount;

  /// Review data passed from product details page.
  final GetReviewSummaryResponse? reviewData;

  @override
  Widget buildDesktopWidget(BuildContext context) =>
      _buildView(context, ScreenType.desktop);

  @override
  Widget buildMobileWidget(BuildContext context) =>
      _buildView(context, ScreenType.mobile);

  @override
  Widget buildTabletWidget(BuildContext context) =>
      _buildView(context, ScreenType.tablet);

  Widget _buildView(BuildContext context, ScreenType device) =>
      ReviewListingWidget(
        productDetails: productDetails,
        device: device,
        totalReviewCount: totalReviewCount,
        reviewData: reviewData,
      );
}
