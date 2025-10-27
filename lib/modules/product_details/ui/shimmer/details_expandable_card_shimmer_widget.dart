
import '../../../../utils/exports.dart';

/// Shimmer loading widget for expandable product details cards.
class DetailsExpandableCardShimmerWidget extends StatelessWidget {
  /// Creates a shimmer loading widget for expandable product details cards.
  const DetailsExpandableCardShimmerWidget({super.key});

  @override
  Widget build(BuildContext context) {


    return Container(
      padding: const EdgeInsets.only(
        left: Dimens.space12,
        right: Dimens.space12,
        top: Dimens.space13,
        bottom: Dimens.space14,
      ),
      decoration: BoxDecoration(
        border: Border.all(
          color: MainConfig.appColors.lightGreyColor,
          width: Dimens.borderWidth05,
        ),
        borderRadius: const BorderRadius.all(Radius.circular(Dimens.space8)),
        color: AppColors.whiteColor,
      ),
      child: ShimmerEffectWidget(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // Title Row
            Row(
              children: <Widget>[
                // Mimic the title text placeholder.
                Container(
                  width: MediaQuery.of(context).size.width * 0.5,
                  height: Dimens.fontSize16,
                  color: Colors.white,
                ),
                const Spacer(),
                // Mimic the expand/collapse icon placeholder.
                DecoratedBox(
                  decoration: BoxDecoration(
                    color: MainConfig.appColors.iceBlueColor,
                  ),

                  child: Container(
                    width: Dimens.size16,
                    height: Dimens.size16,
                    color: Colors.white,
                  ),
                ),
              ],
            ),

          ],
        ),
      ),
    );
  }
}
