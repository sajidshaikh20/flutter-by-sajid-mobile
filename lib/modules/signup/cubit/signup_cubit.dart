import '../../../utils/exports.dart';

/// Cubit for sign up multi-step flow.
class SignUpCubit extends Cubit<SignUpState> {
  /// Creates [SignUpCubit].
  SignUpCubit({required SignUpState initialState}) : super(initialState);

  Timer? _emailResendTimer;
  Timer? _phoneResendTimer;

  /// Updates the active step index.
  void setStep(int step) {
    if (step < 0 || step >= state.totalSteps) {
      return;
    }
        if (step == 0) {
      _stopEmailResendTimer(resetSeconds: true);
      _stopPhoneResendTimer(resetSeconds: true);
      emit(
        state.copyWith(
          currentStep: step,
          status: BaseStateStatus.initial,
          isEmailVerified: false,
          isPhoneVerified: false,
          showEmailOtpField: false,
          showPhoneOtpField: false,
          emailOtp: '',
          phoneOtp: '',
          emailOtpErrorMessage: '',
          phoneOtpErrorMessage: '',
          phoneErrorMessage: '',
        ),
      );
      return;
    }
    emit(state.copyWith(currentStep: step, status: BaseStateStatus.initial));
  }

  bool get canGoPrevious => state.currentStep > 0;

  bool get isLastStep => state.currentStep == state.totalSteps - 1;

  bool get canProceedFromVerification =>
      state.isEmailVerified && state.isPhoneVerified;

  /// Whether sticky Next/Finish should be tappable.
  bool isNextEnabled() {
    if (state.currentStep == 1) {
      return canProceedFromVerification;
    }
    return true;
  }

  void updateCountryCode(CountryCode country) {
    emit(
      state.copyWith(
        countryDialCode: country.dialCode ?? '+91',
        countryIsoCode: country.code ?? 'IN',
        phoneErrorMessage: '',
      ),
    );
  }

  void setFullNameError(String value) =>
      emit(state.copyWith(fullNameErrorMessage: value));

  void setEmailError(String value) =>
      emit(state.copyWith(emailErrorMessage: value));

  void setPhoneError(String value) =>
      emit(state.copyWith(phoneErrorMessage: value));

  void setEmailOtpError(String value) =>
      emit(state.copyWith(emailOtpErrorMessage: value));

  void setPhoneOtpError(String value) =>
      emit(state.copyWith(phoneOtpErrorMessage: value));

  void setEmailOtp(String value) =>
      emit(state.copyWith(emailOtp: value, emailOtpErrorMessage: ''));

  void setPhoneOtp(String value) =>
      emit(state.copyWith(phoneOtp: value, phoneOtpErrorMessage: ''));

  void setUsernameError(String value) =>
      emit(state.copyWith(usernameErrorMessage: value));

  void setPasswordError(String value) =>
      emit(state.copyWith(passwordErrorMessage: value));

  void setConfirmPasswordError(String value) =>
      emit(state.copyWith(confirmPasswordErrorMessage: value));

  /// Clears one-shot feedback message after it has been shown.
  void clearMsg() {
    if (state.msg?.isNotEmpty ?? false) {
      emit(state.copyWith(msg: ''));
    }
  }

  void togglePasswordObscureText() {
    emit(state.copyWith(passwordObscureText: !state.passwordObscureText));
  }

  void toggleConfirmPasswordObscureText() {
    emit(
      state.copyWith(
        confirmPasswordObscureText: !state.confirmPasswordObscureText,
      ),
    );
  }

  void moveToNextField(FocusNode nextFocusNode) {
    nextFocusNode.requestFocus();
  }

  void _startEmailResendTimer() {
    _emailResendTimer?.cancel();
    emit(
      state.copyWith(
        emailResendSecondsRemaining: signUpOtpResendCooldownSeconds,
      ),
    );
    _emailResendTimer = Timer.periodic(const Duration(seconds: 1), (_) {
      _tickEmailResendTimer();
    });
  }

  void _tickEmailResendTimer() {
    final int remaining = state.emailResendSecondsRemaining - 1;
    if (remaining <= 0) {
      _stopEmailResendTimer(resetSeconds: true);
      return;
    }
    emit(state.copyWith(emailResendSecondsRemaining: remaining));
  }

  void _stopEmailResendTimer({bool resetSeconds = false}) {
    _emailResendTimer?.cancel();
    _emailResendTimer = null;
    if (resetSeconds && state.emailResendSecondsRemaining != 0) {
      emit(state.copyWith(emailResendSecondsRemaining: 0));
    }
  }

  void _startPhoneResendTimer() {
    _phoneResendTimer?.cancel();
    emit(
      state.copyWith(
        phoneResendSecondsRemaining: signUpOtpResendCooldownSeconds,
      ),
    );
    _phoneResendTimer = Timer.periodic(const Duration(seconds: 1), (_) {
      _tickPhoneResendTimer();
    });
  }

