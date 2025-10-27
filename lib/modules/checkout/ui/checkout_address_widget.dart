import '../../../utils/exports.dart';

/// A widget representing the checkout address page, including the display of
/// address, shipping method, and time slot details. It uses `CheckOutCubit`
/// for managing the state of the checkout process and provides
/// responsive views.
class CheckoutAddressWidget extends BaseResponsiveView {
  /// Constructor for the `CheckoutAddressWidget`.
  /// It requires a `totalAmt` parameter to display the total amount
  /// in the widget.
  const CheckoutAddressWidget({
    required this.totalAmt,
    super.key,
  });

  /// The total amount to be displayed in the checkout page.
  final String totalAmt;

  @override
  Widget buildDesktopWidget(BuildContext context) =>
      mainScreen(context, ScreenType.desktop);

  @override
  Widget buildMobileWidget(BuildContext context) =>
      mainScreen(context, ScreenType.mobile);

  @override
  Widget buildTabletWidget(BuildContext context) =>
      mainScreen(context, ScreenType.tablet);

  /// Main screen widget that is shown across all device types
  /// (mobile, tablet, desktop).
  /// It contains the address section, shipping method, time slot details, and
  /// a bottom bar with a total amount and a "Proceed to Buy" button.
  Widget mainScreen(BuildContext ctx, ScreenType device) => NoInternetWidget(
        onTryAgain: () async {
          // Retry fetching address list when no internet is detected.

        },
        device: device,
        childWidget: PopScope(
          canPop: false,
          onPopInvokedWithResult: (bool didPop, Object? result) async {
            if (didPop) {
              return;
            }
            // Handle back navigation with forced pop.
            ctx.router.popForced(true);
          },
          child: SafeArea(
            child: Scaffold(
              appBar: CustomSearchAppBar(
                device: device,
                isBackIconVisible: true,
                onTap: () {
                  unawaited(
                    // Handle back button tap to navigate back.
                    ctx.router.maybePop(true),
                  );
                },
                onSearchViewClicked: () {
                  unawaited(
                    // Navigate to the search view when search icon is clicked.
                    ctx.router.push(
                      const SearchRoute(),
                    ),
                  );
                },
              ),
              backgroundColor: MainConfig.appColors.backgroundWhiteColor,
              body: BlocConsumer<CheckOutCubit, CheckOutState>(
                builder: (BuildContext context, CheckOutState state) => Column(
                  children: <Widget>[
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            // Address widget for displaying the user's address.
                            AddressWidget(
                              device: device,
                            ),
                            Dimens.size4.heightBox,
                            // Shipping method widget for selecting
                            // the shipping option.
                            ShippingMethodWidget(
                              device: device,
                              state: state,
                            ),
                            // Time slot details widget for selecting
                            // the preferred delivery time.
                            TimeSlotDetailsWidget(
                              state: state,
                              device: device,
                            ),
                          ],
                        ),
                      ),
                    ),
                    // Bottom total bar widget showing total value and
                    // the "Proceed to Buy" button.
                    BottomTotalBar(
                      device: device,
                      totalLabel: MainConfig.dynamicString(
                        JsonServiceString.keyTotal,
                      ),
                      totalValue: totalAmt,
                      // The total amount to display.
                      onContinueTap: () async {
                        await ctx.read<CheckOutCubit>().onTapProceedButton();
                      },
                      btnTitle: MainConfig.dynamicString(
                        JsonServiceString.keyProceedToBuy,
                      ),
                    ),
                  ],
                ),
                listener: (BuildContext context, CheckOutState state) async {
                  // Handle routing based on the current checkout state.
                  if (state.redirectRoute != null) {
                    await ctx.router.push(
                      state.redirectRoute ??
                          PaymentReviewRoute(
                            billingAddress:
                                context.read<CheckOutCubit>().billingAddress ??
                                    BillingAddress(),
                            shippingData: state.shippingMethodsList
                                    .firstWhereOrNull(
                                      (ShippingMethods element) =>
                                          element.isSelected ?? false,
                                    )
                                    ?.method
                                    ?.first ??
                                Method(),
                          ),
                    );
                  } else if ((state.isSnackBarDisplay ?? false) &&
                      (state.msg?.isNotEmpty ?? false)) {
                    // Show error message as a Snackbar if needed.
                    displaySnackBar(state.msg ?? '', context);
                  }
                },
              ),
            ),
          ),
        ),
      );
}
