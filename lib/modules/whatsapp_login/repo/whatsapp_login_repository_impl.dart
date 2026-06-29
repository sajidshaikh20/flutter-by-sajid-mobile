import '../../../utils/exports.dart';
import '../model/model.dart';
import 'whatsapp_login_repository.dart';

class WhatsAppLoginRepositoryImpl extends WhatsAppLoginRepository {
  @override
  Future<ResponseHandler<BaseResponse<Map<String, dynamic>>>> callSendLoginOtpApi(
    SendLoginOtpRequest request,
  ) async {
    final ResponseHandler<Map<String, dynamic>?> response = await MainConfig
        .apiClient
        .handleApiCall<Map<String, dynamic>>(
          endUrl: Apis.sendLoginOtp,
          apiType: ApiType.post,
          showLoader: true,
          data: request.toJson(),
        );
    return getParsedResponseHandler(
      responseHandler: response,
      parser: (Map<String, dynamic> value) {
        return BaseResponse<Map<String, dynamic>>.fromJson(
          value,
          (Object? json) => json as Map<String, dynamic>,
        );
      },
    );
  }

  @override
  Future<ResponseHandler<BaseResponse<LoginUserResponse>>> callLoginWithOtpApi(
    LoginWithOtpRequest request,
  ) async {
    final ResponseHandler<Map<String, dynamic>?> response = await MainConfig
        .apiClient
        .handleApiCall<Map<String, dynamic>>(
          endUrl: Apis.loginWithOtp,
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
