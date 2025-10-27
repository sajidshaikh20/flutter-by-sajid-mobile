import '../../../utils/exports.dart';

/// Cubit that handles reset password functionality and state management.
class ResetPasswordCubit extends Cubit<ResetPasswordState> {
  /// Creates a reset password cubit.
  ResetPasswordCubit({
    required ResetPasswordRepository repository,
    required ResetPasswordState initialState,
  })  : _repository = repository,
        super(initialState);

  /// Repository is made private since it should not be accessed directly outside this cubit.
  final ResetPasswordRepository _repository;

  /// Toggles the visibility of the new password text field.
  void toggleNewPassObscureText() {
    emit(
      state.copyWith(
        newPasswordObscureText: !state.newPasswordObscureText,
      ),
    );
  }

  /// Toggles the visibility of the confirm password text field.
  void toggleConfirmPassObscureText() {
    emit(
      state.copyWith(
        conFirmPasswordObscureText: !state.conFirmPasswordObscureText,
      ),
    );
  }

  ///Change focus to next field
  void moveToNextField(FocusNode nextFocusNode) {
    nextFocusNode.requestFocus();
  }

  /// Updates the validation error message for the new password field.
  void handleValidationErrorMessageNewPass(String value) {
    emit(state.copyWith(newPassErrorMessage: value));
  }

  /// Updates the validation error message for the confirm password field.
  void handleValidationErrorMessageConPassword(String value) {
    emit(state.copyWith(conPassErrorMessage: value));
  }

  ///Reset password with mobile API.
  Future<void> callResetPasswordWithMobileApi() async {
    if (state.formKey.currentState?.validate() ?? false) {
      emit(state.copyWith(status: BaseStateStatus.loading));

      // Get necessary values from state
      final String websiteId = getIt<CountryService>().websiteId;
      final String mobileNumber = state.mobileNumber;
      final String mobileNumberPrefix = getIt<CountryService>().countryCode ?? '';

      // Create ResetPassword with mobile request model
      final ResetPasswordWithMobileRequestModel requestModel =
      ResetPasswordWithMobileRequestModel(
        platform: getPlatformName(),
        languageId: getIt<LanguageService>().languageId,
        version: getIt<MainConfig>().packageInfo.version,
        websiteId: websiteId,
        mobileNumber: mobileNumber,
        mobileNumberPrefix: mobileNumberPrefix,
        sentOtp: AppConstant.zeroStr,
        verifyOtp: AppConstant.zeroStr,
        updatePassword: AppConstant.oneStr,
        newPassword: state.newPassController.text.trim(),
        confirmPassword: state.conPasswordController.text.trim(),
      );

      try {
        // Await the repository API call
        final ResponseHandler<BaseResponse<void>> response =
        await _repository.callResetPasswordWithMobileApi(requestModel);

        if (response.isSuccess()) {
          final OnSuccessResponse<BaseResponse<void>>? successInstance =
          response.getSuccessInstance();

          if (successInstance != null) {
            final BaseResponse<void> baseResponse = successInstance.response;

            // Check if the BaseResponse is successful and has data
            if (baseResponse.success) {
              _handleSuccess(baseResponse);
            } else {
              emit(state.copyWith(
                status: BaseStateStatus.failure,
                msg: baseResponse.message.isNotEmpty ? baseResponse.message : '',
                showDefaultErrMsg: true,
              ));
            }
          } else {
            emit(state.copyWith(
              status: BaseStateStatus.failure,
              showDefaultErrMsg: true,
            ));
          }
        } else {
          _handleFailure(response.getFailureInstance()?.error?.errorMessage);
        }
      } on Exception catch (_) {
        // Handle any exceptions during the API call
        emit(state.copyWith(
          status: BaseStateStatus.failure,
          showDefaultErrMsg: true,
        ));
      }
    }
  }

  ///handling the success scenario for reset password API.
  void _handleSuccess(BaseResponse<void> responseModel) {
    if (responseModel.success) {
      emit(state.copyWith(
        status: BaseStateStatus.success,
        successMsg: responseModel.message,
        shouldGoBack: true,
      ));
    } else {
      emit(state.copyWith(
        status: BaseStateStatus.failure,
        msg: responseModel.message,
      ));
    }
  }

  ///handling the failure scenario after calling the reset password API.
  void _handleFailure(String? msg) {
    emit(state.copyWith(status: BaseStateStatus.failure, msg: msg));
  }

  /// Resets the success message.
  void resetSuccessMsg() {
    emit(state.copyWith(status: BaseStateStatus.initial, successMsg: ''));
  }

  @override
  Future<void> close() {
    // Cancel the timer before closing the Cubit to avoid emitting after close
    return super.close();
  }
}
