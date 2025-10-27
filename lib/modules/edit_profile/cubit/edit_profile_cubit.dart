import '../../../utils/exports.dart';

/// Cubit responsible for managing the state and logic of the Edit Profile page.
///
/// Handles form validation, API calls for saving profile data,
/// updating user information (mobile code, nationality, gender),
/// and managing validation error messages.
class EditProfileCubit extends Cubit<EditProfileState> {
  /// Creates an instance of [EditProfileCubit].
  ///
  /// Requires:
  /// - [repository]: Repository to handle API calls for editing profile.
  /// - [initial]: Initial state of type [EditProfileState].
  EditProfileCubit({
    required this.repository,
    required EditProfileState initial,
  }) : super(initial) {
    unawaited(_loadUserProfileData());
  }

  /// Repository to handle API calls for editing profile.
  final EditProfileRepository repository;

  /// Calls the API to save the edited profile data.
  ///
  /// Validates the form before sending the request. If the API call is successful,
  /// updates the state with a success message; otherwise emits failure state with an error message.
  Future<void> callEditProfileSaveData(
      EditProfileRequestModel editProfileRequestModel) async {
    // if (state.formKey.currentState?.validate() ?? false) {

    await repository
        .callEditProfileSaveData(
      editProfileRequestModel: editProfileRequestModel,
    )
        .then((ResponseHandler<BaseResponse<EditProfileResponse>> value) async {
      if (value.isSuccess()) {
        if (value.getSuccessInstance()?.response.success ?? false) {
          await SharedPref.instance.saveEditProfileData(
              value.getSuccessInstance()?.response.data ??
                  const EditProfileResponse());

          final EditProfileResponse? editProfileData =
          value.getSuccessInstance()?.response.data!;
          await UserProfileService.instance().updateUserProfile(
            customerName: editProfileData?.customerName,
            customerEmail: editProfileData?.customerEmail,
            phoneNumber: editProfileData?.phoneNumber,
            customerToken: editProfileData?.customerToken,
            customerId: editProfileData?.customerId,
            quoteId: editProfileData?.quoteId,
            totalOrderValue: editProfileData?.totalOrderValue,
            lastOrderDate: editProfileData?.lastOrderDate,
            storeCredit: editProfileData?.walletBalance,
            rewardPoints: editProfileData?.loyaltyPoints,
            totalOrder: editProfileData?.totalOrder,
            cartCount: editProfileData?.cartCount,
            referralCode: editProfileData?.referralCode,
            fcmToken: editProfileData?.fcmToken,
            gender: editProfileData?.gender,
            birthday: editProfileData?.birthday,
            nationality: editProfileData?.nationality,
            prefix: editProfileData?.prefix,
            arabicNationality: editProfileData?.arabicNationality,
          );

          emit(state.copyWith(
            status: BaseStateStatus.success,
            successMsg: value.getSuccessInstance()?.response.message,
            redirectRoute: const MyAccountRoute(),
          ));
        } else {
          emit(state.copyWith(
            status: BaseStateStatus.failure,
            msg: value.getSuccessInstance()?.response.message.toString() ?? '',
          ));
        }
      } else if (value.isFailure()) {
        emit(state.copyWith(
          status: BaseStateStatus.failure,
          msg: value.getFailureInstance()?.error?.errorMessage.toString() ?? '',
        ));
      }
    });
    // }
  }

  /// Updates the mobile phone code in the state.
  void updateMobileCode(String phoneCode) {
    emit(state.copyWith(status: BaseStateStatus.initial, phoneCode: phoneCode));
  }

  /// Resets the success message and state status.
  void resetSuccessMsg() {
    emit(state.copyWith(
        status: BaseStateStatus.initial, successMsg: '', msg: ''));
  }

  /// Updates the validation error message for the full name field.
  void handleValidationErrorMessageForFullName(String value) {
    emit(state.copyWith(fullNameErrorMessage: value));
  }

  /// Updates the validation error message for the mobile number field.
  void handleValidationErrorMessageForMobileNumber(String value) {
    emit(state.copyWith(mobileErrorMessage: value));
  }

  /// Updates the validation error message for the email field.
  void handleValidationErrorMessageForEmail(String value) {
    emit(state.copyWith(emailErrorMessage: value));
  }

