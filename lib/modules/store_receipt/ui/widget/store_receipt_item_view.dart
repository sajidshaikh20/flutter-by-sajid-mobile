import '../../../../utils/exports.dart';

/// A widget that displays an individual item in the list of store receipts.
class StoreReceiptItemView extends StatelessWidget {
  /// Creates a [StoreReceiptItemView] widget.
  const StoreReceiptItemView({
    super.key,
    required this.receiptList,
    required this.index,
    required this.position,
    this.device = ScreenType.mobile,
  });

  /// The list of receipts.
  final List<StoreReceipt> receiptList;

  /// The index of the receipt.
  final int index;

  /// The position of the receipt in the list.
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
        await context.router.push(MyOrderDetailRoute(
            orderId: int.tryParse(receiptList[position].receiptId ?? '')));
      },
      child: Container(
        decoration: BoxDecorationExtension.customDecoration(
          color: MainConfig.appColors.textWhiteColor,
          borderRadius: Dimens.radius8.borderRadius,
          border: Border.all(
              color: MainConfig.appColors.lightGreyColor,
              width: Dimens.borderWidth05),
        ),
        padding: Dimens.space8.padding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            MyOrderListHeaderView(
              deliveryLabel: receiptList.isNotEmpty &&
                      (receiptList[position].deliveryType?.toLowerCase() ==
                              'pickup' ||
                          receiptList[position].deliveryType?.toLowerCase() ==
                              'pickUp')
                  ? context.appString.pickupKey
                  : context.appString.deliveryKey,
              orderDate: receiptList.isNotEmpty
                  ? (receiptList[position].date ?? '')
                  : '',
              svgPath: receiptList.isNotEmpty &&
                      (receiptList[position].deliveryType?.toLowerCase() ==
                              'pickup' ||
                          receiptList[position].deliveryType?.toLowerCase() ==
                              'pickUp')
                  ? Assets.svgs.icPickupOrder.path
                  : Assets.svgs.icOrderDelivery.path,
              isHideStatus: false,
              position: position,
              isPastOrder: index == 1,
              orderStatus: receiptList.isNotEmpty
                  ? (receiptList[position].status ?? '')
                  : '',
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: Dimens.space8),
              child: DottedLine(
                height: Dimens.sizePoint5,
                color: MainConfig.appColors.lightGreyColor,
              ),
            ),
            MyOrderMiddleView(
              orderId: receiptList.isNotEmpty
                  ? (receiptList[position].receiptId ?? '')
                  : '',
              thumbUrl: receiptList.isNotEmpty
                  ? (receiptList[position].itemImageUrl ?? '')
                  : '',
              orderFinalAmount: receiptList.isNotEmpty
                  ? (receiptList[position].receiptTotal ?? '')
                  : '',
              noOfItems: receiptList.isNotEmpty
                  ? (receiptList[position].itemCount?.toString() ?? '')
                  : '',
            ),
            Padding(
              padding: const EdgeInsets.only(top: Dimens.space8),
              child: DottedLine(
                height: Dimens.sizePoint5,
                color: MainConfig.appColors.lightGreyColor,
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Dimens.size6.heightBox,
                CustomTextLabelWidget(
                  label: receiptList.isNotEmpty
                      ? (receiptList[position].storeName ?? '')
                      : '',
                  style: context.textTheme.displayMedium?.copyWith(
                    color: MainConfig.appColors.textBlackColor,
                    fontWeight: FontWeight.w500,
                    fontSize: Dimens.fontSize12,
                    height: Dimens.lineHeight14.toLineHeight(Dimens.fontSize12),
                  ),
                ),
                CustomTextLabelWidget(
                  textAlign: TextAlign.start,
                  label: receiptList.isNotEmpty
                      ? (receiptList[position].storeAddress ?? '')
                      : '',
                  style: context.textTheme.displayMedium?.copyWith(
                    color: MainConfig.appColors.creyColor,
                    fontWeight: FontWeight.w400,
                    fontSize: Dimens.fontSize11,
                    height: Dimens.lineHeight14.toLineHeight(Dimens.fontSize11),
                  ),
                ),
                CustomTextLabelWidget(
                  textAlign: TextAlign.start,
                  label: receiptList.isNotEmpty
                      ? (receiptList[position].receiptData?.receiptDate ?? '')
                      : '',
                  style: context.textTheme.displayMedium?.copyWith(
                    color: MainConfig.appColors.creyColor,
                    fontWeight: FontWeight.w400,
                    fontSize: Dimens.fontSize12,
                    height: Dimens.lineHeight16.toLineHeight(Dimens.fontSize12),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  /// Sets device-specific dimensions for tablet and mobile layouts.
  ///
  /// Modifies the provided dimension values based on the current device type.
  /// For tablet devices, it updates font sizes, margins, and padding values.
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
      SizedBox widthBox) {
    switch (device) {
      case ScreenType.tablet:
        customButtonFontSize = Dimens.fontSize20;
        titleFontSize = Dimens.fontSize22;
        marginLeft = Dimens.space32;
        marginTop = Dimens.space20;

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
