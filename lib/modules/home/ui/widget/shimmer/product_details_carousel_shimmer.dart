import '../../../../../utils/exports.dart';

/// A Shimmer widget that simulates the loading state of a product details carousel.
///
/// This widget displays a placeholder carousel with a shimmer effect to indicate that
/// the actual product images are being loaded. It provides a visually appealing
/// loading experience to the user.
class ProductDetailsCarouselShimmer extends StatelessWidget {
  /// The height of the carousel placeholder.
  ///
  /// If not specified, a default height of [Dimens.size156] is used.
  final double? height;

  /// The number of items to simulate in the carousel.
  ///
  /// Defaults to 3, representing 3 carousel items.
  final int itemCount;

  /// The background color of the image placeholder.
  ///
  /// Defaults to [AppColors.whiteColor].
  final Color imageBgColor;

  /// Creates a [ProductDetailsCarouselShimmer] widget.
  const ProductDetailsCarouselShimmer({
    super.key,
    this.height,
    this.itemCount = 3, // Simulate 3 carousel items by default
    this.imageBgColor = AppColors.whiteColor,
  });

  @override
  /// Builds the shimmer effect for the product details carousel.
  Widget build(BuildContext context) {
    /// Define base and highlight colors for the shimmer effect.
    final Color baseColor = Colors.grey.shade300;
    final Color highlightColor = Colors.grey.shade100;

    return Shimmer.fromColors(
      baseColor: baseColor,
      highlightColor: highlightColor,
      child: Column(children: <Widget>[
        /// Carousel placeholder container
        Container(
          height: height ?? Dimens.size156,
          decoration: BoxDecoration(
            color: imageBgColor,
            borderRadius: BorderRadius.circular(Dimens.space6),
          ),
        ),
        /// Vertical spacing
        Dimens.size4.heightBox,
        /// Indicators row
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List<Widget>.generate(itemCount, (int index) {
            /// For shimmer, you can decide on a fixed indicator style.
            /// Here, the first indicator is made larger to mimic the "selected" state.
            return _buildIndicator(index);
          }),
        ),
      ]),
    );
  }

  /// Builds a single indicator for the carousel.
  Widget _buildIndicator(int index) {
    return Container(
      margin: const EdgeInsets.only(right: Dimens.size2),
      width: index == 0 ? Dimens.size8 : Dimens.size4,
      height: Dimens.size4,
      decoration: BoxDecoration(
        color: index == 0
            ? MainConfig.appColors.mainColor
            : MainConfig.appColors.unselectedGreyColor,
        shape: index == 0 ? BoxShape.rectangle : BoxShape.circle,
        borderRadius: index == 0 ? Dimens.radius30.borderRadius : null,
      ),
    );
  }
}