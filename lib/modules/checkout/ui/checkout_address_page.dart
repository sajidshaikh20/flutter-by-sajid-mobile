import '../../../utils/exports.dart';

@RoutePage()
/// A page that handles the checkout address section, including total amount
/// and optional cart list response model. It uses the `CheckOutCubit` to
/// manage the state and provides responsive views for different screen types.
class CheckoutAddressPage extends BaseResponsiveView {

  /// Constructor for the `CheckoutAddressPage`.
  /// It requires a `totalAmt` parameter and optionally accepts a
  /// `cartListResponseModel`.
  const CheckoutAddressPage({
    required this.totalAmt, super.key,
  });

  /// The total amount to be displayed in the checkout page.
  final String totalAmt;

  /// The optional response model for the cart list, used if available.

  @override
  Widget buildDesktopWidget(BuildContext context) => buildViews(context);

  @override
  Widget buildMobileWidget(BuildContext context) => buildViews(context);

  @override
  Widget buildTabletWidget(BuildContext context) => buildViews(context);

  /// Builds the view for the checkout address page with the required
  /// `CheckOutCubit` and `CheckoutAddressWidget`. It provides the total amount
  /// and optional cart list response model for state management.
  Widget buildViews(BuildContext context) => BlocProvider<CheckOutCubit>(
    lazy: false,
    create: (BuildContext context) => CheckOutCubit(
      // The repository responsible for fetching the checkout data.
      repository: CheckoutRepositoryImpl(),

      // The optional cart list response model to provide additional details.

    ),
    child: CheckoutAddressWidget(totalAmt: totalAmt),
  );
}
