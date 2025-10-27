import '../../../../utils/exports.dart';

/// A widget for password input in the signup form.
/// 
/// This widget provides a password field with validation and toggle visibility
/// functionality for the signup process.
class PasswordWidget extends StatelessWidget {
  /// The device type for responsive design.
  final ScreenType device;

  /// Creates a [PasswordWidget].
  const PasswordWidget({super.key, this.device = ScreenType.mobile});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignupCubit, SignupState>(
      buildWhen: (SignupState previous, SignupState current) {
        // Only rebuild when password error message or obscure text changes
        return previous.passwordErrorMessage != current.passwordErrorMessage ||
            previous.passwordObscureText != current.passwordObscureText;
      },
      builder: (BuildContext context, SignupState state) {
        return PasswordFieldWidget(
          device: device,
          controller: state.passwordController,
          errorMsg: state.passwordErrorMessage,
          label: context.appString.passwordKey,

          inputAction: TextInputAction.done,
          onChange: (String value) {
            if (value.validatePasswordBool() ?? false) {
              context.read<SignupCubit>().handleValidationErrorMessageForPassword('');
            }
          },
          focusNode: state.passwordFocusNode,
          obscureText: state.passwordObscureText,
          toggleObscureText: () {
            context.instance<SignupCubit>().togglePassObscureText();
          },
        );
      },
    );
  }
}
