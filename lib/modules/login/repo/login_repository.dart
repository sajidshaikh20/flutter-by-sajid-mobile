import '../../../utils/exports.dart';

/// Abstract repository for login operations.
abstract class LoginRepository extends BaseRepository {
  /// Creates an instance of [LoginRepository].
  LoginRepository();

  /// Calls the login API with user credentials.
  ///
  /// [request] The login request model containing user credentials.
  ///
  /// Returns a [ResponseHandler] containing [BaseResponse<LoginUserResponse>]
  /// with the login result and user information.
  Future<ResponseHandler<BaseResponse<LoginUserResponse>>>  callLoginApi(
      LoginRequestModel request);
}
