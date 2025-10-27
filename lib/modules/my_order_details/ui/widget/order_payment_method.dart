import '../../../../utils/exports.dart';

/// A widget displaying the payment method details for an order.
class OrderPaymentMethod extends StatelessWidget {
  /// Initializes the widget with payment method details and device type.
  const OrderPaymentMethod({
    super.key,
    this.response,
    this.device = ScreenType.mobile,
  });

  /// The device type (e.g., mobile, tablet) for responsive layout.
  final ScreenType device;

  /// The response model containing the order payment details.
  final MyOrderDetailResponseModel? response;

  @override
  Widget build(BuildContext context) {
    double fontSizeMobTab14_20 = Dimens.fontSize14;
    double fontSizeMobTab16_25 = Dimens.fontSize16;
    SizedBox heightBoxMobTab8_16 = Dimens.size8.heightBox;

    switch (device) {
      case ScreenType.tablet:
        fontSizeMobTab14_20 = Dimens.fontSize20;
        fontSizeMobTab16_25 = Dimens.fontSize25;
        heightBoxMobTab8_16 = Dimens.size16.heightBox;

      case ScreenType.mobile:
      case ScreenType.desktop:
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        CustomTextLabelWidget(
          label: MainConfig.dynamicString(JsonServiceString.keyPaymentMethod),
          style: context.textTheme.headlineMedium?.copyWith(
            fontSize: fontSizeMobTab16_25,
            fontWeight: FontWeight.bold,
            color: MainConfig.appColors.textColorGreyBlack,
          ),
        ),
        heightBoxMobTab8_16,
        CustomTextLabelWidget(
          label: response?.paymentMethod ?? '',
          maxLines: Dimens.maxLines02,
          textAlign: TextAlign.start,
          overflow: TextOverflow.ellipsis,
          style: context.textTheme.bodyMedium?.copyWith(
            fontSize: fontSizeMobTab14_20,
            fontWeight: FontWeight.w400,
            color: MainConfig.appColors.textLabelGreyColor,
          ),
        ),
      ],
    );
  }
}