  /// Updates the selected nationality in the state.
  ///
  /// Optionally sets [isMenuOpen] if the nationality selection menu is open.
  void updateNationality(String nationality, {bool? isMenuOpen}) {
    emit(state.copyWith(
        selectedNationality: nationality, isMenuOpen: isMenuOpen));
    state.nationalityController.text = nationality; // Update UI field
  }

  /// Gets the date of birth field value.
  String get dateOfBirth => state.dateOfBirthController.text;

  /// Updates the date of birth field.
  set dateOfBirth(String value) {
    state.dateOfBirthController.text = value;
  }

  /// Updates the validation error message for the date of birth field.
  void handleValidationErrorMessageForDateOfBirth(String value) {
    emit(state.copyWith(dateOfBirthErrorMessage: value));
  }

  /// Updates the validation error message for nationality selection.
  void handleValidationErrorMessageForNationality(String value,
      {bool? isMenuOpen}) {
    emit(
        state.copyWith(nationalityErrorMessage: value, isMenuOpen: isMenuOpen));
  }

  /// Updates the validation error message for gender selection.
  void handleValidationErrorMessageForGender(String? value) {
    emit(state.copyWith(genderErrorMessage: value));
  }

  /// Updates the selected gender in the state.
  void updateSelectedGender(String? gender) {
    emit(state.copyWith(selectedGender: gender));
  }

  /// Updates the validation error message for updating email.
  void handleValidationErrorMessageForUpdateEmail(String value) {
    emit(state.copyWith(updateEmailErrorMessage: value));
  }

  /// Moves focus to the next input field.
  void moveToNextField(FocusNode nextFocusNode) {
    nextFocusNode.requestFocus();
  }

  /// Resets the update email field and its validation error.
  void resetUpdateEmail() {
    state.updateEmailController.clear();
    emit(state.copyWith(updateEmailErrorMessage: ''));
  }

  /// Converts API gender value to UI gender value for proper display
  String _convertApiGenderToUiGender(String apiGender) {
    DebugLog.instance.i(
        '🔍 Converting gender: "$apiGender" (lowercase: "${apiGender.toLowerCase()}")');
    switch (apiGender.toLowerCase()) {
      case 'male':
      case 'm':
        DebugLog.instance.i('🔍 Matched "male" -> returning AppConstant.male');
        return AppConstant.male;
      case 'female':
      case 'f':
        DebugLog.instance.i('🔍 Matched "female" -> returning AppConstant.female');
        return AppConstant.female;
      default:
        DebugLog.instance.w('⚠ Unknown gender value from API: "$apiGender"');
        return apiGender; // Return as-is if unknown
    }
  }

