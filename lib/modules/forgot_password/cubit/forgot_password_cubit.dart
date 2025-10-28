import '../../../utils/exports.dart';

/// Cubit that manages forgot password state and operations.
class ForgotPasswordCubit extends Cubit<ForgotPasswordState> {
  /// Creates a forgot password cubit.
  ///
  /// [repository] The repository for forgot password operations.
  /// [initialState] The initial state of the forgot password screen.
  ForgotPasswordCubit({
    required this.repository,
    required ForgotPasswordState initialState,
  }) : super(initialState);

  /// The repository used for forgot password operations.
  final ForgotPasswordRepository repository;

  ///Forgot password with mobile API.
  Future<void> callForgotPasswordWithMobileApi() async {
    if (state.formKey.currentState?.validate() ?? false) {
      emit(state.copyWith(status: BaseStateStatus.loading));

      // Get necessary values from SharedPref
     /// final String websiteId = getIt<CountryService>().websiteId;
      final String mobileNumber =
          state.resetPasswordFieldController.text.trim();
     // final String mobileNumberPrefix = getIt<CountryService>().countryCode ?? '';

      // Create ForgotPassword with mobile request model
      final ForgotPasswordWithMobileRequestModel requestModel =
          ForgotPasswordWithMobileRequestModel(
        platform: getPlatformName(),
        version: getIt<MainConfig>().packageInfo.version,
        mobileNumber: mobileNumber,
        languageId: getIt<LanguageService>().languageId,
        sentOtp: AppConstant.oneStr,
        verifyOtp: AppConstant.zeroStr,
        updatePassword: AppConstant.zeroStr,
        otp: AppConstant.empty,
      );

      try {
        // Await the repository API call
        final ResponseHandler<BaseResponse<void>> response =
            await repository.callForgotPasswordWithMobileApi(requestModel);

        if (response.isSuccess()) {
          final OnSuccessResponse<BaseResponse<void>>? successInstance =
              response.getSuccessInstance();

          if (successInstance != null) {
            final BaseResponse<void> baseResponse = successInstance.response;

            // Check if the BaseResponse is successful and has data
            if (baseResponse.success) {
              _handleMobileSuccess(baseResponse);
            } else {
              emit(state.copyWith(
                  status: BaseStateStatus.failure,
                  msg: baseResponse.message.isNotEmpty
                      ? baseResponse.message
                      : '',
                  showDefaultErrMsg: true));
            }
          } else {
            emit(state.copyWith(
                status: BaseStateStatus.failure, showDefaultErrMsg: true));
          }
        } else {
          _handleFailure(response.getFailureInstance()?.error?.errorMessage);
        }
      } on Exception catch (_) {
        // Handle any exceptions during the API call
        emit(state.copyWith(
            status: BaseStateStatus.failure, showDefaultErrMsg: true));
      }
    }
  }

  ///Forgot password with email API.
  Future<void> callForgotPasswordWithEmailApi() async {
    if (state.formKey.currentState?.validate() ?? false) {
      emit(state.copyWith(status: BaseStateStatus.loading));

      // Get email from controller
      final String email = state.resetPasswordFieldController.text.trim();

      // Create ForgotPassword with email request model
      final ForgotPasswordWithEmailRequestModel requestModel =
          ForgotPasswordWithEmailRequestModel(
        platform: getPlatformName(),
        version: getIt<MainConfig>().packageInfo.version,
        email: email,
        languageId: getIt<LanguageService>().languageId
      );

      try {
        // Await the repository API call
        final ResponseHandler<BaseResponse<void>> response =
            await repository.callForgotPasswordWithEmailApi(requestModel);

        if (response.isSuccess()) {
          final OnSuccessResponse<BaseResponse<void>>? successInstance =
              response.getSuccessInstance();

          if (successInstance != null) {
            final BaseResponse<void> baseResponse = successInstance.response;

            // Check if the BaseResponse is successful and has data
            if (baseResponse.success) {
              _handleEmailSuccess(baseResponse);
            } else {
              emit(state.copyWith(
                  status: BaseStateStatus.failure,
                  msg: baseResponse.message.isNotEmpty
                      ? baseResponse.message
                      : '',
                  showDefaultErrMsg: true));
            }
          } else {
            emit(state.copyWith(
                status: BaseStateStatus.failure, showDefaultErrMsg: true));
          }
        } else {
          _handleFailure(response.getFailureInstance()?.error?.errorMessage);
        }
      } on Exception catch (_) {
        // Handle any exceptions during the API call
        emit(state.copyWith(
            status: BaseStateStatus.failure, showDefaultErrMsg: true));
      }
    }
  }

  ///handling the success scenario for mobile forgot password API.
  void _handleMobileSuccess(BaseResponse<void> responseModel) {
    if (responseModel.success) {
      final String mobileNumber =
          state.resetPasswordFieldController.text.trim();

      // Extract OTP from success message
      DebugLog.instance.i('=== FORGOT PASSWORD OTP EXTRACTION DEBUG ===');
      DebugLog.instance.i('Success message: "${responseModel.message}"');
      final String? extractedOtp =
          OtpExtractor.extractOtpFromMessage(responseModel.message);
      DebugLog.instance.i('Extracted OTP: $extractedOtp');
      DebugLog.instance.i('=== END FORGOT PASSWORD OTP EXTRACTION DEBUG ===');
      int prefix = getIt<UserProfileService>().prefix;
      emit(state.copyWith(
        status: BaseStateStatus.success,
        successMsg: responseModel.message,
        redirectRoute: VerifyOtpRoute(
          email: mobileNumber,
          prefix: prefix != 0 ? '${getIt<UserProfileService>().prefix}' : AppConstant.defaultCountryCodeInt.toString(),
          autoFilledOtp: extractedOtp,

        ),
      ));
    } else {
      emit(state.copyWith(
          status: BaseStateStatus.failure, msg: responseModel.message));
    }
  }

  ///handling the success scenario for email forgot password API.
  void _handleEmailSuccess(BaseResponse<void> responseModel) {
    if (responseModel.success) {
      emit(state.copyWith(
          status: BaseStateStatus.success,
          successMsg: responseModel.message,
          shouldGoBack: true));
    } else {
      emit(state.copyWith(
          status: BaseStateStatus.failure, msg: responseModel.message ));
    }
  }

  ///handling the failure scenario after calling the forgot password API.
  void _handleFailure(String? msg) {
    emit(state.copyWith(status: BaseStateStatus.failure, msg: msg));
  }

  /// Resets the success message.
  void resetSuccessMsg() {
    DebugLog.instance
        .i('🔄 Resetting success message and shouldGoBack to false');
    emit(state.copyWith(
      status: BaseStateStatus.initial,
      successMsg: '',
    ));
  }

  /// Handles segment index changes between email and mobile options.
  ///
  /// [newIndex] The new segment index (0 for email, 1 for mobile).
  void onSegmentChangedIndex(int newIndex) {
    state.resetPasswordFieldController.clear();
    state.forgotPasswordFocusNode.unfocus();
    emit(state.copyWith(
      status: BaseStateStatus.success,
      selectedSegmentIndex: newIndex, // Update the segment index
    ));
  }
///handleValidationErrorMessageForEmailOrPhone
  void handleValidationErrorMessageForEmailOrPhone(String value) {
    emit(state.copyWith(
      emailErrorMessage: value,
    ));
  }
}
