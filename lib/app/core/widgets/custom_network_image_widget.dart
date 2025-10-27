import '../../../utils/exports.dart';

/// baseNetworkImage widget
///
/// using this widget we can show loader while image is loading
/// we can caching the image and also handle error widget while
/// loading image url.
class CustomNetworkImageWidget extends StatelessWidget {

  ///constructor CustomNetworkImageWidget
  const CustomNetworkImageWidget({
    super.key,
    required this.imageUrl,
    this.imageBuilder,
    this.placeholder,
    this.progressIndicatorBuilder,
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
    required this.placeHolderImage,
    this.alignment = Alignment.center,
    this.indicatorSize = Dimens.size25, // Default value

  });

  /// [imageUrl] The URL of the image to be loaded.
  final String? imageUrl;

  /// [imageBuilder] A builder function to customize the image display.
  final ImageWidgetBuilder? imageBuilder;

  /// [placeholder] Widget to display while the image is loading.
  final Widget? placeholder;

  /// [progressIndicatorBuilder] A builder function to customize the progress indicator.
  final ProgressIndicatorBuilder? progressIndicatorBuilder;

  /// [errorWidget] Widget to display if the image fails to load.
  final Widget? errorWidget;

  /// [shadow] List of BoxShadow to apply to the image container.
  final List<BoxShadow>? shadow;

  /// [placeHolderImage] Generic Widget type for placeholder image.
  final Widget placeHolderImage;

  /// [width] Width of the image container.
  final double? width;

  /// [borderWidth] Width of the border around the image.
  final double? borderWidth;

  /// [height] Height of the image container.
  final double? height;

  /// [fit] How the image should be inscribed into the container.
  final BoxFit? fit;

  /// [color] Background color of the image container.
  final Color? color;

  /// [borderColor] Color of the border around the image.
  final Color? borderColor;

  /// [isShowPlaceHolder] Whether to show the custom placeholder or a loading indicator.
  final bool isShowPlaceHolder;

  /// [alignment] Alignment of the image within the container.
  final Alignment alignment;
  /// [isDownloadPath] Alignment of the image within the container.
  final bool isDownloadPath;
  /// [radius] Alignment of the image within the container.
  final double? radius;
  /// [indicatorSize] Alignment of the image within the container.
  final double indicatorSize;


  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      key: key,
      imageUrl: imageUrl ?? '',
      imageBuilder: (BuildContext context, ImageProvider<Object> imageProvider) {
        return Container(
          height: height,
          width: width,
          decoration: BoxDecoration(
              border: Border.all(
                  color: borderColor ?? MainConfig.appColors.borderTransparentColor,
                  width: borderWidth ?? Dimens.borderWidth1),
              color: color,
              borderRadius: (radius ?? Dimens.radius0).borderRadius,
              image: DecorationImage(image: imageProvider, fit: fit),
              boxShadow: shadow),
        );
      },
      placeholder: (BuildContext context, String image) {
        return isShowPlaceHolder
            ? placeholder ??
                _placeHolderWidget(() {
                  return placeHolderImage;
                })
            : Center(
                child: Container(
                    height: indicatorSize,
                    width: indicatorSize,
                    alignment: Alignment.center,
                    child: const CircularProgressIndicator(
                      strokeWidth: Dimens.size2,
                    )),
              );
      },
      errorWidget: (
        BuildContext context,
        String url,
        dynamic error,
      ) {
        return errorWidget ??
            _placeHolderWidget(() {
              return placeHolderImage;
            });
      },
      width: width,
      height: height,
      fit: fit,
      alignment: alignment,
    );
  }

  Widget _placeHolderWidget(Widget Function() child) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        border: Border.all(
            color: borderColor ?? MainConfig.appColors.borderTransparentColor,
            width: borderWidth ?? Dimens.borderWidth1),
        color: color,
        borderRadius: (radius ?? Dimens.radius4).borderRadius,
      ),
      child: child.call(),
    );
  }
}
