import '../../../../utils/exports.dart';

/// Widget that displays the payment status page with success/failure information.
class PaymentStatusPageWidget extends StatelessWidget {
  /// Creates a payment status page widget.
  const PaymentStatusPageWidget({
    required this.isPaymentSuccess,
    super.key,
    this.responseModel,
    this.device = ScreenType.mobile,
  });

  /// Indicates whether the payment was successful.
  final bool isPaymentSuccess;

  /// The response model containing order details.
  final PlaceOrderResponseModel? responseModel;

  /// The screen type for responsive design.
  final ScreenType device;
  static bool _disablePopScope = false;

  @override
  Widget build(BuildContext context) {
    const double sizeMobTab_44_87 = Dimens.size44;
    const double spaceMobTab_20_40 = Dimens.space20;
    const double heightBoxMobTab_16_32 = Dimens.size16;
    const double heightBoxMobTab_23_44 = Dimens.size23;
    const double heightBoxMobTab_56_110 = Dimens.size56;
    const double fontSizeMobTab_15_22 = Dimens.fontSize15;
    const double fontSizeMobTab_18_28 = Dimens.fontSize18;
    const double fontSizeMobTab_24_32 = Dimens.fontSize24;
    deviceDimens(
      sizeMobTab_44_87,
      spaceMobTab_20_40,
      heightBoxMobTab_16_32,
      fontSizeMobTab_15_22,
      fontSizeMobTab_18_28,
      fontSizeMobTab_24_32,
      heightBoxMobTab_23_44,
      heightBoxMobTab_56_110,
    );

    return NoInternetWidget(
      device: device,
      onTryAgain: () {},
      childWidget: BlocBuilder<PaymentStatusCubit, PaymentStatusState>(
        builder: (BuildContext context, PaymentStatusState state) => PopScope(
          onPopInvokedWithResult: (bool didPop, Object? result) async {
            if (_disablePopScope) {
              // Skip PopScope handling if navigation was
              //  initiated programmatically.
              return;
            }

            await context.router
                .replaceAll(<PageRouteInfo>[const DashboardRoute()]);
          },
          child: Scaffold(
            backgroundColor: MainConfig.appColors.backgroundSmokeWhite,
            body: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: spaceMobTab_20_40,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  if (isPaymentSuccess)
                    Assets.svgs.icCheckMark.svg()
                  else
                    Assets.svgs.icPaymentFailed.svg(),
                  heightBoxMobTab_16_32.heightBox,
                  CustomTextLabelWidget(
                    label: isPaymentSuccess
                        ? MainConfig.dynamicString(
                            JsonServiceString.keyThankYou,
                          )
                        : MainConfig.dynamicString(
                            JsonServiceString.keyFailed,
                          ),
                    style: context.textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w700,
                      fontSize: fontSizeMobTab_24_32,
                      color: MainConfig.appColors.textColorGreyBlack,
                    ),
                  ),
                  CustomTextLabelWidget(
                    label: isPaymentSuccess
                        ? responseModel?.orderLabel ?? ''
                        : MainConfig.dynamicString(
                            JsonServiceString.keyYourPaymentWasNotCompleted,
                          ),
                    style: context.textTheme.bodyMedium?.copyWith(
                      fontSize: fontSizeMobTab_15_22,
                      fontWeight: FontWeight.w400,
                      color: MainConfig.appColors.textColorGreyBlack,
                    ),
                  ),
                  PaymentDetailItemView(
                    isPaymentSuccess: isPaymentSuccess,
                    paymentDetail: AppConstant.dummyPaymentDetailKey,
                    responseModel: responseModel,
                    device: device,
                  ),
                  if (isPaymentSuccess)
                    heightBoxMobTab_23_44.heightBox
                  else
                    heightBoxMobTab_56_110.heightBox,
                  CustomButtonWidget(
                    height: sizeMobTab_44_87,
                    title: isPaymentSuccess
                        ? MainConfig.dynamicString(
                            JsonServiceString.keyDoneUpper,
                          )
                        : MainConfig.dynamicString(
                            JsonServiceString.keyTryAgain,
                          ),
                    onTap: () {
                      _disablePopScope =
                          true; // Disable PopScope before navigating.
                      navigateToTab(context, 0);
                      scheduleMicrotask(() {
                        _disablePopScope =
                            false; // Re-enable PopScope after navigation.
                      });
                      // context.router.replaceAll([const DashboardRoute()]);
                    },
                    titleTextStyle: context.textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w500,
                      color: MainConfig.appColors.backgroundWhiteColor,
                      fontSize: fontSizeMobTab_18_28,
                    ),
                    device: device,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// Adjusts dimensions based on the device type for responsive design.
  void deviceDimens(
    double sizeMobTab_44_87,
    double spaceMobTab_20_40,
    double heightBoxMobTab_16_32,
    double fontSizeMobTab_15_22,
    double fontSizeMobTab_18_28,
    double fontSizeMobTab_24_32,
    double heightBoxMobTab_23_44,
    double heightBoxMobTab_56_110,
  ) {
    switch (device) {
      case ScreenType.tablet:
        sizeMobTab_44_87 = Dimens.size87;
        spaceMobTab_20_40 = Dimens.space40;
        heightBoxMobTab_16_32 = Dimens.size32;
        fontSizeMobTab_15_22 = Dimens.fontSize22;
        fontSizeMobTab_18_28 = Dimens.fontSize28;
        fontSizeMobTab_24_32 = Dimens.fontSize32;
        heightBoxMobTab_23_44 = Dimens.size44;
        heightBoxMobTab_56_110 = Dimens.size110;

      case ScreenType.mobile:
      case ScreenType.desktop:
    }
  }
}
