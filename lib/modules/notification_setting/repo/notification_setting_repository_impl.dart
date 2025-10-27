import '../../../utils/exports.dart';

/// `NotificationSettingRepositoryImpl` is a class that extends `MyAccountRepository` and
/// provides implementations for various user account related API calls.
class NotificationSettingRepositoryImpl extends NotificationSettingRepository {
  /// Calls the notification setting API to update user notification preferences.
  /// Returns a `ResponseHandler` containing a `BaseResponse<dynamic>`.
  @override
  Future<ResponseHandler<BaseResponse<void>>> callNotificationSetting({required NotificationSettingRequestModel requestModel}) async {

    final ResponseHandler<Map<String, dynamic>?> response = await MainConfig.apiClient
        .handleApiCall<Map<String, dynamic>>(
            endUrl: Apis.toggleNotificationStatus,
            apiType: ApiType.post,
            showLoader: true,
            data: requestModel.toJson());
    return getParsedResponseHandler(
      responseHandler: response,
      parser: (Map<String, dynamic> value) {
        return BaseResponse<void>.fromJson(
          value,
              (_) {},
        );
      },
    );
  }

}
