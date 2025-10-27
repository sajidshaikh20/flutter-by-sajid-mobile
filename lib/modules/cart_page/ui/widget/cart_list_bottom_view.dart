import '../../../../utils/exports.dart';

/// A widget representing the bottom section of the cart list screen.
///
/// Typically, this section includes the subtotal, discounts, taxes,
/// and the checkout button. It remains fixed at the bottom while
/// the cart items scroll above it.
class CartListBottomView extends StatelessWidget {
  /// Creates a [CartListBottomView] instance.
  const CartListBottomView({super.key, required this.customGradientButtonPressed, required this.btnWidth, required this.title, required this.isCheckoutAllowed, required this.device});


  /// Callback triggered when the custom gradient button is pressed.
  final VoidCallback customGradientButtonPressed;

  /// Width of the button. Determines how wide the button will render.
  final double btnWidth;

  /// The text displayed on the button.
  final String title;

  /// Flag to indicate whether checkout or the primary action is allowed.
  final bool isCheckoutAllowed;

  /// The type of device used, for responsive layout adjustments.
  final ScreenType device;

  @override
  Widget build(BuildContext context) {
    EdgeInsets commonContainerPadding = const EdgeInsets.symmetric(
      vertical: Dimens.space7,
      horizontal: Dimens.space16,
    );

    switch (device) {
      case ScreenType.tablet:
        commonContainerPadding = const EdgeInsets.only(
          top: Dimens.space10,
          bottom: Dimens.space10,
          right: Dimens.space26,
          left: Dimens.space26,
        );

      default:
        break;
    }
    return BlocBuilder<CartPageCubit, CartPageState>(
      builder: (BuildContext context, CartPageState state) {
        return Stack(
          children: <Widget>[
            // Main bottom view container
            Container(
              height: Dimens.size88,
              padding: commonContainerPadding,
              color: MainConfig.appColors.backgroundWhite,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Expanded(
                    child: CartTotalpayUsingWidget(
                      paymentSelectionPressed: () async {
                        await showCustomBottomSheetView(
                          titleStyle: context.textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.w700,
                            fontSize: Dimens.fontSize16,
                            height:
                            Dimens.lineHeight24.toLineHeight(Dimens.fontSize16),
                            color: AppColors.blackColor,
                          ),
                          backgroundColor:
                          MainConfig.appColors.backgroundLightPinkColor,
                          context: context,
                          title: context.appString.payUsingKey,
                          child: PayUsingWidget(
                            paymentMethods:
                            state.availablePaymentMethods ?? <PaymentMethodResponse>[],
                            selectedPaymentMethod: state.selectedPaymentMethod,
                            onPaymentMethodSelected:
                                (PaymentMethodResponse paymentMethod) {
                              context.read<CartPageCubit>().selectPaymentMethod(paymentMethod);
                            },
                            onBottomSheetClose: () async {
                              await context.router.maybePop();
                            },
                          ),
                          bothExtremeEnd: true,
                        );
                      },
                    ),
                  ),
                  const SizedBox(width: Dimens.space12),
                  CheckoutCustomGradientButton(
                    isButtonEnabled: isCheckoutAllowed,
                    amountWithCurrency: formatPrice(
                      state.cartDetailsListingResponse?.finalTotal,
                      getIt<LanguageService>().defaultCurrency,
                    ),
                    title: title,
                    btnWidth: btnWidth,
                    onButtonPressed: customGradientButtonPressed,
                  ),
                ],
              ),
            ),

            // 🔹 Top-only shadow overlay
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: Container(
                height: 2, // thin area for the shadow
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: <Color>[
                      Color.fromRGBO(0, 0, 0, 0.1), // 20% black
                      Color.fromRGBO(0, 0, 0, 0.0), // fade out
                    ],
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );

  }
}
