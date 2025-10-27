import '../../../../utils/exports.dart';
/// A widget that displays a single line or multiline text,
/// typically used in lists or detailed views.
///
/// Supports optional custom text style, maximum lines, and device-specific layout adjustments.
class ListTextView extends StatelessWidget {
  /// Creates a [ListTextView].
  ///
  /// The [label] is required and represents the text to display.
  /// The optional [textStyle] allows customizing the font, color, or other text properties.
  /// The optional [maxLines] limits the number of lines the text can occupy.
  /// The [device] parameter lets you adjust layout/styling based on the device type,
  /// defaulting to [ScreenType.mobile].
  const ListTextView({
    super.key,
    required this.label,
    this.textStyle,
    this.maxLines,
    this.device = ScreenType.mobile,
  });

  /// The text content to display.
  final String label;

  /// Optional styling for the text.
  final TextStyle? textStyle;

  /// Maximum number of lines the text can occupy. Null means unlimited lines.
  final int? maxLines;

  /// The type of device layout to adapt the widget's appearance.
  final ScreenType device;
  @override
  Widget build(BuildContext context) {
    double listTextFontSize=Dimens.fontSize16;
    switch(device){

      case ScreenType.tablet:
        listTextFontSize=Dimens.fontSize20;

      default:
        break;
    }
    return Directionality(
      textDirection:
      isRTLText(label) ? TextDirection.rtl : TextDirection.ltr,
      child: CustomTextLabelWidget(
        label: label,
        maxLines: maxLines ?? Dimens.maxLines01,
        overflow: TextOverflow.ellipsis,
        style: textStyle ??
            context.textTheme.headlineMedium?.copyWith(
              fontWeight: FontWeight.w500,
              color: MainConfig.appColors.textGreyDarkColor,
              fontSize: listTextFontSize,
            ),
        textAlign:   isLanguageAlignmentLTR ? TextAlign.left : TextAlign.right,
      ),
    );
  }
}
