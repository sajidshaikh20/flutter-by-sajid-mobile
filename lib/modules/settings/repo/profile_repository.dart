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
  Future<ResponseHandler<BaseResponse<dynamic>>> deleteAccount();
  Future<ResponseHandler<BaseResponse<dynamic>>> logout();
  Future<ResponseHandler<BaseResponse<TradingPreferencesResponse>>> getTradingPreferences();
  Future<ResponseHandler<BaseResponse<ClientProfileResponse>>> updateBalanceAndRisk({
    double? amountBalance,
    double? riskPercentage,
  });
  Future<ResponseHandler<BaseResponse<dynamic>>> changePassword({
    required String currentPassword,
    required String newPassword,
  });
}
