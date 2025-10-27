import '../../../../utils/exports.dart';

///[NewPasswordWidget] : this is a widget for display and get the new password from the user.
class NewPasswordWidget extends StatelessWidget {
  ///[NewPasswordWidget] constructor
  const NewPasswordWidget({
    super.key,
    this.device = ScreenType.mobile,
  });

  ///[device] : this is the current device in which the application is running.
  final ScreenType device;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChangePasswordCubit, ChangePasswordState>(
      buildWhen: (ChangePasswordState previous, ChangePasswordState current) {
        // Only rebuild when new password related state changes
        return previous.newPassObscureText != current.newPassObscureText ||
               previous.newPassErrorMessage != current.newPassErrorMessage;
      },
      builder: (BuildContext context, ChangePasswordState state) {
        return PasswordFieldWidget(
          device: device,
          controller: state.newPassController,
          label: context.appString.newPasswordKey,
          inputAction: TextInputAction.next,
          focusNode: state.newPassFocusNode,
          obscureText: state.newPassObscureText,
          nextFocusNode: state.newPassFocusNode,
          errorMsg: state.newPassErrorMessage,
          onChange: (String value) {
            if (value.validatePasswordBool() ?? false) {
              context.read<ChangePasswordCubit>()
                  .handleValidationErrorMessageNewPass('');
            }
          },
          toggleObscureText: () {
            context.instance<ChangePasswordCubit>().toggleNewPassObscureText();
          },
          onTextSubmit: (_) {
            context
                .instance<ChangePasswordCubit>()
                .moveToNextField(state.newPassFocusNode);
          },
        );
      },

    );
  }
}
