import '../../../../utils/exports.dart';
///SelectLocationWidget
class SelectLocationWidget extends StatefulWidget {

  ///SelectLocationWidget
  const SelectLocationWidget({
    super.key, 
    this.device = ScreenType.mobile,
    this.isEdit = false,
    this.addressType,
  });

  /// The type of screen on which the widget is displayed.
  ///
  /// Used to determine responsive layout behavior based on the device
  /// (e.g., mobile, tablet, or web).
  final ScreenType device;

  /// Indicates whether the current state is in edit mode.
  ///
  /// When `true`, the user can modify existing data.
  /// When `false`, the view is in read-only or add-new mode.
  final bool isEdit;

  /// The type of address being displayed or edited.
  ///
  /// This can represent different address categories, such as
  /// "Home", "Work", or "Other". May be `null` if not specified.
  final String? addressType;

  @override
  State<SelectLocationWidget> createState() => _SelectLocationWidgetState();
}

class _SelectLocationWidgetState extends State<SelectLocationWidget> {
  @override
  void initState() {
    super.initState();
    
    // If in edit mode and addressType is provided, set the address type
    if (widget.isEdit && widget.addressType != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        final String addressType = widget.addressType!.toLowerCase();
        if (addressType == 'home') {
          context.instance<AddressCubit>().setAddressType(AddressType.home.name);
        } else if (addressType == 'work') {
          context.instance<AddressCubit>().setAddressType(AddressType.work.name);
        } else {
          context.instance<AddressCubit>().setAddressType(AddressType.other.name);
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    double widthMobTab6_18 = Dimens.size6;
    switch (widget.device) {
      case ScreenType.tablet:
        widthMobTab6_18 = Dimens.size18;

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
              device: widget.device,
              keyName: AddressType.home.name,
              name: context.appString.navHomeKey,
              image: Assets.svgs.icHomeLocation,
              isSelected: state.currentSelectedAddress == AddressType.home.name,
            ),
          ),
          widthMobTab6_18.widthBox,
          Expanded(
            child: LocationBoxes(
              device: widget.device,
              keyName: AddressType.work.name,
              name: context.appString.workKey,
              image: Assets.svgs.icOfficeLocation,
              isSelected:
                  state.currentSelectedAddress == AddressType.work.name,
            ),
          ),
          widthMobTab6_18.widthBox,
          Expanded(
            child: LocationBoxes(
              device: widget.device,
              keyName: AddressType.other.name,
              name: context.appString.otherKey,
              image: Assets.svgs.icOtherLocation,
              isSelected:
                  state.currentSelectedAddress == AddressType.other.name,
            ),
          ),
        ],
      );
    });
  }
}
