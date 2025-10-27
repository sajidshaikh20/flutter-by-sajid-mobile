import '../../../utils/exports.dart';

/// Abstract repository for notification setting operations.
abstract class NotificationSettingRepository extends BaseRepository {
  /// Creates an instance of [NotificationSettingRepository].
  NotificationSettingRepository();

  /// API for notification setting operations.
  ///
  /// [requestModel] The request model containing notification settings to update.
  ///
  /// Returns a [ResponseHandler] containing [BaseResponse<void>]
  /// indicating the success or failure of the operation.
  Future<ResponseHandler<BaseResponse<void>>> callNotificationSetting({required NotificationSettingRequestModel requestModel});
}
