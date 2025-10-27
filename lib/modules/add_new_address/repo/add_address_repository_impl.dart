import '../../../utils/exports.dart';

/// Implementation of [AddAddressRepository] that performs API calls
/// for adding or updating addresses.
class AddAddressRepositoryImpl extends AddAddressRepository {
  /// Sends a request to add or update an address via the API.
  ///
  /// The [request] parameter contains all the necessary address details.
  /// The API call is performed as a POST request to [Apis.addressAddUpdate].
  ///
  /// Returns a [ResponseHandler] containing a [BaseResponse] that wraps
  /// an [AddNewAddressResponseModel], which holds the ID of the created
  /// or updated address.
  @override
  Future<ResponseHandler<BaseResponse<AddNewAddressResponseModel>>> callAddUpdateAddress(
      AddNewAddressRequestModel request,
      ) async {
    final ResponseHandler<Map<String, dynamic>?> response = await MainConfig.apiClient
        .handleApiCall<Map<String, dynamic>>(
      endUrl: Apis.addressAddUpdate,
      apiType: ApiType.post,
      showLoader: true,
      data: request.toJson(),
    );

    return getParsedResponseHandler(
      responseHandler: response,
      parser: (Map<String, dynamic> value) {
        return BaseResponse<AddNewAddressResponseModel>.fromJson(
          value,
              (Object? json) =>
              AddNewAddressResponseModel.fromJson(json as Map<String, dynamic>),
        );
      },
    );
  }
}
