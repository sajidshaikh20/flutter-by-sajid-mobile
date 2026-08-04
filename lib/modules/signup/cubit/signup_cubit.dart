import 'package:image_picker/image_picker.dart';
import 'package:file_picker/file_picker.dart' as fp;
import '../../../utils/exports.dart';

/// Cubit for sign up multi-step flow.
class SignUpCubit extends Cubit<SignUpState> {
  /// Creates [SignUpCubit].
  SignUpCubit({
    required this.repository,
    required SignUpState initialState,
  }) : super(initialState);

  /// SignUp repository.
  final SignUpRepository repository;

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
    final String cleanDialCode = (country.dialCode ?? '+91').replaceAll(RegExp(r'[^\d+]'), '').trim();
    emit(
      state.copyWith(
        countryDialCode: cleanDialCode,
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
    final String dialCode = state.countryDialCode.replaceAll(RegExp(r'[^\d+]'), '').trim();

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
    final String cleanDialCode = dialCode.replaceAll(RegExp(r'[^\d+]'), '').trim();
    switch (cleanDialCode) {
      case '+91':
      case '91':
        return 10;
      case '+965':
      case '965':
        return 8;
      case '+971':
      case '971':
        return 9;
      case '+966':
      case '966':
        return 9;
      case '+1':
      case '1':
        return 10;
      case '+974':
      case '974':
        return 8;
      case '+973':
      case '973':
        return 8;
      case '+968':
      case '968':
        return 8;
      case '+44':
      case '44':
        return 10;
      default:
        return null;
    }
  }

  /// Sends email OTP.
  Future<void> sendEmailOtp(BuildContext context) async {
    if (!_validateEmailForOtp(context)) {
      return;
    }
    final String defaultMsg = context.appString.signUpOtpSentEmailKey;
    try {
      emit(state.copyWith(status: BaseStateStatus.loading));
      final ResponseHandler<BaseResponse<SignUpResponse>> response =
          await repository.startRegistration(
        StartRegistrationRequest(
          name: state.fullName,
          email: state.email,
          role: state.accountType,
        ),
      );

      if (response.isSuccess()) {
        final BaseResponse<SignUpResponse>? baseResponse =
            response.getSuccessInstance()?.response;
        if (baseResponse != null && baseResponse.success) {
          emit(
            state.copyWith(
              showEmailOtpField: true,
              emailOtp: '',
              emailOtpErrorMessage: '',
              msg: baseResponse.message.isNotEmpty
                  ? baseResponse.message
                  : defaultMsg,
              status: BaseStateStatus.success,
            ),
          );
          _startEmailResendTimer();
        } else {
          emit(state.copyWith(
            status: BaseStateStatus.failure,
            msg: baseResponse?.message ?? 'Failed to send verification email.',
          ));
        }
      } else {
        final String? errorMsg =
            response.getFailureInstance()?.error?.errorMessage;
        emit(state.copyWith(
          status: BaseStateStatus.failure,
          msg: errorMsg ?? 'Failed to send verification email.',
        ));
      }
    } on Exception {
      emit(state.copyWith(
        status: BaseStateStatus.failure,
        msg: 'An error occurred while sending OTP.',
      ));
    }
  }

  /// Sends phone OTP.
  Future<void> sendPhoneOtp(BuildContext context) async {
    if (!_validatePhoneForOtp(context)) {
      return;
    }
    final String defaultMsg = context.appString.signUpOtpSentPhoneKey;
    try {
      emit(state.copyWith(status: BaseStateStatus.loading));
      final ResponseHandler<BaseResponse<SignUpResponse>> response =
          await repository.sendPhoneOtp(
        SendPhoneOtpRequest(
          email: state.email,
          countryCode: state.countryDialCode,
          phone: state.phoneController.text.trim(),
        ),
      );

      if (response.isSuccess()) {
        final BaseResponse<SignUpResponse>? baseResponse =
            response.getSuccessInstance()?.response;
        if (baseResponse != null && baseResponse.success) {
          emit(
            state.copyWith(
              showPhoneOtpField: true,
              phoneOtp: '',
              phoneOtpErrorMessage: '',
              msg: baseResponse.message.isNotEmpty
                  ? baseResponse.message
                  : defaultMsg,
              status: BaseStateStatus.success,
            ),
          );
          _startPhoneResendTimer();
        } else {
          emit(state.copyWith(
            status: BaseStateStatus.failure,
            msg: baseResponse?.message ?? 'Failed to send phone OTP.',
          ));
        }
      } else {
        final String? errorMsg =
            response.getFailureInstance()?.error?.errorMessage;
        emit(state.copyWith(
          status: BaseStateStatus.failure,
          msg: errorMsg ?? 'Failed to send phone OTP.',
        ));
      }
    } on Exception {
      emit(state.copyWith(
        status: BaseStateStatus.failure,
        msg: 'An error occurred while sending phone OTP.',
      ));
    }
  }

  /// Verifies email OTP.
  Future<void> verifyEmailOtp(BuildContext context) async {
    final String? error = _validateOtp(state.emailOtp, context.appString);
    if (error != null) {
      setEmailOtpError(error);
      return;
    }
    final String defaultMsg = context.appString.signUpEmailVerifiedSuccessKey;
    try {
      emit(state.copyWith(status: BaseStateStatus.loading));
      final ResponseHandler<BaseResponse<SignUpResponse>> response =
          await repository.verifyEmailOtp(
        VerifyEmailOtpRequest(
          email: state.email,
          otp: state.emailOtp,
        ),
      );

      if (response.isSuccess()) {
        final BaseResponse<SignUpResponse>? baseResponse =
            response.getSuccessInstance()?.response;
        if (baseResponse != null && baseResponse.success) {
          _stopEmailResendTimer(resetSeconds: true);
          emit(
            state.copyWith(
              isEmailVerified: true,
              showEmailOtpField: false,
              emailOtp: '',
              emailOtpErrorMessage: '',
              status: BaseStateStatus.success,
              msg: baseResponse.message.isNotEmpty
                  ? baseResponse.message
                  : defaultMsg,
            ),
          );
        } else {
          emit(state.copyWith(
            status: BaseStateStatus.failure,
            emailOtpErrorMessage: baseResponse?.message ?? 'Invalid OTP code.',
          ));
        }
      } else {
        final String? errorMsg =
            response.getFailureInstance()?.error?.errorMessage;
        emit(state.copyWith(
          status: BaseStateStatus.failure,
          emailOtpErrorMessage: errorMsg ?? 'Invalid OTP code.',
        ));
      }
    } on Exception {
      emit(state.copyWith(
        status: BaseStateStatus.failure,
        msg: 'An error occurred during verification.',
      ));
    }
  }

  /// Verifies phone OTP.
  Future<void> verifyPhoneOtp(BuildContext context) async {
    final String? error = _validateOtp(state.phoneOtp, context.appString);
    if (error != null) {
      setPhoneOtpError(error);
      return;
    }
    final String defaultMsg = context.appString.signUpPhoneVerifiedSuccessKey;
    try {
      emit(state.copyWith(status: BaseStateStatus.loading));
      final ResponseHandler<BaseResponse<SignUpResponse>> response =
          await repository.verifyPhoneOtp(
        VerifyPhoneOtpRequest(
          email: state.email,
          countryCode: state.countryDialCode,
          phone: state.phoneController.text.trim(),
          otp: state.phoneOtp,
        ),
      );

      if (response.isSuccess()) {
        final BaseResponse<SignUpResponse>? baseResponse =
            response.getSuccessInstance()?.response;
        if (baseResponse != null && baseResponse.success) {
          _stopPhoneResendTimer(resetSeconds: true);
          emit(
            state.copyWith(
              isPhoneVerified: true,
              showPhoneOtpField: false,
              phoneOtp: '',
              phoneOtpErrorMessage: '',
              status: BaseStateStatus.success,
              msg: baseResponse.message.isNotEmpty
                  ? baseResponse.message
                  : defaultMsg,
            ),
          );
        } else {
          emit(state.copyWith(
            status: BaseStateStatus.failure,
            phoneOtpErrorMessage: baseResponse?.message ?? 'Invalid OTP code.',
          ));
        }
      } else {
        final String? errorMsg =
            response.getFailureInstance()?.error?.errorMessage;
        emit(state.copyWith(
          status: BaseStateStatus.failure,
          phoneOtpErrorMessage: errorMsg ?? 'Invalid OTP code.',
        ));
      }
    } on Exception {
      emit(state.copyWith(
        status: BaseStateStatus.failure,
        msg: 'An error occurred during phone verification.',
      ));
    }
  }

  /// Resend email OTP.
  Future<void> resendEmailOtp(BuildContext context) async {
    if (!state.canResendEmailOtp) {
      return;
    }
    await sendEmailOtp(context);
  }

  /// Resend phone OTP.
  Future<void> resendPhoneOtp(BuildContext context) async {
    if (!state.canResendPhoneOtp) {
      return;
    }
    await sendPhoneOtp(context);
  }

  /// Completes user registration.
  Future<void> registerUser(BuildContext context) async {
    if (state.accountType == UserRole.trader) {
      if (!validateTraderProfile(context)) {
        return;
      }
    }
    final String defaultMsg = context.appString.signUpRegistrationCompleteKey;
    try {
      emit(state.copyWith(status: BaseStateStatus.loading));

      double? experience;
      String? bio;
      if (state.accountType == UserRole.trader) {
        final String exp = state.tradingExperience;
        if (exp.contains('0-1')) {
          experience = 0.5;
        } else if (exp.contains('1-3')) {
          experience = 2.0;
        } else if (exp.contains('3-5')) {
          experience = 4.0;
        } else if (exp.contains('5+')) {
          experience = 6.0;
        }
        bio = state.strategyDescriptionController.text.trim();
        if (bio.isEmpty) {
          bio = 'Forex Trader';
        }
      }

      final String fcmToken = await NotificationManager.instance.getOrRefreshFCMToken() ?? '';

      final ResponseHandler<BaseResponse<SignUpResponse>> response =
          await repository.completeRegistration(
        CompleteRegistrationRequest(
          email: state.email,
          username: state.usernameController.text.trim(),
          password: state.passwordController.text.trim(),
          experience: experience,
          bio: bio,
          fcmToken: fcmToken,
          deviceType: DeviceInfoHelper.getDeviceType(),
          deviceId: DeviceInfoHelper.getDeviceId(),
          platform: DeviceInfoHelper.getPlatform(),
          appVersion: DeviceInfoHelper.getAppVersion(),
        ),
      );

      if (response.isSuccess()) {
        final BaseResponse<SignUpResponse>? baseResponse =
            response.getSuccessInstance()?.response;
        if (baseResponse != null && baseResponse.success) {
          await SharedPref.instance.setValue(PrefsKey.isRegisteredKey, true);
          emit(state.copyWith(
            status: BaseStateStatus.success,
            msg: baseResponse.message.isNotEmpty
                ? baseResponse.message
                : defaultMsg,
          ));
        } else {
          emit(state.copyWith(
            status: BaseStateStatus.failure,
            msg: baseResponse?.message ?? 'Failed to complete registration.',
          ));
        }
      } else {
        final String? errorMsg =
            response.getFailureInstance()?.error?.errorMessage;
        emit(state.copyWith(
          status: BaseStateStatus.failure,
          msg: errorMsg ?? 'Failed to complete registration.',
        ));
      }
    } on Exception {
      emit(state.copyWith(
        status: BaseStateStatus.failure,
        msg: 'An error occurred during registration.',
      ));
    }
  }

  bool tryProceedFromCurrentStep(BuildContext context) {
    switch (state.currentStep) {
      case 0:
        return validateBasicInfo(context);
      case 1:
        return validateVerificationStep(context);
      case 2:
        return validateCompleteProfile(context);
      case 3:
        return validateTraderProfile(context);
      default:
        return true;
    }
  }

  // Setters for Trader Questionnaire & Social fields
  void setAccountType(UserRole type) {
    emit(state.copyWith(
      accountType: type,
      totalSteps: type == UserRole.client ? signUpSocialTotalSteps : signUpTraderTotalSteps,
      currentStep: state.currentStep,
    ));
  }

  void setTradingExperience(String value) {
    emit(state.copyWith(tradingExperience: value));
  }

  void setProfessionallyTraded(bool value) {
    emit(state.copyWith(professionallyTraded: value));
  }

  void toggleMarketTraded(String market) {
    final List<String> currentMarkets = List<String>.from(state.marketsTraded);
    if (currentMarkets.contains(market)) {
      currentMarkets.remove(market);
    } else {
      currentMarkets.add(market);
    }
    emit(state.copyWith(marketsTraded: currentMarkets));
  }

  void setTradingStyle(String value) {
    emit(state.copyWith(tradingStyle: value));
  }

  void setFundedAccountExperience(bool value) {
    emit(state.copyWith(fundedAccountExperience: value));
  }

  void setPassedFundedChallenge(bool value) {
    emit(state.copyWith(passedFundedChallenge: value));
  }

  void setMaintainTradingJournal(bool value) {
    emit(state.copyWith(maintainTradingJournal: value));
  }

  void setInternetBackup(bool value) {
    emit(state.copyWith(internetBackup: value));
  }

  void setUseVps(bool value) {
    emit(state.copyWith(useVps: value));
  }

  void setGovernmentIdSubmitted(bool value) {
    emit(state.copyWith(governmentIdSubmitted: value));
  }

  void setTradingStatementSubmitted(bool value) {
    emit(state.copyWith(tradingStatementSubmitted: value));
  }

  void setMyfxbookVerified(bool value) {
    emit(state.copyWith(myfxbookVerified: value));
  }

  void setFxblueVerified(bool value) {
    emit(state.copyWith(fxblueVerified: value));
  }

  void setBrokerStatementAttached(bool value) {
    emit(state.copyWith(brokerStatementAttached: value));
  }

  void setDeclarationConfirmed(bool value) {
    emit(state.copyWith(declarationConfirmed: value));
  }

  void autofillTraderProfile() {
    state.previousFirmController.text = 'Apex Trading Capital';
    state.primaryInstrumentsController.text = 'EURUSD, GBPUSD, Gold';
    state.preferredCurrencyPairsController.text = 'EURUSD, GBPUSD';
    state.averageTradesPerDayController.text = '5';
    state.preferredTimeframesController.text = '15m, 1h';
    state.preferredSessionsController.text = 'London, New York';
    state.strategyDescriptionController.text = 'Applying ICT concepts with liquidity sweeps and fair value gaps.';
    state.primaryEdgeController.text = 'High discipline, execution, and risk management.';
    state.indicatorsToolsController.text = 'Fibers, Pivot Points';
    state.averageRiskPerTradeController.text = '1%';
    state.riskRewardRatioController.text = '1:2';
    state.maxDailyDrawdownController.text = '3%';
    state.maxOverallDrawdownController.text = '6%';
    state.useStopLossesController.text = 'Yes, always at swing highs/lows.';
    state.averageMonthlyReturnController.text = '8%';
    state.averageWinRateController.text = '55%';
    state.largestWinningMonthController.text = '14%';
    state.largestLosingMonthController.text = '-4%';
    state.currentAccountSizeController.text = '10000';
    state.largestAccountManagedController.text = '100000';
    state.propFirmsWorkedController.text = 'FTMO, FundedNext';
    state.accountSizesPassedController.text = '100k';
    state.handlingLosingStreaksController.text = 'Lower lot size by 50% or take a break.';
    state.biggestWeaknessController.text = 'FOMO on news days.';
    state.biggestStrengthController.text = 'Cut losses quickly.';
    state.tradingPlatformController.text = 'MT5';
    state.brokersUsedController.text = 'IC Markets';
    state.performanceTrackingLinksController.text = 'https://www.myfxbook.com/members/demo';
    state.additionalNotesController.text = 'Looking forward to joining the elite pool.';
    state.instagramHandleController.text = 'https://instagram.com/trader_demo';
    state.twitterHandleController.text = 'https://x.com/trader_demo';
    state.traderSignatureController.text = state.fullName.isNotEmpty ? state.fullName : 'Sajid Shaikh';

    emit(state.copyWith(
      tradingExperience: '3-5 Years',
      professionallyTraded: true,
      marketsTraded: <String>['Forex', 'Crypto'],
      tradingStyle: 'Day Trading',
      fundedAccountExperience: true,
      passedFundedChallenge: true,
      maintainTradingJournal: true,
      internetBackup: true,
      useVps: true,
      myfxbookVerified: true,
      fxblueVerified: false,
      governmentIdPath: '/mock/government_id.pdf',
      bankStatementPath: '/mock/bank_statement.pdf',
      tradingCertificatePath: '/mock/trading_certificate.pdf',
      declarationConfirmed: true,
    ));
  }

  // Document file pickers
  Future<void> pickGovernmentId() async {
    try {
      final fp.FilePickerResult? result = await fp.FilePicker.platform.pickFiles(
        type: fp.FileType.custom,
        allowedExtensions: <String>['pdf'],
      );
      if (result != null && result.files.single.path != null) {
        final fp.PlatformFile file = result.files.single;
        // 1 MB is 1024 * 1024 bytes
        if (file.size > 1024 * 1024) {
          emit(state.copyWith(msg: 'File size exceeds the 1MB limit. Please upload a smaller PDF.'));
          return;
        }
        emit(state.copyWith(governmentIdPath: file.path, governmentIdSubmitted: true));
      }
    } on Exception catch (e) {
      emit(state.copyWith(msg: 'Failed to pick PDF file: $e'));
    }
  }

  Future<void> pickBankStatement() async {
    try {
      final fp.FilePickerResult? result = await fp.FilePicker.platform.pickFiles(
        type: fp.FileType.custom,
        allowedExtensions: <String>['pdf'],
      );
      if (result != null && result.files.single.path != null) {
        final fp.PlatformFile file = result.files.single;
        // 1 MB is 1024 * 1024 bytes
        if (file.size > 1024 * 1024) {
          emit(state.copyWith(msg: 'File size exceeds the 1MB limit. Please upload a smaller PDF.'));
          return;
        }
        emit(state.copyWith(bankStatementPath: file.path, brokerStatementAttached: true));
      }
    } on Exception catch (e) {
      emit(state.copyWith(msg: 'Failed to pick PDF file: $e'));
    }
  }

  Future<void> pickTradingCertificate() async {
    try {
      final fp.FilePickerResult? result = await fp.FilePicker.platform.pickFiles(
        type: fp.FileType.custom,
        allowedExtensions: <String>['pdf'],
      );
      if (result != null && result.files.single.path != null) {
        final fp.PlatformFile file = result.files.single;
        // 1 MB is 1024 * 1024 bytes
        if (file.size > 1024 * 1024) {
          emit(state.copyWith(msg: 'File size exceeds the 1MB limit. Please upload a smaller PDF.'));
          return;
        }
        emit(state.copyWith(tradingCertificatePath: file.path, tradingStatementSubmitted: true));
      }
    } on Exception catch (e) {
      emit(state.copyWith(msg: 'Failed to pick PDF file: $e'));
    }
  }

  // Build the complete questionnaire model for submission
  SignUpQuestionnaireModel _buildQuestionnaireModel() {
    return SignUpQuestionnaireModel(
      accountType: state.accountType.value,
      tradingExperience: state.tradingExperience,
      professionallyTraded: state.professionallyTraded,
      previousFirm: state.previousFirmController.text.trim(),
      marketsTraded: state.marketsTraded,
      primaryInstruments: state.primaryInstrumentsController.text.trim(),
      preferredCurrencyPairs: state.preferredCurrencyPairsController.text.trim(),
      tradingStyle: state.tradingStyle,
      averageTradesPerDay: state.averageTradesPerDayController.text.trim(),
      preferredTimeframes: state.preferredTimeframesController.text.trim(),
      preferredSessions: state.preferredSessionsController.text.trim(),
      strategyDescription: state.strategyDescriptionController.text.trim(),
      primaryEdge: state.primaryEdgeController.text.trim(),
      indicatorsTools: state.indicatorsToolsController.text.trim(),
      averageRiskPerTrade: state.averageRiskPerTradeController.text.trim(),
      riskRewardRatio: state.riskRewardRatioController.text.trim(),
      maxDailyDrawdown: state.maxDailyDrawdownController.text.trim(),
      maxOverallDrawdown: state.maxOverallDrawdownController.text.trim(),
      useStopLosses: state.useStopLossesController.text.trim(),
      averageMonthlyReturn: state.averageMonthlyReturnController.text.trim(),
      averageWinRate: state.averageWinRateController.text.trim(),
      largestWinningMonth: state.largestWinningMonthController.text.trim(),
      largestLosingMonth: state.largestLosingMonthController.text.trim(),
      currentAccountSize: state.currentAccountSizeController.text.trim(),
      largestAccountManaged: state.largestAccountManagedController.text.trim(),
      fundedAccountExperience: state.fundedAccountExperience,
      propFirmsWorked: state.propFirmsWorkedController.text.trim(),
      passedFundedChallenge: state.passedFundedChallenge,
      accountSizesPassed: state.accountSizesPassedController.text.trim(),
      handlingLosingStreaks: state.handlingLosingStreaksController.text.trim(),
      biggestWeakness: state.biggestWeaknessController.text.trim(),
      biggestStrength: state.biggestStrengthController.text.trim(),
      maintainTradingJournal: state.maintainTradingJournal,
      tradingPlatform: state.tradingPlatformController.text.trim(),
      brokersUsed: state.brokersUsedController.text.trim(),
      internetBackup: state.internetBackup,
      useVps: state.useVps,
      governmentIdSubmitted: state.governmentIdPath != null,
      tradingStatementSubmitted: state.tradingCertificatePath != null,
      myfxbookVerified: state.myfxbookVerified,
      fxblueVerified: state.fxblueVerified,
      brokerStatementAttached: state.bankStatementPath != null,
      performanceTrackingLinks: state.performanceTrackingLinksController.text.trim(),
      additionalNotes: state.additionalNotesController.text.trim(),
      instagramHandle: state.instagramHandleController.text.trim(),
      twitterHandle: state.twitterHandleController.text.trim(),
      governmentId: state.governmentIdPath,
      bankStatement: state.bankStatementPath,
      tradingCertificate: state.tradingCertificatePath,
      traderSignature: state.traderSignatureController.text.trim(),
      declarationConfirmed: state.declarationConfirmed,
    );
  }

  // Validations for questionnaire steps
  bool validateTraderProfile(BuildContext context) {
    if (state.tradingExperience.isEmpty) {
      emit(state.copyWith(msg: 'Please select trading experience.'));
      return false;
    }
    if (state.previousFirmController.text.trim().isEmpty) {
      emit(state.copyWith(msg: 'Please enter previous firm/company name.'));
      return false;
    }
    if (state.marketsTraded.isEmpty) {
      emit(state.copyWith(msg: 'Please select at least one market traded.'));
      return false;
    }
    if (state.primaryInstrumentsController.text.trim().isEmpty) {
      emit(state.copyWith(msg: 'Please enter primary instruments.'));
      return false;
    }
    if (state.preferredCurrencyPairsController.text.trim().isEmpty) {
      emit(state.copyWith(msg: 'Please enter preferred currency pairs.'));
      return false;
    }
    if (state.tradingStyle.isEmpty) {
      emit(state.copyWith(msg: 'Please select a trading style.'));
      return false;
    }

    final String strategyDesc = state.strategyDescriptionController.text.trim();
    if (strategyDesc.length < 20 || strategyDesc.length > 500) {
      emit(state.copyWith(msg: 'Strategy description must be between 20 and 500 characters.'));
      return false;
    }
    final Map<String, TextEditingController> fieldsToCheck = <String, TextEditingController>{
      'averageTradesPerDay': state.averageTradesPerDayController,
      'preferredTimeframes': state.preferredTimeframesController,
      'preferredSessions': state.preferredSessionsController,
      'primaryEdge': state.primaryEdgeController,
      'indicatorsTools': state.indicatorsToolsController,
      'tradingPlatform': state.tradingPlatformController,
      'brokersUsed': state.brokersUsedController,
      'averageRiskPerTrade': state.averageRiskPerTradeController,
      'riskRewardRatio': state.riskRewardRatioController,
      'maxDailyDrawdown': state.maxDailyDrawdownController,
      'maxOverallDrawdown': state.maxOverallDrawdownController,
      'useStopLosses': state.useStopLossesController,
      'averageMonthlyReturn': state.averageMonthlyReturnController,
      'averageWinRate': state.averageWinRateController,
      'largestWinningMonth': state.largestWinningMonthController,
      'largestLosingMonth': state.largestLosingMonthController,
      'currentAccountSize': state.currentAccountSizeController,
      'largestAccountManaged': state.largestAccountManagedController,
      'propFirmsWorked': state.propFirmsWorkedController,
      'accountSizesPassed': state.accountSizesPassedController,
      'handlingLosingStreaks': state.handlingLosingStreaksController,
      'biggestWeakness': state.biggestWeaknessController,
      'biggestStrength': state.biggestStrengthController,
    };
    for (final MapEntry<String, TextEditingController> entry in fieldsToCheck.entries) {
      if (entry.value.text.trim().isEmpty) {
        emit(state.copyWith(msg: 'Please fill out all strategy and performance fields.'));
        return false;
      }
    }

    final String links = state.performanceTrackingLinksController.text.trim();
    if (links.isEmpty || !RegExpressions.instance.performanceUrl.hasMatch(links)) {
      emit(state.copyWith(msg: 'Please enter a valid performance tracking URL.'));
      return false;
    }
    if (state.additionalNotesController.text.trim().length > 1000) {
      emit(state.copyWith(msg: 'Additional notes cannot exceed 1000 characters.'));
      return false;
    }
    if (state.governmentIdPath == null) {
      emit(state.copyWith(msg: 'Please upload your Government ID.'));
      return false;
    }
    if (state.traderSignatureController.text.trim().isEmpty) {
      emit(state.copyWith(msg: 'Please enter your signature.'));
      return false;
    }
    if (!state.declarationConfirmed) {
      emit(state.copyWith(msg: 'You must confirm the declaration to proceed.'));
      return false;
    }
    return true;
  }

  bool validateSocialProfile(BuildContext context) {
    final String links = state.performanceTrackingLinksController.text.trim();
    if (links.isEmpty || !RegExpressions.instance.performanceUrl.hasMatch(links)) {
      emit(state.copyWith(msg: 'Please enter a valid performance tracking URL.'));
      return false;
    }
    final String insta = state.instagramHandleController.text.trim();
    if (insta.isNotEmpty && !RegExpressions.instance.instagramUrl.hasMatch(insta)) {
      emit(state.copyWith(msg: 'Please enter a valid Instagram URL.'));
      return false;
    }
    final String twitter = state.twitterHandleController.text.trim();
    if (twitter.isNotEmpty && !RegExpressions.instance.twitterUrl.hasMatch(twitter)) {
      emit(state.copyWith(msg: 'Please enter a valid Twitter/X URL.'));
      return false;
    }
    if (state.governmentIdPath == null) {
      emit(state.copyWith(msg: 'Please upload your Government ID.'));
      return false;
    }
    if (state.traderSignatureController.text.trim().isEmpty) {
      emit(state.copyWith(msg: 'Please enter your signature.'));
      return false;
    }
    if (!state.declarationConfirmed) {
      emit(state.copyWith(msg: 'You must confirm the declaration to proceed.'));
      return false;
    }
    return true;
  }
}
