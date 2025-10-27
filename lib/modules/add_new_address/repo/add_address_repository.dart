import '../../../utils/exports.dart';

/// An abstract repository that defines methods for adding or updating an address.
///
/// This repository extends [BaseRepository] and provides a contract
/// for performing add or update address API operations.
abstract class AddAddressRepository extends BaseRepository {
  /// Calls the API to add or update an address.
  ///
  /// Takes an [AddNewAddressRequestModel] as input, which contains
  /// all the necessary address details and metadata.
  ///
  /// Returns a [ResponseHandler] containing a [BaseResponse] that wraps
  /// an [AddNewAddressResponseModel], which includes information such as
  /// the newly created or updated address ID.
  Future<ResponseHandler<BaseResponse<AddNewAddressResponseModel>>> callAddUpdateAddress(
      AddNewAddressRequestModel request,
      );
}
