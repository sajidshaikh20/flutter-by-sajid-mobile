import '../../../utils/exports.dart';

/// A common image widget that can handle both network URLs and local assets
/// 
/// This widget automatically detects whether the image path is a network URL
/// or a local asset and renders the appropriate widget accordingly.
class CommonImageWidget extends StatelessWidget {
  /// Creates a [CommonImageWidget]
  const CommonImageWidget({
    super.key,
    required this.imagePath,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
    this.placeHolderImage,
    this.errorWidget,
    this.borderColor,
    this.borderWidth,
    this.radius,
    this.color,
    this.shadow,
    this.alignment = Alignment.center,
    this.isShowPlaceHolder = false,
    this.indicatorSize = Dimens.size25,
  });

  /// The image path - can be a network URL (http/https) or local asset path
  final String? imagePath;

  /// Width of the image container
  final double? width;

  /// Height of the image container
  final double? height;

  /// How the image should be inscribed into the container
  final BoxFit fit;

  /// Placeholder widget to show while loading or on error
  final Widget? placeHolderImage;

  /// Custom error widget
  final Widget? errorWidget;

  /// Border color of the container
  final Color? borderColor;

  /// Border width of the container
  final double? borderWidth;

  /// Border radius of the container
  final double? radius;

  /// Background color of the container
  final Color? color;

  /// Shadow effects for the container
  final List<BoxShadow>? shadow;

  /// Alignment of the image within the container
  final Alignment alignment;

  /// Whether to show custom placeholder or loading indicator
  final bool isShowPlaceHolder;

  /// Size of the loading indicator
  final double indicatorSize;

  @override
  Widget build(BuildContext context) {
    // Check if it's a network URL (starts with http or https)
    if (_isNetworkUrl(imagePath)) {
      return CustomNetworkImageWidget(
        imageUrl: imagePath,
        width: width,
        height: height,
        fit: fit,
        placeHolderImage: placeHolderImage ?? _getDefaultPlaceholder(),
        errorWidget: errorWidget,
        borderColor: borderColor,
        borderWidth: borderWidth,
        radius: radius,
        color: color,
        shadow: shadow,
        alignment: alignment,
        isShowPlaceHolder: isShowPlaceHolder,
        indicatorSize: indicatorSize,
      );
    } else {
      // Local asset image
      return _buildLocalAssetImage();
    }
  }

  /// Determines if the given path is a network URL
  bool _isNetworkUrl(String? path) {
    return path!.startsWith('http://') || path.startsWith('https://');
  }

  /// Builds the local asset image widget
  Widget _buildLocalAssetImage() {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        border: Border.all(
          color: borderColor ?? MainConfig.appColors.borderTransparentColor,
          width: borderWidth ?? Dimens.borderWidth1,
        ),
        color: color,
        borderRadius: (radius ?? Dimens.radius0).borderRadius,
        boxShadow: shadow,
      ),
      child: ClipRRect(
        borderRadius: (radius ?? Dimens.radius0).borderRadius,
        child: Image.asset(
          imagePath!,
          width: width,
          height: height,
          fit: fit,
          alignment: alignment,
          errorBuilder: (BuildContext context, Object error, StackTrace? stackTrace) {
            return errorWidget ?? _getDefaultPlaceholder();
          },
        ),
      ),
    );
  }

  /// Returns the default placeholder widget
  Widget _getDefaultPlaceholder() {
    return Assets.svgs.icPlaceHolderDukkan.svg();
  }
}
