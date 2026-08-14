import '../../../utils/exports.dart';

class MyTradesRepositoryImpl extends MyTradesRepository {
  @override
  Future<ResponseHandler<BaseResponse<List<TradeResponse>>>> getMyTrades({
    String? status,
    int? limit,
    int? offset,
    String? fromDate,
    String? toDate,
  }) async {
    final Map<String, dynamic> params = <String, dynamic>{};
    if (status != null && status.isNotEmpty) {
      params['status'] = status;
    }
    if (limit != null) {
      params['limit'] = limit;
    }
    if (offset != null) {
      params['offset'] = offset;
    }
    if (fromDate != null && fromDate.isNotEmpty) {
      params['fromDate'] = fromDate;
    }
    if (toDate != null && toDate.isNotEmpty) {
      params['toDate'] = toDate;
    }

    final String role = UserProfileService.instance().roleName.toUpperCase();
    final String endUrl = (role == 'TRADER' || role == 'MENTOR' || role == 'ADMIN')
        ? Apis.traderMyTrades
        : Apis.clientMyTrades;

    final ResponseHandler<Map<String, dynamic>?> response = await MainConfig
        .apiClient
        .handleApiCall<Map<String, dynamic>>(
          endUrl: endUrl,
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

  @override
  Future<ResponseHandler<BaseResponse<List<TradeResponse>>>> searchTrades({
    required String keyword,
  }) async {
    final Map<String, dynamic> params = <String, dynamic>{
      'keyword': keyword,
    };

    final ResponseHandler<Map<String, dynamic>?> response = await MainConfig
        .apiClient
        .handleApiCall<Map<String, dynamic>>(
          endUrl: Apis.searchMyTrades,
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
