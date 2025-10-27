import '../../../utils/exports.dart';

/// Widget that displays a filter or sort option with an icon and label.
class FilterSortWidget extends StatelessWidget {
  /// Creates a filter sort widget.
  const FilterSortWidget({
    super.key,
    required this.label,
    required this.image,
    required this.onTap,
    this.leftPosition = 0,
    this.rightPosition = 0,
    this.showIndicator = true,
  });

  /// The label text to display.
  final String label;

  /// The SVG image/icon to display.
  final SvgGenImage image;

  /// Callback function called when the widget is tapped.
  final VoidCallback onTap;

  /// Left position for positioning the widget.
  final double leftPosition;

  /// Right position for positioning the widget.
  final double rightPosition;

  /// Whether to show an indicator dot.
  final bool showIndicator;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.only(
            left: !context.isEnglishLanguage ? Dimens.space12 : 0,
            right: context.isEnglishLanguage ? 0 : Dimens.space12),
        child: Stack(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(right: Dimens.space7),
              child: CustomTextLabelWithIcon(
                iconPadding: EdgeInsets.only(
                    right: context.isEnglishLanguage ? Dimens.space8 : 0,
                    left: context.isEnglishLanguage ? 0 : Dimens.space8),
                image: image,
                isPrefix: true,
                style: context.textTheme.headlineSmall?.copyWith(
                  color: MainConfig.appColors.backgroundBlackColor,
                  fontSize: Dimens.fontSize14,
                  height: Dimens.lineHeight18.toLineHeight(Dimens.fontSize14),
                  fontWeight: FontWeight.w600,
                ),
                label: label,
              ),
            ),
            if (showIndicator) ...<Widget>[
              context.isEnglishLanguage
                  ? Positioned(
                      right: leftPosition,
                      child: Container(
                        height: Dimens.size6,
                        width: Dimens.size6,
                        decoration: BoxDecorationExtension.customDecoration(
                            color: MainConfig.appColors.secondaryColor,
                            shape: BoxShape.circle),
                      ))
                  : Positioned(
                      left: rightPosition,
                      child: Container(
                        height: Dimens.size6,
                        width: Dimens.size6,
                        decoration: BoxDecorationExtension.customDecoration(
                            color: MainConfig.appColors.secondaryColor,
                            shape: BoxShape.circle),
                      ))
            ],
          ],
        ),
      ),
    );
  }
}

