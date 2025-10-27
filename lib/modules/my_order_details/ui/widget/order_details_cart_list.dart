import '../../../../utils/exports.dart';

/// A widget that displays a list of products in an order details view.
/// 
/// This widget shows either a shimmer loading state or the actual product list
/// with options to write reviews for each product.
class OrderDetailsCartList extends StatelessWidget {
  /// List of products to display in the cart list.
  final List<ProductListingResponse>? products;
  
  /// Whether to show shimmer loading state.
  final bool isLoading;
  
  /// Whether this is a reward order.
  final bool isReward;
  
  /// The order ID for review purposes.
  final int? orderId;

  /// Creates an [OrderDetailsCartList] widget.
  const OrderDetailsCartList({
    super.key,
    this.products,
    this.orderId,
    this.isLoading = false,
    this.isReward = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: Dimens.space16),
      child: DecoratedBox(
          decoration: BoxDecoration(
            border: Border.all(
              color: MainConfig.appColors.lightGreyColor,
              width: Dimens.borderWidth05,
            ),
            borderRadius: Dimens.space8.borderRadius,
            color: MainConfig.appColors.backgroundWhite,
          ),
          child: CustomListView(
              scrollPhysics: const NeverScrollableScrollPhysics(),
              isPadding: true,
              itemBuilder: (BuildContext context, int index) {
                // Show shimmer when loading
                if (isLoading) {
                  return OrderListViewShimmerWidget(
                    index: index,
                    isLastItem: index == 2, // Show 3 shimmer items
                  );
                }
                
                // Show actual product data
                final ProductListingResponse? product = 
                    products != null && index < products!.length 
                        ? products![index] 
                        : null;
                
                return OrderListViewWidget(
                  index: index,
                  product: product,
                  isLastItem: index == (products?.length ?? 0) - 1,
                  onWriteReviewPressed: () async {
                    await context.router
                        .push(WriteReviewRoute(
                          orderId: orderId,
                      product : product
                    ));
                  },
                );
              },
              itemCount: isLoading ? 3 : (products?.length ?? 0))), // Show 3 shimmer items when loading
    );
  }
}
