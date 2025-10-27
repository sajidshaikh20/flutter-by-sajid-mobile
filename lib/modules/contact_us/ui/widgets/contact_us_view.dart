import '../../../../utils/exports.dart';

/// [ContactUsView] is a widget that displays the contact us screen.
class ContactUsView extends StatelessWidget {
  /// [ContactUsView] constructor
  const ContactUsView({super.key, this.device = ScreenType.mobile});

  /// [device] is used for responsive ui
  final ScreenType device;

  @override
  Widget build(BuildContext context) {
    switch (device) {
      case ScreenType.tablet:

      default:
        break;
    }
    ContactUsCubit cubit = context.instance<ContactUsCubit>();

    return BlocListener<ContactUsCubit, ContactUsState>(
  listenWhen: (ContactUsState previous, ContactUsState current) {
    // Only listen when message changes and is not empty
    return previous.msg != current.msg && 
           (current.msg?.isNotEmpty ?? false);
  },
  listener: (BuildContext context, ContactUsState state) {
    if (state.msg != null && (state.msg?.isNotEmpty ?? false)) {
      displaySnackBar(state.msg ?? '', context);
    }
  },
  child: Scaffold(
      backgroundColor: MainConfig.appColors.backgroundPinkColor,
      body: Column(
        children: <Widget>[
          ProductDetailsAppBar(
            onTap: () async {
              // await context.router.push(StoreLocationsRoute());
            },
            style: context.textTheme.headlineMedium?.copyWith(
              fontWeight: FontWeight.w600,
              fontSize: Dimens.fontSize14,
              color: MainConfig.appColors.mainColor,
              height: Dimens.lineHeight18.toLineHeight(Dimens.fontSize14),
            ),
            titleText: context.appString.contactUsKey,
            isLastWidgetDisplay: false,
            prefixIcon: Assets.svgs.icBack
                .svg(height: Dimens.size24, width: Dimens.size24),
          ),
          Expanded(
            child: SingleChildScrollView(
                child: Padding(
              padding: const EdgeInsets.all(Dimens.size16),
              child: Column(
                children: <Widget>[
                  BlocBuilder<ContactUsCubit, ContactUsState>(
                    buildWhen: (ContactUsState previous, ContactUsState current) {
                      // This is a static description, no rebuild needed
                      return false;
                    },
                    builder: (BuildContext context, ContactUsState state) {
                      return CustomTextLabelWidget(
                          style: context.textTheme.bodySmall?.copyWith(
                              fontWeight: FontWeight.w600,
                              height: Dimens.lineHeight18
                                  .toLineHeight(Dimens.fontSize14),
                              color: MainConfig.appColors.textBlackColor,
                              fontSize: Dimens.fontSize14),
                          textAlign: TextAlign.start,
                          label: context.appString.contactUsDescKey);
                    },
                  ),
                  Dimens.size32.heightBox,
                  BlocBuilder<ContactUsCubit, ContactUsState>(
                    buildWhen: (ContactUsState previous, ContactUsState current) {
                      // Only rebuild when full name error message changes
                      return previous.fullNameErrorMessage != current.fullNameErrorMessage;
                    },
                    builder: (BuildContext context, ContactUsState state) {
                      return CommonTextFormFieldWidget(
                        device: device,
                        focusNode: state.fullNameFocusNode,
                        errorMsg: state.fullNameErrorMessage,
                        controller: state.fullNameController,
                        maxLength: Dimens.maxLength50,
                        label: context.appString.fullNameKey,
                        input: TextInputAction.next,
                        onChange: (String value) {
                          if (value.validateFirstLastNameField() == true) {
                            context
                                .read<ContactUsCubit>()
                                .handleValidationErrorMessageForFullName('');
                          }
                        },
                        inputFormatters: <TextInputFormatter>[
                          LengthLimitingTextInputFormatter(
                              Dimens.size200.toInt()),
                        ],
                        onTextSubmit: (_) {
                          context
                              .read<ContactUsCubit>()
                              .moveToNextField(state.mobileNumberFocusNode);
                        },
                      );
                    },
                  ),
                  Dimens.size16.heightBox,
                  BlocBuilder<ContactUsCubit, ContactUsState>(
                    buildWhen: (ContactUsState previous, ContactUsState current) {
                      // Only rebuild when mobile error message or phone code changes
                      return previous.mobileErrorMessage != current.mobileErrorMessage ||
                             previous.phoneCode != current.phoneCode;
                    },
                    builder: (BuildContext context, ContactUsState state) {
                      return CustomMobileInputWidget(
                        device: device,
                        errorMessage: state.mobileErrorMessage,
                        focusNode: state.mobileNumberFocusNode,
                        mobileNumberController:
                            cubit.state.mobileNumberController,
                        initialCountryCode: cubit.state.phoneCode ?? "",
                        onChange: (String value) {
                          if (value.validMobileBool(isRequired: true) == true) {
                            cubit.handleValidationErrorMessageForMobileNumber(
                                '');
                          }
                        },
                        onCountryCodeChanged: (String? dialCode) {
                          cubit.updateMobileCode(dialCode.toString());
                        },
                      );
                    },
                  ),
                  Dimens.size16.heightBox,
                  BlocBuilder<ContactUsCubit, ContactUsState>(
                    buildWhen: (ContactUsState previous, ContactUsState current) {
                      // Only rebuild when email error message changes
                      return previous.emailErrorMessage != current.emailErrorMessage;
                    },
                    builder: (BuildContext context, ContactUsState state) {
                      return CommonTextFormFieldWidget(
                        textInputType: TextInputType.emailAddress,
                        device: device,
                        controller: cubit.state.emailController,
                        label: context.appString.emailIdKey,
                        isEditable: true,
                        focusNode: state.emailFocusNode,
                        errorMsg: state.emailErrorMessage,
                        style: context.textTheme.displayMedium?.copyWith(
                            color: MainConfig.appColors.creyColor,
                            fontWeight: FontWeight.w600,
                            fontSize: Dimens.fontSize16,
                            height: Dimens.lineHeight29
                                .toLineHeight(Dimens.fontSize16)),
                        input: TextInputAction.next,
                        inputFormatters: <TextInputFormatter>[
                          LengthLimitingTextInputFormatter(
                              AppConstant.limitingTextInputFormatter)
                        ],
                        textCapitalization: TextCapitalization.none,
                      );
                    },
                  ),
                  Dimens.size16.heightBox,
                  BlocBuilder<ContactUsCubit, ContactUsState>(
                    buildWhen: (ContactUsState previous, ContactUsState current) {
                      // Only rebuild when comment error message changes
                      return previous.writeCommnetMessage != current.writeCommnetMessage;
                    },
                    builder: (BuildContext context, ContactUsState state) {
                      return CommonTextFormFieldWidget(
                        device: device,
                        editTextHeight: Dimens.size171,
                        controller: cubit.state.writeCommentContoller,
                        label: context.appString.writeCommentKey,
                        maxLines: Dimens.maxLength4,
                        focusNode: state.writeCommentFocusNode,
                        textAlign: TextAlign.start,
                        isEditable: true,
                        errorMsg: state.writeCommnetMessage,
                        textInputType: TextInputType.multiline,
                        isEmojiAllow: true,
                        style: context.textTheme.displayMedium?.copyWith(
                            color: MainConfig.appColors.creyColor,
                            fontWeight: FontWeight.w600,
                            fontSize: Dimens.fontSize16,
                            height: Dimens.lineHeight29
                                .toLineHeight(Dimens.fontSize16)),
                        input: TextInputAction.done,
                        inputFormatters: <TextInputFormatter>[
                          LengthLimitingTextInputFormatter(
                              AppConstant.limitingTextInputFormatter),
                        ],
                      );
                    },
                  ),
                  Dimens.size23.heightBox,
                  CustomGradientButtonWidget(
                    title: context.appString.submitButtonKey,

                    titleTextStyle: context.textTheme.headlineMedium?.copyWith(
                      fontSize: Dimens.fontSize16,
                      color: Colors.white,
                    ),
                    onTap: () async {
                      if (validateEditProfileForm(context)) {
                        final ContactUsCubit contactusCubit = context.instance<ContactUsCubit>();
                        final String fullName = contactusCubit.state.fullNameController.text.trim();
                        final String mobileNumber = contactusCubit.state.mobileNumberController.text.trim();
                        final String email = contactusCubit.state.emailController.text.trim();
                        final String writeComment = contactusCubit.state.writeCommentContoller.text.trim();
                        
                        // Call the API with form values
                        await contactusCubit.submitContactUsForm(
                          name: fullName,
                          mobile: mobileNumber,
                          email: email,
                          comment: writeComment,
                        );
                      }
                    },
                  ),
                ],
              ),
            )),
          )
        ],
      ),
    ),
);
  }

