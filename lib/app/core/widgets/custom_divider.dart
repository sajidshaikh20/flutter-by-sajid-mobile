import '../../../utils/exports.dart';

/// A customizable divider widget that provides a flexible way to add
/// visual separation between UI elements.
class CustomDivider extends StatelessWidget {
  /// The height of the divider.
  final double? height;

  /// The color of the divider.
  final Color? color;

  /// The width of the divider.
  final double? width;

  /// An optional child widget to be displayed within the divider.
  final Widget? child;

  /// The alignment of the child within the divider.
  final AlignmentGeometry? alignment;

  /// The decoration to paint behind the divider.
  final Decoration? decoration;
///
  const CustomDivider(
      {super.key,
      this.height,
      this.color,
      this.width,
      this.child,
      this.decoration,
      this.alignment});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: alignment,
      height: height,
      color: color,
      width: width,
      decoration: decoration,
      child: child,
    );
  }
}
