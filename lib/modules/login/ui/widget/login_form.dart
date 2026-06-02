import '../../../../utils/exports.dart';

/// A widget for the login form.
///
/// OPTIMIZATION NOTES:
/// - Uses BlocBuilder widgets only where necessary for reactive UI updates
/// - Each BlocBuilder includes buildWhen conditions to minimize unnecessary rebuilds
/// - Static elements (like buttons, spacing) remain outside BlocBuilder for performance
class LoginForm extends StatelessWidget {
  ///
  const LoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    return _loginForm(context);
  }

  BlocListener<LoginCubit, LoginState> _loginForm(BuildContext context) {
    final LoginCubit loginCubit = context.instance<LoginCubit>();
    final bool isDark = context.isDark;
    final Color backgroundColor = isDark
        ? AppColors.backgroundDark
        : AppColors.backgroundLight;
    final Color dotColor = isDark
        ? AppColors.primaryPurple.withValues(alpha: 0.15)
        : AppColors.primaryPurple.withValues(alpha: 0.12);
    final bool isRTL = Directionality.of(context) == TextDirection.rtl;
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
          await context.router.replaceAll(<PageRouteInfo>[
            state.redirectRoute!,
          ]);
        }
      },
      child: NoInternetWidget(
        onTryAgain: () {},
        childWidget: Scaffold(
          backgroundColor: backgroundColor,
          resizeToAvoidBottomInset: true,
          body: Stack(
            fit: StackFit.expand,
            children: <Widget>[
              Positioned.fill(
                child: CustomPaint(painter: WaveDottedPainter(color: dotColor)),
              ),
              Form(
                key: loginCubit.state.formKey,
                child: Column(
                  children: <Widget>[
                    SafeArea(
                      bottom: false,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: Dimens.size16,
                          vertical: Dimens.size12,
                        ),
                        child: Align(
                          alignment: isRTL
                              ? Alignment.centerRight
                              : Alignment.centerLeft,
                          child: GestureDetector(
                            onTap: () => goBack(context),
                            child: RotatedIcon(
                              isLanguageAlignmentLTR: !isRTL,
                              iconWidget: Assets.svgs.icBack.svg(
                                color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    DecoratedBox(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        boxShadow: <BoxShadow>[
                          BoxShadow(
                            color: isDark
                                ? AppColors.primaryPurple.withValues(alpha: 0.2)
                                : AppColors.primaryPurple.withValues(
                                    alpha: 0.08,
                                  ),
                            blurRadius: 30,
                            spreadRadius: 5,
                          ),
                        ],
                      ),
                      child: Assets.png.icCropWekoIcon.image(
                        height: Dimens.size100,
                        width: Dimens.size100,
                        fit: BoxFit.contain,
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: Dimens.size16,
                        ),
                        child: SingleChildScrollView(
                          child: Column(
                            children: <Widget>[
                              Dimens.size20.heightBox,
                              CustomTextLabelWidget(
                                label: context.appString.memberLoginKey,
                                style: context.textTheme.titleLarge?.copyWith(
                                  height: Dimens.lineHeight28.toLineHeight(
                                    Dimens.fontSize24,
                                  ),
                                  fontWeight: FontWeight.w800,
                                  fontSize: Dimens.fontSize24,
                                  color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight,
                                ),
                              ),
                              Dimens.size8.heightBox,
                              CustomTextLabelWidget(
                                label: context.appString.continueJourneySecurelyKey,
                                style: context.textTheme.bodyMedium?.copyWith(
                                  color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight,
                                  fontSize: Dimens.fontSize14,
                                ),
                              ),
                              Dimens.size100.heightBox,

                              BlocBuilder<LoginCubit, LoginState>(
                                buildWhen:
                                    (LoginState previous, LoginState current) {
                                      return previous.emailErrorMessage !=
                                              current.emailErrorMessage;
                                    },
                                builder: (BuildContext context, LoginState state) {
                                  return CommonTextFormFieldWidget(
                                    controller: state.emailController,
                                    label:
                                        context.appString.emailOrUsernameKey,
                                    input: TextInputAction.next,
                                    focusNode: state.emailFocusNode,
                                    errorMsg: state.emailErrorMessage,
                                    onChange: (String value) {
                                      if (value.isEmpty) {
                                        loginCubit.handleValidationErrorMessageForEmail(
                                          '',
                                        );
                                      } else {
                                        if (value.contains('@')) {
                                          if (value.validateEmailBool() ?? true) {
                                            loginCubit.handleValidationErrorMessageForEmail(
                                              '',
                                            );
                                          }
                                        } else {
                                          if (value.trim().length >= 3 && !value.contains(' ')) {
                                            loginCubit.handleValidationErrorMessageForEmail(
                                              '',
                                            );
                                          }
                                        }
                                      }
                                    },
                                    maxLength: Dimens.maxLength50,
                                    onTextSubmit: (_) {
                                      loginCubit.moveToNextField(
                                        state.passwordFocusNode,
                                      );
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
                                    controller:
                                        loginCubit.state.passwordController,
                                    label: context.appString.passwordKey,
                                    input: TextInputAction.done,
                                    focusNode: state.passwordFocusNode,
                                    errorMsg: state.passwordErrorMessage,
                                    maxLength: Dimens.maxLength15,
                                    obscureText:
                                        loginCubit.state.passwordObscureText,
                                    onChange: (String value) {
                                      if (value.validatePasswordBool() ??
                                          false) {
                                        loginCubit
                                            .handleValidationErrorMessageForPassword(
                                              '',
                                            );
                                      } else {
                                        loginCubit
                                            .handleValidationErrorMessageForPassword(
                                              context
                                                  .appString
                                                  .passAllCriteriaKey,
                                            );
                                      }
                                    },
                                    suffixIcon: CustomTextLabelWidget(
                                      label: state.passwordObscureText
                                          ? context.appString.showKey
                                          : context.appString.hideKey,
                                      textAlign: TextAlign.start,
                                      style: context.textTheme.bodySmall
                                          ?.copyWith(
                                            fontWeight: FontWeight.w400,
                                            height: Dimens.lineHeight16
                                                .toLineHeight(
                                                  Dimens.fontSize12,
                                                ),
                                            color: isDark
                                                ? AppColors.textSecondaryDark
                                                : AppColors.textSecondaryLight,
                                            fontSize: Dimens.fontSize12,
                                          ),
                                      onTap: () {
                                        loginCubit
                                            .toggleCurrentPassObscureText();
                                      },
                                    ),
                                  );
                                },
                              ),
                              Dimens.size15.heightBox,
                              const OtherAuthView(),
                              Dimens.size40.heightBox,
                              CustomButtonWidget(
                                title: context.appString.loginKey,
                                height: Dimens.size52,
                                borderRadius: Dimens.radius12,
                                titleTextStyle: context.textTheme.bodyLarge
                                    ?.copyWith(
                                      fontWeight: FontWeight.w600,
                                      fontSize: Dimens.fontSize12,
                                      color: Colors.white,
                                    ),
                                onTap: () async {
                                  final String email = loginCubit
                                      .state
                                      .emailController
                                      .text
                                      .trim();
                                  final String password = loginCubit
                                      .state
                                      .passwordController
                                      .text
                                      .trim();
                                  bool isValid =
                                      true; //Flag for overall validation result
 
                                  // Empty check
                                  if (email.isEmpty || password.isEmpty) {
                                    if (email.isEmpty) {
                                      loginCubit
                                          .handleValidationErrorMessageForEmail(
                                            context.appString.pleaseEnterEmailOrUsernameKey,
                                          );
                                      isValid = false;
                                    }
                                    if (password.isEmpty) {
                                      loginCubit
                                          .handleValidationErrorMessageForPassword(
                                            "${context.appString.pleaseEnterThePasswordKey}.",
                                          );
                                      isValid = false;
                                    }
                                  }
 
                                  // Validate Email or Username
                                  if (email.isNotEmpty) {
                                    if (email.contains('@')) {
                                      final String? emailError = email
                                          .validateEmail(
                                            isOnlyEmail: true,
                                            enterMobileOrNumberMsg: context
                                                .appString
                                                .pleaseEnterEmailOrUsernameKey,
                                            enterEmailMsg: context
                                                .appString
                                                .pleaseEnterEmailOrUsernameKey,
                                            validEmailMsg: context
                                                .appString
                                                .pleaseEnterValidEmailKey,
                                          );
                                      if (emailError?.isNotEmpty ?? false) {
                                        loginCubit
                                            .handleValidationErrorMessageForEmail(
                                              emailError ?? "",
                                            );
                                        isValid = false;
                                      } else {
                                        loginCubit
                                            .handleValidationErrorMessageForEmail(
                                              "",
                                            );
                                      }
                                    } else {
                                      if (email.length < 3) {
                                        loginCubit
                                            .handleValidationErrorMessageForEmail(
                                              "Username must be at least 3 characters",
                                            );
                                        isValid = false;
                                      } else if (email.contains(' ')) {
                                        loginCubit
                                            .handleValidationErrorMessageForEmail(
                                              "Username cannot contain spaces",
                                            );
                                        isValid = false;
                                      } else {
                                        loginCubit
                                            .handleValidationErrorMessageForEmail(
                                              "",
                                            );
                                      }
                                    }
                                  }
 
                                  // Validate Password
                                  if (password.isNotEmpty) {
                                    final String? passwordError = password
                                        .validatePassword(
                                          isNewPassword: true,
                                          customError: context
                                              .appString
                                              .pleaseEnterThePasswordKey,
                                          emptyPasswordMsg: context
                                              .appString
                                              .pleaseEnterThePasswordKey,
                                          invalidPasswordMsg: context
                                              .appString
                                              .passAllCriteriaKey,
                                        );
                                    if (passwordError?.isNotEmpty ?? false) {
                                      loginCubit
                                          .handleValidationErrorMessageForPassword(
                                            passwordError ?? "",
                                          );
                                      isValid = false;
                                    } else {
                                      loginCubit
                                          .handleValidationErrorMessageForPassword(
                                            "",
                                          ); // Clear password error if valid
                                    }
                                  }
 
                                  if (isValid) {
                                    // Call login API
                                    await loginCubit.login(
                                      emailMobile: email,
                                      password: password,
                                    );
                                  }
                                },
                              ),


                              Padding(
                                padding: const EdgeInsets.only(
                                  bottom: Dimens.space50,
                                  top: Dimens.size82,
                                ),
                                child: CustomTextLabelWidget(
                                  onTap: () async {
                                    displaySnackBar(
                                      'Sign Up is not implemented yet. Please use Google Sign In.',
                                      context,
                                    );
                                  },
                                  label: context.appString.dontHaveAccountKey,
                                  style: context.textTheme.titleLarge?.copyWith(
                                    height: Dimens.lineHeight20.toLineHeight(
                                      Dimens.fontSize14,
                                    ),
                                    fontWeight: FontWeight.w600,
                                    fontSize: Dimens.fontSize14,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
