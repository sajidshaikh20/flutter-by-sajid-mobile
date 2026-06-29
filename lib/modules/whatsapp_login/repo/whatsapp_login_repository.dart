import '../../../utils/exports.dart';
import '../model/model.dart';

abstract class WhatsAppLoginRepository extends BaseRepository {
  WhatsAppLoginRepository();

  Future<ResponseHandler<BaseResponse<Map<String, dynamic>>>> callSendLoginOtpApi(
      SendLoginOtpRequest request);

  Future<ResponseHandler<BaseResponse<LoginUserResponse>>> callLoginWithOtpApi(
      LoginWithOtpRequest request);
}
