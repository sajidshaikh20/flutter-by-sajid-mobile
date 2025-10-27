import '../../../utils/exports.dart';

/// Concrete implementation of [EditProfileRepository] that handles
/// API calls for editing the user's profile.
class EditProfileRepositoryImpl extends EditProfileRepository {
  /// Calls the API to save the user's edited profile data.
  ///
  /// [editProfileRequestModel] contains all the fields required to update
  /// the user's profile such as name, mobile number, token, etc.
  ///
  /// Returns a [ResponseHandler] wrapping an [EditProfileModel] which contains
  /// the result of the API call, including success status, messages, and profile info.
  @override
  Future<ResponseHandler<BaseResponse<EditProfileResponse>>> callEditProfileSaveData({
    required EditProfileRequestModel editProfileRequestModel,
  }) async {
    // Convert the request model to JSON for API call

    // Make the API call using MainConfig.apiClient
    final ResponseHandler<Map<String, dynamic>?> response =
    await MainConfig.apiClient.handleApiCall<Map<String, dynamic>>(
      endUrl: Apis.editProfile,
      apiType: ApiType.post,
      data: editProfileRequestModel.toJson(),
      showLoader: true,
    );

    // Parse the API response into a BaseResponse<EditProfileResponse>
    return getParsedResponseHandler(
      responseHandler: response,
      parser: (Map<String, dynamic> value) => BaseResponse<EditProfileResponse>.fromJson(
        value,
        (Object? json) => EditProfileResponse.fromJson(json as Map<String, dynamic>),
      ),
    );
  }

  @override
  Future<ResponseHandler<BaseResponse<void>>> callUpdateEmail({
    required UpdateEmailRequestModel updateEmailRequestModel,
  }) async {
    // Convert the request model to JSON for API call

    // Make the API call using MainConfig.apiClient
    final ResponseHandler<Map<String, dynamic>?> response =
    await MainConfig.apiClient.handleApiCall<Map<String, dynamic>>(
      endUrl: Apis.updateEmail,
      apiType: ApiType.post,
      data: updateEmailRequestModel.toJson(),
      showLoader: true,
    );

    // Parse the API response into a BaseResponse<EditProfileResponse>
    return getParsedResponseHandler(
      responseHandler: response,
      parser: (Map<String, dynamic> value) {
        return BaseResponse<void>.fromJson(
          value, (_) {}, // No data expected, so return null
        );
      },
    );
  }

}
