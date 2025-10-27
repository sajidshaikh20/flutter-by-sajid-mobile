import '../../../../utils/exports.dart';

/// A widget that displays a text label with optional color and device-specific styling.
///
/// This widget is typically used for form labels or small descriptive texts.
class LabelTextWidget extends StatelessWidget {
  /// Creates a [LabelTextWidget].
  ///
  /// The [label] text is required.
  /// The optional [textColor] sets the color of the label text.
  /// The [device] parameter allows adjusting the layout/styling based on device type,
  /// defaulting to [ScreenType.mobile].
  const LabelTextWidget({
    super.key,
    required this.label,
    this.textColor,
    this.device = ScreenType.mobile,
  });

  /// The text to display as the label.
  final String label;

  /// Optional color of the label text.
  final Color? textColor;

  /// The type of device layout to adapt the widget's appearance.
  final ScreenType device;
  @override
  Widget build(BuildContext context) {
    double fontSize=Dimens.fontSize12;
    switch(device){
      case ScreenType.tablet:
        fontSize=Dimens.fontSize16;

      default:
        break;
    }
    
    return CustomTextLabelWidget(
        label: label,
        style: MainConfig.appStyle.textBold.copyWith(
          fontSize: fontSize,
          color: textColor ?? MainConfig.appColors.textLightBlueColor,
          height: Dimens.fontHeight1_7,
        ));
  }
}
