import '../../../utils/exports.dart';

/// Widget that displays the reset password form with validation and submission.
class ResetPasswordPageWidget extends StatelessWidget {
  /// Creates a reset password page widget.
  const ResetPasswordPageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final ResetPasswordCubit resetPasswordCubit = context.instance<ResetPasswordCubit>();

    return BlocListener<ResetPasswordCubit, ResetPasswordState>(
      listener: (BuildContext context, ResetPasswordState state) async {
        if (state.successMsg.isNotEmpty) {
          displaySnackBar(state.successMsg, context);
          resetPasswordCubit.resetSuccessMsg();
          await context.router.pushAndPopUntil(
            LoginRoute(),
            predicate: (Route<dynamic> route) =>
                route.settings.name == SocialLoginRoute.name,
          );
        }  else if (state.msg != null && (state.msg?.isNotEmpty ?? false)) {
          displaySnackBar(state.msg ?? '', context);
        }
      },
      listenWhen: (ResetPasswordState previous, ResetPasswordState current) =>
          current.successMsg.isNotEmpty ||
          (current.msg != null && (current.msg?.isNotEmpty ?? false)),
      child: Column(
        children: <Widget>[
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: Dimens.space16),
                child: Form(
                  key: resetPasswordCubit.state.formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Dimens.size15.heightBox,
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: Dimens.space26),
                        child: CustomTextLabelWidget(
                          label: context.appString.differentPassFromPreviousKey,
                          style: context.textTheme.bodyMedium?.copyWith(
                              fontWeight: FontWeight.w500,
                              height: Dimens.lineHeight18
                                  .toLineHeight(Dimens.fontSize14),
                              fontSize: Dimens.fontSize14),
                        ),
                      ),
                      Dimens.size37.heightBox,
                      BlocBuilder<ResetPasswordCubit, ResetPasswordState>(
                        buildWhen: (ResetPasswordState previous, ResetPasswordState current) =>
                            previous.newPasswordObscureText != current.newPasswordObscureText ||
                            previous.newPassErrorMessage != current.newPassErrorMessage,
                        builder: (BuildContext context, ResetPasswordState state) {
                          return CommonTextFormFieldWidget(
                            controller: state.newPassController,
                            maxLength: Dimens.maxLength15,
                            focusNode: state.newPassFocusNode,
                            obscureText: state.newPasswordObscureText,
                            errorMsg: state.newPassErrorMessage,
                            input: TextInputAction.next,
                            suffixIcon: CustomTextLabelWidget(
                              label: state.newPasswordObscureText
                                  ? context.appString.showKey
                                  : context.appString.hideKey,
                              textAlign: TextAlign.start,
                              style: context.textTheme.bodySmall?.copyWith(
                                  color: MainConfig.appColors.textBlackColor,
                                  fontSize: Dimens.fontSize12),
                              onTap: () {
                                resetPasswordCubit.toggleNewPassObscureText();
                              },
                            ),
                            onChange: (String value) {
                              if (value.validatePasswordBool() ?? false) {
                                resetPasswordCubit
                                    .handleValidationErrorMessageNewPass('');
                              }
                            },
                            onTextSubmit: (_) {
                              resetPasswordCubit
                                  .moveToNextField(state.conPasswordFocusNode);
                            },
                            label: context.appString.newPasswordKey,
                          );
                        },
                      ),
                      Dimens.size15.heightBox,
                      BlocBuilder<ResetPasswordCubit, ResetPasswordState>(
                        buildWhen: (ResetPasswordState previous, ResetPasswordState current) =>
                            previous.conFirmPasswordObscureText != current.conFirmPasswordObscureText ||
                            previous.conPassErrorMessage != current.conPassErrorMessage,
                        builder: (BuildContext context, ResetPasswordState state) {
                          return CommonTextFormFieldWidget(
                            obscureText: state.conFirmPasswordObscureText,
                            maxLength: Dimens.maxLength15,
                            controller: state.conPasswordController,
                            focusNode: state.conPasswordFocusNode,
                            errorMsg: state.conPassErrorMessage,
                            suffixIcon: CustomTextLabelWidget(
                              label: state.conFirmPasswordObscureText
                                  ? context.appString.showKey
                                  : context.appString.hideKey,
                              textAlign: TextAlign.start,
                              style: context.textTheme.bodySmall?.copyWith(
                                  color: MainConfig.appColors.textLightBlackColor,
                                  fontSize: Dimens.fontSize12),
                              onTap: () {
                                resetPasswordCubit.toggleConfirmPassObscureText();
                              },
                            ),
                            onChange: (String value) {
                              if (value.validatePasswordBool() ?? false) {
                                resetPasswordCubit
                                    .handleValidationErrorMessageConPassword('');
                              }
                            },
                            label: context.appString.confirmNewPasswordKey,
                          );
                        },
                      ),
                      Dimens.size26.heightBox,
                      const PasswordRequirements(),
                      Dimens.size17.heightBox,
                    ],
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: Dimens.space16, vertical: Dimens.space25),
            child: BlocBuilder<ResetPasswordCubit, ResetPasswordState>(
              //#TODO No specific buildWhen needed - button rebuilds for all state changes
              builder: (BuildContext context, ResetPasswordState state) {
                return CustomGradientButtonWidget(
                  title: context.appString.resetKey,
                  titleTextStyle: context.textTheme.headlineMedium?.copyWith(
                    fontSize: Dimens.fontSize18,
                    color: MainConfig.appColors.textWhiteColor,
                  ),
                  onTap: () async {
                    if (_validateResetPasswordForm(context, resetPasswordCubit)) {
                      // Check password match after validating the form
                      final String newPassword =
                          resetPasswordCubit.state.newPassController.text.trim();
                      final String conPassword =
                          resetPasswordCubit.state.conPasswordController.text.trim();

                      if (newPassword != conPassword) {
                        displaySnackBar(context.appString.passDoNotMatchKey, context);
                        return;
                      }
                      // Proceed with API call if passwords match
                      await resetPasswordCubit.callResetPasswordWithMobileApi();
                    }
                  },
                );
              },
            ),
          ),
          Dimens.size15.heightBox,
        ],
      ),
    );
  }

  bool _validateResetPasswordForm(
    BuildContext context,
    ResetPasswordCubit resetPasswordCubit,
  ) {
    final String newPassword = resetPasswordCubit.state.newPassController.text.trim();
    final String conPassword =
        resetPasswordCubit.state.conPasswordController.text.trim();
    bool isValid = true;

    // Check for empty fields
    if (newPassword.isEmpty || conPassword.isEmpty) {
      if (newPassword.isEmpty) {
        isValid = false;
        resetPasswordCubit.handleValidationErrorMessageNewPass(
            context.appString.pleaseEnterNewPasswordKey);
      }
      if (conPassword.isEmpty) {
        isValid = false;
        resetPasswordCubit.handleValidationErrorMessageConPassword(
            context.appString.pleaseEnterYourConfirmPasswordKey);
      }
    }

    // Validate the new password
    final String? passwordError = newPassword.validatePassword(
        isNewPassword: true, customError: context.appString.pleaseEnterNewPasswordKey,
        emptyPasswordMsg: context.appString.pleaseEnterThePasswordKey,
        invalidPasswordMsg: context.appString.passAllCriteriaKey);
    if (passwordError?.isNotEmpty ?? false) {
      isValid = false;
      resetPasswordCubit
          .handleValidationErrorMessageNewPass(passwordError ?? "");
    } else {
      resetPasswordCubit.handleValidationErrorMessageNewPass("");
    }

    // Validate the confirm password
    final String? conPasswordError = conPassword.validatePassword(
        isNewPassword: true,
        customError: context.appString.pleaseEnterYourConfirmPasswordKey,
        emptyPasswordMsg: context.appString.pleaseEnterThePasswordKey,
        invalidPasswordMsg: context.appString.passAllCriteriaKey);
    if (conPasswordError?.isNotEmpty ?? false) {
      isValid = false;
      resetPasswordCubit
          .handleValidationErrorMessageConPassword(conPasswordError ?? "");
    } else {
      resetPasswordCubit.handleValidationErrorMessageConPassword("");
    }

    return isValid;
  }
}
