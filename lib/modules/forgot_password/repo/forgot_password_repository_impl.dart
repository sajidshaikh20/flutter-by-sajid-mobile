import '../../../utils/exports.dart';

/// Implementation of [ForgotPasswordRepository].
class ForgotPasswordRepositoryImpl extends ForgotPasswordRepository {
  @override
  Future<ResponseHandler<BaseResponse<void>>> sendResetLink({
    required String email,
  }) async {
    final ForgotPasswordRequestModel request = ForgotPasswordRequestModel(
      email: email,
    );

    final ResponseHandler<Map<String, dynamic>?> response = await MainConfig
        .apiClient
        .handleApiCall<Map<String, dynamic>>(
          endUrl: Apis.forgotPasswordWithEmail,
          apiType: ApiType.post,
          showLoader: true,
          data: request.toJson(),
        );

    return getParsedResponseHandler(
      responseHandler: response,
      parser: (Map<String, dynamic> value) {
        return BaseResponse<void>.fromJson(value, (_) {});
      },
    );
  }
}
