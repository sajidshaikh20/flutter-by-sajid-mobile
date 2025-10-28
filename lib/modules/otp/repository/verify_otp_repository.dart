import '../../../../utils/exports.dart';

/// Abstract repository for OTP verification operations.
abstract class VerifyOtpRepository extends BaseRepository {
  /// Calls the sign up API with user registration data.
  ///
  /// Returns a [ResponseHandler] containing [BaseResponse<SignupUserResponse>]
  /// with the signup result.
  Future<ResponseHandler<BaseResponse<SignupUserResponse>>> callSignUpApi(
      SignupRequestModel request);

  /// Calls the sign up user OTP API to verify the OTP code.
  ///
  /// Returns a [ResponseHandler] containing [BaseResponse<void>]
  /// indicating OTP verification success or failure.
  Future<ResponseHandler<BaseResponse<void>>> callSignUpUserOtpApi(
      SignUpUserOtpRequestModel request);

  /// Calls the verify OTP API for password reset verification.
  ///
  /// Returns a [ResponseHandler] containing [BaseResponse<void>]
  /// indicating OTP verification success or failure.
  Future<ResponseHandler<BaseResponse<void>>> callverifyOtp(
      ForgotPasswordWithMobileRequestModel request);


}
