import '../../../../../utils/exports.dart';

/// A shimmer placeholder widget representing a common product item.
///
/// This widget is typically used as a loading placeholder for product items
/// in lists or grids while the actual data is being fetched.
class ProductCommonItemShimmer extends StatelessWidget {
  /// The height of the shimmer item.
  ///
  /// If null, a default height will be used by the parent layout.
  final double? heightOfItem;

  /// The width of the shimmer item.
  ///
  /// If null, a default width will be used by the parent layout.
  final double? widthOfItem;

  /// Creates a [ProductCommonItemShimmer] widget.
  ///
  /// [heightOfItem] and [widthOfItem] are optional and can be used to
  /// override the default dimensions.
  const ProductCommonItemShimmer({
    super.key,
    this.heightOfItem,
    this.widthOfItem,
  });

  @override
  Widget build(BuildContext context) {
    // Use your defined cell dimensions.
    double widthOfTheCell = widthOfItem ?? Dimens.widthOfTheCell;
    double heightOfTheCell = heightOfItem ?? Dimens.heightOfTheCell;
     double imageSize = widthOfTheCell - (Dimens.paddingOfCell * 2);

    return Container(
      padding: Dimens.paddingOfCell.padding,
      height: heightOfTheCell,
      width: widthOfTheCell,
      decoration: BoxDecoration(
        color: MainConfig.appColors.backgroundWhite,
        border: Border.all(
          color: MainConfig.appColors.dukkanborderGreyLightColor,
        ),
        borderRadius: Dimens.radius8.borderRadius,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          // Placeholder for the image & rating area.
          ShimmerEffect(

            child: Container(
      width: imageSize,
        height: imageSize,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: Dimens.radius6.borderRadius,
        ),
      ),
          ),

          const SizedBox(height: Dimens.size5),
          // Placeholder for product name (simulate 2 lines).
          ShimmerEffect(

            child: SizedBox(
              height: Dimens.size41,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    height: Dimens.fontSize14,
                    width: widthOfTheCell * 0.8,
                    color: Colors.white,
                    margin: const EdgeInsets.only(bottom: Dimens.space4),
                  ),
                  Container(
                    height: Dimens.fontSize14,
                    width: widthOfTheCell * 0.7,
                    color: Colors.white,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: Dimens.size3),
          // Placeholder for unit label.
          ShimmerEffect(

            child: Container(
              height: Dimens.size22,
              width: widthOfTheCell * 0.4,
              padding: const EdgeInsets.symmetric(
                horizontal: Dimens.space4,
                vertical: Dimens.space3,
              ),
              decoration: BoxDecoration(
                color: MainConfig.appColors.iceBlueColor,
                borderRadius: Dimens.radius4.borderRadius,
              ),
            ),
          ),
          const SizedBox(height: Dimens.size8),
          // Placeholder for price.
          ShimmerEffect(
            child: Container(
              height: Dimens.fontSize14,
              width: widthOfTheCell * 0.3,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: Dimens.size1),
          // Placeholder for discount row.
          ShimmerEffect(
            child: SizedBox(
              height: Dimens.size18,
              child: Row(
                children: <Widget>[
                  Container(
                    height: Dimens.fontSize14,
                    width: widthOfTheCell * 0.2,
                    color: Colors.white,
                  ),
                  const SizedBox(width: Dimens.size8),
                  Container(
                    height: Dimens.fontSize12,
                    width: widthOfTheCell * 0.25,
                    color: Colors.white,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: Dimens.size3),
          // Placeholder for Add button or quantity button.
          ShimmerEffect(
            child: Container(
              height: Dimens.size32,
              width: widthOfTheCell,
              decoration: BoxDecoration(
                // If you use a gradient in your real button, you can simulate it here.
                gradient:  LinearGradient(
                  colors: <Color>[MainConfig.appColors.mainColor, MainConfig.appColors.mainColor],
                ),
                borderRadius: Dimens.radius4.borderRadius,
              ),
            ),
          ),
        ],
      ),
    );
  }
}