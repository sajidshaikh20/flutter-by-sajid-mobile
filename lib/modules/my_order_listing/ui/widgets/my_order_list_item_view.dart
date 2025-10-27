import '../../../../utils/exports.dart';

/// A widget that displays an individual item in the list of orders.
class MyOrderListItemView extends StatelessWidget {
  /// Creates a [MyOrderListItemView] widget.
  ///
  /// The [orderList], [index], [isApiLoading], and [position] arguments
  /// must not be null.
  ///
  /// The [device] argument defaults to [ScreenType.mobile].
  ///
  /// Args:
  ///  [orderList]: The list of orders.
  ///  [index]: The index of the order in the list.
  ///  [isApiLoading]: Whether the API is currently loading.
  ///  [position]: The position of the order in the list.
  ///  [device]: The device type. Defaults to [ScreenType.mobile].

  const MyOrderListItemView({
    super.key,
    required this.myOrder,
    required this.index,
    required this.isApiLoading,
    required this.position,
    this.device = ScreenType.mobile,
    this.isPastOrder = false,

  });

  /// Whether this order is a past order.
  final bool isPastOrder;

  /// The list of orders.
  final ListOfMyOrderResponse myOrder;
  /// The index of the order.
  final int index;
  /// Whether the API is currently loading.
  final bool isApiLoading;
  /// The position of the order in the list.
  final int position;
  /// The device type.
  final ScreenType device;

  @override
  Widget build(BuildContext context) {
    double customButtonFontSize = Dimens.fontSize15;
    double titleFontSize = Dimens.fontSize18;
    double marginLeft = Dimens.space16;
    double marginTop = Dimens.space14;
    double marginRight = Dimens.space16;

    double paddingLeft = Dimens.space12;
    double paddingBottom = Dimens.space10;
    double paddingRight = Dimens.space12;
    SizedBox heightBox = Dimens.size30.heightBox;
    SizedBox widthBox = Dimens.size20.widthBox;

    deviceDimens(
        customButtonFontSize,
        titleFontSize,
        marginLeft,
        marginTop,
        marginRight,
        paddingLeft,
        paddingBottom,
        paddingRight,
        heightBox,
        widthBox);

    return InkWell(
      splashFactory: NoSplash.splashFactory,
      splashColor: MainConfig.appColors.transparent,
      highlightColor: MainConfig.appColors.transparent,
      overlayColor: WidgetStateProperty.all(Colors.transparent),
      onTap: () async {
        await context.router.push(MyOrderDetailRoute(orderId: myOrder.orderId));
      },
      child:
      Padding(
        padding: const EdgeInsets.only(
            left: Dimens.space16,
            right: Dimens.space16,
            bottom: Dimens.space16),
        child: Container(

          decoration: BoxDecorationExtension.customDecoration(
            color: MainConfig.appColors.textWhiteColor,
            borderRadius: Dimens.radius8.borderRadius,
            border: Border.all(
                color: MainConfig.appColors.lightGreyColor, width: Dimens.borderWidth05),
          ),
          padding: const EdgeInsets.only(
            left: Dimens.space8,
            right: Dimens.space8,
            top: Dimens.space8,
          ),
          child: Column(
            children: <Widget>[
              MyOrderListHeaderView(
                svgPath: (myOrder.orderType?.toLowerCase().trim() == AppConstant.pickup1)
                    ? Assets.svgs.icPickupOrder.path
                    : Assets.svgs.icOrderDelivery.path,
                deliveryLabel: myOrder.orderType?.toTitleCaseConvert ?? '',
                orderDate: myOrder.orderDate ?? '',
                position: position,
                isPastOrder: isPastOrder ,
                orderStatus: myOrder.mashkorStatus?.toLowerCase() ?? '',
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: Dimens.space8),
                child: DottedLine(
                  height: Dimens.sizePoint5,
                  color: MainConfig.appColors.lightGreyColor,
                ),
              ),
              MyOrderMiddleView(
                orderId: myOrder.orderId.toString(),
                noOfItems: myOrder.noOfItems.toString(),
                orderFinalAmount: myOrder.orderFinalAmount.toString(),
                thumbUrl: myOrder.firstProduct?.thumbUrl.toString(),
              ),
              Padding(
                padding: const EdgeInsets.only(top: Dimens.space8),
                child: DottedLine(
                  height: Dimens.sizePoint5,
                  color: MainConfig.appColors.lightGreyColor,
                ),
              ),


              MyOrderListBottomView(
                isPastOrder: isPastOrder,
                orderId: myOrder.orderId?.toString(),
                order: myOrder,
              )
            ],
          ),
        ),
      ),
    );
  }

  /// Adjusts dimensions based on the device type for responsive design.
  void deviceDimens(
      double customButtonFontSize,
      double titleFontSize,
      double marginLeft,
      double marginTop,
      double marginRight,
      double paddingLeft,
      double paddingBottom,
      double paddingRight,
      SizedBox heightBox,
      SizedBox widthBox)
  {
    switch (device) {
      case ScreenType.tablet:
        customButtonFontSize = Dimens.fontSize20;
        titleFontSize = Dimens.fontSize22;
        marginLeft = Dimens.space32;
        marginTop = Dimens.space20;
        marginRight = Dimens.space32;

        paddingLeft = Dimens.space24;
        paddingBottom = Dimens.space20;
        paddingRight = Dimens.space24;
        heightBox = Dimens.size60.heightBox;
        widthBox = Dimens.size40.widthBox;

      default:
        break;
    }
  }
}
