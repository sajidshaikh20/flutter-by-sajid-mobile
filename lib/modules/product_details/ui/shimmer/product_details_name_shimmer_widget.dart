
import '../../../../app/app.dart';

/// Shimmer loading widget for product name and basic details.
class ProductDetailsNameShimmerWidget extends StatelessWidget {
  /// Creates a shimmer loading widget for product name and details.
  const ProductDetailsNameShimmerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ShimmerEffectWidget(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          // Shimmer placeholder for the product name
          Expanded(
            child: Container(
              height: Dimens.size20,
              color: Colors.white, // The shimmer will overlay this
            ),
          ),
          const SizedBox(width: Dimens.size10),

          // Shimmer placeholder for the wishlist icon
          Container(
            width: Dimens.size24,
            height: Dimens.size24,
            color: Colors.white,
          ),
        ],
      ),
    );
  }
}
