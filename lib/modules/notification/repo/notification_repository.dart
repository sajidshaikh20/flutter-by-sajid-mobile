import '../../../utils/exports.dart';


/// Abstract repository for notification operations.
abstract class NotificationRepository extends BaseRepository {
  /// Creates an instance of [NotificationRepository].
  NotificationRepository();

  /// Fetches the list of notifications.
  ///
  /// [request] The request model containing parameters for the notification list API.
  ///
  /// Returns a [ResponseHandler] containing [BaseResponse<List<ListOfNotificationResponse>>]
  /// with the list of notifications.
  Future<ResponseHandler<BaseResponse<List<ListOfNotificationResponse>>>>
  getNotificationList(NotificationRequestModel request);

  /// Marks notifications as read.
  ///
  /// [notificationIds] List of notification IDs to mark as read.
  ///
  /// Returns a [ResponseHandler] containing [BaseResponse<dynamic>]
  /// indicating the success or failure of the operation.
  Future<ResponseHandler<BaseResponse<dynamic>>>
  readNotification(List<int>? notificationIds);
}



