import '../../../utils/exports.dart';

/// Cubit for forgot password flow.
class ForgotPasswordCubit extends Cubit<ForgotPasswordState> {
  /// Creates [ForgotPasswordCubit].
  ForgotPasswordCubit({
    required this.repository,
    required ForgotPasswordState initialState,
  }) : super(initialState);

  /// Repository for forgot password API.
  final ForgotPasswordRepository repository;

  /// Updates email validation error message.
  void handleValidationErrorMessageForEmail(String value) {
    emit(state.copyWith(emailErrorMessage: value));
  }

  /// Sends reset link to the provided email.
  Future<void> sendResetLink({required String email}) async {
    try {
      emit(state.copyWith(status: BaseStateStatus.loading));

      final ResponseHandler<BaseResponse<void>> response = await repository
          .sendResetLink(email: email);

      if (response.isSuccess()) {
        emit(
          state.copyWith(
            status: BaseStateStatus.success,
            msg: response.getSuccessInstance()?.response.message ?? '',
          ),
        );
        return;
      }

      emit(
        state.copyWith(
          status: BaseStateStatus.failure,
          msg: response.getFailureInstance()?.error?.errorMessage ?? '',
        ),
      );
    } on Exception {
      emit(state.copyWith(status: BaseStateStatus.failure));
    }
  }
}
