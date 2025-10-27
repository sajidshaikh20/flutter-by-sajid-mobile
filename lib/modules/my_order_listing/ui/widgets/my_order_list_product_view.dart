import '../../../../utils/exports.dart';

/// Widget that displays product information for an order item.
class MyOrderListProductView extends StatelessWidget {
  /// Creates a my order list product view.
  const MyOrderListProductView(
      {super.key,
      required this.orderId,
      required this.date,
      required this.status,
      required this.statusColorCode,
      required this.orderTotal,
      required this.itemCount,
      required this.itemImageUrl,
      this.device = ScreenType.mobile});

  /// The unique identifier for the order.
  final String orderId;

  /// The date when the order was placed.
  final String date;

  /// The current status of the order.
  final String status;

  /// The color code for the status display.
  final String statusColorCode;

  /// The total amount of the order.
  final String orderTotal;

  /// The number of items in the order.
  final String itemCount;

  /// The URL of the item image.
  final String itemImageUrl;

  /// The screen type for responsive design.
  final ScreenType device;

  @override
  Widget build(BuildContext context) {
    double imageSize = Dimens.size80;
    double orderIdFontSize = Dimens.fontSize20;
    double sizeMobTab3_5 = Dimens.size3;
    double sizeMobTab8_12 = Dimens.size8;
    double sizeMobTab4_6 = Dimens.size4;
    double sizeMobTab10_15 = Dimens.size10;
    switch (device) {

      case ScreenType.tablet:
        imageSize = Dimens.size110;
        orderIdFontSize = Dimens.fontSize26;
        sizeMobTab3_5 = Dimens.size5;
        sizeMobTab8_12 = Dimens.size12;
        sizeMobTab4_6 = Dimens.size6;
        sizeMobTab10_15 = Dimens.size15;
       
      default:
        break;
    }

    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              if(!isLanguageAlignmentLTR)
              Dimens.size4.heightBox,
              CustomTextLabelWidget(
                label: "#$orderId",
                style: context.textTheme.headlineMedium?.copyWith(
                  color: MainConfig.appColors.textDarkBlueColor,
                  fontWeight: FontWeight.bold,
                  fontSize: orderIdFontSize,
                ),
              ),
              sizeMobTab3_5.heightBox,
              MyOrderListItemDateView(
                device: device,
                date: date,
                status: status,
                statusColorCode: statusColorCode,
              ),
              sizeMobTab8_12.heightBox,
              CustomDivider(
                height: Dimens.size1,
                color: MainConfig.appColors.dividerWhiteOfWhisperColor,
              ),
              sizeMobTab4_6.heightBox,
              MyOrderListItemAmount(
                device: device,
                orderTotal: orderTotal,
                itemCount: itemCount,
              )
            ],
          ),
        ),
        sizeMobTab10_15.widthBox,
        CustomNetworkImageWidget(
            imageUrl: itemImageUrl,
            placeHolderImage:Assets.svgs.icPlaceHolderDukkan.svg(),
            height: imageSize,
            width: imageSize)
      ],
    );
  }
}
