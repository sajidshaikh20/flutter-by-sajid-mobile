import '../../../utils/exports.dart';

@RoutePage()
/// Page that displays payment status (success or failure) with order details.
class PaymentStatusPage extends BaseResponsiveView {
  /// Creates a payment status page.
  const PaymentStatusPage({
    required this.isPaymentSuccess,
    super.key,
    this.responseModel,
  });

  /// Indicates whether the payment was successful.
  final bool isPaymentSuccess;

  /// The response model containing order details.
  final PlaceOrderResponseModel? responseModel;

  @override
  Widget buildDesktopWidget(BuildContext context) =>
      _buildView(context, ScreenType.desktop);

  @override
  Widget buildMobileWidget(BuildContext context) =>
      _buildView(context, ScreenType.mobile);

  @override
  Widget buildTabletWidget(BuildContext context) =>
      _buildView(context, ScreenType.tablet);

  Widget _buildView(BuildContext context, ScreenType device) =>
      BlocProvider<PaymentStatusCubit>(
        create: (BuildContext context) => PaymentStatusCubit(),
        child: PaymentStatusPageWidget(
          isPaymentSuccess: isPaymentSuccess,
          responseModel: responseModel,
          device: device,
        ),
      );
}
