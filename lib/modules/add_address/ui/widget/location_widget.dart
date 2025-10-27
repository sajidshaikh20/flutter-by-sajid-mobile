import '../../../../utils/exports.dart';

/// A widget that displays location-related content or options.
///
/// This widget can adapt its layout and styling based on the [device] type.
class LocationWidget extends StatelessWidget {
  /// Creates a [LocationWidget].
  ///
  /// The [device] parameter allows adjusting the layout/styling based on the device type,
  /// defaulting to [ScreenType.mobile].
  const LocationWidget({
    super.key,
    this.device = ScreenType.mobile,
  });

  /// The type of device layout to adapt the widget's appearance.
  final ScreenType device;
  @override
  Widget build(BuildContext context) {
    double widthMobTab6_18=Dimens.size6;
    switch(device){
      case ScreenType.tablet:
        widthMobTab6_18=Dimens.size18;

      default:
        break;
    }
    
    return BlocBuilder<AddressCubit, AddressState>(
        buildWhen: (AddressState previous, AddressState current) {
      return previous.currentSelectedAddress != current.currentSelectedAddress;
    }, builder: (BuildContext context, AddressState state) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Expanded(
            child: LocationBoxes(
              device: device,
              keyName: AddressType.home.name,
              name: MainConfig.dynamicString(JsonServiceString.keyHome),
              image: Assets.svgs.icHome,
              isSelected: state.currentSelectedAddress == AddressType.home.name,
            ),
          ),
          widthMobTab6_18.widthBox,
          Expanded(
            child: LocationBoxes(
              device: device,
              keyName: AddressType.work.name,
              name: MainConfig.dynamicString(JsonServiceString.keyOffice),
              image: Assets.svgs.icBriefcase,
              isSelected:
                  state.currentSelectedAddress == AddressType.work.name,
            ),
          ),
          widthMobTab6_18.widthBox,
          Expanded(
            child: LocationBoxes(
              device: device,
              keyName: AddressType.other.name,
              name: MainConfig.dynamicString(JsonServiceString.keyOther),
              image: Assets.svgs.icOtherIcon,
              isSelected:
                  state.currentSelectedAddress == AddressType.other.name,
            ),
          ),
        ],
      );
    });
  }
}
