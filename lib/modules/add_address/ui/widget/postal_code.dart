import '../../../../utils/exports.dart';
/// A widget that displays or handles postal code input or information.
///
/// The layout and styling can adapt based on the [device] type.
class PostalCode extends StatelessWidget {
  /// Creates a [PostalCode] widget.
  ///
  /// The [device] parameter allows adjusting the layout/styling based on the device type,
  /// defaulting to [ScreenType.mobile].
  const PostalCode({
    super.key,
    this.device = ScreenType.mobile,
  });

  /// The type of device layout to adapt the widget's appearance.
  final ScreenType device;
  @override
  Widget build(BuildContext context) {
    final AddressCubit addressCubit = context.instance<AddressCubit>();
    return CustomTextFormFieldWidget(
      device: device,
      controller: addressCubit.state.postalCodeTextEditingController,
      label: MainConfig.dynamicString(JsonServiceString.keyPostalCode),
      textInputType: TextInputType.number,
      input: TextInputAction.next,
      focusNode: addressCubit.state.postalCodeFocusNode,
      onTextSubmit: (String p0) {
        FocusScope.of(context).requestFocus(addressCubit.state.mobileNumberFocusNode);
      },
      validator: (dynamic value) {
        return value.toString().validateTextIsEmpty(
              MainConfig.dynamicString(JsonServiceString.keyPleaseEnterPostalCode),
            );
      },
    );
  }
}
