import '../../../utils/exports.dart';

///Notification repository implementation
class NotificationRepositoryImpl extends NotificationRepository {
  @override
  Future<ResponseHandler<BaseResponse<List<ListOfNotificationResponse>>>>
      getNotificationList(NotificationRequestModel request) async {
    ResponseHandler<Map<String, dynamic>?> response =
        await MainConfig.apiClient.handleApiCall<Map<String, dynamic>>(
      endUrl: Apis.notificationList,
      apiType: ApiType.post,
      data: request.toJson(),
    );

    return getParsedResponseHandler(
      responseHandler: response,
      parser: (Map<String, dynamic> json) =>
          BaseResponse<List<ListOfNotificationResponse>>.fromJson(
        json,
        (dynamic data) => (data as List<dynamic>)
            .map((dynamic item) => ListOfNotificationResponse.fromJson(
                item as Map<String, dynamic>))
            .toList(),
      ),
    );
  }

  @override
  Future<ResponseHandler<BaseResponse<dynamic>>> readNotification(
      List<int>? notificationIds) async {
    NotificationReadRequestModel notificationReadRequestModel =
        NotificationReadRequestModel(
            languageId: int.tryParse(getIt<LanguageService>().languageId) ?? 1,
            platform: getPlatformName(),
            version: getIt<MainConfig>().packageInfo.version,
            customerToken: getIt<UserProfileService>().customerToken,
            notifiactionIds: notificationIds);

    DebugLog.instance.i(
        'notificationReadRequestModel created: ${notificationReadRequestModel.toJson()}');
    final ResponseHandler<Map<String, dynamic>?> response =
        await MainConfig.apiClient.handleApiCall<Map<String, dynamic>>(
            endUrl: Apis.readNotificationCount,
            apiType: ApiType.post,
            data: notificationReadRequestModel.toJson());

    return getParsedResponseHandler(
        responseHandler: response,
        parser: (Map<String, dynamic> value) {
          final BaseResponse<List<void>> result = BaseResponse<List<void>>(
            success: value['success'] == true || value['status_code'] == 200,
            statusCode: value['status_code'] ?? 0,
            message: value['message'] ?? '',
            totalCount: value['total_count'] as int?,
            error: value['error'] as String?,
          );

          return result;
        });
  }
}
