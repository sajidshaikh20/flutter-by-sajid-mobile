import '../../../../../utils/exports.dart';

/// A placeholder shimmer widget displayed in the cart
/// when items are out of stock or loading.
///
/// This widget is typically used to show a skeleton UI
/// while fetching cart item details or indicating out-of-stock items.
class CartOutOfStockShimmer extends StatelessWidget {
  /// Creates a [CartOutOfStockShimmer] instance.
  const CartOutOfStockShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
        left: Dimens.space16,
        right: Dimens.space16,
        top: Dimens.space16,
        bottom: Dimens.space10,
      ),
      decoration: BoxDecorationExtension.customDecoration(
        color: MainConfig.appColors.backgroundWhiteShade,
        borderRadius: Dimens.radius8.borderRadius,
        border: Border.all(
          color: MainConfig.appColors.redColor,
          width: Dimens.borderWidth05,
        ),
      ),
      child: ShimmerEffect(
        child: Column(
          children: <Widget>[
            // -- First Row: "Out of stock" text + close icon --
            Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                // Placeholder for "OutOfStockMsg" text
                Container(
                  width: Dimens.size120,
                  height: Dimens.size14,
                  color: Colors.white,
                ),
                const Spacer(),
                // Placeholder for Close Icon
                Container(
                  width: Dimens.size16,
                  height: Dimens.size16,
                  color: Colors.white,
                ),
              ],
            ),
            const SizedBox(height: Dimens.size20),
        
            // -- OutOfStockRowItem placeholder --
          const OutOffStockListItemShimmer(index: 0, itemCount: 1),
            const SizedBox(height: Dimens.size14),
        
            // -- Divider placeholder --
            Container(
              width: double.infinity,
              height: Dimens.borderWidth05,
              color: Colors.white,
            ),
            const SizedBox(height: Dimens.size14),
        
            // -- "View All" text placeholder --
            Container(
              width: Dimens.size60,
              height: Dimens.size14,
              color: Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}