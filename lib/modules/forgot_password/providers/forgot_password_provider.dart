import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../utils/exports.dart';
import '../state/forgot_password_state.dart';
import '../repository/forgot_password_repository.dart';

/// Notifier for managing forgot password state and operations (Riverpod version).
class ForgotPasswordNotifier extends StateNotifier<ForgotPasswordState> {
  /// Creates a forgot password notifier.
  ///
  /// [repository] The repository for forgot password operations.
  /// [initialState] The initial state of the forgot password screen.
  ForgotPasswordNotifier({
    required this.repository,
    required ForgotPasswordState initialState,
  }) : super(initialState);

  /// The repository used for forgot password operations.
  final ForgotPasswordRepository repository;

  ///Forgot password with mobile API.
  Future<void> callForgotPasswordWithMobileApi() async {
    if (state.formKey.currentState?.validate() ?? false) {
      state = state.copyWith(status: BaseStateStatus.loading);

      final String mobileNumber =
          state.resetPasswordFieldController.text.trim();

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
        final ResponseHandler<BaseResponse<void>> response =
            await repository.callForgotPasswordWithMobileApi(requestModel);

        if (response.isSuccess()) {
          final OnSuccessResponse<BaseResponse<void>>? successInstance =
              response.getSuccessInstance();

          if (successInstance != null) {
            final BaseResponse<void> baseResponse = successInstance.response;

            if (baseResponse.success) {
              _handleMobileSuccess(baseResponse);
            } else {
              state = state.copyWith(
                  status: BaseStateStatus.failure,
                  msg: baseResponse.message.isNotEmpty
                      ? baseResponse.message
                      : '',
                  showDefaultErrMsg: true);
            }
          } else {
            state = state.copyWith(
                status: BaseStateStatus.failure, showDefaultErrMsg: true);
          }
        } else {
          _handleFailure(response.getFailureInstance()?.error?.errorMessage);
        }
      } on Exception catch (_) {
        state = state.copyWith(
            status: BaseStateStatus.failure, showDefaultErrMsg: true);
      }
    }
  }

  ///Forgot password with email API.
  Future<void> callForgotPasswordWithEmailApi() async {
    if (state.formKey.currentState?.validate() ?? false) {
      state = state.copyWith(status: BaseStateStatus.loading);

      final String email = state.resetPasswordFieldController.text.trim();

      final ForgotPasswordWithEmailRequestModel requestModel =
          ForgotPasswordWithEmailRequestModel(
        platform: getPlatformName(),
        version: getIt<MainConfig>().packageInfo.version,
        email: email,
        languageId: getIt<LanguageService>().languageId
      );

      try {
        final ResponseHandler<BaseResponse<void>> response =
            await repository.callForgotPasswordWithEmailApi(requestModel);

        if (response.isSuccess()) {
          final OnSuccessResponse<BaseResponse<void>>? successInstance =
              response.getSuccessInstance();

          if (successInstance != null) {
            final BaseResponse<void> baseResponse = successInstance.response;

            if (baseResponse.success) {
              _handleEmailSuccess(baseResponse);
            } else {
              state = state.copyWith(
                  status: BaseStateStatus.failure,
                  msg: baseResponse.message.isNotEmpty
                      ? baseResponse.message
                      : '',
                  showDefaultErrMsg: true);
            }
          } else {
            state = state.copyWith(
                status: BaseStateStatus.failure, showDefaultErrMsg: true);
          }
        } else {
          _handleFailure(response.getFailureInstance()?.error?.errorMessage);
        }
      } on Exception catch (_) {
        state = state.copyWith(
            status: BaseStateStatus.failure, showDefaultErrMsg: true);
      }
    }
  }

  void _handleMobileSuccess(BaseResponse<void> responseModel) {
    if (responseModel.success) {
      final String mobileNumber =
          state.resetPasswordFieldController.text.trim();

      final String? extractedOtp =
          OtpExtractor.extractOtpFromMessage(responseModel.message);
      final int prefix = getIt<UserProfileService>().prefix;
      state = state.copyWith(
        status: BaseStateStatus.success,
        successMsg: responseModel.message,
        redirectRoute: VerifyOtpRoute(
          email: mobileNumber,
          prefix: prefix != 0 ? '${getIt<UserProfileService>().prefix}' : AppConstant.defaultCountryCodeInt.toString(),
          autoFilledOtp: extractedOtp,
        ),
      );
    } else {
      state = state.copyWith(
          status: BaseStateStatus.failure, msg: responseModel.message);
    }
  }

  void _handleEmailSuccess(BaseResponse<void> responseModel) {
    if (responseModel.success) {
      state = state.copyWith(
          status: BaseStateStatus.success,
          successMsg: responseModel.message,
          shouldGoBack: true);
    } else {
      state = state.copyWith(
          status: BaseStateStatus.failure, msg: responseModel.message);
    }
  }

  void _handleFailure(String? msg) {
    state = state.copyWith(status: BaseStateStatus.failure, msg: msg);
  }

  void resetSuccessMsg() {
    DebugLog.instance
        .i('🔄 Resetting success message and shouldGoBack to false');
    state = state.copyWith(
      status: BaseStateStatus.initial,
      successMsg: '',
    );
  }

  void onSegmentChangedIndex(int newIndex) {
    state.resetPasswordFieldController.clear();
    state.forgotPasswordFocusNode.unfocus();
    state = state.copyWith(
      status: BaseStateStatus.success,
      selectedSegmentIndex: newIndex,
    );
  }

  void handleValidationErrorMessageForEmailOrPhone(String value) {
    state = state.copyWith(
      emailErrorMessage: value,
    );
  }
}

/// Provider for ForgotPasswordRepository.
final Provider<ForgotPasswordRepository> forgotPasswordRepositoryProvider =
    Provider<ForgotPasswordRepository>((ProviderRef<ForgotPasswordRepository> ref) {
  return ForgotPasswordRepoImpl();
});

/// Provider for ForgotPasswordNotifier (auto-dispose for page-level instances).
final AutoDisposeStateNotifierProviderFamily<ForgotPasswordNotifier, ForgotPasswordState, ForgotPasswordState> forgotPasswordNotifierProvider =
    StateNotifierProvider.autoDispose.family<ForgotPasswordNotifier, ForgotPasswordState, ForgotPasswordState>(
  (AutoDisposeStateNotifierProviderRef<ForgotPasswordNotifier, ForgotPasswordState> ref, ForgotPasswordState initialState) {
    final ForgotPasswordRepository repository = ref.watch(forgotPasswordRepositoryProvider);
    return ForgotPasswordNotifier(repository: repository, initialState: initialState);
  },
);

