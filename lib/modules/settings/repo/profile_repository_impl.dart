import 'package:image_picker/image_picker.dart';

import '../../../utils/exports.dart';

class ProfileRepositoryImpl extends ProfileRepository {
  @override
  Future<ResponseHandler<BaseResponse<ClientProfileResponse>>>
  getProfile() async {
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
          (Object? json) =>
              ClientProfileResponse.fromJson(json as Map<String, dynamic>),
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
      final XFile image = request.profilePicture!;
      final List<int> bytes = await image.readAsBytes();
      data['profilePicture'] = MultipartFile.fromBytes(
        bytes,
        filename: image.name,
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
          (Object? json) =>
              ClientProfileResponse.fromJson(json as Map<String, dynamic>),
        );
      },
    );
  }

  @override
  Future<ResponseHandler<BaseResponse<ClientProfileResponse>>>
  uploadProfilePicture(XFile file) async {
    final List<int> bytes = await file.readAsBytes();
    final FormData formData = FormData.fromMap(<String, dynamic>{
      'profilePicture': MultipartFile.fromBytes(bytes, filename: file.name),
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
          (Object? json) =>
              ClientProfileResponse.fromJson(json as Map<String, dynamic>),
        );
      },
    );
  }

  @override
  Future<ResponseHandler<BaseResponse<dynamic>>> deleteAccount() async {
    final ResponseHandler<Map<String, dynamic>?> response = await MainConfig
        .apiClient
        .handleApiCall<Map<String, dynamic>>(
          endUrl: Apis.deleteAccount,
          apiType: ApiType.delete,
          showLoader: true,
        );

    return getParsedResponseHandler(
      responseHandler: response,
      parser: (Map<String, dynamic> value) {
        return BaseResponse<dynamic>.fromJson(value, (Object? json) => json);
      },
    );
  }

  @override
  Future<ResponseHandler<BaseResponse<TradingPreferencesResponse>>> getTradingPreferences() async {
    final ResponseHandler<Map<String, dynamic>?> response = await MainConfig
        .apiClient
        .handleApiCall<Map<String, dynamic>>(
          endUrl: Apis.getBalanceRisk,
          showLoader: true,
        );

    return getParsedResponseHandler(
      responseHandler: response,
      parser: (Map<String, dynamic> value) {
        return BaseResponse<TradingPreferencesResponse>.fromJson(
          value,
          (Object? json) =>
              TradingPreferencesResponse.fromJson(json as Map<String, dynamic>),
        );
      },
    );
  }

  @override
  Future<ResponseHandler<BaseResponse<ClientProfileResponse>>> updateBalanceAndRisk({
    double? amountBalance,
    double? riskPercentage,
  }) async {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (amountBalance != null) {
      data['amountBalance'] = amountBalance;
    }
    if (riskPercentage != null) {
      data['riskPercentage'] = riskPercentage;
    }

    final ResponseHandler<Map<String, dynamic>?> response = await MainConfig
        .apiClient
        .handleApiCall<Map<String, dynamic>>(
          endUrl: Apis.updateBalanceRisk,
          apiType: ApiType.put,
          data: data,
          showLoader: true,
        );

    return getParsedResponseHandler(
      responseHandler: response,
      parser: (Map<String, dynamic> value) {
        return BaseResponse<ClientProfileResponse>.fromJson(
          value,
          (Object? json) =>
              ClientProfileResponse.fromJson(json as Map<String, dynamic>),
        );
      },
    );
  }
}
