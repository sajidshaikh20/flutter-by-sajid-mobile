import '../../../utils/exports.dart';

/// Abstract repository class for handling contact us requests.
abstract class ContactUsRepository extends BaseRepository {
  /// Repository class constructor
  ContactUsRepository();

  /// Abstract method for sending a contact us request and getting the response.
  ///
  /// Takes a [ContactUsRequestModel] as parameter and returns a [ResponseHandler]
  /// with a [ContactUsResponseModel].
  Future<ResponseHandler<BaseResponse<void>>> contactUsApi({
    required ContactUsRequestModel contactUsRequestModel,
  });
}
