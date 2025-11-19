import '../../../../utils/exports.dart';

/// A widget for the login form.
///
/// OPTIMIZATION NOTES:
/// - Uses BlocBuilder widgets only where necessary for reactive UI updates
/// - Each BlocBuilder includes buildWhen conditions to minimize unnecessary rebuilds
/// - Static elements (like buttons, spacing) remain outside BlocBuilder for performance
class LoginForm extends StatelessWidget {
  ///
  const LoginForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return _loginForm(context);
  }

  BlocListener<LoginCubit, LoginState> _loginForm(BuildContext context) {
    final LoginCubit loginCubit = context.instance<LoginCubit>();
    return BlocListener<LoginCubit, LoginState>(
      // Listen only when relevant state changes occur
      listenWhen: (LoginState previous, LoginState current) {
        return previous.redirectRoute != current.redirectRoute ||
            previous.msg != current.msg;
      },
      listener: (BuildContext context, LoginState state) async {
        if (state.msg != null && (state.msg?.isNotEmpty ?? false)) {
          displaySnackBar(state.msg ?? '', context);
        }
        if (state.redirectRoute != null) {
          await context.router
              .replaceAll(<PageRouteInfo>[state.redirectRoute!]);
        }
      },
      child: NoInternetWidget(
        onTryAgain: () {},
        childWidget: Scaffold(
          resizeToAvoidBottomInset: true,
          body: Form(
            key: loginCubit.state.formKey,
            child: Column(
              children: <Widget>[
                const TopViewOnboardingLogin(
                  isFromLogin: true,
                ),
                Expanded(
                  child: BottomViewOnboardingLogin(
                      childWidget: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: Dimens.size16),
                    child: SingleChildScrollView(
                      child: Column(
                        children: <Widget>[
                          Dimens.size50.heightBox,
                          CustomTextLabelWidget(
                            label: context.appString.loginKey,
                            style: context.textTheme.titleLarge?.copyWith(
                                height: Dimens.lineHeight28
                                    .toLineHeight(Dimens.fontSize24),
                                fontSize: Dimens.fontSize24),
                          ),
                          Dimens.size40.heightBox,

                          BlocBuilder<LoginCubit, LoginState>(
                            buildWhen:
                                (LoginState previous, LoginState current) {
                              // Only rebuild when email-related state changes
                              return previous.emailErrorMessage !=
                                      current.emailErrorMessage ||
                                  previous.isNumberConsidered !=
                                      current.isNumberConsidered;
                            },
                            builder: (BuildContext context, LoginState state) {
                              return CommonTextFormFieldWidget(
                                controller: state.emailController,
                                label: context.appString.labelMobileOrMailKey,
                                input: TextInputAction.next,
                                focusNode: state.emailFocusNode,
                                errorMsg: state.emailErrorMessage,
                                prefixIconConstraints:
                                    (state.isNumberConsidered ?? false)
                                        ? const BoxConstraints(
                                            minWidth: Dimens.size24,
                                            minHeight: Dimens.size24,
                                            maxWidth: Dimens.size62,
                                            maxHeight: Dimens.size50,
                                          )
                                        : null,
                                prefixIcon: (state.isNumberConsidered ?? false)
                                    ? CustomTextLabelWidget(
                                        textDirection: TextDirection.ltr,
                                        label: context
                                            .appString.kuwaitCountryCodeKey,
                                        style: context.textTheme.bodyMedium
                                            ?.copyWith(
                                                fontWeight: FontWeight.w600,
                                                height: Dimens.lineHeight24
                                                    .toLineHeight(
                                                        Dimens.fontSize16),
                                                fontSize: Dimens.fontSize16),
                                      )
                                    : null,
                                onChange: (String value) {
                                  if (value.startsWithNumber()) {
                                    context
                                        .read<LoginCubit>()
                                        .updateNumberConsideration(
                                            isNumber: true);
                                  }
                                  if (value.containsChar()) {
                                    context
                                        .read<LoginCubit>()
                                        .updateNumberConsideration(
                                            isNumber: false);
                                  }

                                  if (value.isEmpty) {
                                    loginCubit
                                      ..handleValidationErrorMessageForEmail('')
                                      ..updateNumberConsideration(
                                          isNumber: false);
                                  }
                                  if (value.validateEmailBool() ?? true) {
                                    loginCubit
                                        .handleValidationErrorMessageForEmail(
                                            '');
                                  }
                                  if (value.validMobileBool() == true) {
                                    loginCubit
                                        .handleValidationErrorMessageForEmail(
                                            '');
                                  }
                                },
                                maxLength: (state.isNumberConsidered ?? false)
                                    ? Dimens.maxLength8
                                    : Dimens.maxLength50,
                                onTextSubmit: (_) {
                                  loginCubit
                                      .moveToNextField(state.passwordFocusNode);
                                },
                                textCapitalization: TextCapitalization.none,
                              );
                            },
                          ),
                          Dimens.size16.heightBox,
                          // BlocBuilder for Password input field
                          // REQUIRED: Rebuilds when password visibility or error message changes
                          // to update show/hide toggle and validation feedback
                          BlocBuilder<LoginCubit, LoginState>(
                            buildWhen:
                                (LoginState previous, LoginState current) {
                              // Only rebuild when password-related state changes
                              return previous.passwordObscureText !=
                                      current.passwordObscureText ||
                                  previous.passwordErrorMessage !=
                                      current.passwordErrorMessage;
                            },
                            builder: (BuildContext context, LoginState state) {
                              return CommonTextFormFieldWidget(
                                controller: loginCubit.state.passwordController,
                                label: context.appString.passwordKey,
                                input: TextInputAction.done,
                                focusNode: state.passwordFocusNode,
                                errorMsg: state.passwordErrorMessage,
                                maxLength: Dimens.maxLength15,
                                obscureText:
                                    loginCubit.state.passwordObscureText,
                                onChange: (String value) {
                                  if (value.validatePasswordBool() ?? false) {
                                    // If password is valid, clear the error message
                                    loginCubit
                                        .handleValidationErrorMessageForPassword(
                                            '');
                                  }
                                },
                                suffixIcon: CustomTextLabelWidget(
                                  label: state.passwordObscureText
                                      ? context.appString.showKey
                                      : context.appString.hideKey,
                                  textAlign: TextAlign.start,
                                  style: context.textTheme.bodySmall?.copyWith(
                                      fontWeight: FontWeight.w400,
                                      height: Dimens.lineHeight16
                                          .toLineHeight(Dimens.fontSize12),
                                      color: MainConfig
                                          .appColors.textLightBlackColor,
                                      fontSize: Dimens.fontSize12),
                                  onTap: () {
                                    loginCubit.toggleCurrentPassObscureText();
                                  },
                                ),
                              );
                            },
                          ),
                          Dimens.size15.heightBox,
                          const OtherAuthView(),
                          Dimens.size16.heightBox,
                          CustomGradientButtonWidget(
                              title: context.appString.loginKey,
                              onTap: () async {
                                final String email = loginCubit
                                    .state.emailController.text
                                    .trim();
                                final String password = loginCubit
                                    .state.passwordController.text
                                    .trim();
                                bool isValid =
                                    true; //Flag for overall validation result

                                // Empty check
                                if (email.isEmpty || password.isEmpty) {
                                  if (email.isEmpty) {
                                    loginCubit.handleValidationErrorMessageForEmail(
                                        "${context.appString.pleaseEnterMobileOrNumberKey}.");
                                    isValid = false;
                                  }
                                  if (password.isEmpty) {
                                    loginCubit
                                        .handleValidationErrorMessageForPassword(
                                            "${context.appString.pleaseEnterThePasswordKey}.");
                                    isValid = false;
                                  }
                                }

                                // Validate Mobile Number
                                if (email.isNotEmpty) {
                                  if (loginCubit.state.isNumberConsidered ??
                                      false) {
                                    final String? mobileError = email
                                        .validMobileNo(
                                            emptyMobileMsg:
                                                "Please Enter Valid Mobie",
                                            onlyNumbersAllowedMsg: context
                                                .appString
                                                .onlyNumbersAllowedKey,
                                            invalidMobileMsg:
                                                "Please Enter Valid Mobile");
                                    if (mobileError?.isNotEmpty ?? false) {
                                      loginCubit
                                          .handleValidationErrorMessageForEmail(
                                              mobileError ?? "");
                                      isValid = false;
                                    } else {
                                      loginCubit
                                          .handleValidationErrorMessageForEmail(
                                              ""); // Clear mobile error if valid
                                    }
                                  }
                                }

                                // Validate Email
                                if (email.isNotEmpty &&
                                    (email.startsWithLetter() ||
                                        loginCubit.state.isNumberConsidered ==
                                            false)) {
                                  final String? emailError =
                                      email.validateEmail(
                                          isOnlyEmail: true,
                                          enterMobileOrNumberMsg: context
                                              .appString
                                              .pleaseEnterMobileOrNumberKey,
                                          enterEmailMsg: context
                                              .appString.pleaseEnterTheEmailKey,
                                          validEmailMsg:
                                              "Please Enter Valid Email");
                                  if (emailError?.isNotEmpty ?? false) {
                                    loginCubit
                                        .handleValidationErrorMessageForEmail(
                                            emailError ?? "");
                                    isValid = false;
                                  } else {
                                    loginCubit
                                        .handleValidationErrorMessageForEmail(
                                            ""); // Clear email error if valid
                                  }
                                }

                                // Validate Password
                                if (password.isNotEmpty) {
                                  final String? passwordError =
                                      password.validatePassword(
                                          isNewPassword: true,
                                          customError: context.appString
                                              .pleaseEnterThePasswordKey,
                                          emptyPasswordMsg: context.appString
                                              .pleaseEnterThePasswordKey,
                                          invalidPasswordMsg: context
                                              .appString.passAllCriteriaKey);
                                  if (passwordError?.isNotEmpty ?? false) {
                                    loginCubit
                                        .handleValidationErrorMessageForPassword(
                                            passwordError ?? "");
                                    isValid = false;
                                  } else {
                                    loginCubit
                                        .handleValidationErrorMessageForPassword(
                                            ""); // Clear password error if valid
                                  }
                                }

                                if (isValid) {
                                  // Call login API
                                  await loginCubit.login(
                                    emailMobile: email,
                                    password: password,
                                  );
                                }
                              }),
                          Dimens.size65.heightBox,
                          CustomTextLabelWidget(
                            onTap: () async {
                              // await context.router.replace(const DashboardRoute());
                            },
                            label: context.appString.continueGuestKey,
                            style: context.textTheme.titleLarge?.copyWith(
                                height: Dimens.lineHeight20
                                    .toLineHeight(Dimens.fontSize20),
                                fontWeight: FontWeight.w600,
                                fontSize: Dimens.fontSize14),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                bottom: Dimens.space50, top: Dimens.size82),
                            child: CustomTextLabelWidget(
                              label: context.appString.dontHaveAccountKey,
                              style: context.textTheme.titleLarge?.copyWith(
                                  height: Dimens.lineHeight20
                                      .toLineHeight(Dimens.fontSize14),
                                  fontWeight: FontWeight.w600,
                                  fontSize: Dimens.fontSize14),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
