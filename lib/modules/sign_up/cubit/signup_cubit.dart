import '../../../utils/exports.dart';

/// Cubit responsible for handling the Signup flow,
/// including form validation, user input updates,
/// and API request preparation.
class SignupCubit extends Cubit<SignupState> {
  /// Creates an instance of [SignupCubit] with the given [repository] and [initialState].
  /// Automatically sets the default country code using [CountryService].
  SignupCubit({required this.repository, required SignupState initialState})
      : super(initialState) {

    // Only set country code if it's not empty and different from the default
  //  final String countryCode = getIt<CountryService>().countryCode ?? '';

    /// Fetches and updates the loyalty points.

  }

  /// Repository used to perform sign-up API calls.
  final SignUpRepository repository;


  /// Validates the signup form input and prepares the request model.
  /// If validation passes, emits a [BaseStateStatus.loading] state with the request data.
  Future<void> validateInput(
      String messageForFullName,
      String messageForMobileNumber,
      String messageForEmail,
      String messageForNationality,
      String messageForDob,
      String messageForGender,
      String messageForPassword,
      String messageForOnlyNumbersAllowed,
      String messageForEnterValidMobileNumber,
      String messageForInvalidEmail,
      String messageForInvalidPassword,
      String messageForAcceptTerms,
      ) async {
    if (state.formKey.currentState?.validate() ?? false) {
      // Collect form data
      final String fullName = state.fullNameController.text.trim();
      final String mobileNumber = state.mobileController.text.trim();
      final String email = state.emailController.text.trim();
      final String nationality = state.nationalityController.text.trim();
      final String dateOfBirth = state.dateOfBirthController.text.trim();
      final String password = state.passwordController.text.trim();
      final String? selectedGender = state.selectedGender;
      
      // Validate required fields
      bool isValid = true;
      
      if (fullName.isEmpty) {
        handleValidationErrorMessageForFullName(messageForFullName);
        isValid = false;
      }

      if (mobileNumber.isEmpty) {
        handleValidationErrorMessageForMobileNumber(messageForMobileNumber);
        isValid = false;
      } else {
        final String? numberError = mobileNumber.validMobileNo(
            emptyMobileMsg : messageForMobileNumber,
            onlyNumbersAllowedMsg : messageForOnlyNumbersAllowed,
            invalidMobileMsg : messageForEnterValidMobileNumber);
        if (numberError != null && numberError.isNotEmpty) {
          handleValidationErrorMessageForMobileNumber(numberError);
          isValid = false;
        } else {
          handleValidationErrorMessageForMobileNumber(""); // Clear mobile error if valid
        }
      }

      if (email.isEmpty) {
        handleValidationErrorMessageForEmail(messageForEmail);
        isValid = false;
      } else {
        final String? emailError = email.validateEmail(
            isOnlyEmail: true,
            enterMobileOrNumberMsg : messageForInvalidEmail,
            enterEmailMsg: messageForEmail,
            validEmailMsg: messageForInvalidEmail
        );
        if (emailError != null && emailError.isNotEmpty) {
          handleValidationErrorMessageForEmail(emailError);
          isValid = false;
        } else {
          handleValidationErrorMessageForEmail(""); // Clear email error if valid
        }
      }

      if (nationality.isEmpty) {
        handleValidationErrorMessageForNationality(messageForNationality);
        isValid = false;
      }

      if (dateOfBirth.isEmpty) {
        handleValidationErrorMessageForDateOfBirth(messageForDob);
        isValid = false;
      }

      if (password.isEmpty) {
        handleValidationErrorMessageForPassword(messageForPassword);
        isValid = false;
      } else {
        final String? passwordError = password.validatePassword(
            isNewPassword: true,
            customError: messageForInvalidPassword,
            emptyPasswordMsg: messageForPassword,
            invalidPasswordMsg: messageForInvalidPassword
          );
        if (passwordError != null && passwordError.isNotEmpty) {
          handleValidationErrorMessageForPassword(passwordError);
          isValid = false;
        } else {
          handleValidationErrorMessageForPassword(""); // Clear password error if valid
        }
      }

      if (selectedGender == null || selectedGender.isEmpty) {
        handleValidationErrorMessageForGender(messageForGender);
        isValid = false;
      }

      if (!state.isChecked) {
        handleValidationErrorMessageForTermCondition(messageForAcceptTerms);
        isValid = false;
      }
      
      if (!isValid) {
        return;
      }
      
      // Create request model
      final SignUpUserOtpRequestModel request = SignUpUserOtpRequestModel(
        platform: getPlatformName(),
        languageId: int.tryParse(getIt<LanguageService>().languageId) ?? 1,
        mobileNumber: mobileNumber,
        mobileNumberPrefix: state.mobilePrefix,
          referralCode: state.referralCodeController.text,
        version: getIt<MainConfig>().packageInfo.version, // or get from app version
      );
      emit(state.copyWith(status: BaseStateStatus.loading, requestModel: request));
      // Call API
      await callSignUpUserOtpApi(request);
    }
  }


