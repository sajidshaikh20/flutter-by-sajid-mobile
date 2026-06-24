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
    final Map<String, dynamic> data = <String, dynamic>{
      'name': request.name,
      'phone': request.phone,
      'countryCode': request.countryCode,
    };

    if (request.profilePicture != null) {
      final String fileName = request.profilePicture!.path.split('/').last;
      data['profilePicture'] = await MultipartFile.fromFile(
        request.profilePicture!.path,
        filename: fileName,
      );
    }

    final FormData formData = FormData.fromMap(data);

    final ResponseHandler<Map<String, dynamic>?> response = await MainConfig
        .apiClient
        .handleApiCall<Map<String, dynamic>>(
          endUrl: Apis.updateClientProfile,
          apiType: ApiType.put,
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

  @override
  Future<ResponseHandler<BaseResponse<ClientProfileResponse>>> uploadProfilePicture(
    File file,
  ) async {
    final String fileName = file.path.split('/').last;
    final FormData formData = FormData.fromMap(<String, dynamic>{
      'profilePicture': await MultipartFile.fromFile(file.path, filename: fileName),
    });

    final ResponseHandler<Map<String, dynamic>?> response = await MainConfig
        .apiClient
        .handleApiCall<Map<String, dynamic>>(
          endUrl: Apis.updateClientProfile,
          apiType: ApiType.put,
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
