import 'exports.dart';

/// A widget that creates a horizontal dotted line,
/// customizable in height and color.
class DottedLine extends StatelessWidget {
  /// A constructor that creates a horizontal dotted line,
  /// customizable in height and color.
  DottedLine({super.key, this.height = Dimens.size1, Color? color})
      : color = color ?? MainConfig.appColors.dottedLineColor;

  /// A widget that creates a horizontal dotted line, customizable in
  /// height and color.
  final double height;

  /// The color of the dots in the line.
  final Color color;

  @override
  Widget build(BuildContext context) => LayoutBuilder(
    builder: (BuildContext context, BoxConstraints constraints) {
      double boxWidth = constraints.constrainWidth();
      const double dashWidth = Dimens.size2;
      const double dashHeight = Dimens.size2;
      int dashCount =
      (boxWidth / (Dimens.size1points5 * dashWidth)).floor();
      return Flex(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        direction: Axis.horizontal,
        children: List<Widget>.generate(
          dashCount,
              (_) => SizedBox(
            width: dashWidth,
            height: dashHeight,
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: color,
                borderRadius: const BorderRadius.all(
                  Radius.circular(Dimens.radius10),
                ),
              ),
            ),
          ),
        ),
      );
    },
  );
}

/// Reusable dotted divider line with optional indent/endIndent.
/// Use inside cards or lists for a dotted separator.
class DottedDivider extends StatelessWidget {
  const DottedDivider({
    super.key,
    this.indent = Dimens.space0,
    this.endIndent = Dimens.space0,
    this.color,
  });

  /// Space from the left edge.
  final double indent;

  /// Space from the right edge.
  final double endIndent;


  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: indent, right: endIndent),
      child: DottedLine(color: color ?? MainConfig.appColors.dividerColor),
    );
  }
}
