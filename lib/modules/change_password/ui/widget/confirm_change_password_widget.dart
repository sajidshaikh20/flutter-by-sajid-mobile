import '../../../../utils/exports.dart';

/// A widget for confirming the new password in the change password flow.
///
/// This widget uses [BlocBuilder] to rebuild only when the confirm password
/// state changes (obscure text toggle or error message update). It displays
/// a [PasswordFieldWidget] with proper validation and toggle functionality.
class ConfirmChangePasswordWidget extends StatelessWidget {
  /// Creates a [ConfirmChangePasswordWidget].
  ///
  /// The [device] parameter determines the screen type for responsive styling.
  const ConfirmChangePasswordWidget({
    super.key,
    this.device = ScreenType.mobile,
  });

  /// The type of device, used for responsive styling.
  final ScreenType device;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChangePasswordCubit, ChangePasswordState>(
      /// Only rebuild the widget when confirm password specific state changes.
      buildWhen: (ChangePasswordState previous, ChangePasswordState current) {
        return previous.cnfPasswordObscureText != current.cnfPasswordObscureText ||
            previous.conPassErrorMessage != current.conPassErrorMessage;
      },
      builder: (BuildContext context, ChangePasswordState state) {
        return PasswordFieldWidget(
          device: device,
          controller: state.cnfPassController,
          label: context.appString.confirmNewPasswordKey,
          inputAction: TextInputAction.done,
          focusNode: state.cnfPassFocusNode,
          obscureText: state.cnfPasswordObscureText,
          errorMsg: state.conPassErrorMessage,
          onChange: (String value) {
            if (value.validatePasswordBool() ?? false) {
              context
                  .read<ChangePasswordCubit>()
                  .handleValidationErrorMessageConPassword('');
            }
          },
          toggleObscureText: () {
            context
                .instance<ChangePasswordCubit>()
                .toggleConfirmPassObscureText();
          },
        );
      },
    );
  }
}