  void _tickPhoneResendTimer() {
    final int remaining = state.phoneResendSecondsRemaining - 1;
    if (remaining <= 0) {
      _stopPhoneResendTimer(resetSeconds: true);
      return;
    }
    emit(state.copyWith(phoneResendSecondsRemaining: remaining));
  }

  void _stopPhoneResendTimer({bool resetSeconds = false}) {
    _phoneResendTimer?.cancel();
    _phoneResendTimer = null;
    if (resetSeconds && state.phoneResendSecondsRemaining != 0) {
      emit(state.copyWith(phoneResendSecondsRemaining: 0));
    }
  }

  @override
  Future<void> close() {
    _emailResendTimer?.cancel();
    _phoneResendTimer?.cancel();
    return super.close();
  }

  /// Validates basic info (full name + email) before moving to verification.
  bool validateBasicInfo(BuildContext context) {
    final AppString strings = context.appString;
    final String fullName = state.fullName;
    final String email = state.email;
    bool isValid = true;

    if (fullName.isEmpty) {
      setFullNameError(strings.signUpPleaseEnterFullNameKey);
      isValid = false;
    } else if (fullName.length < 2) {
      setFullNameError(strings.signUpPleaseEnterValidFullNameKey);
      isValid = false;
    } else {
      setFullNameError('');
    }

    if (email.isEmpty) {
      setEmailError('${strings.pleaseEnterTheEmailKey}.');
      isValid = false;
    } else {
      final String? emailError = email.validateEmail(
        isOnlyEmail: true,
        enterMobileOrNumberMsg: strings.pleaseEnterTheEmailKey,
        enterEmailMsg: strings.pleaseEnterTheEmailKey,
        validEmailMsg: strings.pleaseEnterValidEmailKey,
      );
      if (emailError?.isNotEmpty ?? false) {
        setEmailError(emailError ?? '');
        isValid = false;
      } else {
        setEmailError('');
      }
    }

    return isValid;
  }

  /// Validates verification step before moving to complete profile.
  bool validateVerificationStep(BuildContext context) {
    if (!state.isEmailVerified) {
      setEmailOtpError(context.appString.signUpVerifyEmailFirstKey);
      return false;
    }
    if (!state.isPhoneVerified) {
      setPhoneOtpError(context.appString.signUpVerifyPhoneFirstKey);
      return false;
    }
    return true;
  }

  /// Validates complete profile before finishing sign up.
  bool validateCompleteProfile(BuildContext context) {
    final AppString strings = context.appString;
    final String username = state.usernameController.text.trim();
    final String password = state.passwordController.text.trim();
    final String confirmPassword = state.confirmPasswordController.text.trim();
    bool isValid = true;

    if (username.isEmpty) {
      setUsernameError(strings.signUpPleaseEnterUsernameKey);
      isValid = false;
    } else if (username.length < 3 || username.contains(' ')) {
      setUsernameError(strings.signUpPleaseEnterValidUsernameKey);
      isValid = false;
    } else {
      setUsernameError('');
    }

    final String? passwordError = password.validatePassword(
      isNewPassword: true,
      emptyPasswordMsg: strings.pleaseEnterThePasswordKey,
      invalidPasswordMsg: strings.passAllCriteriaKey,
    );
    if (passwordError?.isNotEmpty ?? false) {
      setPasswordError(passwordError ?? '');
      isValid = false;
    } else {
      setPasswordError('');
    }

    if (confirmPassword.isEmpty) {
      setConfirmPasswordError(strings.signUpPleaseConfirmPasswordKey);
      isValid = false;
    } else if (confirmPassword != password) {
      setConfirmPasswordError(strings.signUpPasswordsDoNotMatchKey);
      isValid = false;
    } else {
      setConfirmPasswordError('');
    }

    return isValid;
  }

  String? _validateOtp(String otp, AppString strings) {
    if (otp.isEmpty) {
      return strings.signUpPleaseEnterOtpKey;
    }
    if (otp.length != signUpOtpLength ||
        !RegExpressions.instance.onlyNumbersPattern.hasMatch(otp)) {
      return strings.signUpPleaseEnterValidOtpKey;
    }
    return null;
  }

  bool _validateEmailForOtp(BuildContext context) {
    final AppString strings = context.appString;
    final String email = state.email;
    if (email.isEmpty) {
      setEmailError('${strings.pleaseEnterTheEmailKey}.');
      return false;
    }
    final String? emailError = email.validateEmail(
      isOnlyEmail: true,
      enterMobileOrNumberMsg: strings.pleaseEnterTheEmailKey,
      enterEmailMsg: strings.pleaseEnterTheEmailKey,
      validEmailMsg: strings.pleaseEnterValidEmailKey,
    );
    if (emailError?.isNotEmpty ?? false) {
      setEmailError(emailError ?? '');
      return false;
    }
    setEmailError('');
    return true;
  }

