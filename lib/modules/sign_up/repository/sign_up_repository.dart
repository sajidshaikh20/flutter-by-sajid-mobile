import '../../../utils/exports.dart';

/// Abstract repository for sign up operations.
abstract class SignUpRepository extends BaseRepository {
  /// Calls the CMS API to get content data.
  ///
  /// Returns a [ResponseHandler] containing the [CmsResponseModel].
  Future<ResponseHandler<CmsResponseModel>> callCMSApi({
    required CmsRequestModel cmsRequestModel,
  });

  /// Calls the sign up OTP API to send verification code.
  ///
  /// Returns a [ResponseHandler] with the API response.
  Future<ResponseHandler<BaseResponse<void>>> callSignUpUserOtpApi(
      SignUpUserOtpRequestModel request);
}
