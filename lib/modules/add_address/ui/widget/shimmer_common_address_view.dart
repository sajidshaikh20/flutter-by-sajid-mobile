import '../../../../utils/exports.dart';

/// A widget that displays a shimmer effect placeholder for a common address view.
///
/// This widget is typically used while address data is loading to indicate that content
/// is being fetched. The layout and styling can adapt based on the [device] type.
class ShimmerCommonAddressView extends StatelessWidget {
  /// Creates a [ShimmerCommonAddressView] widget.
  ///
  /// The [device] parameter allows adjusting the layout/styling based on the device type,
  /// defaulting to [ScreenType.mobile].
  const ShimmerCommonAddressView({
    super.key,
    this.device = ScreenType.mobile,
  });

  /// The type of device layout to adapt the widget's appearance.
  final ScreenType device;

  @override
  Widget build(BuildContext context) {
    double simmerCommonContainerHeight = Dimens.size10;
    double simmerCommonContainerWidth = Dimens.size50;
    double heightMobTab6_10 = Dimens.size6;

    switch (device) {
      case ScreenType.mobile:
        break;
      case ScreenType.tablet:
        simmerCommonContainerHeight = Dimens.size15;
        simmerCommonContainerWidth = Dimens.size65;
        heightMobTab6_10 = Dimens.size10;

      default:
        break;
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        CommonContainer(
          height: simmerCommonContainerHeight,
          width: simmerCommonContainerWidth,
          backgroundColor: MainConfig.appColors.backgroundWhiteColor,
        ),
        heightMobTab6_10.heightBox,
        ShimmerAddressListItemView(
          device: device,
        )
      ],
    );
  }
}
