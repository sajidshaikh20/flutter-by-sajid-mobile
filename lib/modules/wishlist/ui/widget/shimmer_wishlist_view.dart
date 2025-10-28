import '../../../../utils/exports.dart';

/// A shimmer loading view for the wishlist items.
class ShimmerWishListView extends StatelessWidget {
  /// Creates a shimmer loading view for the wishlist.
  const ShimmerWishListView({
    super.key,
    this.device = ScreenType.mobile,
    this.isRemovePadding = false,
  });

  /// The screen type for responsive design.
  final ScreenType device;

  /// Whether to remove padding from the view.
  final bool isRemovePadding;

  @override
  Widget build(BuildContext context) {
    double crossAxisSpacing = Dimens.space11;
    double paddingForView = Dimens.space10;
    final double itemWidth =
        (context.width - crossAxisSpacing - (paddingForView * 2)) /
            AppConstant.crossAxisCount2;
    final double itemHeight = itemWidth + Dimens.heightOfTheBottomContentWithOutImagePadding;

    return Padding(
      padding: isRemovePadding
          ? EdgeInsets.zero
          : const EdgeInsets.only(

        left: Dimens.space10,
        right: Dimens.space10,
        top: Dimens.space16,
      ),
      child: GridView.builder(
        shrinkWrap: true,
        padding: EdgeInsets.zero,
        itemCount: 10,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          childAspectRatio: itemWidth / itemHeight,
          crossAxisCount: AppConstant.crossAxisCount2,
          crossAxisSpacing: crossAxisSpacing,
          mainAxisSpacing: crossAxisSpacing,
        ),
        itemBuilder: (BuildContext context, int index) {
          return ProductCommonItemShimmer(
            widthOfItem: itemWidth,
            heightOfItem: itemHeight,
          );
        },
      ),
    );
  }
}
