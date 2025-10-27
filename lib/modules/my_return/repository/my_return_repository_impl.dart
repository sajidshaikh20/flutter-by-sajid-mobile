import '../../../utils/exports.dart';

/// Implementation of MyReturnRepository to fetch return orders.
class MyReturnRepositoryImpl extends MyReturnRepository {
  @override
  /// Fetches the user's return orders from the API.
  Future<ResponseHandler<MyReturnModel>> getMyReturnList({
    required ReturnOrderRequestModel myReturnRequestModel,
  }) async {
    ResponseHandler<Map<String, dynamic>?> response =
    await MainConfig.apiClient.handleApiCall<Map<String, dynamic>>(
      endUrl: Apis.myReturn,
      apiType: ApiType.post,
      params: myReturnRequestModel.toJson(),
    );
    return getParsedResponseHandler(
      responseHandler: response,
      parser: MyReturnModel.fromJson,
    );
  }
}
