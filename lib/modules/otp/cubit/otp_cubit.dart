import '../../../../utils/exports.dart';

/// Business logic controller for OTP verification and countdown handling.
class OtpCubit extends Cubit<OtpState> {
  /// Key to control the OTP input widget.
  final GlobalKey<OtpPinFieldState> otpPinFieldKey = GlobalKey<OtpPinFieldState>();
  Timer? _timer;
  final VerifyOtpRepository _repository = VerifyOtpRepositoryImpl();

  /// Default constructor
  OtpCubit() : super(const OtpState(secondsRemaining: Dimens.second60)) {
    startTimer();
  }

  /// Factory constructor with flow type and signup data
  factory OtpCubit.withFlow({
    required OtpFlowType flowType,
    SignUpFormDataModel? signupFormData,
    String? autoFilledOtp,
  })
  {
    final OtpCubit cubit = OtpCubit();

    // Set initial flow data using emit
    cubit.emit(cubit.state.copyWith(
      flowType: flowType,
      signupFormData: signupFormData,
      autoFilledOtp: autoFilledOtp,
    ));

    // Auto-fill OTP if provided (extracted from toast message)
    if (autoFilledOtp != null && autoFilledOtp.isNotEmpty) {
      cubit.otpChange(autoFilledOtp);

      /*// Schedule auto-fill after widget is built with a small delay
      WidgetsBinding.instance.addPostFrameCallback((_) {

        Future<void>.delayed(const Duration(milliseconds: 100), () {
          if (cubit.otpPinFieldKey.currentState != null) {
            cubit.setOtp(autoFilledOtp);
          } else {
            // Try again after a longer delay
            Future<void>.delayed(const Duration(milliseconds: 500), () {
              if (cubit.otpPinFieldKey.currentState != null) {
                cubit.setOtp(autoFilledOtp);
              }
            });
          }
        });
      });*/
    }

    return cubit;
  }

  /// Updates the current OTP value in the state.
  void otpChange(String otpNumber) {
    emit(state.copyWith(otpNumber: otpNumber));
  }

  /// Starts the OTP countdown timer and emits each tick.
  void startTimer() {
    Duration countdownDuration = const Duration(seconds: Dimens.second60);
    int remainingSeconds = countdownDuration.inSeconds;
    _timer = Timer.periodic(const Duration(seconds: 1), (Timer timer) {
      remainingSeconds--;
      if (remainingSeconds <= 0) {
        // Don't clear the OTP text field when timer reaches zero
        // Only cancel the timer and update the remaining seconds
        timer.cancel();
      }
      if (!isClosed) {
        emit(state.copyWith(secondsRemaining: remainingSeconds));
      }
    });
  }

  @override
  /// Cancels the internal timer when disposing the cubit.
  Future<void> close() {
    // Cancel the timer before closing the Cubit to avoid emitting after close
    _timer?.cancel();
    return super.close();
  }

  /// Clears any temporary message in the state.
  void clearMessage() {
    if (state.msg?.isNotEmpty ?? false) {
      emit(state.copyWith(msg: ''));
    }
  }

  /// Extracts OTP from a message and auto-fills it
  void extractAndFillOtp(String message) {
    final String? extractedOtp = OtpExtractor.extractOtpFromMessage(message);
    if (extractedOtp != null && extractedOtp.isNotEmpty) {
      otpChange(extractedOtp);
    }
  }

  /// Sets OTP in the widget and state
  void setOtp(String otp) {
    otpChange(otp);

    // Also set in the widget if available
    if (otpPinFieldKey.currentState != null) {
      final OtpPinFieldState state = otpPinFieldKey.currentState!;
      state.controller.text = otp;
      // Update the internal state
      state.pinsInputed.clear();
      for (int i = 0; i < otp.length; i++) {
        state.pinsInputed.add(otp[i]);
      }
      // Fill remaining slots with empty strings
      for (int i = otp.length; i < 4; i++) {
        state.pinsInputed.add('');
      }
      state.ending = otp.length == 4;
    }
  }




