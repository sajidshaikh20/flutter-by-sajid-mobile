import '../../../../utils/exports.dart';

/// A widget that displays the UI for updating the user's email.
///
/// This widget can be used in profile screens or forms where
/// users need to update their email address.
class UpdateEmailWidget extends StatelessWidget {
  ///UpdateEmailWidget
  const UpdateEmailWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
      child: Padding(
        padding: EdgeInsets.only(
          left: Dimens.space16,
          right: Dimens.space34,
          bottom: MediaQuery.of(context)
              .viewInsets
              .bottom, // Adjust padding when keyboard appears
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          // Important to allow bottom sheet resizing
          children: <Widget>[
            Dimens.size10.heightBox,
            CustomTextLabelWidget(
              label: context.appString.pleaseEnterNewEmailIdKey,
              style: context.textTheme.displayMedium?.copyWith(
                  color: MainConfig.appColors.textBlackColor,
                  fontWeight: FontWeight.w400,
                  fontSize: Dimens.fontSize14,
                  height: Dimens.lineHeight18.toLineHeight(Dimens.fontSize14)),
            ),
            Dimens.size21.heightBox,
            BlocBuilder<EditProfileCubit, EditProfileState>(
              buildWhen: (EditProfileState previous, EditProfileState current) {
                // Only rebuild when update email error message changes
                return previous.updateEmailErrorMessage !=
                    current.updateEmailErrorMessage;
              },
              builder: (BuildContext context, EditProfileState state) {
                final EditProfileCubit editProfileCubit =
                    context.instance<EditProfileCubit>();
                return CommonTextFormFieldWidget(
                  textInputType: TextInputType.emailAddress,
                  controller: state.updateEmailController,
                  errorMsg: state.updateEmailErrorMessage,
                  focusNode: state.emailFocusNode,
                  label: context.appString.emailIdKey,
                  maxLength: Dimens.maxLength50,
                  onChange: (String value) {
                    if (value.validateEmailBool() ?? false) {
                      editProfileCubit
                          .handleValidationErrorMessageForUpdateEmail('');
                    }
                  },
                  input: TextInputAction.done,
                  onTextSubmit: (_) {},
                  textCapitalization: TextCapitalization.none,
                );
              },
            ),
            Dimens.size24.heightBox,
           CustomGradientButtonWidget(
                title: context.appString.updateKey,
                titleTextStyle: context.textTheme.headlineMedium?.copyWith(
                    fontSize: Dimens.fontSize16,
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    height:
                        Dimens.lineHeight24.toLineHeight(Dimens.fontSize16)),
                onTap: () async {
                  if (validateEditProfileForm(context)) {
                    debugPrint("Update successfully");
                    await context
                        .instance<EditProfileCubit>()
                        .callUpdateEmail();
                    if (context.mounted) {
                      await context.router.maybePop();
                    }
                    // Optionally clear input field after dismiss
                  // context.instance<EditProfileCubit>().state.updateEmailController.clear();
                  }
                },
              ),
            Dimens.size34.heightBox,
          ],
        ),
      ),
    );
  }

  ///validateEditProfileForm
  bool validateEditProfileForm(BuildContext context) {
    final EditProfileCubit editProfileCubit =
        context.instance<EditProfileCubit>();

    final String email =
        editProfileCubit.state.updateEmailController.text.trim();

    bool isValid = true;

    if (email.isEmpty) {
      isValid = false;
      editProfileCubit.handleValidationErrorMessageForUpdateEmail(
          context.appString.pleaseEnterTheEmailKey);
    }

    final String? emailError = email.validateEmail(
        isOnlyEmail: true,
        enterMobileOrNumberMsg: context.appString.pleaseEnterMobileOrNumberKey,
        enterEmailMsg: context.appString.pleaseEnterTheEmailKey,
        validEmailMsg: context.appString.pleaseEnterValidEmailKey);
    if (emailError?.isNotEmpty ?? false) {
      isValid = false;
      editProfileCubit
          .handleValidationErrorMessageForUpdateEmail(emailError ?? "");
    } else {
      editProfileCubit.handleValidationErrorMessageForUpdateEmail("");
    }

    return isValid;
  }
}
