import '../../../../utils/exports.dart';

/// A widget representing a common container used in the checkout section.
/// It adjusts its height based on the device type (mobile, tablet, or desktop).
class CheckOutCommonContainer extends StatelessWidget {

  /// Constructor for creating a `CheckOutCommonContainer` widget.
  /// [margin] is the optional margin for the container.
  /// [width] is the optional width for the container.
  /// [device] determines the screen type (mobile, tablet, desktop).
  const CheckOutCommonContainer({
    super.key,
    this.margin,
    this.width,
    this.device = ScreenType.mobile,
  });

  /// The optional margin for the container.
  final EdgeInsetsGeometry? margin;

  /// The optional width for the container.
  final double? width;

  /// The type of screen for adjusting the height. Defaults to mobile.
  final ScreenType device;

  @override
  Widget build(BuildContext context) {
    // Default height for mobile devices
    double height = Dimens.size22;

    switch (device) {
      case ScreenType.tablet:
        height = Dimens.size30;
      case ScreenType.mobile:
      case ScreenType.desktop:
    }

    // Container with dynamic height based on the device type
    return Container(
      color: MainConfig.appColors.dukkanborderGreyLightColor,
      height: height,
      width: width,
      margin: margin,
    );
  }
}
