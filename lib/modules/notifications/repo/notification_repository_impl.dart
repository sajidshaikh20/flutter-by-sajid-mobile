import '../../../utils/exports.dart';
import '../model/paginated_notifications.dart';
import 'notification_repository.dart';

/// Implementation of [NotificationRepository] that communicates with the backend.
class NotificationRepositoryImpl extends NotificationRepository {
  @override
  Future<ResponseHandler<BaseResponse<PaginatedNotifications>>> getNotifications({
    required int page,
    required int size,
  }) async {
    final Map<String, dynamic> params = <String, dynamic>{
      'page': page,
      'size': size,
    };

    final ResponseHandler<Map<String, dynamic>?> response = await MainConfig
        .apiClient
        .handleApiCall<Map<String, dynamic>>(
          endUrl: Apis.notifications,
          apiType: ApiType.get,
          params: params,
        );

    return getParsedResponseHandler(
      responseHandler: response,
      parser: (Map<String, dynamic> value) {
        return BaseResponse<PaginatedNotifications>.fromJson(
          value,
          (Object? json) =>
              PaginatedNotifications.fromJson(json as Map<String, dynamic>),
        );
      },
    );
  }

  @override
  Future<ResponseHandler<BaseResponse<dynamic>>> markRead(dynamic notificationId) async {
    final ResponseHandler<Map<String, dynamic>?> response = await MainConfig
        .apiClient
        .handleApiCall<Map<String, dynamic>>(
          endUrl: Apis.markNotificationRead(notificationId),
          apiType: ApiType.put,
        );

    return getParsedResponseHandler(
      responseHandler: response,
      parser: (Map<String, dynamic> value) {
        return BaseResponse<dynamic>.fromJson(value, (Object? json) => json);
      },
    );
  }
}
