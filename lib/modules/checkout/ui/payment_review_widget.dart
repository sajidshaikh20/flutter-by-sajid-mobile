import '../../../utils/exports.dart';

/// A widget that displays the payment review screen.
/// This widget adjusts its layout based on the device type
/// (mobile, tablet, or desktop).
class PaymentReviewWidget extends StatelessWidget {
  /// Creates a [PaymentReviewWidget].
  ///
  /// The [device] parameter determines the layout based on the screen size:
  /// - [ScreenType.mobile] for mobile layout
  /// - [ScreenType.tablet] for tablet layout
  /// - [ScreenType.desktop] for desktop layout
  const PaymentReviewWidget({super.key, this.device = ScreenType.mobile});

  /// The device type (mobile, tablet, or desktop) to determine the layout.
  ///
  /// This variable allows the widget to adjust its layout and behavior
  /// according to
  /// the screen size or type of device.
  final ScreenType device;

  @override
  Widget build(BuildContext context) {
    double fontsizeMobtab1522 = Dimens.fontSize15;
    double fontsizeMobtab1625 = Dimens.fontSize16;
    double fontsizeMobtab1727 = Dimens.fontSize17;
    double fontsizeMobtab1830 = Dimens.fontSize18;
    double spaceMobtab48 = Dimens.space4;
    double spaceMobtab3955 = Dimens.space39;
    double spaceMobtab816 = Dimens.space8;
    double spaceMobtab1020 = Dimens.space10;
    double heightboxMobtab3060 = Dimens.size30;
    double bottomPadding = Dimens.space8;
    double topPadding = Dimens.space4;
    double heightboxMobtab1020 = Dimens.size10;

    switch (device) {
      case ScreenType.tablet:
        fontsizeMobtab1522 = Dimens.fontSize22;
        fontsizeMobtab1625 = Dimens.fontSize25;
        fontsizeMobtab1727 = Dimens.fontSize27;
        fontsizeMobtab1830 = Dimens.fontSize25;
        spaceMobtab1020 = Dimens.space20;
        bottomPadding = Dimens.space16;
        topPadding = Dimens.space8;
        heightboxMobtab3060 = Dimens.size60;
        heightboxMobtab1020 = Dimens.size20;
        spaceMobtab816 = Dimens.space16;
        spaceMobtab48 = Dimens.space8;
        spaceMobtab3955 = Dimens.space55;

      case ScreenType.mobile:
      case ScreenType.desktop:
    }

    return NoInternetWidget(
      device: device,
      onTryAgain: () async {

      },
      childWidget: BlocConsumer<PaymentCubit, PaymentState>(
        builder: (BuildContext context, PaymentState state) => Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: CustomSearchAppBar(
            isBackIconVisible: true,
            onTap: () {
              unawaited(
                context.router.maybePop(),
              );
            },
            device: device,
          ),
          body: SafeArea(
            child: Column(
              children: <Widget>[
                Expanded(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: bottomPadding.padding,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Visibility(
                            visible: state.paymentMethods?.isNotEmpty ?? false,
                            replacement: ShimmerEffect(
                              child: CommonContainer(
                                padding: EdgeInsets.zero,
                                height: Dimens.size15,
                                width: Dimens.size100,
                                backgroundColor:
                                    MainConfig.appColors.backgroundWhiteColor,
                              ),
                            ),
                            child: CustomTextLabelWidget(
                              label: MainConfig.dynamicString(
                                JsonServiceString.keySelectPaymentType,
                              ),
                              style: context.textTheme.titleMedium?.copyWith(
                                color: AppColors.greyDarkBlackColor,
                                fontSize: fontsizeMobtab1830,
                              ),
                            ),
                          ),
                          heightboxMobtab1020.heightBox,
                          PaymentTypePage(
                            paymentMethods:
                                state.paymentMethods ?? <PaymentMethodResponse>[],
                            onChangeValueCallback: (int value) {

                            },
                            device: device,
                          ),
                          if (state.reviewPaymentResponse == null)
                            Dimens.size15.heightBox,
                          Visibility(
                            visible: state.reviewPaymentResponse != null,
                            replacement: CommonContainer(
                              padding: EdgeInsets.zero,
                              boxDecoration:
                                  BoxDecorationExtension.customDecoration(
                                color:
                                    MainConfig.appColors.backgroundWhiteColor,
                                borderRadius: Dimens.space5.borderRadius,
                                border: Dimens.borderWidth1.borderAll(
                                  color: MainConfig
                                      .appColors.dukkanborderGreyLightColor,
                                ),
                              ),
                              childWidgets: const DeliveryShimmerWidget(),
                            ),
                            child: CommonContainer(
                              margin: EdgeInsets.only(bottom: spaceMobtab1020),
                              padding: EdgeInsets.zero,
                              boxDecoration:
                                  BoxDecorationExtension.customDecoration(
                                color:
                                    MainConfig.appColors.backgroundWhiteColor,
                                borderRadius: Dimens.space5.borderRadius,
                                border: Dimens.borderWidth1.borderAll(
                                  color: MainConfig
                                      .appColors.dukkanborderGreyLightColor,
                                ),
                              ),
                              childWidgets: Padding(
                                padding: spaceMobtab816.padding,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    CustomTextLabelWidget(
                                      label: MainConfig.dynamicString(
                                        JsonServiceString
                                            .keyDeliveryInformation,
                                      ),
                                      style: context.textTheme.headlineSmall
                                          ?.copyWith(
                                        fontSize: fontsizeMobtab1625,
                                        color: MainConfig
                                            .appColors.textDarkBlackColor,
                                      ),
                                    ),
                                    Dimens.space3.heightBox,
                                    Visibility(
                                      visible: state
                                              .reviewPaymentResponse
                                              ?.timeslotDetails
                                              ?.orderDeliveryDate
                                              ?.isNotEmpty ??
                                          false,
                                      child: getPaymentSummary(
                                        context,
                                        MainConfig.dynamicString(
                                          JsonServiceString.keyDeliveryDate,
                                        ),
                                        state
                                                .reviewPaymentResponse
                                                ?.timeslotDetails
                                                ?.orderDeliveryDate ??
                                            '',
                                        style: context.textTheme.titleMedium
                                            ?.copyWith(
                                          color: MainConfig
                                              .appColors.textDarkBlackColor,
                                          fontSize: fontsizeMobtab1522,
                                        ),
                                      ),
                                    ),
                                    Visibility(
                                      visible: state
                                              .reviewPaymentResponse
                                              ?.timeslotDetails
                                              ?.orderDeliveryTime
                                              ?.isNotEmpty ??
                                          false,
                                      child: getPaymentSummary(
                                        context,
                                        MainConfig.dynamicString(
                                          JsonServiceString.keyDeliveryTime,
                                        ),
                                        state
                                                .reviewPaymentResponse
                                                ?.timeslotDetails
                                                ?.orderDeliveryTime ??
                                            '',
                                        style: context.textTheme.titleMedium
                                            ?.copyWith(
                                          color: MainConfig
                                              .appColors.textDarkBlackColor,
                                          fontSize: fontsizeMobtab1522,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Visibility(
                            visible: state.reviewPaymentResponse != null,
                            replacement: CommonContainer(
                              padding: EdgeInsets.zero,
                              margin: EdgeInsets.only(top: spaceMobtab1020),
                              boxDecoration:
                                  BoxDecorationExtension.customDecoration(
                                color:
                                    MainConfig.appColors.backgroundWhiteColor,
                                borderRadius: Dimens.space5.borderRadius,
                                border: Dimens.borderWidth1.borderAll(
                                  color: MainConfig
                                      .appColors.dukkanborderGreyLightColor,
                                ),
                              ),
                              childWidgets:
                                  const CheckoutSummaryShimmerWidget(),
                            ),
                            child: CommonContainer(
                              padding: EdgeInsets.zero,
                              boxDecoration:
                                  BoxDecorationExtension.customDecoration(
                                color:
                                    MainConfig.appColors.backgroundWhiteColor,
                                borderRadius: Dimens.space5.borderRadius,
                                border: Dimens.borderWidth1.borderAll(
                                  color: MainConfig
                                      .appColors.dukkanborderGreyLightColor,
                                ),
                              ),
                              childWidgets: Padding(
                                padding: spaceMobtab816.padding,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    CustomTextLabelWidget(
                                      label: MainConfig.dynamicString(
                                        JsonServiceString.keyOrderSummery,
                                      ),
                                      style: context.textTheme.headlineSmall
                                          ?.copyWith(
                                        color: MainConfig
                                            .appColors.textDarkBlackColor,
                                        fontSize: fontsizeMobtab1727,
                                      ),
                                    ),
                                    Dimens.space3.heightBox,
                                    Visibility(
                                      visible: state
                                              .reviewPaymentResponse
                                              ?.orderReviewData
                                              ?.totals
                                              ?.subtotal
                                              ?.value
                                              ?.isNotEmpty ??
                                          false,
                                      child: getPaymentSummary(
                                        context,
                                        state
                                                .reviewPaymentResponse
                                                ?.orderReviewData
                                                ?.totals
                                                ?.subtotal
                                                ?.title ??
                                            '',
                                        state
                                                .reviewPaymentResponse
                                                ?.orderReviewData
                                                ?.totals
                                                ?.subtotal
                                                ?.formattedValue ??
                                            '',
                                        style: context.textTheme.titleMedium
                                            ?.copyWith(
                                          color: MainConfig
                                              .appColors.textDarkBlackColor,
                                          fontSize: fontsizeMobtab1522,
                                        ),
                                      ),
                                    ),
                                    spaceMobtab48.heightBox,
                                    Visibility(
                                      visible: state
                                              .reviewPaymentResponse
                                              ?.orderReviewData
                                              ?.totals
                                              ?.shipping
                                              ?.value
                                              ?.isNotEmpty ??
                                          false,
                                      child: getPaymentSummary(
                                        context,
                                        state
                                                .reviewPaymentResponse
                                                ?.orderReviewData
                                                ?.totals
                                                ?.shipping
                                                ?.title ??
                                            '',
                                        state
                                                .reviewPaymentResponse
                                                ?.orderReviewData
                                                ?.totals
                                                ?.shipping
                                                ?.formattedValue ??
                                            '',
                                        style: context.textTheme.titleMedium
                                            ?.copyWith(
                                          color: MainConfig
                                              .appColors.textDarkBlackColor,
                                          fontSize: fontsizeMobtab1522,
                                        ),
                                      ),
                                    ),
                                    spaceMobtab48.heightBox,
                                    Visibility(
                                      visible: state
                                              .reviewPaymentResponse
                                              ?.orderReviewData
                                              ?.totals
                                              ?.discount
                                              ?.value
                                              ?.isNotEmpty ??
                                          false,
                                      child: getPaymentSummary(
                                        context,
                                        state
                                                .reviewPaymentResponse
                                                ?.orderReviewData
                                                ?.totals
                                                ?.discount
                                                ?.title ??
                                            '',
                                        state
                                                .reviewPaymentResponse
                                                ?.orderReviewData
                                                ?.totals
                                                ?.discount
                                                ?.formattedValue ??
                                            '',
                                        style: context.textTheme.titleMedium
                                            ?.copyWith(
                                          color: MainConfig
                                              .appColors.textDarkBlackColor,
                                          fontSize: fontsizeMobtab1522,
                                        ),
                                      ),
                                    ),
                                    spaceMobtab48.heightBox,
                                    Visibility(
                                      visible: state
                                              .reviewPaymentResponse
                                              ?.orderReviewData
                                              ?.totals
                                              ?.tax
                                              ?.value
                                              ?.isNotEmpty ??
                                          false,
                                      child: getPaymentSummary(
                                        context,
                                        state
                                                .reviewPaymentResponse
                                                ?.orderReviewData
                                                ?.totals
                                                ?.tax
                                                ?.title ??
                                            '',
                                        state
                                                .reviewPaymentResponse
                                                ?.orderReviewData
                                                ?.totals
                                                ?.tax
                                                ?.formattedValue ??
                                            '',
                                        style: context.textTheme.titleMedium
                                            ?.copyWith(
                                          color: MainConfig
                                              .appColors.textDarkBlackColor,
                                          fontSize: fontsizeMobtab1522,
                                        ),
                                      ),
                                    ),
                                    spaceMobtab48.heightBox,
                                    Visibility(
                                      visible: state
                                              .reviewPaymentResponse
                                              ?.orderReviewData
                                              ?.totals
                                              ?.totalExclVat
                                              ?.value
                                              ?.isNotEmpty ??
                                          false,
                                      child: getPaymentSummary(
                                        context,
                                        state
                                                .reviewPaymentResponse
                                                ?.orderReviewData
                                                ?.totals
                                                ?.totalExclVat
                                                ?.title ??
                                            '',
                                        state
                                                .reviewPaymentResponse
                                                ?.orderReviewData
                                                ?.totals
                                                ?.totalExclVat
                                                ?.formattedValue ??
                                            '',
                                        style: context.textTheme.titleMedium
                                            ?.copyWith(
                                          color: MainConfig
                                              .appColors.textDarkBlackColor,
                                          fontSize: fontsizeMobtab1522,
                                        ),
                                      ),
                                    ),
                                    spaceMobtab48.heightBox,
                                    Visibility(
                                      visible: state
                                              .reviewPaymentResponse
                                              ?.orderReviewData
                                              ?.totals
                                              ?.grandTotal
                                              ?.value
                                              ?.isNotEmpty ??
                                          false,
                                      child: getPaymentSummary(
                                        context,
                                        state
                                                .reviewPaymentResponse
                                                ?.orderReviewData
                                                ?.totals
                                                ?.grandTotal
                                                ?.title ??
                                            '',
                                        state
                                                .reviewPaymentResponse
                                                ?.orderReviewData
                                                ?.totals
                                                ?.grandTotal
                                                ?.formattedValue ??
                                            '',
                                        style: context.textTheme.titleLarge
                                            ?.copyWith(
                                          fontSize: fontsizeMobtab1830,
                                          color: MainConfig
                                              .appColors.textDarkBlackColor,
                                        ),
                                      ),
                                    ),
                                    spaceMobtab1020.heightBox,
                                    Visibility(
                                      visible: state
                                              .reviewPaymentResponse
                                              ?.totalDiscount
                                              .isNotNullOrEmpty ??
                                          false,
                                      child: CommonContainer(
                                        padding: EdgeInsets.zero,
                                        width: context.width,
                                        height: spaceMobtab3955,
                                        boxDecoration: BoxDecorationExtension
                                            .customDecoration(
                                          borderRadius:
                                              Dimens.space5.borderRadius,
                                          color: MainConfig.appColors
                                              .backgroundLightSkyBlueColor,
                                        ),
                                        childWidgets: Padding(
                                          padding: EdgeInsets.symmetric(
                                            vertical: topPadding,
                                          ),
                                          child: Directionality(
                                            textDirection: isRTLText(
                                              state.reviewPaymentResponse
                                                      ?.totalDiscount ??
                                                  '',
                                            )
                                                ? TextDirection.rtl
                                                : TextDirection.ltr,
                                            child: CustomTextLabelWidget(
                                              label: state.reviewPaymentResponse
                                                      ?.totalDiscount ??
                                                  '',
                                              style: context
                                                  .textTheme.titleMedium
                                                  ?.copyWith(
                                                color: MainConfig.appColors
                                                    .textDarkBlackColor,
                                                fontSize: fontsizeMobtab1625,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          heightboxMobtab3060.heightBox,
                        ],
                      ),
                    ),
                  ),
                ),
                OrderSummaryPage(state: state, device: device),
              ],
            ),
          ),
        ),
        listener: (BuildContext context, PaymentState state) async {
          if (state.redirectRoute != null) {
            context.router.popUntilRoot();
            await context.router.push(
              state.redirectRoute ??
                  PaymentStatusRoute(isPaymentSuccess: false),
            );
          } else if ((state.isSnackBarDisplay ?? false) &&
              (state.msg?.isNotEmpty ?? false)) {
            // Show Error Msg.
            displaySnackBar(state.msg ?? '', context);
          }
        },
      ),
    );
  }

  /// Returns a row widget displaying a payment summary with a label and value.
  /// The label represents the summary description, and the value represents
  /// the corresponding amount or information.
  Row getPaymentSummary(
    BuildContext context,
    String label,
    String value, {
    double? fontSize,
    TextStyle? style,
  }) =>
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Expanded(
            child: CustomTextLabelWidget(
              label: label,
              textAlign: TextAlign.start,
              style: style ??
                  context.textTheme.labelMedium?.copyWith(
                    color: MainConfig.appColors.textDarkBlackColor,
                    fontSize: fontSize ?? Dimens.fontSize15,
                  ),
            ),
          ),
          Dimens.space70.widthBox,
          buildCustomTextLabel(
            value: value,
            style: style, // Optional custom text style for the value.
            context: context, // Passes the context for proper theming.
            fontSize: fontSize, // Optional font size for the value text.
          ),
        ],
      );

  /// Builds a custom text label widget with the specified value, style,
  /// and font size.
  /// If the language is not left-to-right (LTR),
  /// the text direction is forced to LTR.
  Widget buildCustomTextLabel({
    required String value,
    required BuildContext context,
    TextStyle? style,
    double? fontSize,
  }) {
    Widget content = CustomTextLabelWidget(
      label: value, // The label text value to display.
      style: style ??
          context.textTheme.bodySmall?.copyWith(
            color: MainConfig.appColors.textDarkBlackColor,
            fontSize: fontSize ?? Dimens.fontSize15,
          ),
    );

    // Checks if the language direction is not left-to-right (LTR).
    if (!isLanguageAlignmentLTR) {
      content = Directionality(
        textDirection: TextDirection.ltr, // Forces the text direction to LTR.
        child: content,
      );
    }

    return content; // Returns the content widget.
  }
}