  bool _validatePhoneForOtp(BuildContext context) {
    final AppString strings = context.appString;
    final String phone = state.phoneController.text.trim();
    final String dialCode = state.countryDialCode;

    if (phone.isEmpty) {
      setPhoneError(strings.pleaseEnterMobileNumberKey);
      return false;
    }
    if (!RegExpressions.instance.onlyNumbersPattern.hasMatch(phone)) {
      setPhoneError(strings.onlyNumbersAllowedKey);
      return false;
    }

    final int? requiredLength = _requiredPhoneLength(dialCode);
    if (requiredLength != null && phone.length != requiredLength) {
      setPhoneError(strings.enterValidMobileNumberKey);
      return false;
    }
    if (requiredLength == null &&
        (phone.length < 6 || phone.length > 15)) {
      setPhoneError(strings.enterValidMobileNumberKey);
      return false;
    }

    setPhoneError('');
    return true;
  }

  /// Expected local number length for common dial codes.
  int? requiredPhoneLength(String dialCode) =>
      _requiredPhoneLength(dialCode);

  int? _requiredPhoneLength(String dialCode) {
    switch (dialCode) {
      case '+91':
        return 10;
      case '+965':
        return 8;
      case '+971':
        return 9;
      case '+966':
        return 9;
      case '+1':
        return 10;
      default:
        return null;
    }
  }

  /// Sends email OTP — shows pin field (wire API later).
  void sendEmailOtp(BuildContext context) {
    if (!_validateEmailForOtp(context)) {
      return;
    }
    emit(
      state.copyWith(
        showEmailOtpField: true,
        emailOtp: '',
        emailOtpErrorMessage: '',
        msg: context.appString.signUpOtpSentEmailKey,
        status: BaseStateStatus.success,
      ),
    );
    _startEmailResendTimer();
  }

  /// Sends phone OTP — shows pin field (wire API later).
  void sendPhoneOtp(BuildContext context) {
    if (!_validatePhoneForOtp(context)) {
      return;
    }
    emit(
      state.copyWith(
        showPhoneOtpField: true,
        phoneOtp: '',
        phoneOtpErrorMessage: '',
        msg: context.appString.signUpOtpSentPhoneKey,
        status: BaseStateStatus.success,
      ),
    );
    _startPhoneResendTimer();
  }

  /// Verifies email OTP.
  Future<void> verifyEmailOtp(BuildContext context) async {
    final String? error = _validateOtp(state.emailOtp, context.appString);
    if (error != null) {
      setEmailOtpError(error);
      return;
    }
    _stopEmailResendTimer(resetSeconds: true);
    emit(
      state.copyWith(
        isEmailVerified: true,
        showEmailOtpField: false,
        emailOtp: '',
        emailOtpErrorMessage: '',
        status: BaseStateStatus.success,
        msg: context.appString.signUpEmailVerifiedSuccessKey,
      ),
    );
  }

  /// Verifies phone OTP.
  Future<void> verifyPhoneOtp(BuildContext context) async {
    final String? error = _validateOtp(state.phoneOtp, context.appString);
    if (error != null) {
      setPhoneOtpError(error);
      return;
    }
    _stopPhoneResendTimer(resetSeconds: true);
    emit(
      state.copyWith(
        isPhoneVerified: true,
        showPhoneOtpField: false,
        phoneOtp: '',
        phoneOtpErrorMessage: '',
        status: BaseStateStatus.success,
        msg: context.appString.signUpPhoneVerifiedSuccessKey,
      ),
    );
  }

  /// Resend email OTP.
  void resendEmailOtp(BuildContext context) {
    if (!state.canResendEmailOtp) {
      return;
    }
    emit(
      state.copyWith(
        showEmailOtpField: true,
        emailOtp: '',
        emailOtpErrorMessage: '',
        msg: context.appString.signUpOtpResentEmailKey,
        status: BaseStateStatus.success,
      ),
    );
    _startEmailResendTimer();
  }

  /// Resend phone OTP.
  void resendPhoneOtp(BuildContext context) {
    if (!state.canResendPhoneOtp) {
      return;
    }
    emit(
      state.copyWith(
        showPhoneOtpField: true,
        phoneOtp: '',
        phoneOtpErrorMessage: '',
        msg: context.appString.signUpOtpResentPhoneKey,
        status: BaseStateStatus.success,
      ),
    );
    _startPhoneResendTimer();
  }

  /// Attempts to advance from the current step after validation.
  bool tryProceedFromCurrentStep(BuildContext context) {
    switch (state.currentStep) {
      case 0:
        return validateBasicInfo(context);
      case 1:
        return validateVerificationStep(context);
      case 2:
        return validateCompleteProfile(context);
      default:
        return true;
    }
  }
}
