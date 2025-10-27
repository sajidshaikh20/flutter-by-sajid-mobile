import '../../../../utils/exports.dart';

/// A custom rich text widget that displays:
/// - a primary label,
/// - an optional strike-through label,
/// - and a secondary label.
///
/// Each label supports custom text styles and tap gestures.
class CustomRichTextLabel extends StatelessWidget {
  /// The primary text label.
  final String primaryLabel;

  /// An optional strike-through label.
  final String? strikeLabel;

  /// The secondary text label.
  final String secondaryLabel;

  /// The text style for the primary label.
  final TextStyle? primaryStyle;

  /// The text style for the strike-through label.
  final TextStyle? strikeLabelStyle;

  /// The text style for the secondary label.
  final TextStyle? secondaryStyle;

  /// The callback function when the secondary label is tapped.
  final VoidCallback? onTapSecondaryLabel;

  /// The callback function when the primary label is tapped.
  final VoidCallback? onTapPrimaryLabel;

  /// The maximum number of lines for the text.
  final int? maxLines;

  /// Whether to add space between the primary and secondary labels.
  final bool? isSpaceNeeded;

  ///CustomRichTextLabel
  const CustomRichTextLabel({
    super.key,
    this.maxLines = 2,
    this.primaryLabel = "",
    this.secondaryLabel = "",
    this.primaryStyle,
    this.onTapPrimaryLabel,
    this.onTapSecondaryLabel,
    this.secondaryStyle,
    this.isSpaceNeeded,
    this.strikeLabel,
    this.strikeLabelStyle,
  });

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = MainConfig.textTheme;
    final AppColors appColors = MainConfig.appColors;

    return RichText(
      maxLines: maxLines,
      overflow: TextOverflow.ellipsis,
      textAlign: TextAlign.center,
      text: TextSpan(
        recognizer: TapGestureRecognizer()
          ..onTap = () => onTapPrimaryLabel?.call(),
        text: primaryLabel,
        style: primaryStyle ??
            textTheme.titleMedium?.copyWith(color: appColors.textWhiteColor),
        children: <InlineSpan>[
          if (strikeLabel != null)
            TextSpan(text: strikeLabel, style: strikeLabelStyle),
          WidgetSpan(
            alignment: PlaceholderAlignment.baseline,
            baseline: TextBaseline.alphabetic,
            child: SizedBox(
              height: Dimens.size16,
              width: (isSpaceNeeded ?? true) ? 4 : 0,
            ),
          ),
          TextSpan(
            recognizer: TapGestureRecognizer()
              ..onTap = () => onTapSecondaryLabel?.call(),
            text: secondaryLabel,
            style: secondaryStyle ?? textTheme.titleMedium,
          ),
        ],
      ),
    );
  }
}
