import '../../../utils/exports.dart';

/// Implementation of the MyOrderDetailRepository for data operations.
class MyOrderDetailRepositoryImpl extends MyOrderDetailRepository {
  ///Order detail api
  @override
  Future<ResponseHandler<BaseResponse<List<MyOrderDetailResponseModel>>>> callGetOderDetail(
     MyOrderDetailRequestModel orderDetailReqModel,
  ) async {
    ResponseHandler<Map<String, dynamic>?> response =
        await MainConfig.apiClient.handleApiCall<Map<String, dynamic>>(
      endUrl: Apis.myOrderDetail,
      apiType: ApiType.post,
      data: orderDetailReqModel.toJson(),

    );
    return getParsedResponseHandler(
      responseHandler: response,
      parser: (Map<String, dynamic> value) {
        final List<MyOrderDetailResponseModel> myOrderDetailResponseModel =
        (value['data'] as List<dynamic>? ?? <dynamic>[])
            .whereType<Map<String, dynamic>>()
            .map((Map<String, dynamic> item) =>
            MyOrderDetailResponseModel.fromJson(item))
            .toList();

        return BaseResponse<List<MyOrderDetailResponseModel>>(
          success: value['success'] == true || value['status_code'] == 200,
          statusCode: value['status_code'] ?? 0,
          message: value['message'] ?? '',
          data: myOrderDetailResponseModel,
          totalCount: value['total_count'] as int?,
          error: value['error'] as String?,
        );
      },
    );

  }

  ///Re-order api
  @override
  Future<ResponseHandler<ReOrderModel>> callReOrderAPI(String? orderId) async {
    ReorderApiRequestModel reOrderApiModel = ReorderApiRequestModel(
      token: getIt<UserProfileService>().customerToken,
      incrementId: orderId,
    );

    ResponseHandler<Map<String, dynamic>?> response =
        await MainConfig.apiClient.handleApiCall<Map<String, dynamic>>(
      endUrl: Apis.getReOrder,
      apiType: ApiType.post,
      params: reOrderApiModel.toJson(),

    );

    return getParsedResponseHandler(
      responseHandler: response,
      parser: ReOrderModel.fromJson,
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
