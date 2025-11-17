import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../utils/exports.dart';
import '../../../../app/providers/providers.dart';
import 'signup_state_helper.dart';

/// A widget for inputting a mobile number with country code support.
///
/// Rebuilds only when the mobile error message changes. Works with [SignupNotifier]
/// to handle validation and country code changes.
class MobileInputWidget extends ConsumerWidget {
  /// Creates a [MobileInputWidget].
  ///
  /// [device] determines the screen type for responsive styling. Defaults to `ScreenType.mobile`.
  const MobileInputWidget({super.key, this.device = ScreenType.mobile});

  /// The type of screen for which the widget is being built.
  final ScreenType device;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final SignupState initialState = SignupStateHelper.createInitialState();
    final SignupState state = ref.watch(signupNotifierProvider(initialState));
    final SignupNotifier notifier = ref.read(signupNotifierProvider(initialState).notifier);
    return CustomMobileInputWidget(
      device: device,
      onChange: (String value) {
        // Clear error message if the mobile number is valid
        if (value.validMobileBool(isRequired: true) == true) {
          notifier.handleValidationErrorMessageForMobileNumber('');
        }
      },
      onCountryCodeChanged: (String? countryCode) {
        if (countryCode != null && countryCode.isNotEmpty) {
          notifier.setCountryCode(countryCode);
        }
      },
      errorMessage: state.mobileErrorMessage,
      focusNode: state.mobileNumberFocusNode,
      mobileNumberController: state.mobileController,
      initialCountryCode: state.mobilePrefix,
    );
  }
}
