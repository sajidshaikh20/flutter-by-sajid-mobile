
import '../../../../utils/exports.dart';

/// Widget that displays the bottom section of an order item with action buttons.
class MyOrderListBottomView extends StatelessWidget {
  /// Creates a my order list bottom view.
  const MyOrderListBottomView({super.key, this.isPastOrder = false, this.orderId, this.order});

  /// Whether this is a past order (affects available actions).
  final bool isPastOrder;

  /// The ID of the order.
  final String? orderId;

  /// The order response data.
  final ListOfMyOrderResponse? order;
  @override
  Widget build(BuildContext context) {
    return isPastOrder ? Padding(
      padding: const EdgeInsets.symmetric(vertical: Dimens.space12),
      child: InkWell(
        onTap: () async {
          if (order != null) {
            // Call reorder API
            await context.read<MyOrderListCubit>().callReOrderApi(orderId);
          }
        },
        child: CustomTextLabelWidget(
          label: context.appString.reorderKey,
          style: context.textTheme.displayMedium?.copyWith(
              color: MainConfig.appColors.mainColor,
              fontWeight: FontWeight.w700,
              fontSize: Dimens.fontSize14,
              height:
              Dimens.lineHeight16.toLineHeight(Dimens.fontSize14)),
        ),
      ),
    ):Padding(
      padding: const EdgeInsets.symmetric(vertical: Dimens.space12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[

          CustomTextLabelWidget(
            label: context.appString.trackOrderKey,
            style: context.textTheme.displayMedium?.copyWith(
                color: MainConfig.appColors.mainColor,
                fontWeight: FontWeight.w700,
                fontSize: Dimens.fontSize14,
                height:
                Dimens.lineHeight16.toLineHeight(Dimens.fontSize14)),
          ),
          if (!_isOrderCanceled())
            SizedBox(
              height: Dimens.size18,
              child: VerticalDivider(
                thickness: Dimens.sizePoint5,
                width:  Dimens.size0,
                color: MainConfig.appColors.lightGreyColor,
              ),
            ),
          if (!_isOrderCanceled())
            InkWell(
              onTap: () async {
                if (orderId != null) {
                  // Show confirmation dialog before canceling order
                  showCustomDialog(
                    context.appString.cancelOrderConformationKey,
                    title: context.appString.cancelOrderKey,
                    okBtnTitle: context.appString.yesKey,
                    onOkClicked: () async {
                      if (orderId != null) {
                        // Call cancel order API
                        await context.read<MyOrderListCubit>().callCancelOrderApi(orderId);
                      }
                    },
                    cancelBtnTitle: context.appString.cancelKey,
                    onCancelClicked: () => goBack(context),
                  );
                }
              },
              child: CustomTextLabelWidget(
                label: context.appString.cancelOrderkey,
                style: context.textTheme.displayMedium?.copyWith(
                    color: MainConfig.appColors.mainColor,
                    fontWeight: FontWeight.w700,
                    fontSize: Dimens.fontSize14,
                    height:
                    Dimens.lineHeight16.toLineHeight(Dimens.fontSize14)),
              ),
            ),
        ],
      ),
    );
  }

  /// Helper method to check if the order is canceled, delivered, or collected (should not show cancel button)
  bool _isOrderCanceled() {
    if (order?.mashkorStatus == null) return false;
    
    final String lowerStatus = order!.mashkorStatus!.toLowerCase().trim();
    
    // Check if status matches OrderStatusNew.canceled, OrderStatusNew.delivered, or OrderStatusNew.collected
    try {
      final OrderStatusNew status = OrderStatusNew.values.firstWhere(
        (OrderStatusNew e) => e.name.toLowerCase() == lowerStatus,
      );
      return status == OrderStatusNew.canceled || 
             status == OrderStatusNew.delivered || 
             status == OrderStatusNew.collected;
    } on StateError {
      // If no exact enum match found, check for common status string variations
      return lowerStatus == 'canceled' || 
             lowerStatus == 'cancelled' ||
             lowerStatus == 'delivered' ||
             lowerStatus == 'collected' ||
             lowerStatus == AppConstant.pickupStarted.toLowerCase();
    }
  }
}
