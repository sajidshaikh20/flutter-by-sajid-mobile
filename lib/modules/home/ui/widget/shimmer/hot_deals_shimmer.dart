
import '../../../../../utils/exports.dart';

/// Shimmer version for the Hot Deals section.
/// A shimmer placeholder widget representing a list of hot deal items.
///
/// This widget is typically used to show loading placeholders for hot deals
/// in a list or carousel while the actual data is being fetched.
class HotDealsShimmer extends StatelessWidget {
  /// The number of shimmer items to display.
  ///
  /// Defaults to `3`.
  final int itemCount;

  /// Creates a [HotDealsShimmer] widget.
  ///
  /// The [itemCount] parameter specifies how many placeholder items
  /// should be displayed.
  const HotDealsShimmer({
    super.key,
    this.itemCount = 3,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: Dimens.size294,
      child:
      ListView.builder(
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        itemCount: itemCount,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            margin: EdgeInsets.only(
              left: index == 0 ? Dimens.space16 : 0,
              right: Dimens.space10,
            ),
            child: const ProductCommonItemShimmer(),
          );
        },
      ),
    );
  }
}



