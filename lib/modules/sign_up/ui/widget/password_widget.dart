import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../utils/exports.dart';
import '../../../../app/providers/providers.dart';
import 'signup_state_helper.dart';

/// A widget for password input in the signup form.
/// 
/// This widget provides a password field with validation and toggle visibility
/// functionality for the signup process.
class PasswordWidget extends ConsumerWidget {
  /// The device type for responsive design.
  final ScreenType device;

  /// Creates a [PasswordWidget].
  const PasswordWidget({super.key, this.device = ScreenType.mobile});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final SignupState initialState = SignupStateHelper.createInitialState();
    final SignupState state = ref.watch(signupNotifierProvider(initialState));
    final SignupNotifier notifier = ref.read(signupNotifierProvider(initialState).notifier);
    return PasswordFieldWidget(
      device: device,
      controller: state.passwordController,
      errorMsg: state.passwordErrorMessage,
      label: context.appString.passwordKey,
      inputAction: TextInputAction.done,
      onChange: (String value) {
        if (value.validatePasswordBool() ?? false) {
          notifier.handleValidationErrorMessageForPassword('');
        }
      },
      focusNode: state.passwordFocusNode,
      obscureText: state.passwordObscureText,
      toggleObscureText: () {
        notifier.togglePasswordObscureText();
      },
    );
  }
}
