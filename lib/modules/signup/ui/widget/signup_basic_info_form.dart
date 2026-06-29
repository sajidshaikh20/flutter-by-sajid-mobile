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
