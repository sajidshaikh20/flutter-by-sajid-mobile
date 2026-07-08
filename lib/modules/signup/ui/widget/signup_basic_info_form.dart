import '../../../../utils/exports.dart';

/// Sign up step 1 form — full name and email address.
class SignUpBasicInfoForm extends StatelessWidget {
  /// Creates [SignUpBasicInfoForm].
  const SignUpBasicInfoForm({super.key});

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
            title: context.appString.signUpCreateClientAccountKey,
            subtitle: context.appString.signUpBasicInfoDetailsKey,
          ),
          Dimens.size20.heightBox,
          BlocBuilder<SignUpCubit, SignUpState>(
            buildWhen: (SignUpState p, SignUpState c) => p.accountType != c.accountType,
            builder: (BuildContext context, SignUpState state) {
              final bool isClient = state.accountType == UserRole.client;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      // Client Account (First Option)
                      Expanded(
                        child: GestureDetector(
                          onTap: () => cubit.setAccountType(UserRole.client),
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: Dimens.size16),
                            decoration: BoxDecoration(
                              color: isClient
                                  ? AppColors.primaryPurple.withValues(alpha: 0.1)
                                  : (isDark ? AppColors.surfaceDark : AppColors.whiteColor),
                              border: Border.all(
                                color: isClient
                                    ? AppColors.primaryPurple
                                    : (isDark ? AppColors.borderDark : AppColors.borderLight),
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(Dimens.radius12),
                            ),
                            child: Column(
                              children: <Widget>[
                                Icon(
                                  Icons.person_outline,
                                  color: isClient ? AppColors.primaryPurple : Colors.grey,
                                ),
                                Dimens.size8.heightBox,
                                CustomTextLabelWidget(
                                  label: 'Client Account',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: isClient
                                        ? AppColors.primaryPurple
                                        : (isDark ? Colors.white : Colors.black),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Dimens.size16.widthBox,
                      // Trader Account (Second Option)
                      Expanded(
                        child: GestureDetector(
                          onTap: () => cubit.setAccountType(UserRole.trader),
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: Dimens.size16),
                            decoration: BoxDecoration(
                              color: !isClient
                                  ? AppColors.primaryPurple.withValues(alpha: 0.1)
                                  : (isDark ? AppColors.surfaceDark : AppColors.whiteColor),
                              border: Border.all(
                                color: !isClient
                                    ? AppColors.primaryPurple
                                    : (isDark ? AppColors.borderDark : AppColors.borderLight),
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(Dimens.radius12),
                            ),
                            child: Column(
                              children: <Widget>[
                                Icon(
                                  Icons.trending_up,
                                  color: !isClient ? AppColors.primaryPurple : Colors.grey,
                                ),
                                Dimens.size8.heightBox,
                                CustomTextLabelWidget(
                                  label: 'Trader Account',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: !isClient
                                        ? AppColors.primaryPurple
                                        : (isDark ? Colors.white : Colors.black),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Dimens.size16.heightBox,
                  Container(
                    padding: const EdgeInsets.all(Dimens.size12),
                    decoration: BoxDecoration(
                      color: isDark ? AppColors.surfaceDark : Colors.grey.shade50,
                      border: Border.all(
                        color: isDark ? AppColors.borderDark : AppColors.borderLight,
                      ),
                      borderRadius: BorderRadius.circular(Dimens.radius12),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        const Icon(
                          Icons.info_outline,
                          color: AppColors.primaryPurple,
                          size: Dimens.size20,
                        ),
                        Dimens.size12.widthBox,
                        Expanded(
                          child: CustomTextLabelWidget(
                            textAlign: TextAlign.start,
                            label: isClient
                                ? 'Client Account: 3 quick steps to set up. Standard copy trading access without background documents or verification tests.'
                                : 'Trader Account: 4 detailed steps including historical trade setup and document upload. Verify your strategy to become an active signal provider.',
                            style: context.textTheme.bodySmall?.copyWith(
                              color: isDark ? Colors.grey.shade400 : Colors.grey.shade700,
                              fontSize: Dimens.fontSize12,
                              height: 1.4,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
          Dimens.size24.heightBox,
          BlocBuilder<SignUpCubit, SignUpState>(
            buildWhen: (SignUpState p, SignUpState c) =>
                p.fullNameErrorMessage != c.fullNameErrorMessage,
            builder: (BuildContext context, SignUpState state) {
              return CommonTextFormFieldWidget(
                controller: state.fullNameController,
                label: context.appString.signUpFullNameKey,
                hint: context.appString.signUpEnterFullNameKey,
                input: TextInputAction.next,
                focusNode: state.fullNameFocusNode,
                errorMsg: state.fullNameErrorMessage,
                textCapitalization: TextCapitalization.words,
                maxLength: Dimens.maxLength50,
                onChange: (String value) {
                  if (value.trim().length >= 2) {
                    cubit.setFullNameError('');
                  }
                },
                onTextSubmit: (_) {
                  cubit.moveToNextField(state.emailFocusNode);
                },
              );
            },
          ),
          Dimens.size16.heightBox,
          BlocBuilder<SignUpCubit, SignUpState>(
            buildWhen: (SignUpState p, SignUpState c) =>
                p.emailErrorMessage != c.emailErrorMessage,
            builder: (BuildContext context, SignUpState state) {
              return CommonTextFormFieldWidget(
                controller: state.emailController,
                label: context.appString.signUpEmailAddressKey,
                hint: context.appString.signUpEnterEmailAddressKey,
                input: TextInputAction.done,
                focusNode: state.emailFocusNode,
                errorMsg: state.emailErrorMessage,
                textInputType: TextInputType.emailAddress,
                textCapitalization: TextCapitalization.none,
                maxLength: Dimens.maxLength50,
                onChange: (String value) {
                  if (value.validateEmailBool() ?? true) {
                    cubit.setEmailError('');
                  }
                },
              );
            },
          ),
          Dimens.size32.heightBox,
          Align(
            child: GestureDetector(
              onTap: () async {
                await context.router.push(LoginRoute());
              },
              child: CustomTextLabelWidget(
                label: context.appString.alreadyHaveAccountKey,
                style: context.textTheme.titleLarge?.copyWith(
                  height: Dimens.lineHeight20.toLineHeight(
                    Dimens.fontSize14,
                  ),
                  fontWeight: FontWeight.w600,
                  fontSize: Dimens.fontSize14,
                  color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight,
                ),
              ),
            ),
          ),
          Dimens.size24.heightBox,
        ],
      ),
    );
  }
}
