import '../../../../utils/exports.dart';

/// A custom radio button widget with an icon and a label.
///
/// This widget displays a selectable radio icon with a label. The radio can
/// be positioned to the left or right of the label, and alignment can be
/// controlled using [alignToStart].
class SelectableIconRadio extends StatelessWidget {
  /// The value represented by this radio button.
  final String value;

  /// The currently selected value in the group.
  final String? groupValue;

  /// The label text displayed next to the radio icon.
  final String label;

  /// Callback function invoked when the radio button is tapped.
  final Function(String?) onChanged;

  /// The size of the radio icon.
  ///
  /// Defaults to `Dimens.size20`.
  final double size;

  /// Determines the alignment of the row.
  ///
  /// If `true`, items are aligned to the start. If `false`, space is distributed
  /// between items.
  final bool alignToStart;

  /// The position of the radio icon relative to the label.
  ///
  /// Defaults to [RadioPosition.left].
  final RadioPosition radioPosition;

  /// Optional custom text style for the label.
  final TextStyle? textStyle;

  /// Creates a [SelectableIconRadio] widget.
  ///
  /// [value], [groupValue], [label], and [onChanged] are required.
  /// [size], [alignToStart], [radioPosition], and [textStyle] are optional.
  const SelectableIconRadio({
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

    // Helper widget for the radio icon
    Widget radioWidget =
    (isSelected ? Assets.svgs.icCheckedRadio : Assets.svgs.icUncheckedRadio)
        .svg(height: size, width: size);

    // Helper widget for the label
    Widget labelWidget = CustomTextLabelWidget(
      label: label,
      style: textStyle ??
          context.textTheme.displayMedium?.copyWith(
            fontSize: Dimens.fontSize16,
            fontWeight: FontWeight.w600,
            height: Dimens.lineHeight30.toLineHeight(Dimens.fontSize16),
          ),
    );

    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      // Ensures taps are captured even in empty areas
      onTap: () => onChanged(value),
      child: Row(
        mainAxisAlignment: alignToStart
            ? MainAxisAlignment.start
            : MainAxisAlignment.spaceBetween,
        children: radioPosition == RadioPosition.left
            ? <Widget>[radioWidget, Dimens.size15.widthBox, labelWidget]
            : <Widget>[labelWidget, Dimens.size15.widthBox, radioWidget],
      ),
    );
  }
}
