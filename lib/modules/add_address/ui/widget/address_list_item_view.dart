import '../../../../utils/exports.dart';

/// A widget that displays a detailed address item view.
///
/// This widget is used in address lists and checkout screens. It supports
/// displaying a selection chip, delete button, and save address switch.
/// The layout adapts based on the [device] type.
class AddressListItemView extends StatelessWidget {
  /// Creates an [AddressListItemView].
  ///
  /// The [addressModel] provides the data for the address.
  /// The [isForCheckOut] flag indicates if this view is part of the checkout process.
  /// The [isForList] flag indicates if the view is used inside a list.
  /// Optional parameters include showing a delete button, a save address switch,
  /// handling switch changes, and customizing layout for different devices.
  const AddressListItemView({
    super.key,
    required this.addressModel,
    this.isSaveAddressSwitchVisible = false,
    this.isShowDeleteButton = false,
    this.onSwitchChange,
    this.selectedSwitchId,
    this.onDeleteTap,
    required this.isForCheckOut,
    required this.isForList,
    this.selectedAddressId,
    this.device = ScreenType.mobile,
  });

  /// The address data to display.
  final BillingAddress? addressModel;

  /// Whether the "save address" switch is visible.
  final bool? isSaveAddressSwitchVisible;

  /// Whether the delete button is visible.
  final bool? isShowDeleteButton;

  /// Callback triggered when the save address switch is changed.
  final Function({required bool value})? onSwitchChange;

  /// Callback triggered when the delete button is tapped.
  final Function()? onDeleteTap;

  /// The currently selected switch ID.
  final String? selectedSwitchId;

  /// Whether this view is used in the checkout process.
  final bool isForCheckOut;

  /// Whether this view is part of a list.
  final bool isForList;

  /// The currently selected address ID.
  final String? selectedAddressId;

  /// The device type to adapt layout for different screens.
  final ScreenType device;

  @override
  Widget build(BuildContext context) {
    double addressChipWidth = Dimens.size20;
    switch (device) {
      case ScreenType.tablet:
        addressChipWidth = Dimens.size30;
      default:
        break;
    }

    return Container(
      margin: const EdgeInsets.only(bottom: Dimens.space10),
      padding: const EdgeInsets.only(bottom: Dimens.space8),
      decoration: BoxDecorationExtension.customDecoration(
        color: MainConfig.appColors.backgroundExtraLightBlueColor,
        borderRadius: Dimens.radius8.borderRadius,
        border: Border.all(
          color: ((isForCheckOut && addressModel?.id.toString() == selectedAddressId) &&
              isForList)
              ? MainConfig.appColors.borderDarkBlueColor
              : MainConfig.appColors.borderLightWhiteColor,
        ),
      ),
      child: InkWell(
        onTap: isForCheckOut && isForList
            ? () {
          goBack(context, result: addressModel);
        }
            : null,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Visibility(
              visible: isForCheckOut && addressModel?.isShipping == 1,
              replacement: const SizedBox(width: Dimens.space15),
              child: Container(
                margin: isLanguageAlignmentLTR
                    ? const EdgeInsets.only(right: Dimens.space10)
                    : const EdgeInsets.only(left: Dimens.space10),
                child: ClipRRect(
                  borderRadius: isLanguageAlignmentLTR
                      ? const BorderRadius.only(topLeft: Radius.circular(Dimens.radius8))
                      : const BorderRadius.only(topRight: Radius.circular(Dimens.radius8)),
                  child: Assets.png.icDefaultAddressChip.image(width: addressChipWidth),
                ),
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  AddressListItemRow(
                    device: device,
                    isForCheckOut: isForCheckOut,
                    addressModel: addressModel,
                    isShowDeleteButton: isShowDeleteButton,
                    onDeleteTap: onDeleteTap,
                  ),
                  SizedBox(height: isForCheckOut ? Dimens.size10 : Dimens.zero),
                  CheckOutAddressView(
                    device: device,
                    selectedAddressId: selectedAddressId,
                    addressModel: addressModel,
                    isForList: isForList,
                    isForCheckOut: isForCheckOut,
                    isSaveAddressSwitchVisible: isSaveAddressSwitchVisible,
                    onSwitchChange: onSwitchChange,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Returns the translated or formatted title for an address.
  ///
  /// The [isLtr] parameter indicates whether the layout is left-to-right.
  String getAddressTitle({required bool isLtr, required String title}) {
    if (isLtr) {
      return title;
    } else {
      if (title == AddressType.home.name) {
        return MainConfig.dynamicString(JsonServiceString.keyHome);
      } else if (title == AddressType.work.name) {
        return MainConfig.dynamicString(JsonServiceString.keyOffice);
      } else if (title == AddressType.other.name) {
        return MainConfig.dynamicString(JsonServiceString.keyOther);
      } else {
        return MainConfig.dynamicString(JsonServiceString.keyHome);
      }
    }
  }

  /// Returns the icon for a given address type.
  ///
  /// Supports `home`, `work`, and `other` types.
  SvgGenImage getAddressType(String title) {
    if (title.toLowerCase() == AddressType.home.name.toLowerCase()) {
      return Assets.svgs.icHome;
    } else if (title.toLowerCase() == AddressType.work.name.toLowerCase()) {
      return Assets.svgs.icBriefcase;
    } else if (title.toLowerCase() == AddressType.other.name.toLowerCase()) {
      return Assets.svgs.icOtherIcon;
    } else {
      return Assets.svgs.icHome;
    }
  }
}
