import '../../../../utils/exports.dart';

/// A form widget for changing user password.
/// 
/// This widget provides a complete form with current password, new password,
/// and confirm password fields with validation.
class ChangePasswordForm extends StatelessWidget {
  /// The device type for responsive design.
  final ScreenType device;

  /// Creates a [ChangePasswordForm] widget.
  const ChangePasswordForm({super.key, this.device = ScreenType.mobile});

  @override
  Widget build(BuildContext context) {
    double horizontalPadding = Dimens.space16;
    double heightMobTab35_50 = Dimens.size32;
    switch (device) {
      case ScreenType.mobile:
        break;
      case ScreenType.tablet:
        horizontalPadding = Dimens.space100;
        heightMobTab35_50 = Dimens.size50;

      default:
        break;
    }

    final ChangePasswordCubit changePasswordCubit =
        context.instance<ChangePasswordCubit>();
    return BlocListener<ChangePasswordCubit, ChangePasswordState>(
        listener: (BuildContext context, ChangePasswordState state) async {
          if (state.msg != null && (state.msg?.isNotEmpty ?? false)) {
            displaySnackBar(state.msg ?? '', context);
          }
          if (state.redirectRoute != null && state.status == BaseStateStatus.success) {
            await context.router.replaceAll(<PageRouteInfo>[state.redirectRoute!]);
          }
          // if (state.msg?.isNotEmpty ?? false) {
          //   displaySnackBar(state.msg!, context);
          // }
          // if (state.status == BaseStateStatus.success) {
          //   Navigator.pop(context); // Go back after success
          // }
          // else if (state.showDefaultErrMsg ?? false) {
          // }
          // else if (state.successMsg.isNotEmpty) {
          //   // _showSuccessDialog(message: state.successMsg, context: context);
          // }
          // await changePasswordCubit.resetStateValue();
        },
        listenWhen:
            (ChangePasswordState previous, ChangePasswordState current) =>
            previous.status != current.status || (current.msg?.isNotEmpty ?? false),
        child: NoInternetWidget(
          onTryAgain: () {},
          childWidget: Scaffold(
          resizeToAvoidBottomInset: false,
          body: Form(
            key: changePasswordCubit.state.formKey,
            child: Column(
              children: <Widget>[
                ProductDetailsAppBar(
                  titleText: context.appString.changePasswordKey,
                  isLastWidgetDisplay: false,
                  titleColors: MainConfig.appColors.textBlackColor,
                  prefixIcon: Assets.svgs.icBack.svg(),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
                  child: Column(
                    children: <Widget>[
                      Dimens.size16.heightBox,
                      CurrentPasswordWidget(
                        device: device,
                      ),
                      Dimens.size16.heightBox,
                      NewPasswordWidget(
                        device: device,
                      ),
                      Dimens.size16.heightBox,
                      ConfirmChangePasswordWidget(
                        device: device,
                      ),
                      heightMobTab35_50.heightBox,
                      CustomGradientButtonWidget(
                        device: device,
                        title: context.appString.updateKey,
                        onTap: () async {
                          if (_validateChangePassWordForm(context)) {
                            String newPassword = changePasswordCubit
                                .state.newPassController.text
                                .trim();
                            String conPassword = changePasswordCubit
                                .state.cnfPassController.text
                                .trim();

                            if (newPassword != conPassword) {
                              changePasswordCubit
                                  .handleValidationErrorMessageConPassword(
                                      context.appString
                                          .enteredPasswordDoesNotMatchKey);
                              return;
                            }
                            await changePasswordCubit.submitChangePassword();
                          }
                          // context.read<ChangePasswordCubit>().validateInput();
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        )
    )
    );
  }

  /// Validates the change password form.
  /// 
  /// Checks for empty fields, password criteria, and matching confirm password.
  /// Returns true if all validations pass, false otherwise.
  bool _validateChangePassWordForm(BuildContext context) {
    final ChangePasswordCubit changePasswordCubit =
        context.read<ChangePasswordCubit>();
    final String oldRaw = changePasswordCubit.state.oldPassController.text;
    final String newRaw = changePasswordCubit.state.newPassController.text;
    final String conRaw = changePasswordCubit.state.cnfPassController.text;

    final String oldPassword = oldRaw.trim();
    final String newPassword = newRaw.trim();
    final String conPassword = conRaw.trim();

    bool isValid = true;
    bool shouldValidateOld = true;
    bool shouldValidateNew = true;
    bool shouldValidateCon = true;

    // Check for empty fields
    if (oldPassword.isEmpty) {
      isValid = false;
      changePasswordCubit.handleValidationErrorMessageOldPass(
          context.appString.pleaseEnterTheCurrentPasswordKey);
      shouldValidateOld = false;
    }

    if (newPassword.isEmpty) {
      isValid = false;
      changePasswordCubit.handleValidationErrorMessageNewPass(
          context.appString.pleaseEnterNewPasswordKey);
      shouldValidateNew = false;
    }

    if (conPassword.isEmpty) {
      isValid = false;
      changePasswordCubit.handleValidationErrorMessageConPassword(
          context.appString.pleaseEnterYourConfirmPasswordKey);
      shouldValidateCon = false;
    }

    // Disallow leading or trailing spaces in any password fields
    if (oldRaw != oldPassword) {
      isValid = false;
      shouldValidateOld = false;
      changePasswordCubit
          .handleValidationErrorMessageOldPass(context.appString.passAllCriteriaKey);
    }
    if (newRaw != newPassword) {
      isValid = false;
      shouldValidateNew = false;
      changePasswordCubit
          .handleValidationErrorMessageNewPass(context.appString.passAllCriteriaKey);
    }
    if (conRaw != conPassword) {
      isValid = false;
      shouldValidateCon = false;
      changePasswordCubit
          .handleValidationErrorMessageConPassword(context.appString.passAllCriteriaKey);
    }

    // Validate the old password
    if (shouldValidateOld) {
      final String? passwordError = oldPassword.validatePassword(
          isNewPassword: true,
          customError: context.appString.pleaseEnterTheCurrentPasswordKey,
          emptyPasswordMsg: context.appString.pleaseEnterThePasswordKey,
          invalidPasswordMsg: context.appString.passAllCriteriaKey);
      if (passwordError?.isNotEmpty ?? false) {
        isValid = false;
        changePasswordCubit
            .handleValidationErrorMessageOldPass(passwordError ?? "");
      } else {
        changePasswordCubit.handleValidationErrorMessageOldPass("");
      }
    }

    if (shouldValidateNew) {
      final String? newPasswordError = newPassword.validatePassword(
          isNewPassword: true,
          customError: context.appString.pleaseEnterNewPasswordKey,
          emptyPasswordMsg: context.appString.pleaseEnterThePasswordKey,
          invalidPasswordMsg: context.appString.passAllCriteriaKey);
      if (newPasswordError?.isNotEmpty ?? false) {
        isValid = false;
        changePasswordCubit
            .handleValidationErrorMessageNewPass(newPasswordError ?? "");
      } else {
        changePasswordCubit.handleValidationErrorMessageNewPass("");
      }
    }

    // Validate the old password

    // Validate the new password

    // Validate the confirm password
    if (shouldValidateCon) {
      final String? conPasswordError = conPassword.validatePassword(
          isNewPassword: true,
          customError: context.appString.pleaseEnterYourConfirmPasswordKey,
          emptyPasswordMsg: context.appString.pleaseEnterThePasswordKey,
          invalidPasswordMsg: context.appString.passAllCriteriaKey);
      if (conPasswordError?.isNotEmpty ?? false) {
        isValid = false;
        changePasswordCubit
            .handleValidationErrorMessageConPassword(conPasswordError ?? "");
      } else {
        changePasswordCubit.handleValidationErrorMessageConPassword("");
      }
    }

    return isValid;
  }
}
