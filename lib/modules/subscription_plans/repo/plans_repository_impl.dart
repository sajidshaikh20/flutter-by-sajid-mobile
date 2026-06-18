import '../../../utils/exports.dart';

class PlansRepositoryImpl extends PlansRepository {
  @override
  Future<ResponseHandler<BaseResponse<List<PlanResponse>>>> getPlans() async {
    final ResponseHandler<Map<String, dynamic>?> response = await MainConfig
        .apiClient
        .handleApiCall<Map<String, dynamic>>(
          endUrl: Apis.getAllPlans,
          showLoader: true,
        );

    return getParsedResponseHandler(
      responseHandler: response,
      parser: (Map<String, dynamic> value) {
        return BaseResponse<List<PlanResponse>>.fromJson(
          value,
          (Object? json) {
            final List<dynamic> list = json as List<dynamic>? ?? <dynamic>[];
            return list
                .map((dynamic p) => PlanResponse.fromJson(p as Map<String, dynamic>))
                .toList();
          },
        );
      },
    );
  }

  @override
  Future<ResponseHandler<BaseResponse<dynamic>>> createSubscription(
    CreateSubscriptionRequest request,
  ) async {
    final ResponseHandler<Map<String, dynamic>?> response = await MainConfig
        .apiClient
        .handleApiCall<Map<String, dynamic>>(
          endUrl: Apis.createSubscription,
          apiType: ApiType.post,
          showLoader: true,
          data: request.toJson(),
        );

    return getParsedResponseHandler(
      responseHandler: response,
      parser: (Map<String, dynamic> value) {
        return BaseResponse<dynamic>.fromJson(
          value,
          (Object? json) => json,
        );
      },
    );
  }
}
