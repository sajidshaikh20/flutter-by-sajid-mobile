import '../../../../utils/exports.dart';

/// Widget that displays detailed payment information with success/failure status.
class PaymentDetailItemView extends StatelessWidget {
  /// Creates a payment detail item view.
  const PaymentDetailItemView({
    required this.isPaymentSuccess, required this.paymentDetail, super.key,
    this.responseModel,
    this.device = ScreenType.mobile,
  });

  /// Indicates whether the payment was successful.
  final bool isPaymentSuccess;

  /// The payment detail model containing transaction information.
  final PaymentDetailModel paymentDetail;

  /// The response model containing order details.
  final PlaceOrderResponseModel? responseModel;

  /// The screen type for responsive design.
  final ScreenType device;

  @override
  Widget build(BuildContext context) {
    double fontSizeMobTab_13_18 = Dimens.fontSize13;
    double fontSizeMobTab_14_20 = Dimens.fontSize14;
    SizedBox heightBoxMobTab_8_16 = Dimens.size8.heightBox;
    SizedBox heightBoxMobTab_5_10 = Dimens.size5.heightBox;
    SizedBox heightBoxMobTab_24_48 = Dimens.size24.heightBox;
    double bottomPadding = Dimens.space8;
    double spaceMobTab_25_35 = Dimens.space25;
    double spaceMobTab_20_40 = Dimens.space20;
    double firstLastFontSize = Dimens.fontSize25;
    switch (device) {
      case ScreenType.tablet:
        fontSizeMobTab_13_18 = Dimens.fontSize18;
        fontSizeMobTab_14_20 = Dimens.fontSize20;
        bottomPadding = Dimens.space16;
        heightBoxMobTab_8_16 = Dimens.size16.heightBox;
        heightBoxMobTab_5_10 = Dimens.size10.heightBox;
        firstLastFontSize = Dimens.fontSize34;
        spaceMobTab_25_35 = Dimens.space35;
        spaceMobTab_20_40 = Dimens.space40;
        heightBoxMobTab_24_48 = Dimens.size48.heightBox;

      case ScreenType.mobile:
      case ScreenType.desktop:
    }

    return Container(
      margin: EdgeInsets.only(
        top: spaceMobTab_25_35,
      ),
      decoration: BoxDecorationExtension.customDecoration(
        borderRadius: Dimens.radius6.borderRadius,
        border: Border.all(
          color: MainConfig.appColors.borderColorWhite,
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          heightBoxMobTab_5_10,
          CustomTextLabelWidget(
            label: isPaymentSuccess
                ? '${responseModel?.amountLabel ?? ''}'
                    ' ${responseModel?.formattedTotal ?? ''}'
                : '${MainConfig.dynamicString(JsonServiceString.keyFailed)}'
                    ' ${paymentDetail.amount}',
            style: context.textTheme.headlineMedium?.copyWith(
              fontWeight: FontWeight.w600,
              fontSize: firstLastFontSize,
              color: isPaymentSuccess
                  ? MainConfig.appColors.greenColor
                  : MainConfig.appColors.textRedColor,
            ),
          ),
          CustomTextLabelWidget(
            label: isPaymentSuccess
                ? responseModel?.date ?? ''
                : '${paymentDetail.date}, ${paymentDetail.time}',
            style: context.textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.w400,
              fontSize: fontSizeMobTab_13_18,
              color: MainConfig.appColors.textBlackColor,
            ),
          ),
          heightBoxMobTab_8_16,
          CustomDivider(
            height: Dimens.size1,
            color: MainConfig.appColors.dividerGreyColor,
          ),
          Padding(
            padding: bottomPadding.padding,
            child: isPaymentSuccess
                ? Column(
                    children: <Widget>[
                      heightBoxMobTab_24_48,
                      commonPadding(
                        child: OrderDetailSummaryItemView(
                          title: MainConfig.dynamicString(
                            JsonServiceString.keyTransactionId,
                          ),
                          titleStyle: context.textTheme.bodyMedium?.copyWith(
                            fontSize: fontSizeMobTab_14_20,
                            color: MainConfig.appColors.textColorGreyBlack,
                            fontWeight: FontWeight.w400,
                          ),
                          price: responseModel?.incrementId ?? '',
                          priceStyle: context.textTheme.bodyMedium?.copyWith(
                            fontSize: fontSizeMobTab_14_20,
                            color: MainConfig.appColors.textBlackColor,
                            fontWeight: FontWeight.w600,
                          ),
                          device: device,
                        ),
                        bottomPadding: spaceMobTab_20_40,
                      ),
                      commonPadding(
                        child: OrderDetailSummaryItemView(
                          title: MainConfig.dynamicString(
                            JsonServiceString.keyDeliveryDate,
                          ),
                          titleStyle: context.textTheme.bodyMedium?.copyWith(
                            fontSize: fontSizeMobTab_14_20,
                            color: MainConfig.appColors.textColorGreyBlack,
                            fontWeight: FontWeight.w400,
                          ),
                          price: responseModel
                                  ?.timeslotDetails?.orderDeliveryDate ??
                              '',
                          priceStyle: context.textTheme.bodyMedium?.copyWith(
                            fontSize: fontSizeMobTab_14_20,
                            color: MainConfig.appColors.textBlackColor,
                            fontWeight: FontWeight.w600,
                          ),
                          device: device,
                        ),
                        bottomPadding: spaceMobTab_20_40,
                      ),
                      commonPadding(
                        child: OrderDetailSummaryItemView(
                          title: MainConfig.dynamicString(
                            JsonServiceString.keyDeliveryTime,
                          ),
                          titleStyle: context.textTheme.bodyMedium?.copyWith(
                            fontSize: fontSizeMobTab_14_20,
                            color: MainConfig.appColors.textColorGreyBlack,
                            fontWeight: FontWeight.w400,
                          ),
                          price: responseModel
                                  ?.timeslotDetails?.orderDeliveryTime ??
                              '',
                          priceStyle: context.textTheme.bodyMedium?.copyWith(
                            fontSize: fontSizeMobTab_14_20,
                            color: MainConfig.appColors.textBlackColor,
                            fontWeight: FontWeight.w600,
                          ),
                          device: device,
                        ),
                        bottomPadding: spaceMobTab_20_40,
                      ),
                      commonPadding(
                        child: OrderDetailSummaryItemView(
                          title: MainConfig.dynamicString(
                            JsonServiceString.keyOrderNo,
                          ),
                          titleStyle: context.textTheme.bodyMedium?.copyWith(
                            fontSize: fontSizeMobTab_14_20,
                            color: MainConfig.appColors.textColorGreyBlack,
                            fontWeight: FontWeight.w400,
                          ),
                          price: '#${responseModel?.incrementId ?? ''}',
                          priceStyle: context.textTheme.bodyMedium?.copyWith(
                            fontSize: fontSizeMobTab_14_20,
                            color: MainConfig.appColors.textBlackColor,
                            fontWeight: FontWeight.w600,
                          ),
                          device: device,
                        ),
                        bottomPadding: spaceMobTab_20_40,
                      ),
                    ],
                  )
                : Column(
                    children: <Widget>[
                      heightBoxMobTab_24_48,
                      ...paymentDetail.transactionDetails.entries
                          .toList()
                          .asMap()
                          .entries
                          .where(
                            (MapEntry<int, MapEntry<String, String>> entry) => isPaymentSuccess
                                ? entry.key !=
                                    paymentDetail.transactionDetails.length
                                : entry.key !=
                                    paymentDetail.transactionDetails.length - 1,
                          )
                          .map(
                            (MapEntry<int, MapEntry<String, String>> entry) => commonPadding(
                              child: OrderDetailSummaryItemView(
                                title: entry.value.key,
                                titleStyle:
                                    context.textTheme.bodyMedium?.copyWith(
                                  fontSize: fontSizeMobTab_14_20,
                                  color: MainConfig.appColors.textColorGreyBlack,
                                  fontWeight: FontWeight.w400,
                                ),
                                price: entry.value.value,
                                priceStyle:
                                    context.textTheme.bodyMedium?.copyWith(
                                  fontSize: fontSizeMobTab_14_20,
                                  color: MainConfig.appColors.textBlackColor,
                                  fontWeight: FontWeight.w600,
                                ),
                                device: device,
                              ),
                              bottomPadding: spaceMobTab_20_40,
                            ),
                          ),
                    ],
                  ),
          ),
        ],
      ),
    );
  }

  /// Creates a padded widget with optional custom padding.
  Widget commonPadding({
    required Widget child,
    double bottomPadding = Dimens.space20,
    EdgeInsetsGeometry? padding,
  }) =>
      Padding(
        padding: padding ?? EdgeInsets.only(bottom: bottomPadding),
        child: child,
      );
}
