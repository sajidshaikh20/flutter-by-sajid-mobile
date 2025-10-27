import '../../../utils/exports.dart';

/// A common widget to display a grid view.
class CommonGridView extends StatelessWidget {
  /// Creates a [CommonGridView].
  const CommonGridView(
      {super.key,
      /// The delegate that controls the layout of the children within the [GridView].
      required this.gridDelegate,
      /// Called to build children for the [GridView] with
      /// a particular index.
      required this.itemBuilder,
      /// The number of children in the [GridView].
      this.itemCount,
      /// Whether the extent of the scroll view should be determined by the contents of the
      /// children.
      required this.shrinkWrap,
      /// How the scroll view should respond to user input.
      this.physics,
      /// The amount of space by which to inset the children.
      this.padding,
      /// An object that can be used to control the position to which this scroll view is scrolled.
      this.controller});

  /// The delegate that controls the layout of the children within the [GridView].
  final SliverGridDelegate gridDelegate;

  /// Called to build children for the [GridView] with
  /// a particular index.
  final Widget? Function(BuildContext, int) itemBuilder;
  /// The number of children in the [GridView].
  final int? itemCount;
  /// How the scroll view should respond to user input.
  final ScrollPhysics? physics;
  /// Whether the extent of the scroll view should be determined by the contents of the
  /// children.
  final bool shrinkWrap;
  /// The amount of space by which to inset the children.
  final EdgeInsetsGeometry? padding;
  /// An object that can be used to control the position to which this scroll view is scrolled.
  final ScrollController? controller;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: padding,
      controller: controller,
      gridDelegate: gridDelegate,
      itemBuilder: itemBuilder,
      itemCount: itemCount,
      shrinkWrap: shrinkWrap,
      physics: physics,
    );
  }
}
