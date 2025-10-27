import '../../../utils/exports.dart';

/// A customizable two-option segmented control widget.
///
/// Displays two text segments side-by-side with an animated background indicator
/// that moves between them based on the [selectedIndex].
/// It supports both LTR and RTL layouts automatically.
class SegmentedControl extends StatelessWidget {
  /// The currently selected segment index (0 for the first, 1 for the second).
  final int selectedIndex;

  /// Callback triggered when a segment is tapped.
  ///
  /// The parameter is the new selected index (0 or 1).
  final ValueChanged<int> onIndexChanged;

  /// The text label for the first segment.
  final String? firstTitle;

  /// The text label for the second segment.
  final String? secondTitle;

  /// Creates a [SegmentedControl] widget.
  ///
  /// The [selectedIndex] and [onIndexChanged] must not be null.
  const SegmentedControl({
    super.key,
    required this.selectedIndex,
    required this.onIndexChanged,
    this.firstTitle,
    this.secondTitle,
  });

  @override
  Widget build(BuildContext context) {
    final bool isRTL = Directionality.of(context) == TextDirection.rtl;

    // Determine where the indicator should be aligned based on direction and selection.
    final Alignment indicatorAlignment = selectedIndex == 0
        ? (isRTL ? Alignment.centerRight : Alignment.centerLeft)
        : (isRTL ? Alignment.centerLeft : Alignment.centerRight);

    return Container(
      width: Dimens.size150,
      height: Dimens.size30,
      padding: Dimens.space2.padding,
      decoration: BoxDecoration(
        color: MainConfig.appColors.buttongreyColor,
        borderRadius: BorderRadius.circular(Dimens.radius8),
      ),
      child: Stack(
        children: <Widget>[
          /// Animated background indicator for the selected segment.
          AnimatedAlign(
            duration: const Duration(milliseconds: Dimens.milliseconds300),
            curve: Curves.easeInOut,
            alignment: indicatorAlignment,
            child: Container(
              width: Dimens.size72, // Half of total container width
              height: Dimens.size26,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(Dimens.radius6),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                    color: Colors.black.withValues(
                      alpha: 0.1
                    ),
                    blurRadius: 2,
                    offset: const Offset(0, 1),
                  ),
                ],
              ),
            ),
          ),

          /// Foreground row with tap areas for each segment.
          Row(
            textDirection: isRTL ? TextDirection.rtl : TextDirection.ltr,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              _buildSegment(0, firstTitle ?? "", context),
              _buildSegment(1, secondTitle ?? "", context),
            ],
          ),
        ],
      ),
    );
  }

  /// Builds a single segment of the control.
  ///
  /// [index] determines whether it's the first (0) or second (1) segment.
  Widget _buildSegment(int index, String text, BuildContext context) {
    final bool isSelected = selectedIndex == index;

    return Expanded(
      child: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () => onIndexChanged(index),
        child: Container(
          alignment: Alignment.center,
          height: Dimens.size26,
          color: Colors.transparent, // Background handled by AnimatedAlign
          child: CustomTextLabelWidget(
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            label: text,
            style: context.textTheme.bodyMedium?.copyWith(
              color: isSelected
                  ? MainConfig.appColors.mainColor
                  : MainConfig.appColors.creyColor,
              fontWeight: FontWeight.w700,
              height: Dimens.lineHeight16.toLineHeight(Dimens.fontSize12),
              fontSize: Dimens.fontSize12,
            ),
          ),
        ),
      ),
    );
  }
}
