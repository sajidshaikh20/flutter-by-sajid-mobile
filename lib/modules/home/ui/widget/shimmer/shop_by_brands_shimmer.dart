import '../../../../../utils/exports.dart';

/// A shimmer placeholder widget representing a horizontal list of brands.
///
/// This widget is typically used as a loading placeholder for brand items
/// while the actual data is being fetched. It displays a horizontal
/// [ListView] of placeholder containers with shimmer effect.
class ShopByBrandsShimmer extends StatelessWidget {
  /// The number of shimmer placeholder items to display.
  ///
  /// Defaults to `5`.
  final int itemCount;

  /// Creates a [ShopByBrandsShimmer] widget.
  ///
  /// The [itemCount] parameter specifies how many placeholder brand items
  /// should be displayed.
  const ShopByBrandsShimmer({
    super.key,
    this.itemCount = 5,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: Dimens.size78,
      child: Shimmer.fromColors(
        baseColor: Colors.grey.shade300,
        highlightColor: Colors.grey.shade100,
        child: ListView.builder(
          itemCount: itemCount,
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemBuilder: (BuildContext context, int index) {
            return Container(
              margin: EdgeInsets.only(
                left: index == 0 ? Dimens.space16 : 0,
                right: Dimens.space10,
              ),
              width: Dimens.size78,
              height: Dimens.size78,
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(
                  color: MainConfig.appColors.dividerGreyColor,
                  width: Dimens.borderWidth05,
                ),
                borderRadius: Dimens.radius8.borderRadius,
              ),
            );
          },
        ),
      ),
    );
  }
}
