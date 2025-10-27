import '../../../utils/exports.dart';

/// An implementation of the [AddressRepository]
/// that handles API calls for address data.
class AddressRepositoryImpl extends AddressRepository {
  /// Fetches the list of addresses based on the provided request model.
  @override
  Future<ResponseHandler<BaseResponse<List<MyAddressListingResponse>>>> getAddressList(
      AddressListRequestModelDukkan request,
      ) async {
    ResponseHandler<Map<String, dynamic>?> response =
    await MainConfig.apiClient.handleApiCall<Map<String, dynamic>>(
      endUrl: Apis.addressListing,
      data: request.toJson(),
    );

    return getParsedResponseHandler(
      responseHandler: response,
      parser: (Map<String, dynamic> value) {
        try {
          final List<dynamic> dataList = (value['data'] as List<dynamic>?) ?? <dynamic>[];
          final List<MyAddressListingResponse> addresses = dataList.map<MyAddressListingResponse>((dynamic item) {
            try {
              if (item is Map<String, dynamic>) {
                return MyAddressListingResponse.fromJson(item);
              } else {
                return MyAddressListingResponse();
              }
            } on Exception {
              return MyAddressListingResponse();
            }
          }).toList();

          return BaseResponse<List<MyAddressListingResponse>>(
            success: value['success'] ?? false,
            statusCode: value['status_code'] ?? 0,
            message: value['message'] ?? '',
            totalCount: value['total_count'],
            data: addresses,
          );
        } on Exception {
          return BaseResponse<List<MyAddressListingResponse>>(
            success: false,
            statusCode: 0,
            message: 'Error parsing response',
            data: <MyAddressListingResponse>[],
          );
        }
      },
    );
  }



  /// Deletes an address based on the provided delete address request model.
  @override
  Future<ResponseHandler<BaseResponse<void>>> deleteAddressApi({
    required DeleteAddressRequestModel deleteAddressRequestModel,
  }) async
  {
    ResponseHandler<Map<String, dynamic>?> response =
        await MainConfig.apiClient.handleApiCall<Map<String, dynamic>>(
      endUrl: Apis.deleteAddressListing,
      apiType: ApiType.delete,
      showLoader: true,
      data: deleteAddressRequestModel.toJson(),
    );
    return getParsedResponseHandler(
      responseHandler: response,
      parser: (Map<String, dynamic> value) {
        return BaseResponse<void>.fromJson(
          value,
              (_) {}, // No data expected, so return null
        );
      },
    );
  }

  /// Sets a default address based on the provided save default address model.
  @override
  Future<ResponseHandler<DeleteAddressResponse>> saveDefaultAddressApi({
    required SaveDefaultAddressRequestModel saveDefaultAddressModel,
  }) async {
    ResponseHandler<Map<String, dynamic>?> response =
        await MainConfig.apiClient.handleApiCall<Map<String, dynamic>>(
      endUrl: Apis.saveDefaultAddress,
      apiType: ApiType.post,
      options: Options(contentType: AppConstant.contentType),
      data: saveDefaultAddressModel.toJson(),
    );
    return getParsedResponseHandler(
      responseHandler: response,
      parser: DeleteAddressResponse.fromJson,
    );
  }

  /// Fetches address form data based on the provided request model.
  @override
  Future<ResponseHandler<GetAddressFormDataResponse>> getAddressFormData({
    required GetAddressFormData addressListRequestModel,
  }) async {
    ResponseHandler<Map<String, dynamic>?> response =
        await MainConfig.apiClient.handleApiCall<Map<String, dynamic>>(
      endUrl: Apis.addressFormData,
      params: addressListRequestModel.toJson(),
    );
    return getParsedResponseHandler(
      responseHandler: response,
      parser: GetAddressFormDataResponse.fromJson,
    );
  }

  /// Fetches city address form data based on
  /// the provided city address request model.
  @override
  Future<ResponseHandler<GetCityAddressResponse>> getCityAddressFormData({
    required GetCityAddressRequestModel cityAddressListRequestModel,
  }) async {
    ResponseHandler<Map<String, dynamic>?> response =
        await MainConfig.apiClient.handleApiCall<Map<String, dynamic>>(
      endUrl: Apis.addressCity,
      params: cityAddressListRequestModel.toJson(),
    );
    return getParsedResponseHandler(
      responseHandler: response,
      parser: GetCityAddressResponse.fromJson,
    );
  }

  /// Adds address form data based on the provided add address request model.
  @override
  Future<ResponseHandler<SaveAddressResponseModel>> addAddressFormData({
    required AddAddressRequestModel addAddressListRequestModel,
  }) async {
    ResponseHandler<Map<String, dynamic>?> response =
        await MainConfig.apiClient.handleApiCall<Map<String, dynamic>>(
      endUrl: Apis.saveAddress,
      apiType: ApiType.post,
      params: addAddressListRequestModel.toJson(),
    );
    return getParsedResponseHandler(
      responseHandler: response,
      parser: SaveAddressResponseModel.fromJson,
    );
  }

  @override
  Future<ResponseHandler<BaseResponse<List<ListOfStoreResponse>>>> getPickupStoreListing(StoreListRequestModelDukkan request) async {
    ResponseHandler<Map<String, dynamic>?> response =
        await MainConfig.apiClient.handleApiCall<Map<String, dynamic>>(
      endUrl: Apis.listOfStore,
      apiType: ApiType.post,
      data: request.toJson(),
    );

    return getParsedResponseHandler(
      responseHandler: response,
      parser: (Map<String, dynamic> value) {
        try {
          final List<dynamic> dataList = (value['data'] as List<dynamic>?) ?? <dynamic>[];
          final List<ListOfStoreResponse> stores = dataList.map<ListOfStoreResponse>((dynamic item) {
            try {
              if (item is Map<String, dynamic>) {
                return ListOfStoreResponse.fromJson(item);
              } else {
                return ListOfStoreResponse();
              }
            } on Exception {
              return ListOfStoreResponse();
            }
          }).toList();

          return BaseResponse<List<ListOfStoreResponse>>(
            success: value['status'] == 200,
            statusCode: value['status'] ?? 0,
            message: value['message'] ?? '',
            data: stores,
            totalCount: value['total_count'] ?? 0,
          );
        } on Exception {
          return BaseResponse<List<ListOfStoreResponse>>(
            success: false,
            statusCode: 0,
            message: '',
            data: <ListOfStoreResponse>[],
            totalCount: 0,
          );
        }
      },
    );
  }

  /// Changes the store using the provided change store request model.
  @override
  Future<ResponseHandler<DeleteAddressResponse>> changeStoreApi({
    required ChangeStoreRequest changeStoreRequest,
  }) async {
    ResponseHandler<Map<String, dynamic>?> response =
        await MainConfig.apiClient.handleApiCall<Map<String, dynamic>>(
      endUrl: Apis.changeStoreOrOrderMethod,
      apiType: ApiType.post,
      showLoader: true,
      data: changeStoreRequest.toJson(),
    );
    return getParsedResponseHandler(
      responseHandler: response,
      parser: DeleteAddressResponse.fromJson,
    );
  }
}
