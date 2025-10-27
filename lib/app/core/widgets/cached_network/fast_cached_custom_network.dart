import '../../../../utils/exports.dart';

/// FastCachedCustomNetwork widget
///
/// Same UI as `FastCachedCustomNetwork`, but uses FastCachedImage.
class FastCachedCustomNetwork extends StatelessWidget {

  /// Construct FastCachedCustomNetwork
  const FastCachedCustomNetwork({
    super.key,
    required this.imageUrl,
    required this.placeHolderImage,
    this.placeholder,
    this.errorWidget,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
    this.borderColor,
    this.color,
    this.shadow,
    this.borderWidth,
    this.radius,
    this.isDownloadPath = true,
    this.isShowPlaceHolder = false,
    this.alignment = Alignment.center,
    this.indicatorSize = Dimens.size25,
    this.progressIndicatorColor,
  });

  /// The URL of the image to be displayed
  final String imageUrl;

  /// The widget shown as placeholder
  final Widget? placeholder;

  /// The widget shown on error
  final Widget? errorWidget;

  /// The placeholder image if custom placeholder not given
  final Widget placeHolderImage;

  /// The width of the image.
  final double? width;

  /// The height of the image.
  final double? height;

  /// The border width of the container.
  final double? borderWidth;

  /// The border radius of the container.
  final double? radius;

  /// The shadow applied to the container.
  final List<BoxShadow>? shadow;

  /// The border color of the container.
  final Color? borderColor;

  /// The background color of the container.
  final Color? color;

  /// How the image should be inscribed into the space allocated during layout.
  final BoxFit? fit;

  /// The alignment of the image inside the container.
  final Alignment alignment;

  /// Whether to show the placeholder when the image is loading.
  final bool isShowPlaceHolder;

  /// Whether the image URL is a download path.
  final bool isDownloadPath;

  /// The size of the circular progress indicator.
  final double indicatorSize;

  /// The color of the circular progress indicator.
  final Color? progressIndicatorColor;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: FastCachedImage(
        key: ValueKey<String>(imageUrl),
        url: imageUrl,
        fit: fit,
        width: width,
        height: height,
        alignment: alignment,
        fadeInDuration: Duration.zero,
        loadingBuilder: (BuildContext context, FastCachedProgressData progress) {

          final bool isCached = FastCachedImageConfig.isCached(imageUrl: imageUrl);

          // Show placeholder only if explicitly requested and not cached
          if (isShowPlaceHolder && !isCached) {
            return placeholder ?? _placeHolderWidget(() => placeHolderImage);
          }
          if(!isCached){
            return Center(
              child: SizedBox(
                height: indicatorSize,
                width: indicatorSize,
                child: CircularProgressIndicator(
                  strokeWidth: Dimens.size2,
                  value: progress.progressPercentage.value,
                  color: progressIndicatorColor ?? MainConfig.appColors.background,
                ),
              ),
            );
          }
          return const SizedBox.shrink();
        },
        errorBuilder: (BuildContext context, Object exception, StackTrace? stacktrace) {
          return errorWidget ?? _placeHolderWidget(() => placeHolderImage);
        },
      ),
    );
  }

  Widget _placeHolderWidget(Widget Function() child) {
    return Container(
      height: height,
      width: width,
      alignment: alignment,
      decoration: BoxDecoration(
        border: Border.all(
          color: borderColor ?? MainConfig.appColors.borderTransparentColor,
          width: borderWidth ?? Dimens.borderWidth1,
        ),
        color: color,
        borderRadius: (radius ?? Dimens.radius4).borderRadius,
      ),
      child: child.call(),
    );
  }
}


