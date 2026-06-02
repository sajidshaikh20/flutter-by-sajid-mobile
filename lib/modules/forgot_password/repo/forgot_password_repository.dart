import '../../../utils/exports.dart';

/// Repository for forgot password operations.
abstract class ForgotPasswordRepository extends BaseRepository {
  /// Sends password reset link to [email].
  Future<ResponseHandler<BaseResponse<void>>> sendResetLink({
    required String email,
  });
}
