import '../../../utils/exports.dart';

/// Abstract repository for forgot password operations.
abstract class ForgotPasswordRepository extends BaseRepository {
  /// Calls the forgot password API with mobile number.
  ///
  /// [request] The request model containing mobile number and other parameters.
  ///
  /// Returns a [ResponseHandler] containing [BaseResponse<void>] with the operation result.
  Future<ResponseHandler<BaseResponse<void>>>
      callForgotPasswordWithMobileApi(
          ForgotPasswordWithMobileRequestModel request);

  /// Calls the forgot password API with email address.
  ///
  /// [request] The request model containing email and other parameters.
  ///
  /// Returns a [ResponseHandler] containing [BaseResponse<void>] with the operation result.
  Future<ResponseHandler<BaseResponse<void>>>
      callForgotPasswordWithEmailApi(
          ForgotPasswordWithEmailRequestModel request);
}
