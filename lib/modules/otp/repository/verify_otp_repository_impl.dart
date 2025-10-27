import '../../../../utils/exports.dart';

/// Implementation of [VerifyOtpRepository] that handles OTP verification API calls.
class VerifyOtpRepositoryImpl extends VerifyOtpRepository {

  /// Sign up API with user data
  @override
  Future<ResponseHandler<BaseResponse<SignupUserResponse>>> callSignUpApi(
      SignupRequestModel request) async {
    final ResponseHandler<Map<String, dynamic>?> response =
    await MainConfig.apiClient.handleApiCall<Map<String, dynamic>>(
      endUrl: Apis.signupUserWithVerifyOtp,
      apiType: ApiType.post,
      showLoader: true,
      params: request.toJson(),
    );
    return getParsedResponseHandler(
      responseHandler: response,
      parser: (Map<String, dynamic> value) {
        return BaseResponse<SignupUserResponse>.fromJson(
          value,
              (Object? json) => SignupUserResponse.fromJson(json as Map<String, dynamic>),
        );
      },
    );
  }

  /// Sign up OTP API for sending OTP
  @override
  Future<ResponseHandler<BaseResponse<void>>> callSignUpUserOtpApi(
      SignUpUserOtpRequestModel request) async {
    final ResponseHandler<Map<String, dynamic>?> response =
    await MainConfig.apiClient.handleApiCall<Map<String, dynamic>>(
      endUrl: Apis.signupUserOtp,
      apiType: ApiType.post,
      showLoader: true,
      params: request.toJson(),
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

  /// Sign up VERFIFY  with user data
  @override
  Future<ResponseHandler<BaseResponse<void>>> callverifyOtp(
      ForgotPasswordWithMobileRequestModel request) async {
    final ResponseHandler<Map<String, dynamic>?> response =
    await MainConfig.apiClient.handleApiCall<Map<String, dynamic>>(
      endUrl: Apis.forgotPasswordWithMobile,
      apiType: ApiType.post,
      showLoader: true,
      params: request.toJson(),
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

  /// UpdateEmail VERIFY  with user data
  @override
  Future<ResponseHandler<BaseResponse<EditProfileResponse>>> callUpdateEmail(
      UpdateEmailRequestModel request) async {
    final ResponseHandler<Map<String, dynamic>?> response =
    await MainConfig.apiClient.handleApiCall<Map<String, dynamic>>(
      endUrl: Apis.updateEmail,
      apiType: ApiType.post,
      showLoader: true,
      data: request.toJson(),
    );
    return getParsedResponseHandler(
      responseHandler: response,
      parser: (Map<String, dynamic> value) => BaseResponse<EditProfileResponse>.fromJson(
        value,
            (Object? json) => EditProfileResponse.fromJson(json as Map<String, dynamic>),
      ),
    );
  }

}
