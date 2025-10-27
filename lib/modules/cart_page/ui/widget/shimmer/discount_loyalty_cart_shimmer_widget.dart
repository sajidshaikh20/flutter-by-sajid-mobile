import '../../../../../utils/exports.dart';

/// A placeholder shimmer widget displayed for discount and loyalty
/// sections in the cart while the data is loading.
///
/// This widget is typically used to show a skeleton UI for discounts,
/// loyalty points, or offers applied to the cart.
class DiscountLoyaltyCartShimmerWidget extends StatelessWidget {
  /// Creates a [DiscountLoyaltyCartShimmerWidget] instance.
  const DiscountLoyaltyCartShimmerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ShimmerEffectWidget(

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          // Top spacing
          Dimens.size8.heightBox,

          // 1) Placeholder for CartDiscountTextField
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: Dimens.space8),
            child: SizedBox(
              width: double.infinity,
              height: Dimens.size48, // approximate text field height
              child: DecoratedBox(
                decoration: BoxDecoration(color: Colors.white),
              ),
            ),
          ),

          // 2) Loyalty points row
          Padding(
            padding: const EdgeInsets.only(
              left: Dimens.space8,
              right: Dimens.space18,
              top: Dimens.space19,
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                // Checkbox placeholder (24x24 or your standard size)
                const SizedBox(
                  width: Dimens.size24,
                  height: Dimens.size24,
                  child: DecoratedBox(
                    decoration: BoxDecoration(color: Colors.white),
                  ),
                ),
                const SizedBox(width: Dimens.space8),
                // Loyalty column
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      // Title placeholder
                      Container(
                        width: Dimens.size100,
                        height: Dimens.size14,
                        color: Colors.white,
                      ),
                      const SizedBox(height: Dimens.size4),
                      // Description placeholder (two lines)
                      Container(
                        width: double.infinity,
                        height: Dimens.size14,
                        color: Colors.white,
                      ),
                      const SizedBox(height: Dimens.size4),
                      Container(
                        width: Dimens.size150,
                        height: Dimens.size14,
                        color: Colors.white,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // 3) Wallet row
          Padding(
            padding: const EdgeInsets.only(
              left: Dimens.space8,
              right: Dimens.space18,
              top: Dimens.space13,
              bottom: Dimens.space7,
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                // Checkbox placeholder
                const SizedBox(
                  width: Dimens.size24,
                  height: Dimens.size24,
                  child: DecoratedBox(
                    decoration: BoxDecoration(color: Colors.white),
                  ),
                ),
                const SizedBox(width: Dimens.space8),
                // Wallet column
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      // Title placeholder
                      Container(
                        width: Dimens.size60,
                        height: Dimens.size14,
                        color: Colors.white,
                      ),
                      const SizedBox(height: Dimens.size4),
                      // Description placeholder (one line or more)
                      Container(
                        width: Dimens.size150,
                        height: Dimens.size14,
                        color: Colors.white,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}