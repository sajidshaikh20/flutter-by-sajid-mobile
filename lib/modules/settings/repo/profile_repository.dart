import 'package:image_picker/image_picker.dart';

import '../../../utils/exports.dart';

abstract class ProfileRepository extends BaseRepository {
  Future<ResponseHandler<BaseResponse<ClientProfileResponse>>> getProfile();
  Future<ResponseHandler<BaseResponse<ClientProfileResponse>>> updateProfile(
    UpdateClientProfileRequest request,
  );
  Future<ResponseHandler<BaseResponse<ClientProfileResponse>>> uploadProfilePicture(
    XFile file,
  );
}
