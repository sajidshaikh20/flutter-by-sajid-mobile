import '../../../utils/exports.dart';

/// A form widget used to edit user profile information.
///
/// This widget can include fields like full name, email, mobile number,
/// date of birth, and nationality. It is responsive based on the [device] type.
class EditProfileForm extends StatelessWidget {
  /// The type of device to adapt layout and spacing.
  final ScreenType device;


  ///EditProfileForm
  const EditProfileForm({super.key, this.device = ScreenType.mobile});


  @override
  Widget build(BuildContext context) {
    final GlobalKey editTextKey = GlobalKey();

    double heightMobTab14_21 = Dimens.size16;
    double saveFontSize = Dimens.fontSize18;
    switch (device) {
      case ScreenType.tablet:
        heightMobTab14_21 = Dimens.size21;
        saveFontSize = Dimens.fontSize24;

      default:
        break;
    }
   final EditProfileCubit cubit = context.instance<EditProfileCubit>();
    return BlocListener<EditProfileCubit, EditProfileState>(
        listenWhen: (EditProfileState previous, EditProfileState current) {
          // Only listen when status changes to success or failure, or when messages change
          return previous.status != current.status || previous.redirectRoute != current.redirectRoute;
        },
        listener: (BuildContext context, EditProfileState state) async {
      if (state.status == BaseStateStatus.success) {
        displaySnackBar(state.successMsg, context);

        // goBack(context,
        //     result: <String, bool>{APIConstant.editApiCalled: true});
      }
      if (state.status == BaseStateStatus.failure) {
        displaySnackBar(state.msg ?? '', context);

        // goBack(context,
        //     result: <String, bool>{APIConstant.editApiCalled: true});
      }
      if (state.redirectRoute != null) {
        await context.router.push(state.redirectRoute!);
      }
      cubit.resetSuccessMsg();
    }, child: BlocBuilder<EditProfileCubit, EditProfileState>(
      buildWhen: (EditProfileState previous, EditProfileState current) {
        // Only rebuild when form data, validation errors, or UI state changes
        return previous.status != current.status ||
               previous.successMsg != current.successMsg ||
               previous.redirectRoute != current.redirectRoute ||
               previous.msg != current.msg;
      },
      builder: (BuildContext context, EditProfileState state) {
        return Scaffold(

            backgroundColor: MainConfig.appColors.backgroundLightPinkColor,
            body: Column(
              children: <Widget>[
                ProductDetailsAppBar(
                  titleText: context.appString.editProfileKey,
                  isLastWidgetDisplay: false,
                  prefixIcon: Assets.svgs.icBack.svg(),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: Dimens.space16.padding,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          CommonTextFormFieldWidget(
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
                                    .read<EditProfileCubit>()
                                    .handleValidationErrorMessageForFullName(
                                        '');
                              }
                            },
                            inputFormatters: <TextInputFormatter>[
                              LengthLimitingTextInputFormatter(
                                  Dimens.size200.toInt()),
                            ],
                            onTextSubmit: (_) {
                              context
                                  .read<EditProfileCubit>()
                                  .moveToNextField(state.mobileNumberFocusNode);
                            },
                          ),
                          heightMobTab14_21.heightBox,
                          CustomMobileInputWidget(
                            device: device,
                            errorMessage: state.mobileErrorMessage,
                            focusNode: state.mobileNumberFocusNode,
                            mobileNumberController:
                                cubit.state.mobileNumberController,
                            initialCountryCode: cubit.state.phoneCode ?? "",
                            onChange: (String value) {
                              if (value.validMobileBool(isRequired: true)) {
                                cubit.handleValidationErrorMessageForMobileNumber('');
                              }
                            },
                            onCountryCodeChanged: (String? dialCode) {
                              cubit.updateMobileCode(dialCode.toString());
                            },
                          ),
                          Dimens.size16.heightBox,
                          CommonTextFormFieldWidget(
                            device: device,
                            controller: cubit.state.emailController,
                            label: context.appString.emailIdKey,
                            fillColor:
                                MainConfig.appColors.dukkanborderGreyLightColor,
                            isEditable: true,
                            readOnly: true,
                            style: context.textTheme.displayMedium?.copyWith(
                                color: MainConfig.appColors.creyColor,
                                fontWeight: FontWeight.w600,
                                fontSize: Dimens.fontSize16,
                                height: Dimens.lineHeight29
                                    .toLineHeight(Dimens.fontSize16)),
                            suffixIcon: CustomTextLabelWidget(
                              onTap: () async {
                                context.read<EditProfileCubit>().resetUpdateEmail();
                                await showCustomBottomSheetView(
                                  backgroundColor:
                                      MainConfig.appColors.backgroundWhite,
                                  context: context,
                                  title: context.appString.newEmailIdKey,
                                  child: BlocProvider<EditProfileCubit>.value(
                                    value: context.read<EditProfileCubit>(),
                                    // Reuse existing cubit
                                    child: const UpdateEmailWidget(),
                                  ),
                                );
                              },
                              label: context.appString.editKey,
                              style: context.textTheme.displayMedium?.copyWith(
                                  color: MainConfig.appColors.mainColor,
                                  decoration: TextDecoration.underline,
                                  fontWeight: FontWeight.w700,
                                  fontSize: Dimens.fontSize12,
                                  height: Dimens.lineHeight14
                                      .toLineHeight(Dimens.fontSize12)),
                            ),
                            input: TextInputAction.done,
                            inputFormatters: <TextInputFormatter>[
                              LengthLimitingTextInputFormatter(
                                  AppConstant.limitingTextInputFormatter)
                            ],
                          ),
                          Dimens.size16.heightBox,
                        BlocBuilder<EditProfileCubit, EditProfileState>(
                          buildWhen: (EditProfileState previous, EditProfileState current) {
                            // Only rebuild when nationality-related state changes
                            return previous.nationalityErrorMessage != current.nationalityErrorMessage ||
                                   previous.selectedNationality != current.selectedNationality ||
                                   previous.isMenuOpen != current.isMenuOpen;
                          },
                          builder: (BuildContext context, EditProfileState state) {
                            return
                              CommonTextFormFieldWidget(
                            device: device,
                            controller: cubit.state.nationalityController,
                            label: context.appString.nationalityOnlyKey,
                            key: editTextKey,
                            focusNode: state.nationalityFocusNode,
                            errorMsg: state.nationalityErrorMessage,
                            input: TextInputAction.next,
                            isEditable: true,
                            readOnly: true,
                            suffixIcon: AnimatedRotation(
                              turns: state.isMenuOpen ? 0.5 : 0,
                              duration: const Duration(milliseconds: 300), // Adjust duration for smoothness
                              child: Assets.svgs.icDown.svg(),
                            ),
                            onChange: (String value) {
                              context
                                  .read<EditProfileCubit>()
                                  .handleValidationErrorMessageForNationality(
                                      "");
                            },
                            onTap: () async {
                              await clickOfTheDropDown(context, editTextKey);
                            },
                            suffixOnClick: () async {
                              await clickOfTheDropDown(context, editTextKey);
                            },
                            onTextSubmit: (_) {},
                          );
                          },
                        ),
                          Dimens.size16.heightBox,
                        BlocBuilder<EditProfileCubit, EditProfileState>(
                          buildWhen: (EditProfileState previous, EditProfileState current) {
                            // Only rebuild when date of birth error message changes
                            return previous.dateOfBirthErrorMessage != current.dateOfBirthErrorMessage;
                          },
                          builder: (BuildContext context, EditProfileState state) {
                            return
                              CommonTextFormFieldWidget(
                                controller: cubit.state.dateOfBirthController,
                                label: context.appString.dateOfBirthKey,
                                readOnly: true,
                                input: TextInputAction.next,
                                fillColor:
                                MainConfig.appColors.dukkanborderGreyLightColor,
                                borderColor: MainConfig.appColors.redColor,
                                suffixIcon: Assets.svgs.icDCalender.svg(),
                                isEditable: true,
                                enableInteractiveSelection: false,
                                showCursor: false,
                                disableContextMenu: true,
                                onTap: () async {
                                  // context
                                  //     .read<EditProfileCubit>()
                                  //     .handleValidationErrorMessageForDateOfBirth("");
                                  // final String? formattedDate = await pickDate(context);
                                  // if (formattedDate != null) {
                                  //   if(context.mounted) {
                                  //     context.read<EditProfileCubit>().dateOfBirth = formattedDate;
                                  //   }
                                  // }
                                },
                                onTextSubmit: (_) {
                                },
                              );
                          }),
                          Dimens.size20.heightBox,
                        BlocBuilder<EditProfileCubit, EditProfileState>(
                          buildWhen: (EditProfileState previous, EditProfileState current) {
                            // Only rebuild when gender error message or selected gender changes
                            return previous.genderErrorMessage != current.genderErrorMessage ||
                                   previous.selectedGender != current.selectedGender;
                          },
                          builder: (BuildContext context, EditProfileState state) {
                            return
                              GenderSelection(
                                errorMessage: state.genderErrorMessage,
                                onChanged: (String? gender) {
                                  if (gender?.isNotEmpty ?? false) {
                                    context
                                        .read<EditProfileCubit>()
                                        .updateSelectedGender(gender);
                                    context
                                        .read<EditProfileCubit>()
                                        .handleValidationErrorMessageForGender(
                                        '');
                                  }
                                },
                                initialValue: state.selectedGender ?? "",
                              );
                          }
                        ),
                          Dimens.size25.heightBox,
                          CustomGradientButtonWidget(
                            title: context.appString.updateKey,
                            titleTextStyle:
                                context.textTheme.headlineMedium?.copyWith(
                              fontSize: saveFontSize,
                              color: Colors.white,
                            ),
                            onTap: () async {
                             await context
                                 .read<EditProfileCubit>().validateInput(
                                context.appString.pleaseEnterTheFullNameKey,
                               context.appString.pleaseEnterMobileNumberKey,
                                context.appString.pleaseEnterTheEmailIdKey,
                                context.appString.selectNationalityKey,
                                context.appString.selectDOBKey,
                               context.appString.selectGenderKey,
                               context.appString.onlyNumbersAllowedKey,
                               context.appString.enterValidMobileNumberKey,
                              );
                              // if (validateEditProfileForm(context)) {
                              //   await context.router.push(VerifyOtpRoute(
                              //       email: "email",
                              //       redirectRoute: LoginRoute()));
                              //   debugPrint("sign up api calling here");
                              // }

                              // cubit.callEditProfileSaveData(
                              //     context.size?.width.toString() ?? "");
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ));
      },
    ));
  }
///clickOfTheDropDown
  Future<void> clickOfTheDropDown(BuildContext context,
      GlobalKey<State<StatefulWidget>> editTextKey) async {
    context
        .read<EditProfileCubit>()
        .handleValidationErrorMessageForNationality("", isMenuOpen: true);
    String? selectedNat = await showNationalityMenu(context, editTextKey);

    if (context.mounted) {
      context
          .read<EditProfileCubit>()
          .updateNationality(selectedNat ?? "", isMenuOpen: false);
    }
  }
/// validator for edit profile form which return bool value
  bool validateEditProfileForm(BuildContext context) {
    final EditProfileCubit editProfileCubit =
        context.instance<EditProfileCubit>();

    final String fullName =
        editProfileCubit.state.fullNameController.text.trim();
    final String mobileNumber =
        editProfileCubit.state.mobileNumberController.text.trim();
    final String email = editProfileCubit.state.emailController.text.trim();
    final String nationality =
        editProfileCubit.state.nationalityController.text.trim();
    final String dateOfBirth =
        editProfileCubit.state.dateOfBirthController.text.trim();
    final String? selectedGender = editProfileCubit.state.selectedGender;

    bool isValid = true;

    if (fullName.isEmpty) {
      isValid = false;
      editProfileCubit.handleValidationErrorMessageForFullName(
          context.appString.enterFirstNameKey);
    }
    if (mobileNumber.isEmpty) {
      isValid = false;
      editProfileCubit.handleValidationErrorMessageForMobileNumber(
          context.appString.pleaseEnterMobileNumberKey);
    }
    if (email.isEmpty) {
      isValid = false;
      editProfileCubit.handleValidationErrorMessageForEmail(
          context.appString.pleaseEnterTheEmailKey);
    }
    if (nationality.isEmpty) {
      isValid = false;
      editProfileCubit.handleValidationErrorMessageForNationality(
          context.appString.selectNationalityKey);
    }
    if (dateOfBirth.isEmpty) {
      isValid = false;
      editProfileCubit.handleValidationErrorMessageForDateOfBirth(
          context.appString.selectDOBKey);
    }

    final String? numberError = mobileNumber.validMobileNo(emptyMobileMsg : context.appString.pleaseEnterMobileNumberKey,
        onlyNumbersAllowedMsg : context.appString.onlyNumbersAllowedKey,
        invalidMobileMsg : context.appString.enterValidMobileNumberKey);
    if (numberError?.isNotEmpty ?? false) {
      editProfileCubit
          .handleValidationErrorMessageForMobileNumber(numberError ?? "");
      isValid = false;

      // return; // Stop further validation if mobile number is invalid
    } else {
      editProfileCubit.handleValidationErrorMessageForMobileNumber(
          ""); // Clear mobile error if valid
    }

    if (email.startsWithLetter()) {
      final String? emailError = email.validateEmail(
          isOnlyEmail: true,
          enterMobileOrNumberMsg : context.appString.pleaseEnterMobileOrNumberKey,
          enterEmailMsg: context.appString.pleaseEnterTheEmailKey,
          validEmailMsg: context.appString.pleaseEnterValidEmailKey
      );
      if (emailError?.isNotEmpty ?? false) {
        isValid = false;
        editProfileCubit.handleValidationErrorMessageForEmail(emailError ?? "");
      } else {
        editProfileCubit.handleValidationErrorMessageForEmail("");
      }
    }
    if (selectedGender?.isEmpty ?? true) {
      isValid = false;
      editProfileCubit.handleValidationErrorMessageForGender(
          context.appString.selectGenderKey);
    } else {
      editProfileCubit.handleValidationErrorMessageForGender('');
    }

    return isValid;
  }
}
