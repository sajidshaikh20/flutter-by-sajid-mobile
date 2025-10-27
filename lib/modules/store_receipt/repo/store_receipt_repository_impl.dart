import '../../../utils/exports.dart';

/// Implementation of [StoreReceiptRepository] that handles API
/// calls for store receipt-related operations.
class StoreReceiptRepositoryImpl extends StoreReceiptRepository {
  /// Fetches the list of store receipts using the same API as my order listing.
  ///
  /// - [myOrderRequestModel]: Request model with parameters for the API call.
  /// - Returns a [ResponseHandler] containing a [BaseResponse] with list of [ListOfMyOrderResponse].
  @override
  Future<ResponseHandler<BaseResponse<List<ListOfMyOrderResponse>>>> callStoreReceiptList(MyOrderRequestModel myOrderRequestModel) async {
    ResponseHandler<Map<String, dynamic>?> response =
        await MainConfig.apiClient.handleApiCall<Map<String, dynamic>>(
      endUrl: Apis.myOrder,
      apiType: ApiType.post,
      data: myOrderRequestModel.toJson(),
    );

    return getParsedResponseHandler(
      responseHandler: response,
      parser: (Map<String, dynamic> value) {
        final List<ListOfMyOrderResponse> orders =
        (value['data'] as List<dynamic>? ?? <dynamic>[])
            .whereType<Map<String, dynamic>>()
            .map((Map<String, dynamic> item) =>
            ListOfMyOrderResponse.fromJson(item))
            .toList();

        final BaseResponse<List<ListOfMyOrderResponse>> result =
        BaseResponse<List<ListOfMyOrderResponse>>(
          success: value['success'] == true || value['status_code'] == 200,
          statusCode: value['status_code'] ?? 0,
          message: value['message'] ?? '',
          data: orders,
          totalCount: value['total_count'] as int?,
          error: value['error'] as String?,
        );

        return result;
      },
    );
  }

  /// Downloads a specific receipt.
  ///
  /// - [receiptId]: The ID of the receipt to be downloaded.
  /// - Returns a [ResponseHandler] containing the download response.
  @override
  Future<ResponseHandler<Map<String, dynamic>>> callDownloadReceiptAPI(String? receiptId) async {
    Map<String, dynamic> param = <String, dynamic>{};
    ResponseHandler<Map<String, dynamic>?> response =
        await MainConfig.apiClient.handleApiCall<Map<String, dynamic>>(
      endUrl: Apis.getReOrder, // Using existing API endpoint for now
      apiType: ApiType.post,
      params: param,
    );

    return response as ResponseHandler<Map<String, dynamic>>;
  }
} 