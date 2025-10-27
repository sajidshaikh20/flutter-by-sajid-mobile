import '../../../utils/exports.dart';

/// Abstract repository for handling Edit Profile related API calls.
abstract class EditProfileRepository extends BaseRepository {
  /// Default constructor.
  EditProfileRepository();

  /// Calls the API to save the user's edited profile data.
  ///
  /// [editProfileRequestModel] contains all the fields required to update
  /// the user's profile such as name, mobile number, token, etc.
  ///
  /// Returns a [ResponseHandler] wrapping an [EditProfileModel] which contains
  /// the result of the API call, including success status, messages, and profile info.
  Future<ResponseHandler<BaseResponse<EditProfileResponse>>> callEditProfileSaveData({
    required EditProfileRequestModel editProfileRequestModel,
  });
///callUpdateEmail api
  Future<ResponseHandler<BaseResponse<void>>> callUpdateEmail({
    required UpdateEmailRequestModel updateEmailRequestModel,
  });
}
