import '../../../utils/exports.dart';

/// Implementation of the sign up repository.
class SignUpRepositoryImpl extends SignUpRepository {
  /// Calls the sign up OTP API to send verification code.
  ///
  /// Returns a [ResponseHandler] with the API response.
  @override
  Future<ResponseHandler<BaseResponse<void>>> callSignUpUserOtpApi(SignUpUserOtpRequestModel request) async {
    final ResponseHandler<Map<String, dynamic>?> response = await MainConfig.apiClient.handleApiCall<Map<String, dynamic>>(
      endUrl: Apis.signupUserOtp,
      apiType: ApiType.post,
      params: request.toJson(),
      showLoader: true
    );
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

  /// Calls the CMS API to get content data.
  ///
  /// Returns a [ResponseHandler] containing the [CmsResponseModel].
  @override
  Future<ResponseHandler<CmsResponseModel>> callCMSApi({
    required CmsRequestModel cmsRequestModel,
  }) async {
    final ResponseHandler<Map<String, dynamic>?> response = await MainConfig.apiClient
        .handleApiCall<Map<String, dynamic>>(
        endUrl: Apis.cmsAccountApi,
        params: cmsRequestModel.toJson(),
        showLoader: true);

    return getParsedResponseHandler(
      responseHandler: response,
      parser: (Map<String, dynamic> value) => CmsResponseModel.fromJson(
        value,
      ),
    );
  }
}
