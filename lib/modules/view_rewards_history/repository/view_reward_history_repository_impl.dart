import '../../../utils/exports.dart';

/// Implementation of the view reward history repository.
class ViewRewardHistoryRepositoryImpl extends ViewRewardHistoryRepository {
  @override
  Future<ResponseHandler<ViewRewardHistoryResponse>> getRewardsList(
      ViewRewardHistoryRequest viewRewardHistoryRequest) async {

    final ResponseHandler<Map<String, dynamic>?> response = await MainConfig.apiClient
        .handleApiCall<Map<String, dynamic>>(
            endUrl: Apis.viewRewards,
            params: viewRewardHistoryRequest.toJson());

    return getParsedResponseHandler(
      responseHandler: response,
      parser: (Map<String, dynamic> value) => ViewRewardHistoryResponse.fromJson(
        value,
      ),
    );
  }
}
