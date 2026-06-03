import '../../../../utils/exports.dart';

/// Sign up step 3 — username and password fields.
class SignUpCompleteProfileForm extends StatelessWidget {
  /// Creates [SignUpCompleteProfileForm].
  const SignUpCompleteProfileForm({super.key});

  @override
  Widget build(BuildContext context) {
    final SignUpCubit cubit = context.read<SignUpCubit>();
    final bool isDark = context.isDark;

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: Dimens.size16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SignUpStepHeader(
            title: context.appString.signUpCompleteYourProfileKey,
            subtitle: context.appString.signUpSetupWekoAccountKey,
          ),
          Dimens.size24.heightBox,
          BlocBuilder<SignUpCubit, SignUpState>(
            buildWhen: (SignUpState p, SignUpState c) =>
                p.usernameErrorMessage != c.usernameErrorMessage,
            builder: (BuildContext context, SignUpState state) {
              return CommonTextFormFieldWidget(
                controller: state.usernameController,
                label: context.appString.signUpUsernameKey,
                hint: context.appString.signUpChooseUsernameKey,
                input: TextInputAction.next,
                focusNode: state.usernameFocusNode,
                errorMsg: state.usernameErrorMessage,
                textCapitalization: TextCapitalization.none,
                maxLength: Dimens.maxLength50,
                onChange: (String value) {
                  if (value.trim().length >= 3 && !value.contains(' ')) {
                    cubit.setUsernameError('');
                  }
                },
                onTextSubmit: (_) {
                  cubit.moveToNextField(state.passwordFocusNode);
                },
              );
            },
          ),
          Dimens.size16.heightBox,
          BlocBuilder<SignUpCubit, SignUpState>(
            buildWhen: (SignUpState p, SignUpState c) =>
                p.passwordErrorMessage != c.passwordErrorMessage ||
                p.passwordObscureText != c.passwordObscureText,
            builder: (BuildContext context, SignUpState state) {
              return CommonTextFormFieldWidget(
                controller: state.passwordController,
                label: context.appString.passwordKey,
                hint: context.appString.signUpCreateStrongPasswordKey,
                input: TextInputAction.next,
                focusNode: state.passwordFocusNode,
                errorMsg: state.passwordErrorMessage,
                maxLength: Dimens.maxLength15,
                obscureText: state.passwordObscureText,
                onChange: (String value) {
                  if (value.validatePasswordBool() ?? false) {
                    cubit.setPasswordError('');
                  }
                },
                onTextSubmit: (_) {
                  cubit.moveToNextField(state.confirmPasswordFocusNode);
                },
                suffixIcon: CustomTextLabelWidget(
                  label: state.passwordObscureText
                      ? context.appString.showKey
                      : context.appString.hideKey,
                  style: context.textTheme.bodySmall?.copyWith(
                    fontWeight: FontWeight.w400,
                    color: isDark
                        ? AppColors.textSecondaryDark
                        : AppColors.textSecondaryLight,
                    fontSize: Dimens.fontSize12,
                  ),
                  onTap: cubit.togglePasswordObscureText,
                ),
              );
            },
          ),
          Dimens.size16.heightBox,
          BlocBuilder<SignUpCubit, SignUpState>(
            buildWhen: (SignUpState p, SignUpState c) =>
                p.confirmPasswordErrorMessage !=
                    c.confirmPasswordErrorMessage ||
                p.confirmPasswordObscureText != c.confirmPasswordObscureText,
            builder: (BuildContext context, SignUpState state) {
              return CommonTextFormFieldWidget(
                controller: state.confirmPasswordController,
                label: context.appString.signUpConfirmPasswordKey,
                hint: context.appString.signUpConfirmPasswordHintKey,
                input: TextInputAction.done,
                focusNode: state.confirmPasswordFocusNode,
                errorMsg: state.confirmPasswordErrorMessage,
                maxLength: Dimens.maxLength15,
                obscureText: state.confirmPasswordObscureText,
                onChange: (String value) {
                  if (value == state.passwordController.text.trim()) {
                    cubit.setConfirmPasswordError('');
                  }
                },
                suffixIcon: CustomTextLabelWidget(
                  label: state.confirmPasswordObscureText
                      ? context.appString.showKey
                      : context.appString.hideKey,
                  style: context.textTheme.bodySmall?.copyWith(
                    fontWeight: FontWeight.w400,
                    color: isDark
                        ? AppColors.textSecondaryDark
                        : AppColors.textSecondaryLight,
                    fontSize: Dimens.fontSize12,
                  ),
                  onTap: cubit.toggleConfirmPasswordObscureText,
                ),
              );
            },
          ),
          Dimens.size24.heightBox,
        ],
      ),
    );
  }
}
