import '../../../utils/exports.dart';

/// A customizable container widget that provides options for styling and layout.
///
/// This widget is designed to be a versatile container that can be easily
/// customized with different background colors, box decorations, padding,
/// margin, height, and width. It's useful for creating visually distinct
/// sections within a layout or for grouping related widgets together.
///
/// Example Usage:
///
class CommonContainer extends StatelessWidget {
  ///CONSTRUCTOR OF COMMON CONTAINER
  const CommonContainer(
      {super.key,
      this.childWidgets,
      this.boxDecoration,
      this.backgroundColor,
      this.padding,
      this.margin,
      this.height,
      this.width});

  /// The [Widget] to display inside the container.
  final Widget? childWidgets;

  /// The [BoxDecoration] to apply to the container.
  final BoxDecoration? boxDecoration;

  /// The [Color] of the container's background.
  final Color? backgroundColor;

  /// The [EdgeInsetsGeometry] to pad the child within the container.
  final EdgeInsetsGeometry? padding;

  /// The [EdgeInsetsGeometry] to place around the outside of the container.
  final EdgeInsetsGeometry? margin;

  /// The [double] that defines the height of the container.
  final double? height;

  /// The [double] that defines the width of the container.
  final double? width;

  /// Builds a container.
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      height: height,
      width: width,
      padding: padding,
      decoration: boxDecoration,
      color: boxDecoration == null ? backgroundColor : null,
      child: childWidgets,
    );
  }
}
