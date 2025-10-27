import '../../../../utils/exports.dart';

/// A widget for the current password input field.
class CurrentPasswordWidget extends StatelessWidget {
  /// Creates a [CurrentPasswordWidget].
  ///
  /// [device] specifies the screen type (mobile, tablet, etc.).
  /// Defaults to [ScreenType.mobile].
  const CurrentPasswordWidget({super.key, this.device = ScreenType.mobile});

  /// The type of screen the widget is being displayed on.
  final ScreenType device;

  /// Builds the widget's UI.
  ///
  /// It utilizes a [BlocBuilder] to listen to the [ChangePasswordCubit]
  /// and render a [PasswordFieldWidget] based on the state.
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChangePasswordCubit, ChangePasswordState>(
      buildWhen: (ChangePasswordState previous, ChangePasswordState current) {
        // Only rebuild when current password related state changes
        return previous.oldPassObscureText != current.oldPassObscureText ||
               previous.oldPassErrorMessage != current.oldPassErrorMessage;
      },
      builder: (BuildContext context, ChangePasswordState state) {
        return PasswordFieldWidget(
          device: device,
          controller: state.oldPassController,
          label: context.appString.currentPasswordKey,
          inputAction: TextInputAction.next,
          focusNode: state.oldPassFocusNode,
          obscureText: state.oldPassObscureText,
          nextFocusNode: state.oldPassFocusNode,
          errorMsg: state.oldPassErrorMessage,
          onChange: (String value) {
            if (value.validatePasswordBool() ?? false) {
              context.read<ChangePasswordCubit>()
                  .handleValidationErrorMessageOldPass('');
            }
          },
          toggleObscureText: () {
            context.instance<ChangePasswordCubit>().toggleOldPassObscureText();
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
