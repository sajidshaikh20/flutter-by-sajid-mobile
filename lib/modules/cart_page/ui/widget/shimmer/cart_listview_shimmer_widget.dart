import '../../../../../utils/exports.dart';
///CartListViewShimmerWidget
class CartListViewShimmerWidget extends StatelessWidget {
  /// If you need to control whether or not to show a divider, match your logic:
  /// Example: if (index != 1) show the divider. Adjust as needed.
  const CartListViewShimmerWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CustomListView(
      isPadding: true,
      itemBuilder: (BuildContext context, int index) {
        return ShimmerEffectWidget(
          child: Padding(
            padding: const EdgeInsets.all(Dimens.space8),
            child: Column(
              children: <Widget>[
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    // Product Image placeholder (72x72)
                    Container(
                      height: Dimens.size72,
                      width: Dimens.size72,
                      color: Colors.white,
                    ),
                    const SizedBox(
                      width: Dimens.size4,
                    ),
                    // Right Side Content
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          // Title & wishlist icon row
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              // Title placeholder
                              Expanded(
                                child: Container(
                                  height: Dimens.size14,
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(width: Dimens.size4),
                              // Wishlist icon placeholder
                              Container(
                                width: Dimens.size18,
                                height: Dimens.size18,
                                color: Colors.white,
                              ),
                            ],
                          ),
                          Dimens.space4.heightBox,

                          // Row for pack size & quantity
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              // Pack size placeholder
                              Container(
                                height: Dimens.size22,
                                width: Dimens.size60,
                                color: Colors.white,
                              ),
                              // Quantity button placeholder
                              Container(
                                height: Dimens.space24,
                                width: Dimens.space70,
                                color: Colors.white,
                              ),
                            ],
                          ),

                          Dimens.space11.heightBox,

                          // Row for price & delete
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              // Price placeholders
                              Row(
                                children: <Widget>[
                                  // Current price
                                  Container(
                                    width: Dimens.size40,
                                    height: Dimens.size14,
                                    color: Colors.white,
                                  ),
                                  const SizedBox(width: Dimens.size4),
                                  // Old price
                                  Container(
                                    width: Dimens.size40,
                                    height: Dimens.size14,
                                    color: Colors.white,
                                  ),
                                  const SizedBox(width: Dimens.size4),
                                  // Discount
                                  Container(
                                    width: Dimens.size40,
                                    height: Dimens.size12,
                                    color: Colors.white,
                                  ),
                                ],
                              ),
                              // Delete text placeholder
                              Container(
                                width: Dimens.size40,
                                height: Dimens.size12,
                                color: Colors.white,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                // Optional divider logic
                if (index != 1) ...<Widget>[
                  Dimens.size14.heightBox,
                  Container(
                    width: double.infinity,
                    height: Dimens.size1,
                    color: Colors.white,
                  ),
                ],
              ],
            ),
          ),
        );
      },
      itemCount: 2,
    );
  }
}
