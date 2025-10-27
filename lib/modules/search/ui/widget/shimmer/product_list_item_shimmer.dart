
import '../../../../../utils/exports.dart';

/// Shimmer loading widget for product list items during search.
class ProductListItemShimmer extends StatelessWidget {
  /// Creates a shimmer loading widget for product list items.
  const ProductListItemShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return ShimmerEffect(

      child: Padding(
        padding: const EdgeInsets.only(left: Dimens.space16),
        child: Column(
          children: <Widget>[
            // -- InkWell + Padding block skeleton --
            Padding(
              padding: const EdgeInsets.symmetric(vertical: Dimens.space12),
              child: Row(
                children: <Widget>[
                  // Image placeholder
                  Container(
                    width: Dimens.size64,
                    height: Dimens.size64,
                    color: Colors.white,
                  ),
                  const SizedBox(width: Dimens.size12),
                  // Text and prices placeholder
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        // Product Name (2 lines)
                        Container(
                          width: double.infinity,
                          height: Dimens.size14,
                          color: Colors.white,
                        ),
                        const SizedBox(height: Dimens.size6),
                        Container(
                          width: double.infinity,
                          height: Dimens.size14,
                          color: Colors.white,
                        ),
                        const SizedBox(height: Dimens.size10),
                        // Row for the price, old price & discount
                        Row(
                          children: <Widget>[
                            // Price placeholder
                            Container(
                              width: Dimens.size60,
                              height: Dimens.size14,
                              color: Colors.white,
                            ),
                            const SizedBox(width: Dimens.size4),
                            // Old Price placeholder
                            Container(
                              width: Dimens.size60,
                              height: Dimens.size14,
                              color: Colors.white,
                            ),
                            const SizedBox(width: Dimens.size4),
                            // Discount placeholder
                            Container(
                              width: Dimens.size40,
                              height: Dimens.size14,
                              color: Colors.white,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            // -- Divider line placeholder --
            Container(
              height: Dimens.space1,
              color: Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}
