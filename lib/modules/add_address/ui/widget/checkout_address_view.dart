import '../../../../utils/exports.dart';

/// A widget that displays an address in the checkout screen.
///
/// This widget supports displaying the full address, contact details, and a
/// "save address" switch. It can adapt its layout based on the [device] type
/// and highlights the selected address when used in a list.
class CheckOutAddressView extends StatelessWidget {
  /// Creates a [CheckOutAddressView].
  ///
  /// The [isForList] and [isForCheckOut] flags are required to control
  /// layout behavior and selection logic. Optional parameters allow showing
  /// a save address switch, handling switch changes, and customizing the
  /// device layout.
  const CheckOutAddressView({
    super.key,
    this.addressModel,
    this.selectedAddressId,
    required this.isForList,
    required this.isForCheckOut,
    this.isSaveAddressSwitchVisible,
    this.onSwitchChange,
    this.device = ScreenType.mobile,
  });

  /// The address data to display.
  final BillingAddress? addressModel;

  /// Whether this widget is displayed inside a list.
  final bool isForList;

  /// The currently selected address ID.
  final String? selectedAddressId;

  /// Whether this widget is displayed as part of the checkout process.
  final bool isForCheckOut;

  /// Whether the "save address" switch should be visible.
  final bool? isSaveAddressSwitchVisible;

  /// Callback triggered when the save address switch is toggled.
  final Function({required bool value})? onSwitchChange;

  /// The device type to adapt layout for different screens.
  final ScreenType device;

  @override
  Widget build(BuildContext context) {
    double addressFontSize = Dimens.fontSize16;
    switch (device) {
      case ScreenType.tablet:
        addressFontSize = Dimens.fontSize20;
      default:
        break;
    }

    return Row(
      children: <Widget>[
        Expanded(
          child: Visibility(
            visible: isForCheckOut,
            replacement: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                ListTextView(
                  label: "${addressModel?.street?.first} ,",
                  device: device,
                ),
                ListTextView(
                  label: "${addressModel?.city} ${addressModel?.region}",
                  device: device,
                ),
                ListTextView(
                  label: "T : +${addressModel?.telephone}",
                  device: device,
                ),
                Visibility(
                  visible: isSaveAddressSwitchVisible ?? false,
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: CustomTextLabelWidget(
                          label: MainConfig.dynamicString(JsonServiceString.keySaveThisAddress),
                          textAlign: TextAlign.start,
                          maxLines: Dimens.maxLines01,
                          overflow: TextOverflow.ellipsis,
                          style: context.textTheme.headlineSmall?.copyWith(
                            fontSize: addressFontSize,
                          ),
                        ),
                      ),
                      CustomSwitch(
                        value: addressModel?.isSelected ?? false,
                        onChanged: (bool value) {
                          onSwitchChange?.call(value: value);
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Directionality(
                  textDirection: isRTLText(addressModel?.email ?? "")
                      ? TextDirection.rtl
                      : TextDirection.ltr,
                  child: ListTextView(
                    maxLines: Dimens.maxLines02,
                    label: "${addressModel?.street?.first}, ${addressModel?.city}, ${addressModel?.region}",
                    textStyle: context.textTheme.displayMedium?.copyWith(
                      fontWeight: FontWeight.w700,
                      fontSize: addressFontSize,
                    ),
                    device: device,
                  ),
                ),
                Dimens.size10.heightBox,
                Row(
                  children: <Widget>[
                    ListTextView(
                      label: "${MainConfig.dynamicString(JsonServiceString.keyContactTitlephone)} : ",
                      textStyle: context.textTheme.headlineMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: MainConfig.appColors.textBlackColor,
                      ),
                    ),
                    Dimens.size5.widthBox,
                    ListTextView(
                      label: "+${addressModel?.telephone}".contains('+')
                          ? Bidi.enforceLtrInText("+${addressModel?.telephone}")
                          : "+${addressModel?.telephone}",
                      textStyle: context.textTheme.headlineMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                        fontSize: addressFontSize,
                        color: MainConfig.appColors.textBlackColor,
                      ),
                    ),
                  ],
                ),
                Dimens.size6.heightBox,
                Row(
                  children: <Widget>[
                    ListTextView(
                      label: "${MainConfig.dynamicString(JsonServiceString.keyContactTitleemail)} : ",
                      textStyle: context.textTheme.headlineMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                        fontSize: addressFontSize,
                        color: MainConfig.appColors.textBlackColor,
                      ),
                    ),
                    Dimens.size5.widthBox,
                    Expanded(
                      child: Directionality(
                        textDirection: isRTLText(addressModel?.email ?? "")
                            ? TextDirection.rtl
                            : TextDirection.ltr,
                        child: ListTextView(
                          label: "${addressModel?.email}",
                          textStyle: context.textTheme.headlineMedium?.copyWith(
                            fontSize: addressFontSize,
                            color: MainConfig.appColors.textBlackColor,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Dimens.size8.heightBox,
              ],
            ),
          ),
        ),
        Container(
          alignment: Alignment.topCenter,
          margin: const EdgeInsets.symmetric(horizontal: Dimens.space5),
          child: ((isForCheckOut && addressModel?.id.toString() == selectedAddressId) &&
              isForList)
              ? Assets.svgs.icTickIcon.svg()
              : const SizedBox(),
        ),
      ],
    );
  }
}
