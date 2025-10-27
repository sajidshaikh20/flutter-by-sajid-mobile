import '../../../utils/exports.dart';

/// Common container widget used for shimmer loading effects.
class ShimmerCommonContainer extends StatelessWidget {
  /// The height of the container.
  final double? height;

  /// The width of the container.
  final double? width;

  /// The background color of the container.
  final Color? backGroundColor;

  /// Creates a shimmer common container.
  ///
  /// [height] The height of the container. Defaults to a standard size.
  /// [width] The width of the container. Defaults to a standard size.
  /// [backGroundColor] The background color. Defaults to white.
  const ShimmerCommonContainer(
      {super.key, this.width, this.height, this.backGroundColor});

  @override
  Widget build(BuildContext context) {
    return CommonContainer(
      height: height ?? Dimens.size76,
      width: width ?? Dimens.size76,
      backgroundColor: backGroundColor ?? MainConfig.appColors.backgroundWhiteColor,
    );
  }
}
