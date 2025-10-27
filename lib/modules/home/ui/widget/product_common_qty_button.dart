import '../../../../utils/exports.dart';

/// A widget representing a quantity button for a product.
class ProductCommonQtyButton extends StatelessWidget {
  /// The end padding of the button.
  final double? endPaddingOfButton;

  /// The text style for the quantity label.
  final TextStyle? titleTextStyle;

  /// The height of the button.
  final double? heightOfButton;

  /// The width of the button.
  final double? widthOfButton;

  /// The vertical padding of the button content.
  final double? buttonPaddingVertical;

  /// The current quantity in the cart.
  final int cartQty;

  /// Callback when the plus button is pressed.
  final VoidCallback? onPlusPressed;
  /// Callback when the minus button is pressed.
  final VoidCallback? onMinusPressed;
///
  const ProductCommonQtyButton(
      {super.key,
      this.endPaddingOfButton,
      this.titleTextStyle,
      this.heightOfButton,
      this.buttonPaddingVertical,
      this.onPlusPressed,
      this.onMinusPressed,
      this.widthOfButton,
      required this.cartQty});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: heightOfButton ?? Dimens.size32,
      width: widthOfButton,
      padding: EdgeInsets.symmetric(
          vertical: buttonPaddingVertical ?? Dimens.space4),
      decoration: BoxDecoration(
        color: MainConfig.appColors.iceBlueColor, // Background color

        borderRadius: Dimens.radius6.borderRadius, // Rounded corners
      ),
      child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
        GestureDetector(
          onTap: onMinusPressed,
          child: SizedBox(
          //  width: heightOfButton ?? Dimens.size32,
            height: heightOfButton ?? Dimens.size32,
            child: Container(
              color: Colors.transparent, // Optional: Add a background color for debugging
              alignment: Alignment.center, // Center the SVG within the SizedBox
              padding: EdgeInsets.only(
                  left: endPaddingOfButton ?? Dimens.space12,
                  right: Dimens.space8,
                  top: buttonPaddingVertical ?? Dimens.space4,
                  bottom: buttonPaddingVertical ?? Dimens.space4),
              child: SvgPicture.asset(
                Assets.svgs.icQtyMinus.path,

                fit: BoxFit.none, // Ensure the SVG doesn't stretch
              ),
            ),
          ),
        ),
        CustomTextLabelWidget(
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          label: cartQty.toString(),
          style: titleTextStyle ??
              context.textTheme.headlineMedium?.copyWith(
                  height: Dimens.lineHeight24.toLineHeight(Dimens.fontSize16),
                  fontSize: Dimens.fontSize16,
                  color: MainConfig.appColors.mainColor,
                  fontWeight: FontWeight.bold),
        ),
        GestureDetector(
          onTap: onPlusPressed,
          child: SizedBox(
            height: heightOfButton ?? Dimens.size32,
            child: Container(
              color: Colors.transparent, // Optional: Add a background color for debugging
              alignment: Alignment.center,
              child: Padding(
                padding: EdgeInsets.only(
                    right: endPaddingOfButton ?? Dimens.space12,
                    left: Dimens.space8,
                    top: buttonPaddingVertical ?? Dimens.space4,
                    bottom: buttonPaddingVertical ?? Dimens.space4),
                child: Assets.svgs.icQtyPlus.svg(
                  fit: BoxFit.none,
                ),
              ),
            ),
          ),
        ),
      ]),
    );
  }
}
