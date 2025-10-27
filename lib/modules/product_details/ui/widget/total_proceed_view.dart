import '../../../../utils/exports.dart';

/// A widget that displays the total amount section with increment, decrement,
/// and proceed-to-checkout actions.
///
/// This widget is commonly used in cart or checkout screens to show
/// product quantity controls, total information, and checkout actions.
class TotalProceedView extends StatelessWidget {
  /// Creates a [TotalProceedView].
  ///
  /// The [isCheckoutAllowed] parameter determines if the checkout button
  /// should be enabled.
  const TotalProceedView({
    super.key,
    required this.isCheckoutAllowed,
    this.onPlusPressed,
    this.onMinusPressed,
    this.title = "",
    this.cartCount = 0,
    this.btnWidth = Dimens.size138,
    this.isFromCart = false,
    this.selectedUnit,
    required this.customGradientButtonPressed,
    this.checkoutCustomGradientButton,
    this.device = ScreenType.mobile,
  });

  /// Indicates whether checkout is allowed or not.
  final bool isCheckoutAllowed;

  /// Defines the current device type (e.g., mobile, tablet, or web)
  /// for responsive layout handling.
  final ScreenType device;

  /// Callback function triggered when the minus button is pressed
  /// to decrease the product quantity.
  final VoidCallback? onMinusPressed;

  /// The current number of items in the cart.
  final int cartCount;

  /// The title text displayed in the total proceed section.
  final String title;

  /// Callback function triggered when the plus button is pressed
  /// to increase the product quantity.
  final VoidCallback? onPlusPressed;

  /// Callback function triggered when the main action button
  /// (usually “Proceed” or “Add to Cart”) is pressed.
  final VoidCallback customGradientButtonPressed;

  /// Optional callback triggered when a custom checkout button is pressed.
  final VoidCallback? checkoutCustomGradientButton;

  /// The width of the action button.
  final double btnWidth;

  /// Indicates whether this view is being used in the cart page.
  final bool isFromCart;

  /// The selected product unit information, if applicable.
  final ProductListingResponse? selectedUnit;

  @override
  Widget build(BuildContext context) {
    double btnHeight = Dimens.size44;

    EdgeInsets commonContainerPadding = const EdgeInsets.symmetric(
      vertical: Dimens.space7,
      horizontal: Dimens.space16,
    );

    switch (device) {
      case ScreenType.tablet:
        btnHeight = Dimens.size87;
        commonContainerPadding = const EdgeInsets.only(
          top: Dimens.space10,
          bottom: Dimens.space10,
          right: Dimens.space26,
          left: Dimens.space26,
        );

      default:
        break;
    }
    return Container(
      height: Dimens.size88,
      padding: commonContainerPadding,
      decoration: BoxDecoration(
        color: MainConfig.appColors.backgroundWhite,
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.black.withValues(
              alpha: Dimens.opacity02),
            // Shadow color with opacity
            offset: const Offset(1, 0),
            // x: 1, y: 0
            blurRadius: Dimens.blurRadius4, // Blur radius
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          ProceedViewWidget(
            device: device,
            selectedUnit: selectedUnit,
          ),
          cartCount == 0
              ? isFromCart
                  ? CheckoutCustomGradientButton(
                      title: title,
                      btnWidth: btnWidth,
                      onButtonPressed: checkoutCustomGradientButton)
                  : CustomGradientButtonWidget(
                      isButtonEnabled: isCheckoutAllowed,
                      device: device,
                      height: btnHeight,
                      width: btnWidth,
                      onTap: customGradientButtonPressed,
                      titleTextStyle:
                          context.textTheme.headlineMedium?.copyWith(
                        color: !isCheckoutAllowed
                            ? MainConfig.appColors.creyColor
                            : MainConfig.appColors.backgroundWhite,
                        fontWeight: FontWeight.w700,
                        height:
                            Dimens.lineHeight24.toLineHeight(Dimens.fontSize18),
                        fontSize: Dimens.fontSize18,
                      ),
                      title: title,
                    )
              : ProductCommonQtyButton(
                  widthOfButton: Dimens.size138,
                  heightOfButton: Dimens.size44,
                  cartQty: cartCount,
                  endPaddingOfButton: Dimens.space12,
                  onMinusPressed: onMinusPressed,
                  onPlusPressed: onPlusPressed,
                )
        ],
      ),
    );
  }
}
