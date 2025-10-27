import '../../../../utils/exports.dart';

/// A widget for email input in the signup form.
/// 
/// This widget provides a text field for entering email addresses
/// with validation and proper keyboard type.
class EmailWidget extends StatelessWidget {
  /// The device type for responsive design.
  final ScreenType device;

  /// Creates an [EmailWidget].
  const EmailWidget({super.key, this.device = ScreenType.mobile});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignupCubit, SignupState>(
      builder: (BuildContext context, SignupState state) {
        final SignupCubit signUpCubit = context.read<SignupCubit>();
        return CommonTextFormFieldWidget(
          device: device,
          textInputType: TextInputType.emailAddress,
          controller: state.emailController,
          label: context.appString.emailIdKey,
          maxLength: Dimens.maxLength50,
          onChange: (String value) {
            if (value.validateEmailBool() ?? false) {
              signUpCubit.handleValidationErrorMessageForEmail('');
            }

          },
          errorMsg: state.emailErrorMessage,
          input: TextInputAction.next,
          focusNode: state.emailFocusNode,
          onTextSubmit: (_) {
            signUpCubit.moveToNextField(signUpCubit.state.referralCodeFocusNode);
          },
          textCapitalization: TextCapitalization.none,
        );
      },

    );
  }
}
