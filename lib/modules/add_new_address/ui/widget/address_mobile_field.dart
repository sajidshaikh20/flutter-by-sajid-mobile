import '../../../../utils/exports.dart';

/// Mobile number field widget
/// A widget that renders the mobile number input field in an address form.
///
/// This widget uses the current [AddressState] and [AddressCubit] to manage
/// the mobile number input, validation, and interactions.
/// The layout adapts according to the [device] type.
class AddressMobileField extends StatelessWidget {
  /// Creates an [AddressMobileField] widget.
  ///
  /// [state] represents the current address form state.
  /// [addressCubit] manages all state updates and business logic for the mobile field.
  /// [device] determines the layout for mobile, tablet, or desktop.
  const AddressMobileField({
    super.key,
    required this.state,
    required this.addressCubit,
    required this.device,
  });

  /// The current state of the address form.
  final AddressState state;

  /// The cubit responsible for managing the address form state.
  final AddressCubit addressCubit;

  /// The type of device layout to adapt the field's appearance.
  final ScreenType device;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: Dimens.fontSize16),
      child: CustomMobileInputWidget(
        device: device,
        mobileNumberController: state.mobileNumberEditingController,
        initialCountryCode: state.mobileCode.isNotEmpty
            ? state.mobileCode
            : context.appString.kuwaitCountryCodeKey,
        focusNode: state.mobileNoFocusNode,
        errorMessage: state.mobileNoErrorMessage,
        onCountryCodeChanged: (String? code) {
          if (code != null && code.isNotEmpty) {
            addressCubit.updateMobileCode(code);
          }
        },
        onChange: (String value) {
          // Mirror sign-up: clear error when valid; keep optional
          if (value.validMobileBool(isRequired: false) == true) {
            addressCubit.handleValidationErrormobileNo('');
          } else if (value.isNotEmpty) {
            addressCubit.handleValidationErrormobileNo(
                context.appString.enterValidMobileNumberKey);
          } else {
            addressCubit.handleValidationErrormobileNo('');
          }
        },
      ),
    );
  }
}

