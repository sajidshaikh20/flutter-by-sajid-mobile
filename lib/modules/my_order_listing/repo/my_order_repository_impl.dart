import '../../../utils/exports.dart';

/// Implementation of [MyOrderRepository] that handles API
/// calls for order-related operations.
class MyOrderRepositoryImpl extends MyOrderRepository {

  @override
  Future<ResponseHandler<BaseResponse<List<ListOfMyOrderResponse>>>> callMyOrderListApi(MyOrderRequestModel myOrderRequestModel) async{
    ResponseHandler<Map<String, dynamic>?> response =
        await MainConfig.apiClient.handleApiCall<Map<String, dynamic>>(
      endUrl: Apis.myOrder,
      apiType: ApiType.post,
      data: myOrderRequestModel.toJson(),
      showLoader: true,
    );
    return getParsedResponseHandler(
      responseHandler: response,
      parser: (Map<String, dynamic> value) {
        final List<ListOfMyOrderResponse> deals =
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
          data: deals,
          totalCount: value['total_count'] as int?,
          error: value['error'] as String?,
        );

        return result;
      },
    );
  }

  @override
  Future<ResponseHandler<BaseResponse<dynamic>>> callCancelOrder(String? orderId) async {
    CancelOrderRequestModel cancelOrderRequestModel = CancelOrderRequestModel(
        languageId: int.tryParse(getIt<LanguageService>().languageId) ?? 1,
        platform: getPlatformName(),
        version: getIt<MainConfig>().packageInfo.version,
        customerToken: getIt<UserProfileService>().customerToken,
        orderId: orderId
    );
    DebugLog.instance
        .i('cancelOrderRequestModel created: ${cancelOrderRequestModel.toJson()}');
    final ResponseHandler<Map<String, dynamic>?> response =
    await MainConfig.apiClient.handleApiCall<Map<String, dynamic>>(
        endUrl: Apis.cancelOrder,
        apiType: ApiType.post,
        data: cancelOrderRequestModel.toJson(),
        showLoader: true);

    return getParsedResponseHandler(
        responseHandler: response,
        parser: (Map<String, dynamic> value) {
          final BaseResponse<List<void>> result =
          BaseResponse<List<void>>(
            success: value['success'] == true || value['status_code'] == 200,
            statusCode: value['status_code'] ?? 0,
            message: value['message'] ?? '',
            totalCount: value['total_count'] as int?,
            error: value['error'] as String?,
          );

          return result;
        });
  }

  //Re Order API
  @override
  Future<ResponseHandler<BaseResponse<dynamic>>> callReorder(
      ReorderRequestModel reorderRequestModel, {
        bool showLoader = true,
      }) async {
    ResponseHandler<Map<String, dynamic>?> response =
    await MainConfig.apiClient.handleApiCall<Map<String, dynamic>>(
      endUrl: Apis.reOrder, // Updated endpoint
      apiType: ApiType.post,
      data: reorderRequestModel.toJson(), // Changed from FormData to JSON data
      showLoader: showLoader,
    );
    return getParsedResponseHandler(
        responseHandler: response,
        parser: (Map<String, dynamic> value) {
          final BaseResponse<List<void>> result =
          BaseResponse<List<void>>(
            success: value['success'] == true || value['status_code'] == 200,
            statusCode: value['status_code'] ?? 0,
            message: value['message'] ?? '',
            totalCount: value['total_count'] as int?,
            error: value['error'] as String?,
          );

          return result;
        });
  }
}
