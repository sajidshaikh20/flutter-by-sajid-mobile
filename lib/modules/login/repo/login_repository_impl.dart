import '../../../utils/exports.dart';

/// Implementation of [LoginRepository] that handles login API calls.
class LoginRepositoryImpl extends LoginRepository {
  ///Login Api
  @override
  Future<ResponseHandler<BaseResponse<LoginUserResponse>>> callLoginApi(
    LoginRequestModel request,
  ) async {
    final ResponseHandler<Map<String, dynamic>?> response = await MainConfig
        .apiClient
        .handleApiCall<Map<String, dynamic>>(
          endUrl: Apis.login,
          apiType: ApiType.post,
          showLoader: true,
          data: request.toJson(),
        );
    return getParsedResponseHandler(
      responseHandler: response,
      parser: (Map<String, dynamic> value) {
        // Parse using BaseResponse structure
        return BaseResponse<LoginUserResponse>.fromJson(
          value,
          (Object? json) =>
              LoginUserResponse.fromJson(json as Map<String, dynamic>),
        );
      },
    );
  }

  ///Google Login Api
  @override
  Future<ResponseHandler<BaseResponse<LoginUserResponse>>> callGoogleLoginApi(
    GoogleLoginRequest request,
  ) async {
    final ResponseHandler<Map<String, dynamic>?> response = await MainConfig
        .apiClient
        .handleApiCall<Map<String, dynamic>>(
          endUrl: Apis.googleLogin,
          apiType: ApiType.post,
          showLoader: true,
          data: request.toJson(),
        );
    return getParsedResponseHandler(
      responseHandler: response,
      parser: (Map<String, dynamic> value) {
        return BaseResponse<LoginUserResponse>.fromJson(
          value,
          (Object? json) =>
              LoginUserResponse.fromJson(json as Map<String, dynamic>),
        );
      },
    );
  }
}
