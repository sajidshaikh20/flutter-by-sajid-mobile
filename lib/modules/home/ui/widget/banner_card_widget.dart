import '../../../../utils/exports.dart';

/// Banner card subwidget displaying a single promotional image.
class BannerCardWidget extends StatelessWidget {
  /// Creates a banner card widget.
  const BannerCardWidget({
    super.key,
     this.width=Dimens.size262,
    required this.imagePath,
    this.height = Dimens.size100,
  });

  /// Width of the banner card.
  final double? width;

  /// Asset path of the banner image.
  final String imagePath;

  /// Height of the banner card.
  final double height;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: Dimens.radius6.borderRadius,
      child: Image.asset(
        imagePath,
        width: width,
        height: height,
        fit: BoxFit.fitWidth,
      ),
    );
  }
}
