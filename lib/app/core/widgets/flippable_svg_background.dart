import '../../../utils/exports.dart';

/// A widget that displays an SVG asset background
/// which automatically flips horizontally based on the current app language.
///
/// This is useful for supporting right-to-left (RTL) languages by mirroring
/// background images without creating separate asset files.
class FlippableSvgBackground extends StatelessWidget {
  /// The path to the SVG asset file to be displayed.
  final String assetPath;

  /// How the SVG image should be inscribed into the space allocated during layout.
  ///
  /// Defaults to [BoxFit.cover].
  final BoxFit fit;

  /// Creates a [FlippableSvgBackground] widget.
  ///
  /// The [assetPath] parameter must not be null.
  /// If [fit] is not specified, it defaults to [BoxFit.cover].
  const FlippableSvgBackground({
    super.key,
    required this.assetPath,
    this.fit = BoxFit.cover,
  });

  @override
  Widget build(BuildContext context) {
    return Transform(
      alignment: Alignment.center,
      // Flip horizontally if the current language is not English
      transform: Matrix4.identity()
        ..scale(context.isEnglishLanguage ? 1.0 : -1.0, 1.0),
      child: SvgPicture.asset(
        assetPath,
        fit: fit,
      ),
    );
  }
}
