import '../../../../../utils/exports.dart';

/// [HomeAddressSelectionShimmer] is a stateless widget that displays a shimmer effect
/// to indicate that the home address selection is loading.
class HomeAddressSelectionShimmer extends StatelessWidget {
  /// [HomeAddressSelectionShimmer] constructor.
  /// It takes a [Key] as an optional parameter.
  const HomeAddressSelectionShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    // Define shimmer colors (you can adjust these or use your AppColors)

    return ShimmerEffectWidget(
      child: Container(

        height: Dimens.size40,
        padding: const EdgeInsets.only(
          left: Dimens.size16,
          right: Dimens.size17,
        ),
        child: Row(
          children: <Widget>[
            // Circle placeholder (for the icon)
            Container(
              width: Dimens.size28,
              height: Dimens.size28,
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(width: Dimens.size8),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  // Placeholder for the first line (e.g., "Delivery to Home")
                  Container(
                    width: double.infinity,
                    height: Dimens.size14,
                    color: Colors.white,
                  ),
                  const SizedBox(height: Dimens.size4),
                  // Placeholder for the second line (address)
                  Container(
                    width: double.infinity,
                    height: Dimens.size10,
                    color: Colors.white,
                  ),
                ],
              ),
            ),
            const SizedBox(width: Dimens.size8),
            // Placeholder for the down arrow icon
            Container(
              width: Dimens.size16,
              height: Dimens.size16,
              color: Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}