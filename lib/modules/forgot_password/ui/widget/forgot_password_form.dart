import '../../../../utils/exports.dart';

/// Forgot password form UI.
class ForgotPasswordForm extends StatelessWidget {
  /// Creates [ForgotPasswordForm].
  const ForgotPasswordForm({super.key});

  @override
  Widget build(BuildContext context) {
    return _buildForm(context);
  }

  BlocListener<ForgotPasswordCubit, ForgotPasswordState> _buildForm(
    BuildContext context,
  ) {
    final ForgotPasswordCubit cubit = context.instance<ForgotPasswordCubit>();
    final bool isDark = context.isDark;
    final Color backgroundColor = isDark
        ? AppColors.backgroundDark
        : AppColors.backgroundLight;
    final Color dotColor = isDark
        ? AppColors.primaryPurple.withValues(alpha: 0.15)
        : AppColors.primaryPurple.withValues(alpha: 0.12);
    final Color titleColor = isDark
        ? AppColors.textPrimaryDark
        : AppColors.textPrimaryLight;
    final Color subtitleColor = isDark
        ? AppColors.textSecondaryDark
        : AppColors.textSecondaryLight;
    final bool isRTL = Directionality.of(context) == TextDirection.rtl;

    return BlocListener<ForgotPasswordCubit, ForgotPasswordState>(
      listenWhen: (ForgotPasswordState previous, ForgotPasswordState current) {
        return previous.msg != current.msg || previous.status != current.status;
      },
      listener: (BuildContext context, ForgotPasswordState state) {
        if (state.status == BaseStateStatus.success) {
          displaySnackBar(
            (state.msg?.isNotEmpty ?? false)
                ? state.msg!
                : context.appString.resetLinkSentSuccessKey,
            context,
          );
          goBack(context);
          return;
        }

        if (state.status == BaseStateStatus.failure) {
          displaySnackBar(
            (state.msg?.isNotEmpty ?? false)
                ? state.msg!
                : context.appString.forgotPasswordFailedKey,
            context,
          );
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
                key: cubit.state.formKey,
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
                                color: isDark
                                    ? AppColors.textPrimaryDark
                                    : AppColors.textPrimaryLight,
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
                                label: context.appString.resetPasswordTitleKey,
                                style: context.textTheme.titleLarge?.copyWith(
                                  height: Dimens.lineHeight28.toLineHeight(
                                    Dimens.fontSize24,
                                  ),
                                  fontWeight: FontWeight.w800,
                                  fontSize: Dimens.fontSize24,
                                  color: titleColor,
                                ),
                              ),
                              Dimens.size8.heightBox,
                              CustomTextLabelWidget(
                                label: context
                                    .appString
                                    .enterEmailToReceiveResetLinkKey,
                                style: context.textTheme.bodyMedium?.copyWith(
                                  color: subtitleColor,
                                  fontSize: Dimens.fontSize14,
                                  height: Dimens.lineHeight20.toLineHeight(
                                    Dimens.fontSize14,
                                  ),
                                ),
                              ),
                              Dimens.size100.heightBox,

                              BlocBuilder<
                                ForgotPasswordCubit,
                                ForgotPasswordState
                              >(
                                buildWhen:
                                    (
                                      ForgotPasswordState previous,
                                      ForgotPasswordState current,
                                    ) {
                                      return previous.emailErrorMessage !=
                                          current.emailErrorMessage;
                                    },
                                builder:
                                    (
                                      BuildContext context,
                                      ForgotPasswordState state,
                                    ) {
                                      return CommonTextFormFieldWidget(
                                        controller: state.emailController,
                                        label:
                                            context.appString.enterYourEmailKey,
                                        input: TextInputAction.done,
                                        focusNode: state.emailFocusNode,
                                        errorMsg: state.emailErrorMessage,
                                        textInputType:
                                            TextInputType.emailAddress,
                                        textCapitalization:
                                            TextCapitalization.none,
                                        onChange: (String value) {
                                          if (value.validateEmailBool() ??
                                              true) {
                                            cubit
                                                .handleValidationErrorMessageForEmail(
                                                  '',
                                                );
                                          }
                                        },
                                        maxLength: Dimens.maxLength50,
                                      );
                                    },
                              ),
                              Dimens.size24.heightBox,
                              BlocBuilder<
                                ForgotPasswordCubit,
                                ForgotPasswordState
                              >(
                                buildWhen:
                                    (
                                      ForgotPasswordState previous,
                                      ForgotPasswordState current,
                                    ) {
                                      return previous.status != current.status;
                                    },
                                builder: (BuildContext context, ForgotPasswordState state) {
                                  return CustomButtonWidget(
                                    title: context.appString.sendResetLinkKey,
                                    height: Dimens.size52,
                                    borderRadius: Dimens.radius12,
                                    isButtonEnabled:
                                        state.status != BaseStateStatus.loading,
                                    titleTextStyle: context.textTheme.bodyLarge
                                        ?.copyWith(
                                          fontWeight: FontWeight.w600,
                                          fontSize: Dimens.fontSize15,
                                          color: Colors.white,
                                        ),
                                    onTap: () async {
                                      final String email = cubit
                                          .state
                                          .emailController
                                          .text
                                          .trim();

                                      if (email.isEmpty) {
                                        cubit.handleValidationErrorMessageForEmail(
                                          '${context.appString.pleaseEnterTheEmailKey}.',
                                        );
                                        return;
                                      }

                                      final String? emailError = email
                                          .validateEmail(
                                            isOnlyEmail: true,
                                            enterMobileOrNumberMsg: context
                                                .appString
                                                .pleaseEnterTheEmailKey,
                                            enterEmailMsg: context
                                                .appString
                                                .pleaseEnterTheEmailKey,
                                            validEmailMsg: context
                                                .appString
                                                .pleaseEnterValidEmailKey,
                                          );

                                      if (emailError?.isNotEmpty ?? false) {
                                        cubit
                                            .handleValidationErrorMessageForEmail(
                                              emailError ?? '',
                                            );
                                        return;
                                      }
                                      cubit
                                          .handleValidationErrorMessageForEmail(
                                            '',
                                          );
                                      await cubit.sendResetLink(email: email);
                                    },
                                  );
                                },
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
