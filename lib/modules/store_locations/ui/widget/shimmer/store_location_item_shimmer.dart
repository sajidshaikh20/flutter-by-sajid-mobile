import '../../../../../utils/exports.dart';

/// A shimmer loading widget that displays a placeholder for store location items
/// during data loading.
class StoreLocationItemShimmer extends StatelessWidget {
  /// Creates a [StoreLocationItemShimmer] widget.
  ///
  /// [key] is an optional key for the widget.
  const StoreLocationItemShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: Dimens.size6),
      padding: const EdgeInsets.all(Dimens.space12),
      decoration: BoxDecoration(
        color: MainConfig.appColors.backgroundWhite,
        borderRadius: BorderRadius.circular(Dimens.size8),
        border: Border.all(
          color: MainConfig.appColors.lightGreyColor,
        ),
      ),
      child: ShimmerEffectWidget(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                // Left section: Store Name
                Expanded(
                  child: Row(
                    children: <Widget>[
                      // Store Name Section
                      Row(
                        children: <Widget>[
                          Container(
                            width: Dimens.size16,
                            height: Dimens.size16,
                            color: Colors.white,
                          ),
                          const SizedBox(width: Dimens.size8),
                          Container(
                            width: Dimens.size100,
                            height: Dimens.size16,
                            color: Colors.white,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Dimens.size12.heightBox,
            Container(
              width: double.infinity,
              height: Dimens.size16,
              color: Colors.white,
            ),
            Dimens.size13.heightBox,
            SizedBox(
              width: double.infinity,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  // Opening Hours Column
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        width: Dimens.size80,
                        height: Dimens.size10,
                        color: Colors.white,
                      ),
                      const SizedBox(height: Dimens.size8),
                      Container(
                        width: Dimens.size130,
                        height: Dimens.size14,
                        color: Colors.white,
                      ),
                    ],
                  ),

                  // Buttons Row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      // Map Button
                      Container(
                        width: Dimens.size75,
                        height: Dimens.size28,
                        color: Colors.white,
                      ),
                      const SizedBox(width: Dimens.space16),
                      // Spacing between buttons
                      Container(
                        width: Dimens.size75,
                        height: Dimens.size28,
                        color: Colors.white,
                      ),
                      // Call Button
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}