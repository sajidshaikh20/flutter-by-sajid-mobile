import '../../../../utils/exports.dart';

/// `ForgotPasswordForm` is a stateless widget that displays a form for users to
/// request a password reset.
class ForgotPasswordForm extends StatelessWidget {
  /// Constructor for the `ForgotPasswordForm` widget.
  const ForgotPasswordForm({super.key, this.device = ScreenType.mobile});

  /// The device type to adjust the form's layout.
  ///
  /// Defaults to [ScreenType.mobile].
  final ScreenType device;

  @override
  Widget build(BuildContext context) {
    return _forgotPasswordForm(context);
  }

  BlocListener<ForgotPasswordCubit, ForgotPasswordState> _forgotPasswordForm(
      BuildContext context) {
    final ForgotPasswordCubit forgotPassCubit =
        context.instance<ForgotPasswordCubit>();
    double horizontalPadding = Dimens.space16;

    switch (device) {
      case ScreenType.tablet:
        horizontalPadding = Dimens.space90;

      default:
        break;
    }

    return BlocListener<ForgotPasswordCubit, ForgotPasswordState>(
      // Listen only when relevant state changes occur
      listenWhen: (ForgotPasswordState previous, ForgotPasswordState current) {
        return previous.successMsg != current.successMsg ||
            previous.msg != current.msg ||
            previous.shouldGoBack != current.shouldGoBack ||
            previous.redirectRoute != current.redirectRoute;
      },
      listener: (BuildContext context, ForgotPasswordState state) async {
        if (state.successMsg.isNotEmpty) {
          displaySnackBar(state.successMsg, context);
          forgotPassCubit.resetSuccessMsg();
        } else if (state.msg != null && (state.msg?.isNotEmpty ?? false)) {
          // Show Error Msg.
          displaySnackBar(state.msg ?? '', context);
        }
        if (state.shouldGoBack) {
          goBack(context);
          forgotPassCubit.resetSuccessMsg();
        }
        if (state.redirectRoute != null) {
          // Navigate to the redirect route (for mobile OTP verification)
          if (context.mounted) {
            await context.router.push(state.redirectRoute!);
          }
        }
      },
      child: NoInternetWidget(
          childWidget: Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: CustomAppBar(
            title: context.appString.forgotPasswordTitleKey,
            isLogoVisible: false,
            device: device,
            onTap: () {
              context.router.removeLast();
            }),
        body: Stack(
          children: <Widget>[
            // Background SVG
            Positioned.fill(
              child: Assets.svgs.bgFullscreenCommon.svg(
                fit: BoxFit.fill,),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
              child: Form(
                key: forgotPassCubit.state.formKey,
                child: Column(
                  children: <Widget>[
                    Dimens.size15.heightBox,
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: Dimens.space26),
                      child: CustomTextLabelWidget(
                        label: context.appString.detailForgotPasswordKey,
                        style: context.textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.w500,
                            height: Dimens.lineHeight18
                                .toLineHeight(Dimens.fontSize14),
                            fontSize: Dimens.fontSize14),
                      ),
                    ),
                    Dimens.size33.heightBox,
                    BlocBuilder<ForgotPasswordCubit, ForgotPasswordState>(
                      buildWhen: (ForgotPasswordState previous,
                          ForgotPasswordState current) {
                        // Only rebuild when selected segment index changes
                        return previous.selectedSegmentIndex !=
                            current.selectedSegmentIndex;
                      },
                      builder:
                          (BuildContext context, ForgotPasswordState state) {
                        return SegmentedControl(
                          firstTitle: context.appString.mobileKey,
                          secondTitle: context.appString.emailKey,
                          selectedIndex: state.selectedSegmentIndex ?? 0,
                          onIndexChanged: (int value) {
                            context
                                .read<ForgotPasswordCubit>()
                                .onSegmentChangedIndex(value);
                            forgotPassCubit
                                .handleValidationErrorMessageForEmailOrPhone(
                                    '');
                          },
                        );
                      },
                    ),
                    Dimens.size31.heightBox,
                    BlocBuilder<ForgotPasswordCubit, ForgotPasswordState>(
                      buildWhen: (ForgotPasswordState previous,
                          ForgotPasswordState current) {
                        // Only rebuild when segment index or email error message changes
                        return previous.selectedSegmentIndex !=
                                current.selectedSegmentIndex ||
                            previous.emailErrorMessage !=
                                current.emailErrorMessage;
                      },
                      builder:
                          (BuildContext context, ForgotPasswordState state) {
                        return CommonTextFormFieldWidget(
                          focusNode: state.forgotPasswordFocusNode,
                          maxLength: state.selectedSegmentIndex == 0
                              ? Dimens.maxLength8
                              : Dimens.maxLength50,
                          prefixIconConstraints: const BoxConstraints(
                            minWidth: Dimens.size24,
                            minHeight: Dimens.size24,
                            maxWidth: Dimens.size62,
                            maxHeight: Dimens.size50,
                          ),
                          prefixIcon: state.selectedSegmentIndex == 0
                              ? CustomTextLabelWidget(
                                  textDirection: TextDirection.ltr,
                                  label: context.appString.kuwaitCountryCodeKey,
                                  style: context.textTheme.bodyMedium?.copyWith(
                                      fontWeight: FontWeight.w600,
                                      height: Dimens.lineHeight24
                                          .toLineHeight(Dimens.fontSize16),
                                      fontSize: Dimens.fontSize16),
                                )
                              : null,
                          device: device,
                          errorMsg: state.emailErrorMessage,
                          textInputType: state.selectedSegmentIndex == 0
                              ? TextInputType.number
                              : TextInputType.text,
                          controller: forgotPassCubit
                              .state.resetPasswordFieldController,
                          onChange: (String value) {
                            if (value.isEmpty) {
                              forgotPassCubit
                                  .handleValidationErrorMessageForEmailOrPhone(
                                      '');
                            }
                            if (state.selectedSegmentIndex == 0) {
                              if (value.validMobileBool(isRequired: true) ==
                                  true) {
                                forgotPassCubit
                                    .handleValidationErrorMessageForEmailOrPhone(
                                        '');
                              }
                            }
                            if (state.selectedSegmentIndex == 1) {
                              if (value.validateEmailBool() ?? false) {
                                forgotPassCubit
                                    .handleValidationErrorMessageForEmailOrPhone(
                                        '');
                              }
                            }
                          },
                          label: state.selectedSegmentIndex == 0
                              ? context.appString.mobileNumberKey
                              : context.appString.emailIdKey,
                        );
                      },
                    ),
                    const Spacer(),
                    BlocBuilder<ForgotPasswordCubit, ForgotPasswordState>(
                      buildWhen: (ForgotPasswordState previous,
                          ForgotPasswordState current) {
                        // Only rebuild when segment index changes (affects button text)
                        return previous.selectedSegmentIndex !=
                            current.selectedSegmentIndex;
                      },
                      builder:
                          (BuildContext context, ForgotPasswordState state) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: Dimens.space25),
                          child: CustomGradientButtonWidget(
                            device: device,
                            title: state.selectedSegmentIndex == 0
                                ? context.appString.getOtpKey
                                : context.appString.sendKey,
                            onTap: () async {
                              final String resetPasswordText = forgotPassCubit
                                  .state.resetPasswordFieldController.text
                                  .trim();

                              if (state.selectedSegmentIndex == 0) {
                                // Phone number validation
                                if (resetPasswordText.isEmpty) {
                                  forgotPassCubit
                                      .handleValidationErrorMessageForEmailOrPhone(
                                          context.appString
                                              .pleaseEnterMobileNumberKey);
                                  return;
                                }

                                final String? mobileError =
                                    resetPasswordText.validMobileNo(
                                        emptyMobileMsg: context.appString
                                            .pleaseEnterMobileNumberKey,
                                        onlyNumbersAllowedMsg: context
                                            .appString.onlyNumbersAllowedKey,
                                        invalidMobileMsg: context.appString
                                            .enterValidMobileNumberKey);
                                if (mobileError?.isNotEmpty ?? false) {
                                  forgotPassCubit
                                      .handleValidationErrorMessageForEmailOrPhone(
                                          mobileError ?? "");
                                  return; // Stop further validation if mobile number is invalid
                                } else {
                                  forgotPassCubit
                                      .handleValidationErrorMessageForEmailOrPhone(
                                          ""); // Clear mobile error if valid
                                }

                                // Call forgot password with mobile API
                                await forgotPassCubit
                                    .callForgotPasswordWithMobileApi();
                              } else {
                                // Email validation
                                final String? emailError =
                                    resetPasswordText.validateEmail(
                                        isOnlyEmail: true,
                                        enterMobileOrNumberMsg: context
                                            .appString
                                            .pleaseEnterMobileOrNumberKey,
                                        enterEmailMsg: context
                                            .appString.pleaseEnterTheEmailKey,
                                        validEmailMsg: context.appString
                                            .pleaseEnterValidEmailKey);
                                if (emailError?.isNotEmpty ?? false) {
                                  forgotPassCubit
                                      .handleValidationErrorMessageForEmailOrPhone(
                                          emailError ?? "");
                                  return; // Stop further validation if email is invalid
                                } else {
                                  forgotPassCubit
                                      .handleValidationErrorMessageForEmailOrPhone(
                                          ""); // Clear email error if valid
                                }

                                // Call forgot password with email API
                                await forgotPassCubit
                                    .callForgotPasswordWithEmailApi();
                              }
                              // forgotPassCubit.callForgotPasswordApi();
                            },
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      )),
    );
  }
}
