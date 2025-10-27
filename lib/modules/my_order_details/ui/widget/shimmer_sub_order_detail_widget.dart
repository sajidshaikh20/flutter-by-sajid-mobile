import '../../../../utils/exports.dart';

/// A shimmer placeholder widget used for displaying sub-order details.
///
/// This widget is typically used during loading states to show a shimmer
/// effect in place of the actual content.
class ShimmerSubOrderDetailWidget extends StatelessWidget {
  /// Creates a [ShimmerSubOrderDetailWidget].
  ///
  /// [height] sets the height of the shimmer container.
  /// [width] sets the width of the shimmer container.
  /// [backGroundColor] optionally sets a custom background color for the shimmer.
  const ShimmerSubOrderDetailWidget({
    super.key,
    this.width,
    this.height,
    this.backGroundColor,
  });

  /// The height of the shimmer container.
  final double? height;

  /// The width of the shimmer container.
  final double? width;

  /// Optional background color of the shimmer container.
  final Color? backGroundColor;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ShimmerCommonContainer(
        height: height ?? Dimens.size10,
        width: width ?? Dimens.size16,
        backGroundColor: backGroundColor,
      ),
    );
  }
}
