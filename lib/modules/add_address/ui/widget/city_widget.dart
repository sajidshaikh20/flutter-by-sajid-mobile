import '../../../../utils/exports.dart';

/// A widget that displays a city selection field or city-related UI.
///
/// The layout can adapt based on the [device] type, such as mobile, tablet, or web.
class CityWidget extends StatelessWidget {
  /// Creates a [CityWidget].
  ///
  /// The [device] parameter allows customizing the layout for different
  /// screen types. Defaults to [ScreenType.mobile].
  const CityWidget({
    super.key,
    this.device = ScreenType.mobile,
  });

  /// The type of device to adapt the layout for different screens.
  final ScreenType device;

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
      readOnly: true,
      controller: addressCubit.state.cityTextEditingController,
      label: MainConfig.dynamicString(JsonServiceString.keyCityCypCan),
      input: TextInputAction.next,
      suffixIcon: Assets.svgs.icArrowDown.svg(),
      suffixIconSize: suffixIconSize,
      focusNode: addressCubit.state.cityTextFocusNode,
      onTextSubmit: (String p0) {
        FocusScope.of(context)
            .requestFocus(addressCubit.state.postalCodeFocusNode);
      },
      validator: (dynamic value) {
        return value.toString().validateTextIsEmpty(
            MainConfig.dynamicString(
                JsonServiceString.keyAddressSelectCity));
      },
      onTap: () {
        showBottomSheetForAddress(
          device: device,
            context, addressCubit.state, BottomSheetDataType.city);
      },
    );
  }

}