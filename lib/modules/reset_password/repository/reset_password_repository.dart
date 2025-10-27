import '../../../utils/exports.dart';

/// Abstract repository for reset password operations.
abstract class ResetPasswordRepository extends BaseRepository {
  ///Reset password with mobile API
  Future<ResponseHandler<BaseResponse<void>>>
      callResetPasswordWithMobileApi(
          ResetPasswordWithMobileRequestModel request);
}
