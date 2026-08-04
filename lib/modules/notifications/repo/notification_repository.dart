import '../../../utils/exports.dart';
import '../model/paginated_notifications.dart';

/// Abstract class outlining repository operations for notifications.
abstract class NotificationRepository extends BaseRepository {
  /// Fetches a paginated list of notifications.
  Future<ResponseHandler<BaseResponse<PaginatedNotifications>>> getNotifications({
    required int page,
    required int size,
  });

  /// Marks a specific notification as read.
  Future<ResponseHandler<BaseResponse<dynamic>>> markRead(dynamic notificationId);
}
