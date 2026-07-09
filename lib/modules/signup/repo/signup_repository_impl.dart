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

    if (request.role == UserRole.trader) {
      if (request.questionnaire != null) {
        final String? governmentIdPath = request.questionnaire!.governmentId;
        if (governmentIdPath != null && governmentIdPath.isNotEmpty && !governmentIdPath.startsWith('/mock')) {
          data['governmentId'] = await MultipartFile.fromFile(
            governmentIdPath,
            filename: governmentIdPath.split('/').last,
          );
        } else {
          data.remove('governmentId');
        }

        final String? bankStatementPath = request.questionnaire!.bankStatement;
        if (bankStatementPath != null && bankStatementPath.isNotEmpty && !bankStatementPath.startsWith('/mock')) {
          data['bankStatement'] = await MultipartFile.fromFile(
            bankStatementPath,
            filename: bankStatementPath.split('/').last,
          );
        } else {
          data.remove('bankStatement');
        }

        final String? tradingCertificatePath = request.questionnaire!.tradingCertificate;
        if (tradingCertificatePath != null && tradingCertificatePath.isNotEmpty && !tradingCertificatePath.startsWith('/mock')) {
          data['tradingCertificate'] = await MultipartFile.fromFile(
            tradingCertificatePath,
            filename: tradingCertificatePath.split('/').last,
          );
        } else {
          data.remove('tradingCertificate');
        }
      }
    }

    final FormData formData = FormData.fromMap(data);

    final ResponseHandler<Map<String, dynamic>?> response = await MainConfig
        .apiClient
        .handleApiCall<Map<String, dynamic>>(
          endUrl: Apis.completeRegistration,
          apiType: ApiType.post,
          showLoader: true,
          formData: formData,
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
