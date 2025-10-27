

import '../../../../../utils/exports.dart';
///HomeLoyaltyPointsShimmer
class HomeLoyaltyPointsShimmer extends StatelessWidget {
  ///HomeLoyaltyPointsShimmer Constructor
  const HomeLoyaltyPointsShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    // Define shimmer colors; you can adjust these as needed.
    final Color baseColor = Colors.grey.shade300;
    final Color highlightColor = Colors.grey.shade100;

    return Shimmer.fromColors(
      baseColor: baseColor,
      highlightColor: highlightColor,
      child: ClipRRect(
        borderRadius: Dimens.radius8.borderRadius,
        child: Stack(
          children: <Widget>[
            // Mimic the background gradient with a simple colored container

            Container(
              padding: const EdgeInsets.only(
                left: Dimens.space10,
                right: Dimens.space10,
                top: Dimens.space7,
                bottom: Dimens.space8,
              ),
              // Use the same decoration as your original widget.
              decoration: BoxDecorationExtension.customDecoration(
                borderRadius: Dimens.radius8.borderRadius,
              ),
              child: Row(
                children: <Widget>[
                  // Placeholder for the loyalty icon
                  Container(
                    height: Dimens.size35,
                    width: Dimens.size35,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: Dimens.size8),
                  // Placeholder for the text labels
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      // Simulate the "Loyalty Points" text with a rectangular container
                      Container(
                        height: Dimens.size14,
                        width: Dimens.size120, // Adjust width as needed
                        color: Colors.white,
                      ),
                      const SizedBox(height: Dimens.size4),
                      // Simulate the points detail text
                      Container(
                        height: Dimens.size14,
                        width: Dimens.size150, // Adjust width as needed
                        color: Colors.white,
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}