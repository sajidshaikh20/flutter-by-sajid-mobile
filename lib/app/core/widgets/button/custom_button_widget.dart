import '../../../../utils/exports.dart';

/// A custom button widget that can be configured with various styles and properties.
class CustomButtonWidget extends StatelessWidget {
  /// The title text to display on the button.
  ///
  /// This is a required parameter.
  final String title;

  /// Optional text style for the button's title.
  ///
  /// If null, a default text style will be applied.
  final TextStyle? titleTextStyle;

  /// Callback function to be executed when the button is tapped.
  ///
  /// This is a required parameter.
  final Function() onTap;

  /// The color of the button when it is disabled.
  ///
  /// If this is null, the button will use  as the default disabled color.
  final Color? disabledColor;

  /// Whether the button has a border.
  ///
  /// Defaults to `false`.
  final bool hasBorder;

  /// The width of the button's border.
  ///
  /// Defaults to [Dimens.borderWidth1].
  final double borderWidth;

  /// The border radius of the button.
  ///
  /// Defaults to [Dimens.radius6].
  final double borderRadius;

  /// Whether the button is enabled.
  ///
  /// If `false`, the button will be displayed in a disabled state.
  /// Defaults to `true`.
  final bool isButtonEnabled;

  /// The height of the button.
  ///
  /// Defaults to [Dimens.size48].
  final double height;

  /// The width of the button.
  ///
  /// Defaults to [double.infinity].
  final double width;

  /// Whether the button is a primary button.
  ///
  /// If `true`, the button will be displayed as a primary button.
  /// Defaults to `true`.
  final bool isPrimaryButton;

  /// The background color of the button.
  ///
  /// Defaults to `Colors.red`.
  final Color? backgroundColor;

  /// The border color of the button.
  ///
  /// Defaults to `MainConfig.appColors.borderSecondaryColor`.
  final Color borderColor;

  /// An optional icon to display within the button.
  final Widget? icon;

  /// The type of device the button is being displayed on.
  ///
  /// Defaults to `ScreenType.mobile`.
  final ScreenType device;

  /// The text direction for the button's text.
  ///
  final TextDirection? textDirection;
  
  /// If true, draws the border using the inner Container's BoxDecoration
  /// instead of relying on TextButton shape side. Useful when parent styles
  /// might visually hide the shape border.
  final bool drawBorderInDecoration;
  /// Creates a custom button widget.
   CustomButtonWidget(
    /// Creates a custom button widget.
    ///
    ///
    /// The [title] and [onTap] arguments must not be null.
    /// [backgroundColor], [disabledColor] and [borderColor] defaults value
    /// if not provided
      {super.key,
      required this.title,
      this.titleTextStyle,
      required this.onTap,
        Color? disabledColor,
        Color? borderColor,
      this.backgroundColor = Colors.red,
      this.hasBorder = false,
      this.borderWidth = Dimens.borderWidth1,
      this.borderRadius = Dimens.radius6,
      this.isButtonEnabled = true,
      this.height = Dimens.size48,
      this.width = double.infinity,
      this.isPrimaryButton = true,
      this.icon,
        this.textDirection,
      this.device = ScreenType.mobile,
      this.drawBorderInDecoration = false})
      : disabledColor = disabledColor ?? MainConfig.appColors.labelGrey,
        borderColor = borderColor ?? MainConfig.appColors.borderSecondaryColor


  ;

  @override
  Widget build(BuildContext context) {


    double textFontSize = Dimens.fontSize18;
    double buttonHeight = height;

    return TextButton(
      style: TextButton.styleFrom(
        splashFactory: NoSplash.splashFactory,
        minimumSize: Size.zero,
        padding: EdgeInsets.zero,
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        shape: RoundedRectangleBorder(
          side: BorderSide(
            width: borderWidth,
            color: isButtonEnabled
                ? isPrimaryButton
                    ? MainConfig.appColors.borderPrimaryColor
                    : borderColor
                : (disabledColor ?? MainConfig.appColors.borderLightGreyColor),
            style: hasBorder && !drawBorderInDecoration ? BorderStyle.solid : BorderStyle.none,
          ),
          borderRadius: borderRadius.borderRadius,
        ),
        backgroundColor: isButtonEnabled
            ? (isPrimaryButton
                ? MainConfig.appColors.backgroundPrimaryColor
                : backgroundColor)
            : disabledColor,
        textStyle: TextStyle(
            color: !isPrimaryButton
                ? MainConfig.appColors.textPrimaryColor
                : MainConfig.appColors.textWhiteColor),
      ),
      onPressed: () {
        hideKeyboard();
        if (isButtonEnabled) onTap.call();
      },
      child: Container(
        decoration: BoxDecoration(
          color: isButtonEnabled
              ? (isPrimaryButton
                  ? MainConfig.appColors.backgroundPrimaryColor
                  : backgroundColor)
              : disabledColor,
          borderRadius: BorderRadius.circular(borderRadius),
          border: drawBorderInDecoration && hasBorder
              ? Border.all(
                  color: isButtonEnabled
                      ? (isPrimaryButton
                          ? MainConfig.appColors.borderPrimaryColor
                          : borderColor)
                      : (disabledColor ?? MainConfig.appColors.borderLightGreyColor),
                  width: borderWidth,
                )
              : null,
        ),
        height: buttonHeight,
        width: width,
        child: Row(
          children: <Widget>[
            if(icon!=null)
            Padding(
              padding: EdgeInsets.only(left:  isLanguageAlignmentLTR ? Dimens.space22 : Dimens.space0, right: isLanguageAlignmentLTR ? Dimens.space0 : Dimens.space22, top: Dimens.space12,
                  bottom: Dimens.space12),
              child: icon ?? const SizedBox(),
            ),
            Expanded(
              child: Center(
                child: CustomTextLabelWidget(
                  textDirection: textDirection,
                    maxLines: Dimens.maxLines01,
                    label: title,
                    overflow: TextOverflow.ellipsis,
                    style: titleTextStyle ??
                        context.textTheme.headlineMedium?.copyWith(
                          fontSize: textFontSize,
                          color: !isPrimaryButton
                              ? MainConfig.appColors.textPrimaryColor
                              : MainConfig.appColors.textWhiteColor,
                        )),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