  /// Loads user profile data from UserProfileService and populates the form
  Future<void> _loadUserProfileData() async {
    try {
      DebugLog.instance.i('=== Starting _loadUserProfileData ===');
      String deviceId = getDeviceId();
      DebugLog.instance.i('deviceId = $deviceId');

      final UserProfileService userProfileService = getIt<UserProfileService>();
      await userProfileService.ensureUserDataLoaded();

      // Also ensure country data is loaded for nationality dropdown
      final CountryService countryService = getIt<CountryService>();
      await countryService.ensureCountryDataLoaded();
      await countryService
          .loadCountryList(); // Load the full country list for nationality dropdown

      // If country list is empty, try to fetch it from API
      if (countryService.getCountryList().isEmpty) {
        DebugLog.instance
            .w('⚠ Country list is empty, attempting to fetch from API...');
        try {
          // Call the language API to get country list
          final LanguageSelectionRepositoryImpl languageRepo =
          LanguageSelectionRepositoryImpl();

          final ResponseHandler<BaseResponse<LanguageResponseModel>> response =
          await languageRepo.getLanguageList();

          if (response.isSuccess() &&
              response.getSuccessInstance()?.response.data?.countryList !=
                  null) {
            final List<CountryList> countryList =
            response.getSuccessInstance()!.response.data!.countryList;
            await countryService.storeCountryList(countryList);
            DebugLog.instance.i(
                '✓ Country list fetched from API and stored: ${countryList.length} countries');
          } else {
            DebugLog.instance.w('⚠ Failed to fetch country list from API');
          }
        } on Exception catch (e) {
          DebugLog.instance.e('❌ Error fetching country list from API: $e');
        }
      }

      DebugLog.instance.i(
          'UserProfileService.isDataLoaded: ${userProfileService.isDataLoaded}');
      DebugLog.instance.i(
          'CountryService country list count: ${countryService.getCountryList().length}');

      if (userProfileService.isDataLoaded) {
        // Log all available user profile data
        DebugLog.instance.i('=== User Profile Data Details ===');
        DebugLog.instance.i('Customer ID: "${userProfileService.customerId}"');
        DebugLog.instance
            .i('Customer Name: "${userProfileService.customerName}"');
        DebugLog.instance
            .i('Customer Last Name: "${userProfileService.customerLastName}"');
        DebugLog.instance
            .i('Customer Email: "${userProfileService.customerEmail}"');
        DebugLog.instance
            .i('Phone Number: "${userProfileService.phoneNumber}"');
        DebugLog.instance
            .i('Mobile Number: "${userProfileService.mobileNumber}"');
        DebugLog.instance.i(
            'Phone Number Prefix: "${userProfileService.prefix}"');
        DebugLog.instance.i('Quote ID: "${userProfileService.quoteId}"');
        DebugLog.instance.i('Gender: "${userProfileService.gender}"');
        DebugLog.instance.i('Nationality: "${userProfileService.nationality}"');
        DebugLog.instance.i('DOB: "${userProfileService.birthday}"');
        DebugLog.instance
            .i('referralCode: "${userProfileService.referralCode}"');
        DebugLog.instance.i('=== End User Profile Data Details ===');

        // Update text controllers with user data from UserProfileService
        if (userProfileService.customerName.isNotEmpty) {
          state.fullNameController.text = userProfileService.customerName;
          DebugLog.instance.i(
              '✓ Full Name Controller updated: "${userProfileService.customerName}"');
        }

        if (userProfileService.customerEmail.isNotEmpty) {
          state.emailController.text = userProfileService.customerEmail;
          DebugLog.instance.i(
              '✓ Email Controller updated: "${userProfileService.customerEmail}"');
        }

        if (userProfileService.nationality.isNotEmpty) {
          state.nationalityController.text = isLanguageAlignmentLTR  ? userProfileService.nationality : userProfileService.arabicNationality ;
          emit(state.copyWith(
              selectedNationality: userProfileService.nationality));
          DebugLog.instance.i(
              '✓ Nationality Controller updated: "${userProfileService.nationality}"');
        }

        if (userProfileService.birthday.isNotEmpty) {
          state.dateOfBirthController.text = userProfileService.birthday;
          DebugLog.instance.i(
              '✓ dateOfBirth Controller updated: "${userProfileService.birthday}"');
        }

        if (userProfileService.gender.isNotEmpty) {
          DebugLog.instance
              .i('🔍 Processing gender: "${userProfileService.gender}"');
          // Convert API gender value to UI gender value
          String uiGenderValue =
          _convertApiGenderToUiGender(userProfileService.gender);
          DebugLog.instance.i('🔍 Converted gender: "$uiGenderValue"');
          emit(state.copyWith(selectedGender: uiGenderValue));
          DebugLog.instance.i(
              '✓ Gender Controller updated: API="${userProfileService.gender}" -> UI="$uiGenderValue"');
        } else {
          DebugLog.instance.w('⚠ Gender is empty in UserProfileService');
        }

        if (userProfileService.phoneNumber.isNotEmpty) {
          state.mobileNumberController.text = userProfileService.phoneNumber;
          DebugLog.instance.i(
              '✓ Mobile Number Controller updated: "${userProfileService.phoneNumber}"');
        }
        updateMobileCode(userProfileService.prefix.toString());

        // Emit state change to trigger UI rebuild with populated data
        emit(state.copyWith(
          status: BaseStateStatus.initial,
          msg: 'Profile data loaded successfully',
        ));

        DebugLog.instance.i(
            '✓ State updated with phoneCode: "${userProfileService.prefix ?? state.phoneCode}"');
        DebugLog.instance
            .i('✓ User profile data loaded and form populated successfully');
      } else {
        DebugLog.instance
            .w('⚠ UserProfileService data not loaded - no data available');
      }
    } on Exception catch (e) {
      DebugLog.instance.e('❌ Error loading user profile data: $e');
      emit(state.copyWith(
        status: BaseStateStatus.failure,
        msg: 'Failed to load user profile data',
      ));
    }
  }

