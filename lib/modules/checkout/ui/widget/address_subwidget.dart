import '../../../../utils/exports.dart';

/// A widget that displays the address section in the checkout screen.
/// It allows the user to either add a new address or edit an existing one.
class AddressSubWidget extends StatelessWidget {
  /// Constructor for creating an `AddressSubWidget` widget.
  /// [state] holds the current checkout state, and [device] determines
  /// the screen type (mobile, tablet, desktop).
  const AddressSubWidget({
    required this.state,
    super.key,
    this.device = ScreenType.mobile,
  });

  /// The current checkout state that contains address-related data.
  final CheckOutState state;

  /// The type of screen for adjusting the layout. Defaults to mobile.
  final ScreenType device;

  @override
  Widget build(BuildContext context) {
    EdgeInsets containerMargin =
        const EdgeInsets.symmetric(horizontal: Dimens.space10);
    double deliveryAddFontSize = Dimens.fontSize15;
    double pencilIconSize = Dimens.size25;

    switch (device) {
      case ScreenType.tablet:
        deliveryAddFontSize = Dimens.fontSize20;
        containerMargin =
            const EdgeInsets.symmetric(horizontal: Dimens.space20);
        pencilIconSize = Dimens.size35;
      case ScreenType.mobile:
      case ScreenType.desktop:
        break;
    }

    return Container(
      margin: containerMargin,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: Dimens.space8),
              child: CustomTextLabelWidget(
                label: MainConfig.dynamicString(
                  JsonServiceString.keyDeliveryAddress,
                ),
                textAlign: TextAlign.start,
                style: context.textTheme.bodyMedium?.copyWith(
                  fontSize: deliveryAddFontSize,
                  fontWeight: FontWeight.w600,
                  color: MainConfig.appColors.textDarkBlackColor,
                ),
              ),
            ),
          ),
          InkWell(
            onTap: () async {
              if (state.myAddressList?.isNotEmpty ?? false) {
                await context.router
                    .push<BillingAddress>(ListAddressRoute(
                  isForCheckOut: true,
                  selectedAddressId: state.selectedAddress?.id.toString() ?? '',
                ))
                    .then((BillingAddress? value) async {
                  if (context.mounted) {

                  }
                });
              } else {
                await context.router
                    .push(AddNewAddressRoute(isForCheckOut: true));
              }
            },
            child: Row(
              children: <Widget>[
                Visibility(
                  visible: state.myAddressList?.isNotEmpty ?? false,
                  child: Assets.svgs.icPencilIcon.svg(
                    height: pencilIconSize,
                    width: pencilIconSize,
                  ),
                ),
                Dimens.size8.widthBox,
                CustomTextLabelWidget(
                  label: (state.myAddressList?.isNotEmpty ?? false)
                      ? MainConfig.dynamicString(JsonServiceString.keyChange)
                      : MainConfig.dynamicString(JsonServiceString.keyAddNew),
                  style: context.textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: (state.myAddressList?.isEmpty ?? true)
                        ? MainConfig.appColors.textLightBlueColor
                        : MainConfig.appColors.textBlackColor,
                    fontSize: Dimens.fontSize16,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
