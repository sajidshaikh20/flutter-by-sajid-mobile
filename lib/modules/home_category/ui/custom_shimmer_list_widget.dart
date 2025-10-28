import '../../../../../utils/exports.dart';

/// A widget that wraps its [child] widget with a shimmer effect.
///
/// This widget is useful for showing a loading effect (shimmer) while
/// content is being fetched. It is typically used to indicate to the
/// user that content is being loaded dynamically.
class CustomShimmerListWidget extends StatelessWidget {
  /// Constructs a [CustomShimmerListWidget].
  ///
  /// The [child] widget is wrapped inside the shimmer effect.
  /// The [key] parameter is optional for identifying the widget in
  /// the widget tree.
  const CustomShimmerListWidget({
    required this.child, // Child widget to be wrapped with the shimmer effect
    super.key,
  });

  /// The widget that will be displayed with the shimmer effect.
  final Widget child;

  @override
  Widget build(BuildContext context) {
    // Wraps the child widget with the ShimmerEffect widget
    return ShimmerEffect(
      child: child, // Pass the child widget to the shimmer effect
    );
  }
}

/// A widget that applies a shimmer effect to its [child].
///
/// This widget is typically used to display a shimmering loading effect on
/// the [child] widget, often used for loading states or skeleton screens.
class ShimmerEffect extends StatelessWidget {
  /// Constructs a [ShimmerEffect] widget.
  ///
  /// The [child] widget is wrapped inside the shimmer effect.
  const ShimmerEffect({
    required this.child, // The widget that will display the shimmer effect
    super.key,
  });

  /// The widget that will be wrapped and displayed with the shimmer effect.
  final Widget child;

  @override
  Widget build(BuildContext context) {
    // Applies a shimmer effect with base and highlight colors to the child widget
    return Shimmer.fromColors(
      baseColor: AppColors.greyLight,
      highlightColor: AppColors.greyExtraLight,
      child: child,
    );
  }
}
