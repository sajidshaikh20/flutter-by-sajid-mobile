import '../../../../utils/exports.dart';

/// A reusable widget that applies a shimmer animation to its child.
///
/// This widget uses the [Shimmer] package to create a loading placeholder
/// effect. You can customize the base and highlight colors.
///
/// Example:
/// ```dart
/// ShimmerEffectWidget(
///   baseColor: Colors.grey[300],
///   highlightColor: Colors.grey[100],
///   child: Container(
///     width: 100,
///     height: 20,
///     color: Colors.white,
///   ),
/// )
/// ```
class ShimmerEffectWidget extends StatelessWidget {
  /// The color used for the base of the shimmer effect.
  ///
  /// Defaults to [AppColors.shimmerBaseColor] if null.
  final Color? baseColor;

  /// The color used for the highlight portion of the shimmer effect.
  ///
  /// Defaults to [AppColors.shimmerHighlightColor] if null.
  final Color? highlightColor;

  /// The widget to which the shimmer effect will be applied.
  final Widget child;

  /// Creates a [ShimmerEffectWidget].
  ///
  /// The [child] parameter is required and must not be null.
  /// You can optionally provide [baseColor] and [highlightColor] to customize
  /// the shimmer appearance.
  const ShimmerEffectWidget({
    super.key,
    this.baseColor,
    this.highlightColor,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: baseColor ?? AppColors.shimmerBaseColor,
      highlightColor: highlightColor ?? AppColors.shimmerHighlightColor,
      child: child,
    );
  }
}
