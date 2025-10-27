import '../../../../utils/exports.dart';

/// A widget that displays identity-related input fields,
/// such as name, address, or other personal details.
///
/// It uses an [AddressCubit] to manage the state of the fields,
/// and adapts its layout based on the [device] type.
class IdentityFieldsWidget extends StatelessWidget {
  /// Creates an [IdentityFieldsWidget].
  ///
  /// The [addressCubit] is required to manage and update the state.
  /// The [device] parameter determines the layout (mobile, tablet, web),
  /// defaulting to [ScreenType.mobile].
  const IdentityFieldsWidget({
    super.key,
    required this.addressCubit,
    this.device = ScreenType.mobile,
  });

  /// The cubit responsible for managing address and identity field state.
  final AddressCubit addressCubit;

  /// The type of device layout to adapt the widget's appearance.
  final ScreenType device;
  @override
  Widget build(BuildContext context) {
    double heightMobTab15_25 = Dimens.size15;
    switch (device) {
      case ScreenType.tablet:
        heightMobTab15_25 = Dimens.size25;


      default:
        break;
    }
    return Column(
      children: <Widget>[
        CustomTextFormFieldWidget(
          device: device,
          controller: addressCubit.state.firstNameTextEditingController,
          label:
              MainConfig.dynamicString(JsonServiceString.keyRegisterFirstName),
          textInputType: TextInputType.name,
          input: TextInputAction.next,
          focusNode: addressCubit.state.firstNameFocusNode,
          onTextSubmit: (String p0) {
            FocusScope.of(context)
                .requestFocus(addressCubit.state.lastNameTextFocusNode);
          },
          validator: (dynamic value) {
            return value.toString().validateTextIsEmpty(
                MainConfig.dynamicString(
                    JsonServiceString.keyPleaseEnterFirstName));
          },
        ),
        heightMobTab15_25.heightBox,
        CustomTextFormFieldWidget(
          device: device,
          controller: addressCubit.state.lastNameTextEditingController,
          label:
              MainConfig.dynamicString(JsonServiceString.keyRegisterLastName),
          textInputType: TextInputType.name,
          focusNode: addressCubit.state.lastNameTextFocusNode,
          input: TextInputAction.next,
          onTextSubmit: (String p0) {
            FocusScope.of(context)
                .requestFocus(addressCubit.state.streetAddress1FocusNode);
          },
          validator: (dynamic value) {
            return value.toString().validateTextIsEmpty(
                MainConfig.dynamicString(
                    JsonServiceString.keyPleaseEnterLastName));
          },
        ),
        heightMobTab15_25.heightBox,
      ],
    );
  }
}
