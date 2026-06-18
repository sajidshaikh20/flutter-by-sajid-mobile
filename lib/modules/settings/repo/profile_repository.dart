import '../../../utils/exports.dart';

abstract class ProfileRepository extends BaseRepository {
  Future<ResponseHandler<BaseResponse<ClientProfileResponse>>> getProfile();
  Future<ResponseHandler<BaseResponse<ClientProfileResponse>>> updateProfile(
    UpdateClientProfileRequest request,
  );
}
