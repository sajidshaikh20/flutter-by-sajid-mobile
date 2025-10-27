import '../../../../../utils/exports.dart';

/// A placeholder shimmer widget for displaying out-of-stock items in a list.
///
/// This widget is typically used to show a skeleton UI while fetching
/// out-of-stock item details in the cart or order summary screens.
class OutOffStockListItemShimmer extends StatelessWidget {
  /// The index of the current shimmer item in the list.
  final int index;

  /// The total number of items in the list.
  final int itemCount;

  /// The gap between consecutive shimmer items.
  final double gapBetweenItem;

  /// Creates an [OutOffStockListItemShimmer] instance.
  ///
  /// The [index] and [itemCount] are required to properly layout
  /// each shimmer item. [gapBetweenItem] defines the spacing between items.
  const OutOffStockListItemShimmer({
    super.key,
    required this.index,
    required this.itemCount,
    this.gapBetweenItem = 8.0,
  });

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,       // Base skeleton color
      highlightColor: Colors.grey.shade100,  // Shimmer highlight color
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              // Image placeholder (44x44)
              Container(
                height: Dimens.size44,
                width: Dimens.size44,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: Dimens.radius8.borderRadius,
                ),
              ),
              const SizedBox(width: Dimens.size8),
              // Expanded Column for text placeholders
              Expanded(
                child: Column(
                  children: <Widget>[
                    // Top text placeholder
                    Container(
                      height: Dimens.size14,
                      width: double.infinity,
                      color: Colors.white,
                    ),
                    const SizedBox(height: Dimens.size8),
                    // Bottom row (packs text + wishlist icon)
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: Container(
                            height: Dimens.size12,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(width: Dimens.size8),
                        Container(
                          height: Dimens.size18,
                          width: Dimens.size18,
                          color: Colors.white,
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          // Optional gap between items if this is a list
          if (index != itemCount - 1)
            SizedBox(height: gapBetweenItem),
        ],
      ),
    );
  }
}