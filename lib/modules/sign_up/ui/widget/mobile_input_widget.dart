import '../../../../utils/exports.dart';

/// A widget for inputting a mobile number with country code support.
///
/// Rebuilds only when the mobile error message changes. Works with [SignupCubit]
/// to handle validation and country code changes.
class MobileInputWidget extends StatelessWidget {
  /// Creates a [MobileInputWidget].
  ///
  /// [device] determines the screen type for responsive styling. Defaults to `ScreenType.mobile`.
  const MobileInputWidget({super.key, this.device = ScreenType.mobile});

  /// The type of screen for which the widget is being built.
  final ScreenType device;

  @override
  Widget build(BuildContext context) {
    // Access the SignupCubit instance
    SignupCubit cubit = context.instance<SignupCubit>();

    return BlocBuilder<SignupCubit, SignupState>(
      buildWhen: (SignupState previous, SignupState current) {
        // Only rebuild when mobile error message changes
        return previous.mobileErrorMessage != current.mobileErrorMessage;
      },
      builder: (BuildContext context, SignupState state) {
        return CustomMobileInputWidget(
          device: device,
          onChange: (String value) {
            // Clear error message if the mobile number is valid
            if (value.validMobileBool(isRequired: true) == true) {
              cubit.handleValidationErrorMessageForMobileNumber('');
            }
          },
          onCountryCodeChanged: (String? countryCode) {
            if (countryCode != null && countryCode.isNotEmpty) {
              cubit.setCountryCode(countryCode);
            }
          },
          errorMessage: state.mobileErrorMessage,
          focusNode: state.mobileNumberFocusNode,
          mobileNumberController: state.mobileController,
          initialCountryCode: state.mobilePrefix,
        );
      },
    );
  }
}
