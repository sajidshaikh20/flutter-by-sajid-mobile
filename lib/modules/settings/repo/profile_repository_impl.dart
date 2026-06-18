import '../../../utils/exports.dart';

class ProfileRepositoryImpl extends ProfileRepository {
  @override
  Future<ResponseHandler<BaseResponse<ClientProfileResponse>>> getProfile() async {
    final ResponseHandler<Map<String, dynamic>?> response = await MainConfig
        .apiClient
        .handleApiCall<Map<String, dynamic>>(
          endUrl: Apis.getClientProfile,
          showLoader: true,
        );

    return getParsedResponseHandler(
      responseHandler: response,
      parser: (Map<String, dynamic> value) {
        return BaseResponse<ClientProfileResponse>.fromJson(
          value,
          (Object? json) => ClientProfileResponse.fromJson(json as Map<String, dynamic>),
        );
      },
    );
  }

  @override
  Future<ResponseHandler<BaseResponse<ClientProfileResponse>>> updateProfile(
    UpdateClientProfileRequest request,
  ) async {
    final ResponseHandler<Map<String, dynamic>?> response = await MainConfig
        .apiClient
        .handleApiCall<Map<String, dynamic>>(
          endUrl: Apis.updateClientProfile,
          apiType: ApiType.patch,
          showLoader: true,
          data: request.toJson(),
        );

    return getParsedResponseHandler(
      responseHandler: response,
      parser: (Map<String, dynamic> value) {
        return BaseResponse<ClientProfileResponse>.fromJson(
          value,
          (Object? json) => ClientProfileResponse.fromJson(json as Map<String, dynamic>),
        );
      },
    );
  }
}
