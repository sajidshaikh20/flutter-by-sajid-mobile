import '../../../../utils/exports.dart';

/// A custom button widget with gradient background, configurable text,
/// border, and enabled/disabled states.
class CustomGradientButtonWidget extends StatelessWidget {
  /// The text to be displayed on the button.
  ///
  /// This is a required parameter and cannot be null.
  ///
  /// Example:
  ///
  final String title;

  /// Text style for the button title.
  final TextStyle? titleTextStyle;

  /// Callback function to be executed when the button is tapped.
  final Function() onTap;

  /// Color to be used when the button is disabled.
  final Color? disabledColor;

  /// Whether the button should have a border or not.
  final bool hasBorder;

  /// The width of the button's border.
  final double borderWidth;

  /// The radius of the button's corners.
  final double borderRadius;

  /// Indicates whether the button is enabled or disabled.
  final bool isButtonEnabled;

  /// The height of the button.
  final double height;

  /// The width of the button.
  final double width;

  /// The background color of the button.
  final Color? backgroundColor;

  /// The color of the button's border.
  final Color? borderColor;

  /// The type of the device screen.
  final ScreenType device;

  /// Constructs a [CustomGradientButtonWidget].
  ///
  /// [title] is the text to be displayed on the button.
  /// [titleTextStyle] is the style for the title text.
  /// [onTap] is the callback function when the button is pressed.
  /// [backgroundColor] is the button's background color.
  /// [hasBorder] determines if the button should have a border.
  /// [borderWidth] is the width of the button's border.
  /// [borderRadius] is the radius of the button's corners.
  /// [isButtonEnabled] determines if the button is enabled.
  CustomGradientButtonWidget({
    super.key,
    required this.title,
    this.titleTextStyle,
    required this.onTap,
    this.backgroundColor = Colors.white,
    this.hasBorder = false,
    this.borderWidth = Dimens.borderWidth1,
    this.borderRadius = Dimens.radius6,
    this.isButtonEnabled = true,
    this.height = Dimens.size44,
    this.width = double.infinity,
    this.device = ScreenType.mobile,
  })  : disabledColor = MainConfig.appColors.disablegreyColor,
        borderColor = MainConfig.appColors.borderSecondaryColor;

  @override
  Widget build(BuildContext context) {
    TextStyle? disableTextStyle = context.textTheme.headlineSmall?.copyWith(
      fontWeight: FontWeight.bold,
      color: MainConfig.appColors.disableTextColor,
      fontSize: Dimens.fontSize16,
      height: Dimens.lineHeight24.toLineHeight(Dimens.fontSize16),
    );
    TextStyle? enableTextStyle = context.textTheme.headlineSmall?.copyWith(
      fontWeight: FontWeight.bold,
      color: MainConfig.appColors.textWhiteColor,
      fontSize: Dimens.fontSize16,
      height: Dimens.lineHeight24.toLineHeight(Dimens.fontSize16),
    );

    return TextButton(
      style: TextButton.styleFrom(
        splashFactory: NoSplash.splashFactory,
        minimumSize: Size.zero,
        padding: EdgeInsets.zero,
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        textStyle: isButtonEnabled ? enableTextStyle : disableTextStyle,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(borderRadius),
            topRight: Radius.circular(borderRadius),
            bottomLeft: Radius.circular(borderRadius),
            bottomRight: Radius.circular(borderRadius),
          ),
        ),
        backgroundColor: isButtonEnabled ? null : disabledColor,
      ),
      onPressed: () {
        hideKeyboard();
        if (isButtonEnabled) onTap.call();
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(borderRadius),
            bottomRight: Radius.circular(borderRadius),
            topLeft: Radius.circular(borderRadius),
            topRight: Radius.circular(borderRadius),
          ),
          color: isButtonEnabled ? null : disabledColor,
        ),
        height: height,
        width: width,
        child: isButtonEnabled
            ? ClipRRect(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(borderRadius),
                  bottomRight: Radius.circular(borderRadius),
                  topLeft: Radius.circular(borderRadius),
                  topRight: Radius.circular(borderRadius),
                ),
                child: Stack(
                  fit: StackFit.expand,
                  children: <Widget>[
                    // SVG Background
                    Positioned.fill(
                      child: FlippableSvgBackground(
                        assetPath: Assets
                            .svgs.bgGradient.path, // Path to your SVG file
                      ),
                    ),
                    // Foreground Content
                    buttonTextWidget(enableTextStyle),
                  ],
                ),
              )
            : buttonTextWidget(disableTextStyle),
      ),
    );
  }

  ///buttonTextWidget
  Widget buttonTextWidget(TextStyle? enableTextStyle) {
    return Center(
      child: CustomTextLabelWidget(
        maxLines: Dimens.maxLines01,
        label: title,
        overflow: TextOverflow.ellipsis,
        style: titleTextStyle ?? enableTextStyle,
      ),
    );
  }
}
