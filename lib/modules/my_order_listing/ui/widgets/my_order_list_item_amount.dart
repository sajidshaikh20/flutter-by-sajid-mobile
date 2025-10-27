import '../../../../utils/exports.dart';

/// A widget that displays the total amount of an order and the number of items in the order.
class MyOrderListItemAmount extends StatelessWidget {
  /// Creates a [MyOrderListItemAmount] widget.
  const MyOrderListItemAmount({
    super.key,
    /// The total amount of the order.
    required this.orderTotal,
    /// The number of items in the order.
    required this.itemCount,
    /// The type of screen the widget is displayed on.
    /// Defaults to [ScreenType.mobile].
    this.device=ScreenType.mobile
  });

  /// The total amount of the order.
  final String orderTotal;

  /// The number of items in the order.
  final String itemCount;

  /// The type of screen the widget is displayed on.
  ///
  /// Determines the font sizes and spacing used in the widget.
  /// Defaults to [ScreenType.mobile].
  final ScreenType device;

  @override
  Widget build(BuildContext context) {
    double noOfItemFontSize=Dimens.fontSize16;
    double orderTotalFontSize=Dimens.fontSize20;
    double widthBox=Dimens.size20;
    switch(device){

      case ScreenType.tablet:
        noOfItemFontSize=Dimens.fontSize22;
        orderTotalFontSize=Dimens.fontSize26;
        widthBox=Dimens.size24;
       
      default:
        break;
    }

    return Row(
      children: <Widget>[
        Expanded(
          child: CustomTextLabelWidget(
            label: orderTotal,
            textAlign: TextAlign.start,
            style: context.textTheme.headlineMedium?.copyWith(
              color: MainConfig.appColors.textDarkBlueColor,
              fontWeight: FontWeight.w600,
              fontSize: orderTotalFontSize,
            ),
          ),
        ),
        widthBox.widthBox,
        Expanded(
          child: CustomTextLabelWidget(
            label: "${MainConfig.dynamicString(JsonServiceString.keyNoOfItems)} $itemCount",
            textAlign: TextAlign.start,
            style: context.textTheme.bodySmall?.copyWith(
              color: MainConfig.appColors.textColorGreyBlack,
              fontSize: noOfItemFontSize,
            ),
          ),
        ),
      ],
    );
  }
}
