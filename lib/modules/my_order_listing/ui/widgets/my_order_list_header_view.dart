import '../../../../utils/exports.dart';

/// Widget that displays the header section of an order item with status and date information.
class MyOrderListHeaderView extends StatelessWidget {
  /// Creates a my order list header view.
  const MyOrderListHeaderView({
    super.key,
    this.isPastOrder = false,
    required this.position,
    this.isHideStatus = true,
    this.svgPath, // optional path
    required this.deliveryLabel, // required label
    required this.orderDate, // required label
    required this.orderStatus, // required label
  });

  /// Whether this is a past order.
  final bool isPastOrder;

  /// The position/index of this order in the list.
  final int position;

  /// Whether to hide the status information.
  final bool isHideStatus;

  /// The SVG asset path for the status icon.
  final String? svgPath;

  /// The delivery label text.
  final String deliveryLabel;

  /// The order date string.
  final String orderDate;

  /// The order status string.
  final String orderStatus;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        OrderStatusIcon(
          svgPath: svgPath ?? Assets.svgs.icHomeFastDelivery.path,
        ),
        const SizedBox(width: Dimens.size8),
        Expanded(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              CustomTextLabelWidget(
                label: deliveryLabel, // now using passed value
                style: context.textTheme.displayMedium?.copyWith(
                  color: MainConfig.appColors.textBlackColor,
                  fontWeight: FontWeight.w700,
                  fontSize: Dimens.fontSize14,
                  height: Dimens.lineHeight16.toLineHeight(Dimens.fontSize14),
                ),
              ),
              CustomTextLabelWidget(
                textDirection: TextDirection.ltr,
                label: orderDate,
                style: context.textTheme.displayMedium?.copyWith(
                  color: MainConfig.appColors.creyColor,
                  fontWeight: FontWeight.w400,
                  fontSize: Dimens.fontSize12,
                  height: Dimens.lineHeight14.toLineHeight(Dimens.fontSize12),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: Dimens.size8),
        if (isHideStatus && orderStatus.isNotEmpty)
          OrderStatusWidget(
            status: _getOrderStatus(orderStatus),
          ),
      ],
    );
  }

  /// Helper method to determine OrderStatusNew based on order status string
  OrderStatusNew _getOrderStatus(String status) {
    final String lowerStatus = status.toLowerCase().trim();
    
    // Handle special case: pickupStarted maps to collected
    if (lowerStatus == AppConstant.pickupStarted) {
      return OrderStatusNew.collected;
    }
    
    // Try to find exact match with enum names
    try {
      return OrderStatusNew.values.firstWhere(
        (OrderStatusNew e) => e.name.toLowerCase() == lowerStatus,
      );
    } on StateError {
      // If no exact match found, return default status
      return OrderStatusNew.placed;
    }
  }
}