  /// Validates the edit profile form input and prepares the request model.
  /// If validation passes, emits a [BaseStateStatus.loading] state with the request data.
  Future<void> validateInput(
      String messageForFullName,
      String messageForMobileNumber,
      String messageForEmail,
      String messageForNationality,
      String messageForDob,
      String messageForGender,
      String messageForOnlyNumbersAllowed,
      String messageForEnterValidMobileNumber,
      ) async {
    DebugLog.instance.i('=== Starting validateInput ===');

    // Emit loading state
    emit(state.copyWith(status: BaseStateStatus.loading));

    // Collect form data
    final String fullName = state.fullNameController.text.trim();
    final String mobileNumber = state.mobileNumberController.text.trim();
    final String mobileNumberPrefix = state.phoneCode.toString();
    final String email = state.emailController.text.trim();
    final String nationality = state.nationalityController.text.trim();
    final String dateOfBirth = state.dateOfBirthController.text.trim();
    final String? selectedGender = state.selectedGender;

    DebugLog.instance.i('Form data collected:');
    DebugLog.instance.i('Full Name: "$fullName"');
    DebugLog.instance.i('Mobile: "$mobileNumber"');
    DebugLog.instance.i('MobileNumberPrefix: "$mobileNumberPrefix"');
    DebugLog.instance.i('Email: "$email"');
    DebugLog.instance.i('Nationality: "$nationality"');
    DebugLog.instance.i('Date of Birth: "$dateOfBirth"');
    DebugLog.instance.i('Gender: "$selectedGender"');

    // Validate required fields
    bool isValid = true;

    if (fullName.isEmpty) {
      handleValidationErrorMessageForFullName(messageForFullName);
      isValid = false;
      DebugLog.instance.w('❌ Full name validation failed');
    } else {
      handleValidationErrorMessageForFullName(""); // Clear error if valid
    }

    if (mobileNumber.isEmpty) {
      handleValidationErrorMessageForMobileNumber(messageForMobileNumber);
      isValid = false;
      DebugLog.instance.w('❌ Mobile number validation failed - empty');
    } else {
      final String? numberError = mobileNumber.validMobileNo(
          emptyMobileMsg: messageForMobileNumber,
          onlyNumbersAllowedMsg: messageForOnlyNumbersAllowed,
          invalidMobileMsg: messageForEnterValidMobileNumber);
      if (numberError != null && numberError.isNotEmpty) {
        handleValidationErrorMessageForMobileNumber(numberError);
        isValid = false;
        DebugLog.instance.w('❌ Mobile number validation failed: $numberError');
      } else {
        handleValidationErrorMessageForMobileNumber(
            ""); // Clear mobile error if valid
        DebugLog.instance.i('✓ Mobile number validation passed');
      }
    }

    if (nationality.isEmpty) {
      handleValidationErrorMessageForNationality(messageForNationality);
      isValid = false;
      DebugLog.instance.w('❌ Nationality validation failed');
    } else {
      handleValidationErrorMessageForNationality(""); // Clear error if valid
      DebugLog.instance.i('✓ Nationality validation passed');
    }

    if (dateOfBirth.isEmpty) {
      handleValidationErrorMessageForDateOfBirth(messageForDob);
      isValid = false;
      DebugLog.instance.w('❌ Date of birth validation failed');
    } else {
      handleValidationErrorMessageForDateOfBirth(""); // Clear error if valid
      DebugLog.instance.i('✓ Date of birth validation passed');
    }

    if (selectedGender == null || selectedGender.isEmpty) {
      handleValidationErrorMessageForGender(messageForGender);
      isValid = false;
      DebugLog.instance.w('❌ Gender validation failed');
    } else {
      handleValidationErrorMessageForGender(""); // Clear error if valid
      DebugLog.instance.i('✓ Gender validation passed');
    }

    if (!isValid) {
      DebugLog.instance.w('❌ Form validation failed - not calling API');
      emit(state.copyWith(
          status: BaseStateStatus.failure,
          msg: 'Please fill all required fields'));
      return;
    }

    DebugLog.instance.i('✓ All validations passed - preparing API call');

    try {
      UserProfileService userProfile = getIt<UserProfileService>();
      final EditProfileRequestModel editProfileRequestModel =
      EditProfileRequestModel(
          languageId:
          int.tryParse(getIt<LanguageService>().languageId) ?? 1,
          platform: getPlatformName(),
          version: getIt<MainConfig>().packageInfo.version,
          firstName: state.fullNameController.text,
          lastName: state.emailController.text,
          mobileNumber: state.mobileNumberController.text,
          mobileNumberPrefix:
          state.phoneCode ?? AppConstant.defaultCountryCode,
          customerToken: userProfile.customerToken,
          nationality: state.nationalityController.text,
          dob: convertDateFormatForSignup(state.dateOfBirthController.text),
          gender: state.selectedGender != null ? getGenderConstant(state.selectedGender!) : null,
          deviceId: getDeviceId());

      DebugLog.instance.i('✓ EditProfileRequestModel created - calling API');
      await callEditProfileSaveData(editProfileRequestModel);
    } on Exception catch (e) {
      DebugLog.instance.e('❌ Error in validateInput: $e');
      emit(state.copyWith(
        status: BaseStateStatus.failure,
        msg: 'An error occurred while processing your request',
      ));
    }
  }

