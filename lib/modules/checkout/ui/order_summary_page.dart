import '../../../utils/exports.dart';

/// A widget representing the order summary page that shows the payment details
/// and a button to proceed to checkout. It uses `PaymentState` to determine
/// the order summary information.
class OrderSummaryPage extends StatelessWidget {

  /// Constructor for the `OrderSummaryPage`.
  /// It requires the `PaymentState` to display the order summary
  /// and payment details.
  const OrderSummaryPage({
    required this.state, super.key,
    this.device = ScreenType.mobile,
  });

  /// The device type (mobile, tablet, or desktop) that determines the layout.
  final ScreenType device;

  /// The payment state that holds the review payment response and other
  /// payment-related data.
  final PaymentState state;

  @override
  Widget build(BuildContext context) {
    // Switch case for different devices, currently handling only mobile
    // and desktop cases.
    switch (device) {
      case ScreenType.tablet:
        break;

      case ScreenType.mobile:
      case ScreenType.desktop:
    }

    // Check if the `reviewPaymentResponse` is available to display order
    // summary.
    return state.reviewPaymentResponse != null
        ? CommonContainer(
      padding: Dimens.space8.padding,
      backgroundColor: state.reviewPaymentResponse != null
          ? MainConfig.appColors.backgroundGreyColor
          : MainConfig.appColors.backgroundWhiteColor,
      childWidgets: Row(
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              // Display the "Total" label only if `reviewPaymentResponse`
              // is available.
              Visibility(
                visible: state.reviewPaymentResponse != null,
                child: CustomTextLabelWidget(
                  label: MainConfig.dynamicString(
                    JsonServiceString.keyTotal,
                  ),
                  style: context.textTheme.titleLarge?.copyWith(
                    color: MainConfig.appColors.textDarkBlackColor,
                    fontSize: Dimens.fontSize18,
                  ),
                ),
              ),
              Dimens.space4.heightBox,
              // Display the grand total value only if `reviewPaymentResponse`
              // is available.
              Visibility(
                visible: state.reviewPaymentResponse != null,
                child: CustomTextLabelWidget(
                  label: state.reviewPaymentResponse?.orderReviewData
                      ?.totals?.grandTotal?.formattedValue ??
                      '',
                  style: context.textTheme.titleLarge?.copyWith(
                    color: MainConfig.appColors.textDarkBlackColor,
                    fontSize: Dimens.fontSize21,
                  ),
                ),
              ),
            ],
          ),
          const Spacer(),
          Expanded(
            child: Visibility(
              // Show the "Proceed to Checkout" button if the
              // `reviewPaymentResponse` is available.
              visible: state.reviewPaymentResponse != null,
              child: CustomButtonWidget(
                height: Dimens.size44,
                backgroundColor: MainConfig.appColors.backgroundLightBlueColor,
                title: MainConfig.dynamicString(
                  JsonServiceString.keyCheckOutUpper,
                ),
                isPrimaryButton: false,
                width: context.width * Dimens.ratio022,
                titleTextStyle: context.textTheme.titleLarge?.copyWith(
                  fontSize: Dimens.fontSize18,
                  color: MainConfig.appColors.textWhiteColor,
                ),
                onTap: () async {
                  // Handle "Proceed to Checkout" button tap.
                },
              ),
            ),
          ),
        ],
      ),
    )
        : const BottomShimmerWidget(); // Show shimmer effect if
    // no payment response.
  }
}