  /// Verifies the OTP for the forgot password flow.
  ///
  /// Emits loading, success, or failure states accordingly.
  Future<void> verifyForgotPasswordOtp({
    required String mobileNumber,
    required PageRouteInfo? redirectRoute,
  }) async {
    if (state.otpNumber.length != AppConstant.otpTextLength) {
      return;
    }

    emit(state.copyWith(status: BaseStateStatus.loading));

    try {


      final ForgotPasswordWithMobileRequestModel request =
      ForgotPasswordWithMobileRequestModel(
        platform: getPlatformName(),
        version: getIt<MainConfig>().packageInfo.version,
        websiteId: "1",
        storeId: "2",
        mobileNumber: mobileNumber,
        mobileNumberPrefix: AppConstant.defaultCountryCode,
        sentOtp: AppConstant.zeroStr,
        verifyOtp: AppConstant.oneStr,
        updatePassword: AppConstant.zeroStr,
        languageId: getIt<LanguageService>().languageId,
        otp: state.otpNumber,
      );

      final ResponseHandler<BaseResponse<void>> response =
      await _repository.callverifyOtp(request);

      if (response.isSuccess()) {
        final OnSuccessResponse<BaseResponse<void>>? success =
        response.getSuccessInstance();
        if (success != null && success.response.success) {
          emit(state.copyWith(
            status: BaseStateStatus.success,
            redirectRoute: redirectRoute,
            mobileNumber: mobileNumber,
          ));
        } else {
          emit(state.copyWith(status: BaseStateStatus.failure, msg: success?.response.message ?? ''));
        }
      } else {
        emit(state.copyWith(status: BaseStateStatus.failure, msg: response.getFailureInstance()?.error?.errorMessage ?? ''));
      }
    } on Exception {
      emit(state.copyWith(status: BaseStateStatus.failure));
    }
  }

  /// Verifies the OTP for the signup flow.
  ///
  /// Emits loading, success, or failure states accordingly.
  Future<void> verifySignupOtp({
    required PageRouteInfo? redirectRoute,
  }) async {
    if (state.otpNumber.length != AppConstant.otpTextLength) {
      return;
    }

    if (state.signupFormData == null) {
      emit(state.copyWith(
        status: BaseStateStatus.failure,
        msg: '',
      ));
      return;
    }

    emit(state.copyWith(status: BaseStateStatus.loading));

    try {
      // Convert date format from dd-MM-yyyy to dd/MM/yyyy
      final String formattedDob = convertDateFormatForSignup(state.signupFormData!.dateOfBirth);

      // Try different mobile number formats
      final String mobileNumberWithoutPrefix = state.signupFormData!.mobileNumber;

      final SignupRequestModel request = SignupRequestModel(
        platform: getPlatformName(),
        languageId: int.tryParse(getIt<LanguageService>().languageId) ?? 1,
        version: getIt<MainConfig>().packageInfo.version,
        firstName: state.signupFormData?.fullName??"",
        lastName: state.signupFormData?.fullName??"",
        mobileNumber: mobileNumberWithoutPrefix, // Use original mobile number without prefix
        mobileNumberPrefix: state.signupFormData!.mobileNumberPrefix, // Use original prefix
        email: state.signupFormData!.email,
        Nationality: state.signupFormData!.nationality,
        dob: formattedDob,
        referralCode: state.signupFormData!.referralCode,
        password: state.signupFormData!.password,
        gender: getGenderConstant(state.signupFormData!.gender),
        otp: state.otpNumber,
        deviceId: getDeviceId(),
      );

      final ResponseHandler<BaseResponse<SignupUserResponse>> response =
      await _repository.callSignUpApi(request);

      if (response.isSuccess()) {
        final OnSuccessResponse<BaseResponse<SignupUserResponse>>? success =
        response.getSuccessInstance();

        if (success != null && success.response.success) {
          emit(state.copyWith(
            status: BaseStateStatus.success,
            redirectRoute: redirectRoute,
          ));
        } else {
          emit(state.copyWith(
              status: BaseStateStatus.failure,
              msg: success?.response.message ?? ''
          ));
        }
      } else {
        emit(state.copyWith(
            status: BaseStateStatus.failure,
            msg: response.getFailureInstance()?.error?.errorMessage ?? ''
        ));
      }
    } on Exception {
      emit(state.copyWith(status: BaseStateStatus.failure));
    }
  }

