import '../../../../utils/exports.dart';

/// A widget to display and select the state/province for an address.
class StateWidget extends StatelessWidget {
  /// Creates a [StateWidget].
  ///
  /// [device] determines the screen type (mobile or tablet) to adjust UI elements accordingly.
  const StateWidget({super.key, this.device = ScreenType.mobile});

  /// The type of screen the widget is displayed on.
  final ScreenType device;

  /// Builds the UI for the state/province selection.
  @override
  Widget build(BuildContext context) {
    Size suffixIconSize=const Size(Dimens.size14, Dimens.size8);
    switch(device){

      case ScreenType.tablet:
        suffixIconSize=const Size(Dimens.size20, Dimens.size12);

      default:
        break;
    }
    
    final AddressCubit addressCubit = context.instance<AddressCubit>();
    return CustomTextFormFieldWidget(
      device: device,
      controller: addressCubit.state.stateTextEditingController,
      readOnly: true,
      label: MainConfig.dynamicString(JsonServiceString.keyProvinceState),
      input: TextInputAction.next,
      suffixIcon: Assets.svgs.icArrowDown.svg(),
      suffixIconSize: suffixIconSize,
      focusNode: addressCubit.state.stateTextFocusNode,
      onTextSubmit: (String p0) {
        FocusScope.of(context).requestFocus(addressCubit.state.cityTextFocusNode);
      },
      validator: (dynamic value) {
        return value.toString().validateTextIsEmpty(
              MainConfig.dynamicString(JsonServiceString.keyAddressSelectState),
            );
      },
      onTap: () {
        showBottomSheetForAddress(
          device: device,
          context,
          addressCubit.state,
          BottomSheetDataType.state,
        );
      },
    );
  }
}
