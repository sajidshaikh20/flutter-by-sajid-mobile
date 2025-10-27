import '../../../../utils/exports.dart';

/// Widget that displays product rating and review summary.
class ProductRatingReviewWidget extends StatelessWidget {
  /// The review summary data containing ratings and statistics.
  final GetReviewSummaryResponse? review;

  /// The product details containing basic product information.
  final ProductDetailsResponse? productDetails;

  /// The screen type for responsive design.
  final ScreenType device;

  /// Creates a product rating and review widget.
  const ProductRatingReviewWidget(
      {super.key,
      this.review,
      this.productDetails,
      this.device = ScreenType.mobile});

  @override
  Widget build(BuildContext context) {
    final Map<String, int>? ratingArray = review?.ratingArray;
    final  int? reviewCount = review?.reviewCount;
    final List<int> ratingKeys = <int>[5, 4, 3, 2, 1];
    int maxCount = 0;
    if (ratingArray != null && ratingArray.isNotEmpty) {
      maxCount = ratingArray.values.fold(0, (int max, int count) => count > max ? count : max);
    }
    return CustomListView(
        scrollPhysics: const NeverScrollableScrollPhysics(),
        itemCount: ratingKeys.length,
        isPadding: true,
        itemBuilder: (BuildContext context, int index) {
          final int rating = ratingKeys[index];
          final int count = ratingArray?[rating.toString()] ?? 0;
          return ReviewRowWidget(
            itemIndex: rating,
            count: count,
            maxCount: reviewCount??maxCount,
            device: device,
          );
        });
  }
}
