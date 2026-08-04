import '../../../utils/exports.dart';

class HomeRepositoryImpl extends HomeRepository {
  @override
  Future<ResponseHandler<BaseResponse<HomeDashboardResponse>>> getClientDashboard() async {
    final String role = UserProfileService.instance().roleName.toUpperCase();
    final String endpoint = (role == 'TRADER' || role == 'MENTOR')
        ? Apis.traderDashboard
        : Apis.clientDashboard;

    final ResponseHandler<Map<String, dynamic>?> response = await MainConfig
        .apiClient
        .handleApiCall<Map<String, dynamic>>(
          endUrl: endpoint,
        );

    return getParsedResponseHandler(
      responseHandler: response,
      parser: (Map<String, dynamic> value) {
        return BaseResponse<HomeDashboardResponse>.fromJson(
          value,
          (Object? json) =>
              HomeDashboardResponse.fromJson(json as Map<String, dynamic>),
        );
      },
    );
  }

  @override
  Future<ResponseHandler<BaseResponse<List<TradeResponse>>>> getRecentTrades({int? limit}) async {
    final Map<String, dynamic> params = <String, dynamic>{};
    if (limit != null) {
      params['limit'] = limit;
    }

    final ResponseHandler<Map<String, dynamic>?> response = await MainConfig
        .apiClient
        .handleApiCall<Map<String, dynamic>>(
          endUrl: Apis.getRecentTrades,
          params: params,
        );

    return getParsedResponseHandler(
      responseHandler: response,
      parser: (Map<String, dynamic> value) {
        return BaseResponse<List<TradeResponse>>.fromJson(
          value,
          (Object? json) {
            final List<dynamic> list = json as List<dynamic>? ?? <dynamic>[];
            return list
                .map((dynamic t) => TradeResponse.fromJson(t as Map<String, dynamic>))
                .toList();
          },
        );
      },
    );
  }
}
