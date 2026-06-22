import '../../../../utils/exports.dart';

/// A reusable widget that applies a shimmer animation to its child.
///
/// Automatically adapts base/highlight colors for light and dark themes.
class ShimmerEffectWidget extends StatelessWidget {
  /// Optional override for the base shimmer color.
  final Color? baseColor;

  /// Optional override for the highlight shimmer color.
  final Color? highlightColor;

  /// When set, picks light or dark shimmer palette. Defaults to theme brightness.
  final bool? isDark;

  /// The widget to which the shimmer effect will be applied.
  final Widget child;

  const ShimmerEffectWidget({
    super.key,
    this.baseColor,
    this.highlightColor,
    this.isDark,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    final bool dark = isDark ?? context.isDark;
    final Color resolvedBase =
        baseColor ?? (dark ? AppColors.shimmerBaseDarkColor : AppColors.shimmerBaseColor);
    final Color resolvedHighlight = highlightColor ??
        (dark ? AppColors.shimmerHighlightDarkColor : AppColors.shimmerHighlightColor);

    return Shimmer.fromColors(
      baseColor: resolvedBase,
      highlightColor: resolvedHighlight,
      child: child,
    );
  }
}
