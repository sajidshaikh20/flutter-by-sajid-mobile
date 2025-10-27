import '../../../../utils/exports.dart';

/// [CommonLottieAnimation] is a reusable widget for displaying Lottie animations.
class CommonLottieAnimation extends StatelessWidget {
  /// The path to the Lottie asset.
  final String assetPath;

  /// Whether the animation should repeat. Defaults to true.
  final bool? repeat;

  /// The height of the animation.
  final double? height;

  /// The width of the animation.
  final double? width;

  /// How the animation should be inscribed into the available space.
  final BoxFit? fit;

  /// Creates a [CommonLottieAnimation] widget.
  ///
  /// The [assetPath] argument is required.
  const CommonLottieAnimation({
    super.key,
    required this.assetPath,
    this.repeat,
    this.height,
    this.width,
    this.fit,
  });

  @override
  Widget build(BuildContext context) {
    return Lottie.asset(assetPath,
        backgroundLoading: true,

        height: height, width: width, repeat: repeat, fit: fit);
  }
}
