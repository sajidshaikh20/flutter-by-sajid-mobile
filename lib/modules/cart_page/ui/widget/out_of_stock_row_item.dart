import '../../../../utils/exports.dart';

/// A widget that displays a row of out-of-stock items in a list.
class OutOfStockRowItem extends StatelessWidget {
  /// Creates an [OutOfStockRowItem].
  ///
  /// [gapBetweenItem] defines the vertical space between each item in the row.
  /// [itemCount] determines the number of items to be displayed in the row.
  const OutOfStockRowItem(
      {
        super.key,
        this.gapBetweenItem = Dimens.space12,
        this.itemCount = 2
      }
  );
  /// The vertical space between each item.
  final double gapBetweenItem;

  /// The number of items to display.
  final int itemCount;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: itemCount == 2 ? const NeverScrollableScrollPhysics() : null,
      padding: EdgeInsets.zero,
      shrinkWrap: true,
      itemCount: itemCount,
      itemBuilder: (BuildContext context, int index) {
        return
          Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                    color: AppColors.whiteColor,
                    // Background color

                    borderRadius:
                        Dimens.radius8.borderRadius, // Rounded corners
                  ),
                  height: Dimens.size44,
                  width: Dimens.size44,
                  child: Assets.png.imgHotdeals1.image(),
                ),
                const SizedBox(
                  width: Dimens.size8,
                ),
                Expanded(
                  child: Column(
                    children: <Widget>[
                      CustomTextLabelWidget(
                        textDirection: TextDirection.ltr,
                        label:
                            AppConstant.dummyProductName,
                        maxLines: Dimens.maxLines01,
                        overflow: TextOverflow.ellipsis,
                        style: context.textTheme.headlineMedium?.copyWith(
                            height: Dimens.lineHeight18
                                .toLineHeight(Dimens.fontSize14),
                            fontSize: Dimens.fontSize14,
                            color: AppColors.blackColor,
                            fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(
                        height: Dimens.size8,
                      ),
                      Row(
                        children: <Widget>[
                          Expanded(
                            child: CustomTextLabelWidget(
                              textAlign: TextAlign.start,
                              label: AppConstant.dummyPacksName,
                              maxLines:Dimens.maxLines01,
                              overflow: TextOverflow.ellipsis,
                              style: context.textTheme.headlineMedium?.copyWith(
                                  height: Dimens.lineHeight14
                                      .toLineHeight(Dimens.fontSize12),
                                  fontSize: Dimens.fontSize12,
                                  color: MainConfig.appColors.creyColor,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                          Assets.svgs.icWishlistUnselected
                              .svg(height: Dimens.size18, width: Dimens.size18)
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
            if (index != itemCount - 1)
              SizedBox(
                height: gapBetweenItem,
              )
          ],
        );
      },
    );
  }
}