  /// Calls the signup OTP API and handles the response
  Future<void> callSignUpUserOtpApi(SignUpUserOtpRequestModel request) async {
    try {
      final ResponseHandler<BaseResponse<void>> response = await repository.callSignUpUserOtpApi(request);

      if (response.isSuccess()) {
        final OnSuccessResponse<BaseResponse<void>>? successResponse = response.getSuccessInstance();
        if (successResponse != null && successResponse.response.success) {
          // API call successful, navigate to OTP verification
          final String email = state.emailController.text.trim();
          final String fullName = state.fullNameController.text.trim();
          final String mobileNumber = state.mobileController.text.trim();
          final String nationality = state.nationalityController.text.trim();
          final String dateOfBirth = state.dateOfBirthController.text.trim();
          final String referralCode = state.referralCodeController.text.trim();
          final String password = state.passwordController.text.trim();
          final String gender = state.selectedGender ?? '';
          
          // Create form data model
          final SignUpFormDataModel formData = SignUpFormDataModel(
            fullName: fullName,
            mobileNumber: mobileNumber,
            mobileNumberPrefix: state.mobilePrefix,
            email: email,
            nationality: nationality,
            dateOfBirth: dateOfBirth,
            referralCode: referralCode,
            password: password,
            gender: gender,
            deviceId: getDeviceId(),
          );
          
          // Extract OTP from success message
          final String? extractedOtp = OtpExtractor.extractOtpFromMessage(successResponse.response.message);
          
          emit(state.copyWith(
            status: BaseStateStatus.success,
            successMsg: successResponse.response.message,
            redirectRoute: VerifyOtpRoute(
              email: mobileNumber,
              prefix: state.mobilePrefix.substring(1),
              formData: formData,
              flowType: OtpFlowType.signup,
              autoFilledOtp: extractedOtp,
              redirectRoute: LoginRoute(),
            ),
          ));
        } else {
          // API returned success=false with error message
          final String errorMessage = successResponse?.response.message ?? 'Something went wrong';
          emit(state.copyWith(
            status: BaseStateStatus.failure,
            msg: errorMessage,
            showDefaultErrMsg: false, // Changed to false to use the specific error message
          ));
        }
      } else {
        // Network or other failure
        final OnFailureResponse<BaseResponse<void>>? failureResponse = response.getFailureInstance();
        final String errorMessage = failureResponse?.error?.errorMessage ?? 'Network error occurred';
        emit(state.copyWith(
          status: BaseStateStatus.failure,
          msg: errorMessage,
          showDefaultErrMsg: false, // Changed to false to use the specific error message
        ));
      }
    } on Exception catch (e) {
      DebugLog.instance.e(e.toString());
      emit(state.copyWith(
        status: BaseStateStatus.failure,
        msg: 'Network error occurred',
        showDefaultErrMsg: true,
      ));
    }
  }

  /// Sets the [countryCode] for the signup form.
  /// If the code is empty, the default country code is used.
  void setCountryCode(String countryCode) {
    emit(state.copyWith(
      mobilePrefix: countryCode.isEmpty
          ? AppConstant.defaultCountryCode
          : countryCode,
      status: BaseStateStatus.initial,
    ));
  }

  /// Moves focus to the [nextFocusNode] in the form.
  void moveToNextField(FocusNode nextFocusNode) {
    nextFocusNode.requestFocus();
  }

  /// Toggles the visibility of the password field.
  void togglePassObscureText() {
    emit(state.copyWith(
      passwordObscureText: !state.passwordObscureText,
      status: BaseStateStatus.initial,
    ));
  }

  /// Tracks the screen width for API usage and stores it in state.
  void trackScreenWidth(String screenWidth) {
    emit(state.copyWith(
      screenWidth: screenWidth,
      status: BaseStateStatus.initial,
    ));
  }

  /// Tracks whether the signup is via social authentication.
  void trackSocialAuth({required bool isSocial}) {
    emit(state.copyWith(isSocial: isSocial, status: BaseStateStatus.initial));
  }

  /// Updates the state of the terms and conditions checkbox.
  void toggleCheckbox({required bool value}) {
    emit(state.copyWith(isChecked: value, status: BaseStateStatus.initial));
  }

  /// Updates the nationality field and optionally toggles the nationality menu.
  void updateNationality(String value, {bool? isMenuOpen}) {
    state.nationalityController.text = value;
    emit(state.copyWith(isMenuOpen: isMenuOpen));
  }

  /// Updates the date of birth field.
  void updateDateOfBirth(String value) {
    state.dateOfBirthController.text = value;
  }

  /// Updates the validation error message for the fulcontext
  //                 .read<SignupCubit>()
  //                 .handleValidationErrorMessageForDateOfBirth("");
  //             final String? formattedDate = await pickDate(context);
  //             if (formattedDate != null) {
  //               if(context.mounted) {
  //                 context.read<SignupCubit>().updateDateOfBirth(formattedDate);
  //               }
  //             }l name field.
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

  /// Updates the validation error message for the nationality field
  /// and optionally toggles the nationality menu.
  void handleValidationErrorMessageForNationality(String value, {bool? isMenuOpen}) {
    emit(state.copyWith(nationalityErrorMessage: value, isMenuOpen: isMenuOpen));
  }

  /// Updates the validation error message for the password field.
  void handleValidationErrorMessageForPassword(String value) {
    emit(state.copyWith(passwordErrorMessage: value));
  }

  /// Updates the validation error message for the terms & conditions checkbox.
  void handleValidationErrorMessageForTermCondition(String value) {
    emit(state.copyWith(msg: value));
  }

  /// Updates the validation error message for the date of birth field.
  void handleValidationErrorMessageForDateOfBirth(String value) {
    emit(state.copyWith(dateOfBirthErrorMessage: value));
  }

  /// Updates the selected gender in the form state.
  void updateSelectedGender(String? gender) {
    emit(state.copyWith(selectedGender: gender));
  }

  /// Updates the validation error message for the gender field.
  void handleValidationErrorMessageForGender(String? value) {
    emit(state.copyWith(genderErrorMessage: value));
  }
}
