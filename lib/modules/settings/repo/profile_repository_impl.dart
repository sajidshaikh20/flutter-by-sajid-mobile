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
          endUrl: Apis.getClientProfile,
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

  @override
  Future<ResponseHandler<BaseResponse<ClientProfileResponse>>> uploadProfilePicture(
    File file,
  ) async {
    final String fileName = file.path.split('/').last;
    final FormData formData = FormData.fromMap(<String, dynamic>{
      'file': await MultipartFile.fromFile(file.path, filename: fileName),
    });

    final ResponseHandler<Map<String, dynamic>?> response = await MainConfig
        .apiClient
        .handleApiCall<Map<String, dynamic>>(
          endUrl: Apis.getClientProfile,
          apiType: ApiType.patch,
          formData: formData,
          isMultipartFormData: true,
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
}