  /// Generic OTP verification method that calls the appropriate API based on flow type
  Future<void> verifyOtp({
    required String mobileNumber,
    PageRouteInfo? redirectRoute,
  }) async {
    switch (state.flowType) {
      case OtpFlowType.forgotPassword:
        await verifyForgotPasswordOtp(
          mobileNumber: mobileNumber,
          redirectRoute: redirectRoute
        );
      case OtpFlowType.signup:
        final PageRouteInfo finalRedirectRoute = redirectRoute ?? LoginRoute();
        await verifySignupOtp(
          redirectRoute: finalRedirectRoute,
        );

      case OtpFlowType.updateEmail:
        final PageRouteInfo finalRedirectRoute = redirectRoute ?? const MyAccountRoute();

    }
  }

  /// Resends the OTP for the appropriate flow based on flow type
  Future<void> resendOtp({
    required String mobileNumber,
    String? email,
  }) async
  {
    if (state.secondsRemaining != 0) {
      return; // Don't allow resend if timer is still running
    }
    emit(state.copyWith(status: BaseStateStatus.loading));

    try {
      switch (state.flowType) {
        case OtpFlowType.forgotPassword:
          await _resendForgotPasswordOtp(mobileNumber);
        case OtpFlowType.signup:
          await _resendSignupOtp(mobileNumber);
        case OtpFlowType.updateEmail:
          await _resendUpdateEmailOtp(email ?? mobileNumber);
      }
    } on Exception {
      emit(state.copyWith(status: BaseStateStatus.failure));
    }
  }

  /// Resends OTP for forgot password flow
  Future<void> _resendForgotPasswordOtp(String mobileNumber) async {
   // final String websiteId = getIt<CountryService>().websiteId;

    final ForgotPasswordWithMobileRequestModel request =
    ForgotPasswordWithMobileRequestModel(
      platform: getPlatformName(),
      version: getIt<MainConfig>().packageInfo.version,
      websiteId: "",
      storeId: "2",
      mobileNumber: mobileNumber,
      mobileNumberPrefix: AppConstant.defaultCountryCode,
      sentOtp: AppConstant.oneStr, // Send OTP
      verifyOtp: AppConstant.zeroStr, // Don't verify
      updatePassword: AppConstant.zeroStr, // Don't update password
      otp: '', // Empty OTP for sending
      languageId: getIt<LanguageService>().languageId,
    );

    final ResponseHandler<BaseResponse<void>> response =
    await _repository.callverifyOtp(request);

    if (response.isSuccess()) {
      final OnSuccessResponse<BaseResponse<void>>? success =
      response.getSuccessInstance();
      if (success != null && success.response.success) {
        // Restart timer on successful resend
        startTimer();
        emit(state.copyWith(
          status: BaseStateStatus.success,
          msg: success.response.message,
        ));
      } else {
        emit(state.copyWith(
          status: BaseStateStatus.failure,
          msg: success?.response.message ?? '',
        ));
      }
    } else {
      emit(state.copyWith(
        status: BaseStateStatus.failure,
        msg: response.getFailureInstance()?.error?.errorMessage ?? '',
      ));
    }
  }

  /// Resends OTP for signup flow
  Future<void> _resendSignupOtp(String mobileNumber) async {
    if (state.signupFormData == null) {
      emit(state.copyWith(
        status: BaseStateStatus.failure,
        msg: '',
      ));
      return;
    }
    final SignUpUserOtpRequestModel request = SignUpUserOtpRequestModel(
      platform: getPlatformName(),
      languageId: int.tryParse(getIt<LanguageService>().languageId) ?? 1,
      mobileNumber: mobileNumber,
      mobileNumberPrefix: AppConstant.defaultCountryCode,
      version: getIt<MainConfig>().packageInfo.version, // or get from app version
    );

    final ResponseHandler<BaseResponse<void>> response =
    await _repository.callSignUpUserOtpApi(request);

    if (response.isSuccess()) {
      final OnSuccessResponse<BaseResponse<void>>? success =
      response.getSuccessInstance();
      if (success != null && success.response.success) {
        // Restart timer on successful resend
        startTimer();
        emit(state.copyWith(
          status: BaseStateStatus.success,
          msg: success.response.message,
        ));
      } else {
        emit(state.copyWith(
          status: BaseStateStatus.failure,
          msg: success?.response.message ?? '',
        ));
      }
    } else {
      emit(state.copyWith(
        status: BaseStateStatus.failure,
        msg: response.getFailureInstance()?.error?.errorMessage ?? '',
      ));
    }
  }

  /// Resends OTP for update email flow
  Future<void> _resendUpdateEmailOtp(String email) async {


  }

}
