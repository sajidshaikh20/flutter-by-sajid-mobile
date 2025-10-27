import '../../../../utils/exports.dart';



/// Widget that displays order status with appropriate styling and colors.
class OrderStatusWidget extends StatelessWidget {
  /// The order status to display.
  final OrderStatusNew status;

  /// Optional custom text style for the status display.
  final TextStyle? style;

  /// Creates an order status widget.
  const OrderStatusWidget({
    super.key,
    required this.status,
    this.style,
  });

  @override
  Widget build(BuildContext context) {
    // You can use a switch statement or a map. Here is one using switch:
    String label;
    Color bgColor;
    Color textColor;

    switch (status) {
      case OrderStatusNew.placed:
        label = context.appString.orderPlacedKey;
        bgColor = MainConfig.appColors.lightBlueBgColor;
        textColor = MainConfig.appColors.darkBlueColor;
       
      case OrderStatusNew.delivered:
        label = context.appString.deliveredKey;
        bgColor = MainConfig.appColors.lightgreenBgColor;
        textColor = MainConfig.appColors.greenColor;
      case OrderStatusNew.canceled:
        label = context.appString.cancelledKey ;
        bgColor = MainConfig.appColors.lightredBgColor;
        textColor = MainConfig.appColors.redColor;
      case OrderStatusNew.collected:
        label = context.appString.collectedKey;
        bgColor = MainConfig.appColors.lightgreenBgColor;
        textColor = MainConfig.appColors.greenColor;
    }

    return Container(
      padding: const EdgeInsets.symmetric(
          vertical: Dimens.space2, horizontal: Dimens.space4),
      decoration: BoxDecorationExtension.customDecoration(
        color: bgColor,
        borderRadius: Dimens.radius4.borderRadius,
      ),
      child: CustomTextLabelWidget(
        label: label,
        style: style ??
            context.textTheme.displayMedium?.copyWith(
              color: textColor,
              fontWeight: FontWeight.w700,
              fontSize: Dimens.fontSize12,
              height: Dimens.lineHeight14.toLineHeight(Dimens.fontSize12),
            ),
      ),
    );
  }
}