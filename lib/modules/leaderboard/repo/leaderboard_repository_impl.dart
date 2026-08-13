import '../../../utils/exports.dart';

class LeaderboardRepositoryImpl extends LeaderboardRepository {
  @override
  Future<ResponseHandler<BaseResponse<List<LeaderboardItemResponse>>>> getLeaderboard({
    int? limit,
    int? offset,
    String? period,
    String? fromDate,
    String? toDate,
  }) async {
    final Map<String, dynamic> params = <String, dynamic>{};
    if (limit != null) {
      params['limit'] = limit;
    }
    if (offset != null) {
      params['offset'] = offset;
    }
    if (period != null) {
      params['period'] = period;
    }
    if (fromDate != null && toDate != null) {
      params['from'] = fromDate;
      params['to'] = toDate;
    }

    final ResponseHandler<Map<String, dynamic>?> response = await MainConfig
        .apiClient
        .handleApiCall<Map<String, dynamic>>(
          endUrl: Apis.getLeaderboard,
          params: params,
        );

    return getParsedResponseHandler(
      responseHandler: response,
      parser: (Map<String, dynamic> value) {
        return BaseResponse<List<LeaderboardItemResponse>>.fromJson(
          value,
          (Object? json) {
            final List<dynamic> list = json as List<dynamic>? ?? <dynamic>[];
            return list
                .map((dynamic item) => LeaderboardItemResponse.fromJson(item as Map<String, dynamic>))
                .toList();
          },
        );
      },
    );
  }

  @override
  Future<ResponseHandler<BaseResponse<dynamic>>> followTrader(String traderPublicId) async {
    final ResponseHandler<Map<String, dynamic>?> response = await MainConfig
        .apiClient
        .handleApiCall<Map<String, dynamic>>(
          endUrl: Apis.followTrader(traderPublicId),
          apiType: ApiType.post,
          data: <String, dynamic>{},
          showLoader: true,
        );

    return getParsedResponseHandler(
      responseHandler: response,
      parser: (Map<String, dynamic> value) {
        return BaseResponse<dynamic>.fromJson(value, (Object? json) => json);
      },
    );
  }

  @override
  Future<ResponseHandler<BaseResponse<dynamic>>> unfollowTrader(String traderPublicId) async {
    final ResponseHandler<Map<String, dynamic>?> response = await MainConfig
        .apiClient
        .handleApiCall<Map<String, dynamic>>(
          endUrl: Apis.unfollowTrader(traderPublicId),
          apiType: ApiType.delete,
          showLoader: true,
        );

    return getParsedResponseHandler(
      responseHandler: response,
      parser: (Map<String, dynamic> value) {
        return BaseResponse<dynamic>.fromJson(value, (Object? json) => json);
      },
    );
  }

  @override
  Future<ResponseHandler<BaseResponse<List<TradeResponse>>>> getFollowingTraders({
    int? limit,
    int? offset,
    String? status,
    String? fromDate,
    String? toDate,
  }) async {
    final Map<String, dynamic> params = <String, dynamic>{};
    if (limit != null) {
      params['limit'] = limit;
    }
    if (offset != null) {
      params['offset'] = offset;
    }
    if (status != null) {
      params['status'] = status;
    }
    if (fromDate != null) {
      params['fromDate'] = fromDate;
    }
    if (toDate != null) {
      params['toDate'] = toDate;
    }

    final ResponseHandler<Map<String, dynamic>?> response = await MainConfig
        .apiClient
        .handleApiCall<Map<String, dynamic>>(
          endUrl: Apis.getFollowing,
          apiType: ApiType.get,
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
                .map((dynamic item) => TradeResponse.fromJson(item as Map<String, dynamic>))
                .toList();
          },
        );
      },
    );
  }
}
