import '../../../../../utils/exports.dart';



/// A shimmer version of the common category grid.
/// A shimmer placeholder widget for displaying a grid of categories.
///
/// This widget is used to show a loading state while category data is being fetched.
/// It displays a [GridView] of [HomeCategoryItemShimmer] widgets with shimmer animation.
class CommonCategoryShimmer extends StatelessWidget {
  /// The spacing between items along the cross axis (horizontal spacing).
  final double crossAxisSpacing;

  /// The spacing between items along the main axis (vertical spacing).
  final double mainAxisSpacing;

  /// The scroll physics of the [GridView].
  ///
  /// If null, defaults to [NeverScrollableScrollPhysics].
  final ScrollPhysics? physics;

  /// Whether the [GridView] should shrink-wrap its content.
  ///
  /// Defaults to `true`.
  final bool shrinkWrap;

  /// The number of shimmer placeholder items to display in the grid.
  ///
  /// Defaults to [AppConstant.itemCount8].
  final int itemCount;

  /// Creates a [CommonCategoryShimmer] widget.
  ///
  /// All parameters are optional and have default values.
  const CommonCategoryShimmer({
    super.key,
    this.crossAxisSpacing = Dimens.space10,
    this.mainAxisSpacing = Dimens.space10,
    this.physics,
    this.shrinkWrap = true,
    this.itemCount = AppConstant.itemCount8,
  });

  @override
  Widget build(BuildContext context) {
    // Get the device width and calculate the item width.
    double deviceWidth = MediaQuery.of(context).size.width;
    const int columnCount = Dimens.crossAxisCount4;
    int totalHorizontalSpacing =
        Dimens.space10.toInt() * (columnCount - 1); // Total spacing for columns.
    final double itemWidth = (deviceWidth - totalHorizontalSpacing) / columnCount;

    // The grid's item height is defined by Dimens.size118 in the original widget.
    const double itemHeight = Dimens.size118;

    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: GridView.builder(
        shrinkWrap: shrinkWrap,
        physics: physics ?? const NeverScrollableScrollPhysics(),
        padding: EdgeInsets.zero,
        itemCount: itemCount,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          childAspectRatio: itemWidth / itemHeight,
          crossAxisCount: columnCount,
          crossAxisSpacing: crossAxisSpacing,
          mainAxisSpacing: mainAxisSpacing,
        ),
        itemBuilder: (BuildContext context, int index) {
          return const HomeCategoryItemShimmer();
        },
      ),
    );
  }
}


/// A shimmer placeholder for a single category item.
class HomeCategoryItemShimmer extends StatelessWidget {
  ///HomeCategoryItemShimmer
  const HomeCategoryItemShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    // Calculate the width for each grid item.
    double deviceWidth = MediaQuery.of(context).size.width;
    const int columnCount = Dimens.crossAxisCount4;
     int totalHorizontalSpacing = Dimens.space10.toInt() * (columnCount - 1);
    final double itemWidth = (deviceWidth - totalHorizontalSpacing) / columnCount;

    return SizedBox.expand(
      child: Column(
        children: <Widget>[
          // Placeholder for the image container.
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
              color: MainConfig.appColors.backgroundGrayColor, // Mimic the background color.
              border: Border.all(
                color: AppColors.greyBorderColor,
                width: Dimens.borderWidth05,
              ),
              borderRadius: Dimens.radius8.borderRadius,
            ),
            child: Container(
              color: Colors.white, // Shimmer placeholder for the image.
            ),
          ),
          const SizedBox(height: Dimens.size4),
          // Placeholder for the text label.
          Container(
            width: itemWidth * 0.8, // Adjust width as needed.
            height: Dimens.size10, // Adjust height to mimic text.
            color: Colors.white,
          ),
        ],
      ),
    );
  }
}