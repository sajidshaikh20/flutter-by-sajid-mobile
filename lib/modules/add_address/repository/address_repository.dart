import '../../../utils/exports.dart';

/// An abstract class representing the repository for
///  address-related operations.
abstract class AddressRepository extends BaseRepository {
  /// Fetches the list of addresses associated with a given request model.
  Future<ResponseHandler<BaseResponse<List<MyAddressListingResponse>>>> getAddressList(
      AddressListRequestModelDukkan request,
      );

  /// Deletes an address using the provided delete address request model.
  Future<ResponseHandler<BaseResponse<void>>> deleteAddressApi({
    required DeleteAddressRequestModel deleteAddressRequestModel,
  });

  /// Sets a default address using the provided save default
  /// address request model.
  Future<ResponseHandler<DeleteAddressResponse>> saveDefaultAddressApi({
    required SaveDefaultAddressRequestModel saveDefaultAddressModel,
  });

  /// Fetches address form data based on the provided request model.
  Future<ResponseHandler<GetAddressFormDataResponse>> getAddressFormData({
    required GetAddressFormData addressListRequestModel,
  });

  /// Fetches city address form data using the given city address request model.
  Future<ResponseHandler<GetCityAddressResponse>> getCityAddressFormData({
    required GetCityAddressRequestModel cityAddressListRequestModel,
  });

  /// Adds an address using the provided address form data request model.
  Future<ResponseHandler<SaveAddressResponseModel>> addAddressFormData({
    required AddAddressRequestModel addAddressListRequestModel,
  });

  /// Adds an address using the get PickupStoreListing.
  Future<ResponseHandler<BaseResponse<List<ListOfStoreResponse>>>> getPickupStoreListing(
      StoreListRequestModelDukkan request,
      );

  /// Changes the store using the provided change store request model.
  Future<ResponseHandler<DeleteAddressResponse>> changeStoreApi({
    required ChangeStoreRequest changeStoreRequest,
  });
}
