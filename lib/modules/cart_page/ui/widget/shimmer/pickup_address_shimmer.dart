import '../../../../../utils/exports.dart';

/// A placeholder shimmer widget for displaying a pickup address section.
///
/// This widget is typically used to show a skeleton UI while the pickup
/// address details are being fetched, giving users a visual cue that
/// content is loading.
class PickupAddressShimmer extends StatelessWidget {
  /// Creates a [PickupAddressShimmer] instance.
  const PickupAddressShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: MainConfig.appColors.iceBlueColor,
      width: double.infinity,
      padding: const EdgeInsets.only(
        right: Dimens.space16,
        left: Dimens.space16,
        top: Dimens.space1,
        bottom: Dimens.space10,
      ),
      child: ShimmerEffect(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // 1) First Rich Text ("deliveryToKey navHomeKey")
            Container(
              height: Dimens.size16,
              width: Dimens.size140,
              color: Colors.white,
            ),
            const SizedBox(height: Dimens.size8),
            // 2) Text Label ("address")
            Container(
              height: Dimens.size16,
              width: Dimens.size200,
              color: Colors.white,
            ),
            const SizedBox(height: Dimens.size12),
            // 3) Row with Rich Text ("fromKey storeNameKey") & "change"
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                // Left side: "fromKey storeNameKey"
                Container(
                  height: Dimens.size14,
                  width: Dimens.size120,
                  color: Colors.white,
                ),
                // Right side: "change"
                Container(
                  height: Dimens.size14,
                  width: Dimens.size40,
                  color: Colors.white,
                ),
              ],
            ),
            const SizedBox(height: Dimens.size7),
            // 4) Row with Time Icon & Time Label
            Row(
              children: <Widget>[
                // Icon placeholder (square/rect)
                Container(
                  width: Dimens.size16,
                  height: Dimens.size16,
                  color: Colors.white,
                ),
                const SizedBox(width: Dimens.size9),
                // Text label
                Container(
                  height: Dimens.size14,
                  width: Dimens.size80,
                  color: Colors.white,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}