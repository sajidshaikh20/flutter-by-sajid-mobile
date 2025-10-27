import '../../../utils/exports.dart';
///ChangePasswordRepository
abstract class ChangePasswordRepository extends BaseRepository {
  /// Change password API
  Future<ResponseHandler<BaseResponse<dynamic>>> callChangePasswordApi(
      ChangePasswordRequestModel request);
}
