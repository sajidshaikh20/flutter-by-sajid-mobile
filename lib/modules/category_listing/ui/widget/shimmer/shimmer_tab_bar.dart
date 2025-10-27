import '../../../../../utils/exports.dart';

/// A custom widget that displays a shimmer effect for a tab bar.
/// It uses a `ListView.builder` to create a list of shimmer containers
/// to mimic the loading state of a tab bar.
class ShimmerTabBar extends StatelessWidget {
  /// A custom widget that displays a shimmer effect for a tab bar.
  /// It uses a `ListView.builder` to create a list of shimmer containers
  /// to mimic the loading state of a tab bar.
  const ShimmerTabBar({super.key});

  @override
  Widget build(BuildContext context) {
    // Applying shimmer effect with custom base and highlight colors
    return Shimmer.fromColors(
      // Base color of the shimmer effect
      baseColor: Colors.grey[Dimens.colorBand300]!,
      // Highlight color of the shimmer effect
      highlightColor: Colors.grey[Dimens.colorBand100]!,
      child: ListView.builder(
        // The builder to create shimmer container for each item
        itemBuilder: (BuildContext context, int index) => Padding(
          padding: const EdgeInsets.only(
            // Padding to create space around each shimmer item
            left: Dimens.space8,
            right: Dimens.space8,
            top: Dimens.space14,
            bottom: Dimens.space8,
          ),
          child: Container(
            // Width of each shimmer item
            width: Dimens.space80,
            // Height of each shimmer item
            height: Dimens.space20,
            decoration: BoxDecoration(
              // White background color to represent the shimmer effect
              color: Colors.white,
              // Rounded corners for each shimmer item
              borderRadius: BorderRadius.circular(Dimens.radius8),
            ),
          ),
        ),
        // The number of shimmer items to display
        itemCount: Dimens.maxLines05,
        // The scroll direction is horizontal
        scrollDirection: Axis.horizontal,
      ),
    );
  }
}
