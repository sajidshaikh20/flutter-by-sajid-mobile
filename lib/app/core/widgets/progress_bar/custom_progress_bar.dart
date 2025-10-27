import '../../../../utils/exports.dart';

/// A customizable progress bar widget.
///
/// This widget visually represents progress toward a maximum value using a
/// filled bar. The progress is animated when the current value changes.
///
/// Example:
/// ```dart
/// ProgressBar(
///   max: 100,
///   current: 60,
///   color: Colors.green,
///   height: 8.0,
/// )
/// ```
class ProgressBar extends StatelessWidget {
  /// The maximum value of the progress bar.
  ///
  /// This defines the 100% mark for progress calculation.
  final double max;

  /// The current value to display as progress.
  ///
  /// The progress is calculated as `(current / max)`.
  final double current;

  /// The fill color of the progress bar.
  ///
  final Color? color;

  /// The height of the progress bar.
  ///
  /// Defaults to [Dimens.size6] if not provided.
  final double? height;

  /// Creates a [ProgressBar] widget.
  ///
  /// [max] and [current] are required and must be greater than zero.
  /// Optionally, you can provide [color] and [height] to customize the appearance.
  const ProgressBar({
    super.key,
    required this.max,
    required this.current,
    this.height = Dimens.size6,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (_, BoxConstraints boxConstraints) {
        double x = boxConstraints.maxWidth;
        double percent = (current / max) * x;
        return Stack(
          children: <Widget>[
            Container(
              width: x,
              height: height,
              decoration: BoxDecoration(
                color: MainConfig.appColors.greyExtraLightColor,
                borderRadius: Dimens.radius35.borderRadius,
              ),
            ),
            AnimatedContainer(
              duration: const Duration(milliseconds: Dimens.milliseconds500),
              width: percent,
              height: height,
              decoration: BoxDecoration(
                color: color ?? MainConfig.appColors.mainColor,
                borderRadius: Dimens.radius35.borderRadius,
              ),
            ),
          ],
        );
      },
    );
  }
}
