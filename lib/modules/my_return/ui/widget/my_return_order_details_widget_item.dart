import '../../../../utils/exports.dart';

/// Widget to display return order details in the list.
class MyReturnOrderDetailsWidgetItem extends StatelessWidget {
  /// Constructor to initialize the widget with order details and device type.
  const MyReturnOrderDetailsWidgetItem({
    required this.isPaymentSuccess,
    super.key,
    this.returnOrderItem,
    this.device = ScreenType.mobile,
  });

  /// Return order details (optional).
  final ReturnOrderItem? returnOrderItem;

  /// Payment success status for the order.
  final bool isPaymentSuccess;

  /// Device type to handle responsive design.
  final ScreenType device;

  @override
  Widget build(BuildContext context) {
    /// Padding used around the widget for spacing.
    const EdgeInsets padding = EdgeInsets.only(
      left: Dimens.space10,
      right: Dimens.space10,
      bottom: Dimens.space10,
      top: Dimens.space5,
    );

    /// Handling responsive design for different screen types.
    switch (device) {
      case ScreenType.tablet:
        const EdgeInsets.only(
          left: Dimens.space16,
          right: Dimens.space16,
          bottom: Dimens.space16,
          top: Dimens.space10,
        );
      case ScreenType.mobile:
      case ScreenType.desktop:
    }

    return Container(
      padding: padding, // Apply padding for layout.
      decoration: BoxDecorationExtension.customDecoration(
        color: MainConfig.appColors.backgroundWhiteColor, // Background color of the container.
        borderRadius: Dimens.radius5.borderRadius, // Border radius for rounded corners.
        border: Border.all(
          color: MainConfig.appColors.borderLightWhiteColor, // Border color.
        ),
      ),
      child: MyOrderListProductView(
        device: device, // Pass device type for responsive design.
        orderId: returnOrderItem?.orderId ?? '', // Display order ID, default is an empty string if not available.
        date: returnOrderItem?.createdAt ?? '', // Display order creation date, default is empty string if not available.
        status: returnOrderItem?.status ?? '', // Display order status, default is empty string if not available.
        statusColorCode: returnOrderItem?.statusColor ?? '', // Display color code for status, default is empty string.
        orderTotal: 'Id: ${3}', // Display order total, hardcoded to 3 for now.
        itemCount: 2.toString(), // Display item count, hardcoded to 2 for now.
        itemImageUrl: returnOrderItem?.productUrl ?? '', // Display product image URL, default is empty string if not available.
      ),
    );
  }
}