  /// [validateEditProfileForm] method is used to validate the contact us form
  ///
  /// [context] contains the current context of the app
  /// this method retuen  or
  bool validateEditProfileForm(BuildContext context) {
    final ContactUsCubit contactusCubit = context.instance<ContactUsCubit>();

    final String fullName = contactusCubit.state.fullNameController.text.trim();
    final String mobileNumber =
        contactusCubit.state.mobileNumberController.text.trim();
    final String email = contactusCubit.state.emailController.text.trim();
    final String writeComment =
        contactusCubit.state.writeCommentContoller.text.trim();
    bool isValid = true;

    if (fullName.isEmpty) {
      isValid = false;
      contactusCubit.handleValidationErrorMessageForFullName(
          context.appString.enterFirstNameKey);
    }
    if (writeComment.isEmpty) {
      isValid = false;
      contactusCubit.handleValidationErrorMessageForDescription(
          context.appString.pleaseEnterCommentKey);
    }
    if (mobileNumber.isEmpty) {
      isValid = false;
      contactusCubit.handleValidationErrorMessageForMobileNumber(
          context.appString.pleaseEnterMobileNumberKey);
    }
    if (email.isEmpty) {
      isValid = false;
      contactusCubit.handleValidationErrorMessageForEmail(
          context.appString.pleaseEnterTheEmailKey);
    }

    final String? mobileError = mobileNumber.validMobileNo(emptyMobileMsg : context.appString.pleaseEnterMobileNumberKey,
        onlyNumbersAllowedMsg : context.appString.onlyNumbersAllowedKey,
        invalidMobileMsg : context.appString.enterValidMobileNumberKey
    );
    if (mobileError?.isNotEmpty ?? false) {
      isValid = false;
      contactusCubit
          .handleValidationErrorMessageForMobileNumber(mobileError ?? "");
       // Stop further validation if mobile number is invalid
    } else {
      contactusCubit.handleValidationErrorMessageForMobileNumber(
          ""); // Clear mobile error if valid
    }

    if (email.isNotEmpty) {
      final String? emailError = email.validateEmail(
          isOnlyEmail: true,
          enterMobileOrNumberMsg : context.appString.pleaseEnterMobileOrNumberKey,
          enterEmailMsg: context.appString.pleaseEnterTheEmailKey,
          validEmailMsg: context.appString.pleaseEnterValidEmailKey
      );
      if (emailError?.isNotEmpty ?? false) {
        isValid = false;
        contactusCubit.handleValidationErrorMessageForEmail(emailError ?? "");
      } else {
        contactusCubit.handleValidationErrorMessageForEmail("");
      }
    }
    return isValid;
  }
}
