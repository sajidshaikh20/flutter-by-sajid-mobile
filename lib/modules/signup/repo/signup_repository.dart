import '../../../utils/exports.dart';

/// Abstract repository for signup and verification operations.
abstract class SignUpRepository extends BaseRepository {
  SignUpRepository();

  /// Starts registration with name and email.
  Future<ResponseHandler<BaseResponse<SignUpResponse>>> startRegistration(
      StartRegistrationRequest request);

  /// Verifies email OTP.
  Future<ResponseHandler<BaseResponse<SignUpResponse>>> verifyEmailOtp(
      VerifyEmailOtpRequest request);

  /// Sends phone OTP linking to current registration.
  Future<ResponseHandler<BaseResponse<SignUpResponse>>> sendPhoneOtp(
      SendPhoneOtpRequest request);

  /// Verifies phone OTP.
  Future<ResponseHandler<BaseResponse<SignUpResponse>>> verifyPhoneOtp(
      VerifyPhoneOtpRequest request);

  /// Completes full registration profile.
  Future<ResponseHandler<BaseResponse<SignUpResponse>>> completeRegistration(
      CompleteRegistrationRequest request);
}
