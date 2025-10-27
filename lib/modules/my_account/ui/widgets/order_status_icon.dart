import '../../../../utils/exports.dart';

/// Widget that displays an order status icon with customizable background and size.
class OrderStatusIcon extends StatelessWidget {
  /// Creates an order status icon widget.
  const OrderStatusIcon(
      {super.key,
      this.svgGenImage,
      this.containerBg,
      this.containerSize = Dimens.size32,
      required this.svgPath,
      this.imageSize = Dimens.size22});

  /// The background color of the container.
  final Color? containerBg;

  /// The size of the container.
  final double containerSize;

  /// The path to the SVG icon.
  final String svgPath;

  /// The SVG generated image asset.
  final SvgGenImage? svgGenImage;

  /// The size of the icon image.
  final double imageSize;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: containerSize,
      width: containerSize,
      decoration: BoxDecorationExtension.customDecoration(
        color: containerBg ??MainConfig.appColors.iceBlueColor,
        shape: BoxShape.circle,
      ),
      child: svgPath.isNotEmpty
          ? SvgPicture.asset(
              svgPath,
              height: imageSize,
              width: imageSize,
            )
          : (svgGenImage != null
              ? svgGenImage!.svg(
                  height: imageSize,
                  width: imageSize,
                )
              : const SizedBox.shrink()),
    );
  }
}
