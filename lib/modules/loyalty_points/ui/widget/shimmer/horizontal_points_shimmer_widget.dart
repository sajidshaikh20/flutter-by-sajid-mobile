

import '../../../../../utils/exports.dart';

/// Shimmer loading widget for horizontal points list.
class HorizontalPointsShimmerWidget extends StatelessWidget {
  /// Creates a horizontal points shimmer widget.
  const HorizontalPointsShimmerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    // Define base and highlight colors for the shimmer effect.


    return SizedBox(
      height: Dimens.size80,
      child: CustomListView(
        scrollDirection: Axis.horizontal,
        itemCount: AppConstant.itemCount3,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: EdgeInsets.only(
              right: context.isEnglishLanguage ? Dimens.size8 : Dimens.size0,
              left: context.isEnglishLanguage ? Dimens.size0 : Dimens.size8,
            ),
            child: Container(
              width: Dimens.size131,
              decoration: BoxDecoration(
                border: Border.all(
                  color: MainConfig.appColors.lightGreyColor,
                  width: Dimens.borderWidth05,
                ),
                borderRadius:
                    const BorderRadius.all(Radius.circular(Dimens.space8)),
                color: MainConfig.appColors.backgroundWhite,
              ),
              child: ShimmerEffectWidget(
                child: Row(
                  children: <Widget>[
                    // Left vertical colored bar
                    Padding(
                      padding: const EdgeInsets.only(
                          top: Dimens.space10, bottom: Dimens.space11),
                      child: Container(
                        width: Dimens.size1,
                        decoration: BoxDecoration(
                          // For shimmer, we use a solid color (the shimmer will override it)
                          color: index == 2
                              ? MainConfig.appColors.redColor
                              : MainConfig.appColors.greenColor,
                          borderRadius: BorderRadius.only(
                            topRight: context.isEnglishLanguage
                                ? Dimens.radius8.circularRadius
                                : Radius.zero,
                            bottomRight: context.isEnglishLanguage
                                ? Dimens.radius8.circularRadius
                                : Radius.zero,
                            bottomLeft: context.isEnglishLanguage
                                ? Radius.zero
                                : Dimens.radius8.circularRadius,
                            topLeft: context.isEnglishLanguage
                                ? Radius.zero
                                : Dimens.radius8.circularRadius,
                          ),
                        ),
                      ),
                    ),
                    Dimens.size5.widthBox,
                    // Right text area placeholders
                    Padding(
                      padding: const EdgeInsets.only(top: Dimens.size7),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          // Placeholder for the first text (e.g., '+ 20' or '- 20')
                          Container(
                            width: Dimens.size30,
                            height: Dimens.size14,
                            color: Colors.white,
                          ),
                          const SizedBox(height: Dimens.size4),
                          // Placeholder for the second text (e.g., points earned/redeemed)
                          Container(
                            width: Dimens.size70,
                            height: Dimens.fontSize14,
                            color: Colors.white,
                          ),
                          const SizedBox(height: Dimens.size4),
                          // Placeholder for the date/time text
                          Container(
                            width: Dimens.size90,
                            height: Dimens.size11,
                            color: Colors.white,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
