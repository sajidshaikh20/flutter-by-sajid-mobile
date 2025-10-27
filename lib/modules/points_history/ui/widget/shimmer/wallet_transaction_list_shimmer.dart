

import '../../../../../utils/exports.dart';

/// Shimmer version of a single wallet transaction list item.
class WalletTransactionListShimmer extends StatelessWidget {
  /// Creates a shimmer loading widget for wallet transaction list.
  const WalletTransactionListShimmer({super.key});

  @override
  Widget build(BuildContext context) {
   return CustomListView(
      isPadding: true,
      scrollPhysics: const NeverScrollableScrollPhysics(),
      itemBuilder: (BuildContext context, int index) {
        return
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: Dimens.space16,
              vertical: Dimens.space4,
            ),
            child: DecoratedBox(
              decoration: BoxDecoration(
                border: Border.all(
                  color: MainConfig.appColors.lightGreyColor,
                  width: Dimens.borderWidth05,
                ),
                borderRadius: const BorderRadius.all(Radius.circular(Dimens.space8)),
                color: MainConfig.appColors.backgroundWhite,
              ),
              child: ShimmerEffectWidget(
                child: Padding(
                  padding: const EdgeInsets.only(top: Dimens.size8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      // Top row with left vertical stripe and transaction info
                      Row(
                        children: <Widget>[
                          // Left vertical stripe (color will be animated by shimmer)
                          Container(
                            width: Dimens.size2,
                            height: Dimens.space20,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                topRight: context.isEnglishLanguage
                                    ? const Radius.circular(Dimens.space8)
                                    : Radius.zero,
                                bottomRight: context.isEnglishLanguage
                                    ? const Radius.circular(Dimens.space8)
                                    : Radius.zero,
                                bottomLeft: context.isEnglishLanguage
                                    ? Radius.zero
                                    : const Radius.circular(Dimens.space8),
                                topLeft: context.isEnglishLanguage
                                    ? Radius.zero
                                    : const Radius.circular(Dimens.space8),
                              ),
                            ),
                          ),
                          Dimens.size6.widthBox,
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                // Placeholder for the description text
                                Padding(
                                  padding: context.isEnglishLanguage ? const EdgeInsets.only( right: Dimens.size8):const EdgeInsets.only( left: Dimens.size8),

                                  child: Container(
                                    width: double.infinity,
                                    height: Dimens.fontSize14,
                                    color: Colors.white,
                                  ),
                                ),
                                Dimens.size4.heightBox,
                                // Row for transaction id and date placeholders
                                Padding(
                                  padding: context.isEnglishLanguage ? const EdgeInsets.only( right: Dimens.space8):const EdgeInsets.only( left: Dimens.space8),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Container(
                                        width: Dimens.size80,
                                        height: Dimens.fontSize12,
                                        color: Colors.white,
                                      ),
                                      Container(
                                        width: Dimens.size60,
                                        height: Dimens.fontSize12,
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
                      const SizedBox(height: Dimens.size4,),
                      // Bottom padding for the location text placeholder
                      Padding(
                        padding: const EdgeInsets.only(
                            bottom: Dimens.space8,
                            right: Dimens.space8,
                            left: Dimens.space8),
                        child: Container(
                          width: double.infinity,
                          height: Dimens.fontSize12,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
      },
      itemCount: AppConstant.itemCount5, // Set this to the desired number of shimmer items
    )
    // Using Shimmer.fromColors to animate the placeholder
    ;
  }
}
