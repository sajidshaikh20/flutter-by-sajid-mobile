import '../../../../../utils/exports.dart';

/// Shimmer loading widget for transaction list items.
class TrasactionListShimmer extends StatelessWidget {
  /// Creates a shimmer loading widget for transaction list.
  const TrasactionListShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    bool isEnglish = context.isEnglishLanguage;
    return CustomListView(

      itemBuilder: (BuildContext context, int int) {
        return Container(
          margin: const EdgeInsets.only(bottom: Dimens.space8),
          padding: EdgeInsets.only(
            right: isEnglish ? Dimens.space8 : Dimens.space0,
            top: Dimens.space8,
            bottom: Dimens.space8,
            left: isEnglish ? Dimens.space0 : Dimens.space8,
          ),
          decoration: BoxDecorationExtension.customDecoration(
            borderRadius: Dimens.radius8.borderRadius,
            color: AppColors.whiteColor,
            border: Border.all(
              color: MainConfig.appColors.lightGreyColor,
              width: Dimens.borderWidth05,
            ),
          ),
          child: ShimmerEffectWidget(
            child: Row(
              children: <Widget>[
                // Left colored indicator
                Container(
                  width: Dimens.size2,
                  height: Dimens.size20,
                  decoration: BoxDecoration(
                    color: Colors.white, // placeholder color for shimmer
                    borderRadius: isEnglish
                        ? BorderRadius.only(
                            topRight: Dimens.radius8.circularRadius,
                            bottomRight: Dimens.radius8.circularRadius,
                          )
                        : BorderRadius.only(
                            topLeft: Dimens.radius8.circularRadius,
                            bottomLeft: Dimens.radius8.circularRadius,
                          ),
                  ),
                ),
                const SizedBox(width: Dimens.size6),
                // Expanded column skeleton
                Expanded(
                  child: Column(
                    children: <Widget>[
                      // First row
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          // Placeholder for the first text
                          Container(
                            height: Dimens.size12,
                            width: Dimens.size100,
                            color: MainConfig.appColors.backgroundWhite,
                          ),
                          // Placeholder for the second text
                          Container(
                            height: Dimens.size12,
                            width: Dimens.size60,
                            color: MainConfig.appColors.backgroundWhite,
                          ),
                        ],
                      ),
                      const SizedBox(height: Dimens.size2),
                      // Second row
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          // Placeholder for the first text
                          Container(
                            height: Dimens.size10,
                            width: Dimens.size60,
                            color: MainConfig.appColors.backgroundWhite,
                          ),
                          // Placeholder for the second text
                          Container(
                            height: Dimens.size10,
                            width: Dimens.size80,
                            color: MainConfig.appColors.backgroundWhite,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
      itemCount: 4,
    );
  }
}
