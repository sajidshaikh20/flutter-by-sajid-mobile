import '../../../utils/exports.dart';

/// Implementation of the reset password repository.
class ResetPasswordRepoImpl extends ResetPasswordRepository {
  ///Reset password with mobile API

  @override
  Future<ResponseHandler<BaseResponse<void>>> callResetPasswordWithMobileApi(
      ResetPasswordWithMobileRequestModel request) async {
    final ResponseHandler<Map<String, dynamic>?> response = await MainConfig.apiClient
        .handleApiCall<Map<String, dynamic>>(
        endUrl: Apis.forgotPasswordWithMobile,
        apiType: ApiType.post,
        showLoader: true,
        params: request.toJson());
    return getParsedResponseHandler(
      responseHandler: response,
      parser: (Map<String, dynamic> value) {
        return BaseResponse<void>.fromJson(
          value, (_) {}, // No data expected, so return null
        );
      },
    );
  }
}
