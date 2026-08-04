import '../../../utils/exports.dart';

/// Concrete implementation of SignUpRepository communicating with the backend APIs.
class SignUpRepositoryImpl extends SignUpRepository {
  @override
  Future<ResponseHandler<BaseResponse<SignUpResponse>>> startRegistration(
      StartRegistrationRequest request) async {
    final ResponseHandler<Map<String, dynamic>?> response = await MainConfig
        .apiClient
        .handleApiCall<Map<String, dynamic>>(
          endUrl: Apis.startRegistration,
          apiType: ApiType.post,
          showLoader: true,
          data: request.toJson(),
        );
    return getParsedResponseHandler(
      responseHandler: response,
      parser: (Map<String, dynamic> value) {
        return BaseResponse<SignUpResponse>.fromJson(
          value,
          (Object? json) =>
              SignUpResponse.fromJson(json as Map<String, dynamic>),
        );
      },
    );
  }

  @override
  Future<ResponseHandler<BaseResponse<SignUpResponse>>> verifyEmailOtp(
      VerifyEmailOtpRequest request) async {
    final ResponseHandler<Map<String, dynamic>?> response = await MainConfig
        .apiClient
        .handleApiCall<Map<String, dynamic>>(
          endUrl: Apis.verifyEmailOtp,
          apiType: ApiType.post,
          showLoader: true,
          data: request.toJson(),
        );
    return getParsedResponseHandler(
      responseHandler: response,
      parser: (Map<String, dynamic> value) {
        return BaseResponse<SignUpResponse>.fromJson(
          value,
          (Object? json) =>
              SignUpResponse.fromJson(json as Map<String, dynamic>),
        );
      },
    );
  }

  @override
  Future<ResponseHandler<BaseResponse<SignUpResponse>>> sendPhoneOtp(
      SendPhoneOtpRequest request) async {
    final ResponseHandler<Map<String, dynamic>?> response = await MainConfig
        .apiClient
        .handleApiCall<Map<String, dynamic>>(
          endUrl: Apis.sendPhoneOtp,
          apiType: ApiType.post,
          showLoader: true,
          data: request.toJson(),
        );
    return getParsedResponseHandler(
      responseHandler: response,
      parser: (Map<String, dynamic> value) {
        return BaseResponse<SignUpResponse>.fromJson(
          value,
          (Object? json) =>
              SignUpResponse.fromJson(json as Map<String, dynamic>),
        );
      },
    );
  }

  @override
  Future<ResponseHandler<BaseResponse<SignUpResponse>>> verifyPhoneOtp(
      VerifyPhoneOtpRequest request) async {
    final ResponseHandler<Map<String, dynamic>?> response = await MainConfig
        .apiClient
        .handleApiCall<Map<String, dynamic>>(
          endUrl: Apis.verifyPhoneOtp,
          apiType: ApiType.post,
          showLoader: true,
          data: request.toJson(),
        );
    return getParsedResponseHandler(
      responseHandler: response,
      parser: (Map<String, dynamic> value) {
        return BaseResponse<SignUpResponse>.fromJson(
          value,
          (Object? json) =>
              SignUpResponse.fromJson(json as Map<String, dynamic>),
        );
      },
    );
  }

  @override
  Future<ResponseHandler<BaseResponse<SignUpResponse>>> completeRegistration(
      CompleteRegistrationRequest request) async {
    final Map<String, dynamic> data = request.toJson();

    final ResponseHandler<Map<String, dynamic>?> response = await MainConfig
        .apiClient
        .handleApiCall<Map<String, dynamic>>(
          endUrl: Apis.completeRegistration,
          apiType: ApiType.post,
          showLoader: true,
          formData: FormData.fromMap(data),
          isMultipartFormData: true,
        );

    return getParsedResponseHandler(
      responseHandler: response,
      parser: (Map<String, dynamic> value) {
        return BaseResponse<SignUpResponse>.fromJson(
          value,
          (Object? json) =>
              SignUpResponse.fromJson(json as Map<String, dynamic>),
        );
      },
    );
  }
}
