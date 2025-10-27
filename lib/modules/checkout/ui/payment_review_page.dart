import '../../../utils/exports.dart';

/// A widget representing the payment review page where the user can review
/// their
/// payment details, including billing and shipping information.
@RoutePage()
class PaymentReviewPage extends BaseResponsiveView {
  /// Constructor for `PaymentReviewPage` that requires shipping data and
  /// billing address.
  const PaymentReviewPage({
    required this.shippingData,
    required this.billingAddress,
    super.key,
  });

  /// Shipping information containing the selected shipping method and details.
  final Method shippingData;

  /// Billing address information to be used for payment processing.
  final BillingAddress billingAddress;

  @override
  Widget buildDesktopWidget(BuildContext context) =>
      _buildView(context, ScreenType.desktop);

  @override
  Widget buildMobileWidget(BuildContext context) =>
      _buildView(context, ScreenType.mobile);

  @override
  Widget buildTabletWidget(BuildContext context) =>
      _buildView(context, ScreenType.tablet);

  /// A helper function to build the view for different screen types
  /// (desktop, mobile, tablet).
  Widget _buildView(BuildContext context, ScreenType device) =>
      BlocProvider<PaymentCubit>(
        create: (BuildContext context) => PaymentCubit(
          // payment handling.
        ),
        child: PaymentReviewWidget(
            device: device), // Passes the device type to the widget.
      );
}
