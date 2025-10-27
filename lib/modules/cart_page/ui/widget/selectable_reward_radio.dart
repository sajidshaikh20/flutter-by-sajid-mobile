import '../../../../utils/exports.dart';

/// A customizable radio button widget with a label for selecting rewards.
///
/// Supports alignment control, radio icon positioning, and custom text styling.
class SelectableRewardRadio extends StatelessWidget {
  /// The value associated with this radio button.
  final String value;

  /// The currently selected value in the radio group.
  final String? groupValue;

  /// The label text displayed next to the radio button.
  final String label;

  /// Callback triggered when the radio button is tapped or selected.
  final Function(String?) onChanged;

  /// The size of the radio icon.
  final double size;

  /// If true, the radio button and label are aligned to the start;
  /// otherwise, they are spaced between.
  final bool alignToStart;

  /// Controls the position of the radio icon relative to the label.
  final RadioPosition radioPosition;

  /// Optional text style for the label.
  final TextStyle? textStyle;

  /// Creates a [SelectableRewardRadio] widget.
  ///
  /// [value], [groupValue], [label], and [onChanged] are required.
  /// [size] defaults to `Dimens.size20`.
  /// [alignToStart] defaults to true.
  /// [radioPosition] defaults to `RadioPosition.left`.
  const SelectableRewardRadio({
    super.key,
    required this.value,
    required this.groupValue,
    required this.onChanged,
    required this.label,
    this.size = Dimens.size20,
    this.alignToStart = true,
    this.radioPosition = RadioPosition.left,
    this.textStyle,
  });

  @override
  Widget build(BuildContext context) {
    final bool isSelected = value == groupValue;

    // Widget for the radio icon (checked or unchecked)
    Widget radioWidget =
    (isSelected ? Assets.svgs.icCheckedRadio : Assets.svgs.icUncheckedRadio)
        .svg(height: size, width: size);

    // Widget for the label text
    Widget labelWidget = Expanded(
      child: CustomTextLabelWidget(
        label: label,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        textAlign: TextAlign.start,
        style: textStyle ??
            context.textTheme.displayMedium?.copyWith(
              fontSize: Dimens.fontSize16,
              fontWeight: FontWeight.w600,
              height: Dimens.lineHeight30.toLineHeight(Dimens.fontSize16),
            ),
      ),
    );

    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () => onChanged(value),
      child: Row(
        mainAxisAlignment: alignToStart
            ? MainAxisAlignment.start
            : MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: radioPosition == RadioPosition.left
            ? <Widget>[radioWidget, Dimens.size15.widthBox, labelWidget]
            : <Widget>[labelWidget, Dimens.size15.widthBox, radioWidget],
      ),
    );
  }
}
