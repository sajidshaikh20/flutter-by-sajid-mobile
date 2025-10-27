import '../../../utils/exports.dart';

/// Shimmer loading widget for home categories grid display.
class ShimmerCategoryWidget extends StatelessWidget {
  /// Creates a shimmer category widget.
  const ShimmerCategoryWidget({super.key});

  @override
  Widget build(BuildContext context) {
    double deviceWidth = context.width;
    const int totalHorizontalSpacing = 10 * (4 - 1); // Total spacing for 4 columns
    final double itemWidth = (deviceWidth - totalHorizontalSpacing) / Dimens.crossAxisCount4;
    const double itemHeight = Dimens.size130;

    return CustomShimmerListWidget(
      child: Padding(
        padding: const EdgeInsets.only(
          left: Dimens.space16,
          right: Dimens.space17,
          top: Dimens.space17,
        ),
        child: GridView.builder(
          physics: const NeverScrollableScrollPhysics(),
          padding: EdgeInsets.zero,
          itemCount: 8, // Show 8 shimmer items (2 rows of 4)
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            childAspectRatio: itemWidth / itemHeight,
            crossAxisCount: Dimens.crossAxisCount4,
            crossAxisSpacing: Dimens.space10,
            mainAxisSpacing: Dimens.space10,
          ),
          itemBuilder: (BuildContext context, int index) {
            return _buildShimmerCategoryItem(itemWidth);
          },
        ),
      ),
    );
  }

  /// Builds a shimmer item that matches HomeCategoryItem layout
  Widget _buildShimmerCategoryItem(double itemWidth) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        // Image container shimmer
        Container(
          width: itemWidth,
          height: Dimens.size90,
          padding: const EdgeInsets.only(
            left: Dimens.space2,
            right: Dimens.space2,
            top: Dimens.space7,
            bottom: Dimens.space5,
          ),
          decoration: BoxDecoration(
            color: MainConfig.appColors.backgroundGrayColor,
            border: Border.all(
              color: MainConfig.appColors.dukkanborderGreyLightColor,
              width: Dimens.borderWidth05,
            ),
            borderRadius: Dimens.radius8.borderRadius,
          ),
          child: const ShimmerCommonContainer(
            height: Dimens.size76,
            width: double.infinity,
            backGroundColor: Colors.transparent,
          ),
        ),
        
        const SizedBox(height: Dimens.size3),
        
        // Category name shimmer
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 2),
          child: Column(
            children: <Widget>[
              ShimmerCommonContainer(
                height: Dimens.size10,
                width: double.infinity,
              ),
              SizedBox(height: Dimens.size2),
              ShimmerCommonContainer(
                height: Dimens.size10,
                width: Dimens.size40,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