  /// Update Email
  Future<void> callUpdateEmail() async {
    final UpdateEmailRequestModel updateEmailRequestModel =
    UpdateEmailRequestModel(
      languageId: int.tryParse(getIt<LanguageService>().languageId) ?? 1,
      platform: getPlatformName(),
      version: getIt<MainConfig>().packageInfo.version,
      customerToken: getIt<UserProfileService>().customerToken,
      email: state.updateEmailController.text,
      otp: AppConstant.empty,
      deviceId: getDeviceId(),
      websiteId: int.tryParse(getIt<CountryService>().websiteId),
      storeId: int.tryParse(getIt<CountryService>().store.toString()),
      sentOtp: AppConstant.one,
      verifyOtp: AppConstant.zero,
    );
    await repository
        .callUpdateEmail(
      updateEmailRequestModel: updateEmailRequestModel,
    )
        .then((ResponseHandler<BaseResponse<void>> value) async {

      if (value.isSuccess()) {
        final bool responseSuccess = value.getSuccessInstance()?.response.success ?? false;
        final String responseMessage = value.getSuccessInstance()?.response.message ?? '';

        DebugLog.instance.i('🔍 response.success: $responseSuccess');
        DebugLog.instance.i('🔍 response.message: "$responseMessage"');

        final String? extractedOtp = OtpExtractor.extractOtpFromMessage(responseMessage);
        DebugLog.instance.i('✅ Success - Extracted OTP: $extractedOtp');

        if(responseSuccess) {
          // Redirect to OTP verification even if no OTP is extracted from message
          // The API confirms OTP was sent successfully
          emit(state.copyWith(
            status: BaseStateStatus.success,
            successMsg: responseMessage,
            redirectRoute: VerifyOtpRoute(
              updateEmailRequestModel: updateEmailRequestModel,
              email: updateEmailRequestModel.email.toString(),
              prefix: getIt<UserProfileService>().prefix != 0
                  ? '${getIt<UserProfileService>().prefix}'
                  : AppConstant.defaultCountryCodeInt.toString(),
              flowType: OtpFlowType.updateEmail,
              autoFilledOtp: extractedOtp, // Can be null if no OTP extracted
              redirectRoute: const MyAccountRoute(),
            ),
          ));
        } else {
          DebugLog.instance.e('❌ API returned success: false - showing error message');
          emit(state.copyWith(
            status: BaseStateStatus.failure,
            msg: responseMessage,
          ));
        }
      } else if (value.isFailure()) {
        DebugLog.instance.e('❌ Network/API failure');
        emit(state.copyWith(
          status: BaseStateStatus.failure,
          msg: value.getFailureInstance()?.error?.errorMessage.toString() ?? '',
        ));
      }
    });
  }
}
