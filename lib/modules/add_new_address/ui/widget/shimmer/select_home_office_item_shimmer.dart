import '../../../../../utils/exports.dart';
///SelectHomeOfficeItemShimmer
class SelectHomeOfficeItemShimmer extends StatelessWidget {

  ///SelectHomeOfficeItemShimmer CONSTROCTOR
  const SelectHomeOfficeItemShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: Dimens.size6),
      padding: const EdgeInsets.all(Dimens.space12),
      decoration: BoxDecoration(
        color: Colors.white,
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
                // Left section: Store Name (Shimmer)
                Expanded(
                  child: Row(
                    children: <Widget>[
                      // Shimmer for the image
                      Container(
                        width: Dimens.size24,
                        height: Dimens.size24,
                        color: Colors.white,
                      ),
                      const SizedBox(width: Dimens.size8),
                      // Shimmer for the store name
                      Container(
                        width: Dimens.size50,
                        height: Dimens.size16,
                        color: Colors.white,
                      ),
                    ],
                  ),
                ),
                // Right section: Edit and Delete Icons (Shimmer)
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      // Shimmer for the edit text
                      Container(
                        width: Dimens.size30,
                        height: Dimens.size16,
                        color: Colors.white,
                      ),
                      const SizedBox(width: Dimens.size22),
                      // Shimmer for the delete text
                      Container(
                        width: Dimens.size40,
                        height: Dimens.size16,
                        color: Colors.white,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: Dimens.size12),
            // Shimmer for the address
            Container(
              width: double.infinity,
              height: Dimens.size16,
              color: Colors.white,
            ),

          ],
        ),
      ),
    );
  }
}