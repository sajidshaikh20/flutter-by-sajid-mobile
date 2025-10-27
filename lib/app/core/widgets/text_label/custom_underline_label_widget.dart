import '../../../../utils/exports.dart';

/// A custom widget that displays an underlined text label with an optional
/// tap action.
class CustomUnderlineTextWidget extends StatelessWidget {
  /// The text to be displayed as the label.
  final String title;

  /// The function to be called when the label is tapped.
  final Function onTap;

  /// The style of the text label. If null, a default style is used.
  final TextStyle? titleTextStyle;

  /// The default color of the text label.
  final Color? textDefaultColor;

  /// The color of the underline. If null, a default color is used.
  final Color? underlineColor;

  /// The thickness of the underline.
  final double? underLineThickness;

  ///The width of the widget
  final double? width;

  /// Creates a [CustomUnderlineTextWidget].
  const CustomUnderlineTextWidget({
    super.key,
    required this.title,
    required this.onTap,
    this.titleTextStyle,
    this.textDefaultColor,
    this.underlineColor,
    this.underLineThickness = Dimens.thick205,
    this.width,
  });

  /// Builds the widget tree for this widget.
  ///
  /// Returns a [TextButton] with an underlined [CustomTextLabelWidget].
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onTap as void Function()?,
      style: TextButton.styleFrom(
        padding: EdgeInsets.zero,
        alignment: Alignment.center,
      ).copyWith(
        overlayColor: WidgetStateProperty.all(
          Colors.transparent,
        ),
      ),
      child: CustomTextLabelWidget(

        label: title,

        style: titleTextStyle ??
            MainConfig.textTheme.bodyMedium?.copyWith(
              decoration: TextDecoration.underline,
              decorationThickness: underLineThickness,
              decorationColor: underlineColor ?? MainConfig.appColors.textBlackColor,
            ),
      ),
    );
  }
}
