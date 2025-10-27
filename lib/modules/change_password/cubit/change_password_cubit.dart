import '../../../utils/exports.dart';

/// Cubit class to manage state for the Change Password feature.
///
/// Handles password visibility toggles, field validation, and
/// resetting state values after password change or logout.
class ChangePasswordCubit extends Cubit<ChangePasswordState> {
  /// Repository for handling API calls related to password changes.
  final ChangePasswordRepository repository;

  /// Creates a [ChangePasswordCubit] instance with the provided repository and initial state.
  ChangePasswordCubit({
    required this.repository,
    required ChangePasswordState intialState,
  }) : super(intialState);

  /// Moves the focus to the next input field.
  void moveToNextField(FocusNode nextFocusNode) {
    nextFocusNode.requestFocus();
  }

  /// Toggles the visibility of the confirm password field.
  void toggleConfirmPassObscureText() {
    emit(
      state.copyWith(
        cnfPasswordObscureText: !state.cnfPasswordObscureText,
        status: BaseStateStatus.success,
      ),
    );
  }

  /// Toggles the visibility of the new password field.
  void toggleNewPassObscureText() {
    emit(
      state.copyWith(
        newPassObscureText: !state.newPassObscureText,
        status: BaseStateStatus.success,
      ),
    );
  }

  /// Toggles the visibility of the old password field.
  void toggleOldPassObscureText() {
    emit(
      state.copyWith(
        oldPassObscureText: !state.oldPassObscureText,
        status: BaseStateStatus.success,
      ),
    );
  }

  /// Handles validation errors for the old password field.
  void handleValidationErrorMessageOldPass(String errorMessage) {
    emit(state.copyWith(oldPassErrorMessage: errorMessage));
  }

  /// Handles validation errors for the new password field.
  void handleValidationErrorMessageNewPass(String errorMessage) {
    emit(state.copyWith(newPassErrorMessage: errorMessage));
  }

  /// Handles validation errors for the confirm password field.
  void handleValidationErrorMessageConPassword(String errorMessage) {
    emit(state.copyWith(conPassErrorMessage: errorMessage));
  }

  /// Resets the cubit state values to initial state and clears shared preferences.
  ///
  /// Useful after successful password change or user logout.
  Future<void> resetStateValue() async {
    await SharedPref.instance.clearUserDataOnly();
    emit(state.copyWith(
      status: BaseStateStatus.initial,
      showDefaultErrMsg: false,
      msg: '',
    ));
  }

  /// Calls the Change Password API using values from controllers.
  /// Emits [BaseStateStatus.success] with API message on success
  /// or [BaseStateStatus.failure] with error message on failure.
  Future<void> submitChangePassword() async {
    try {
      emit(state.copyWith(status: BaseStateStatus.loading));

      final String oldPassword = state.oldPassController.text.trim();
      final String newPassword = state.newPassController.text.trim();

      final String customerToken = getIt<UserProfileService>().customerToken;

      final ChangePasswordRequestModel request = ChangePasswordRequestModel(
        customerToken: customerToken,
        currentPassword: oldPassword,
        newPassword: newPassword,
        languageId: int.tryParse(getIt<LanguageService>().languageId),
        storeId: getIt<CountryService>().store,
      );

      final ResponseHandler<BaseResponse<dynamic>> response =
          await repository.callChangePasswordApi(request);

      if (response.isSuccess()) {
        final OnSuccessResponse<BaseResponse<dynamic>>? success =
            response.getSuccessInstance();
        final BaseResponse<dynamic>? data = success?.response;

        if (data?.success ?? false) {
          emit(state.copyWith(
            status: BaseStateStatus.success,
            msg: data?.message,
            showDefaultErrMsg: false,
            redirectRoute: const MyAccountRoute(),
          ));
        } else {
          emit(state.copyWith(
            status: BaseStateStatus.failure,
            msg: data?.message,
            showDefaultErrMsg: false,
          ));
        }
      } else {
        final OnFailureResponse<BaseResponse<dynamic>>? failure =
            response.getFailureInstance();
        emit(state.copyWith(
          status: BaseStateStatus.failure,
          msg: failure?.error?.errorMessage ?? MainConfig.appString.networkErrorOccurredKey,
          showDefaultErrMsg: false,
        ));
      }
    } on Exception {
      emit(state.copyWith(
        status: BaseStateStatus.failure,
        msg: MainConfig.appString.networkErrorOccurredKey,
        showDefaultErrMsg: true,
      ));
    }
  }
}
