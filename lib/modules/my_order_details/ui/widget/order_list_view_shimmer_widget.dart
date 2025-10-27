import '../../../../utils/exports.dart';

/// A shimmer placeholder widget for displaying an order item in a list.
///
/// This widget is typically used to indicate loading state while the actual
/// order data is being fetched. It can adjust its layout if it is the last item.
class OrderListViewShimmerWidget extends StatelessWidget {
  /// The index of the item in the list.
  ///
  /// Optional and can be null if not needed.
  final int? index;

  /// Indicates whether this item is the last in the list.
  ///
  /// This can be used to adjust spacing or layout for the last item.
  final bool isLastItem;

  /// Creates an [OrderListViewShimmerWidget].
  ///
  /// The [isLastItem] defaults to `false`.
  const OrderListViewShimmerWidget({
    super.key,
    this.index,
    this.isLastItem = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(Dimens.space8),
      child: Column(
        children: <Widget>[
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              // Product Image Shimmer
              Shimmer.fromColors(
                baseColor: AppColors.shimmerBaseColor,
                highlightColor: AppColors.shimmerHighlightColor,
                child: Container(
                  height: Dimens.size64,
                  width: Dimens.size64,
                  decoration: BoxDecorationExtension.customDecoration(
                    color: MainConfig.appColors.backgroundWhite,
                    borderRadius: Dimens.radius8.borderRadius,
                  ),
                ),
              ),
              Dimens.space12.widthBox,

              // Right side content shimmer
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    // Title shimmer
                    Shimmer.fromColors(
                      baseColor: AppColors.shimmerBaseColor,
                      highlightColor: AppColors.shimmerHighlightColor,
                      child: Container(
                        height: Dimens.size16,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: MainConfig.appColors.backgroundWhite,
                          borderRadius: Dimens.radius4.borderRadius,
                        ),
                      ),
                    ),
                    Dimens.space4.heightBox,
                    
                    // UOM shimmer
                    Shimmer.fromColors(
                      baseColor: AppColors.shimmerBaseColor,
                      highlightColor: AppColors.shimmerHighlightColor,
                      child: Container(
                        height: Dimens.size22,
                        width: Dimens.size60,
                        decoration: BoxDecoration(
                          color: MainConfig.appColors.backgroundWhite,
                          borderRadius: Dimens.radius4.borderRadius,
                        ),
                      ),
                    ),
                    Dimens.space4.heightBox,
                    
                    // Price and rating row shimmer
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        // Price shimmer
                        Shimmer.fromColors(
                          baseColor: AppColors.shimmerBaseColor,
                          highlightColor: AppColors.shimmerHighlightColor,
                          child: Container(
                            height: Dimens.size16,
                            width: Dimens.size80,
                            decoration: BoxDecoration(
                              color: MainConfig.appColors.backgroundWhite,
                              borderRadius: Dimens.radius4.borderRadius,
                            ),
                          ),
                        ),
                        
                        // Rating shimmer
                        Shimmer.fromColors(
                          baseColor: AppColors.shimmerBaseColor,
                          highlightColor: AppColors.shimmerHighlightColor,
                          child: Container(
                            height: Dimens.size16,
                            width: Dimens.size60,
                            decoration: BoxDecoration(
                              color: MainConfig.appColors.backgroundWhite,
                              borderRadius: Dimens.radius4.borderRadius,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          if (index != null && !isLastItem) ...<Widget>[
            // Divider for non-last items
            Dimens.size14.heightBox,
            CustomDivider(
              width: double.infinity,
              height: Dimens.size1,
              color: MainConfig.appColors.dividerColor,
            ),
          ],
        ],
      ),
    );
  }
}
