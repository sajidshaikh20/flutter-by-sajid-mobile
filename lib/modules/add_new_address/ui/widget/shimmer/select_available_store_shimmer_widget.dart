

import '../../../../../utils/exports.dart';


/// [SelectAvailableStoreShimmerWidget] is a stateless widget that displays
/// a shimmer effect placeholder for a list item representing an available store.
///
/// This widget is used to show a loading state while the list of available stores
/// is being fetched from the server.
class SelectAvailableStoreShimmerWidget extends StatelessWidget {
  /// Creates a [SelectAvailableStoreShimmerWidget].
  const SelectAvailableStoreShimmerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    // Define base and highlight colors for shimmer effect.


    return Container(
      margin: const EdgeInsets.symmetric(vertical: Dimens.size6),
      padding: const EdgeInsets.all(Dimens.size12),
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(Dimens.size8),
        border: Border.all(
          color: MainConfig.appColors.lightGreyColor,
        ),
      ),
      child: ShimmerEffectWidget(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // Top row: Icon, Store Name, Distance, and Check Icon
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                // Left side: Store Icon and Name
                Expanded(
                  child: Row(
                    children: <Widget>[
                      // Placeholder for store icon
                      Container(
                        width: Dimens.size16,
                        height: Dimens.size16,
                        color: Colors.white,
                      ),
                      const SizedBox(width: Dimens.size8),
                      // Placeholder for store name text
                      Container(
                        width: 100,
                        height: Dimens.fontSize14,
                        color: Colors.white,
                      ),
                    ],
                  ),
                ),
                // Right side: Distance text and Check Icon
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      // Placeholder for distance text (e.g., "4 km")
                      Container(
                        width: 30,
                        height: Dimens.fontSize12,
                        color: Colors.white,
                      ),
                      const SizedBox(width: Dimens.size12),
                      // Placeholder for check icon
                      Container(
                        width: Dimens.size16,
                        height: Dimens.size16,
                        color: Colors.white,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: Dimens.size12),
            // Placeholder for address text
            Container(
              width: double.infinity,
              height: Dimens.fontSize14,
              color: Colors.white,
            ),
            const SizedBox(height: Dimens.size10),
            // Placeholder for "items not available" text
            Container(
              width: 80,
              height: Dimens.fontSize12,
              color: Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}
