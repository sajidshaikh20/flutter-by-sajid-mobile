import '../../../utils/exports.dart';

/// Implementation of [ForgotPasswordRepository] that handles forgot password API calls.
class ForgotPasswordRepoImpl extends ForgotPasswordRepository {
  ///Forgot password with mobile API
  @override
  Future<ResponseHandler<BaseResponse<void>>> callForgotPasswordWithMobileApi(
      ForgotPasswordWithMobileRequestModel request) async {
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
          value,
              (_) {}, // No data expected, so return null
        );
      },
    );
  }

  ///Forgot password with email API
  @override
  Future<ResponseHandler<BaseResponse<void>>> callForgotPasswordWithEmailApi(
      ForgotPasswordWithEmailRequestModel request) async {
    final ResponseHandler<Map<String, dynamic>?> response = await MainConfig.apiClient
        .handleApiCall<Map<String, dynamic>>(
            endUrl: Apis.forgotPasswordWithEmail,
            apiType: ApiType.post,
            showLoader: true,
            params: request.toJson());
    return getParsedResponseHandler(
      responseHandler: response,
      parser: (Map<String, dynamic> value) {
        return BaseResponse<void>.fromJson(
          value,
          (_) {}, // No data expected, so return null
        );
      },
    );
  }
}
