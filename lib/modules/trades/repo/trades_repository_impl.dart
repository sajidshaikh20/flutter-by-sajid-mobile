import '../../../utils/exports.dart';

class TradesRepositoryImpl extends TradesRepository {
  @override
  Future<ResponseHandler<BaseResponse<List<TradeResponse>>>> getTradesByPlan({
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

    final ResponseHandler<Map<String, dynamic>?> response = await MainConfig
        .apiClient
        .handleApiCall<Map<String, dynamic>>(
          endUrl: Apis.getTradesByPlan,
          params: params,
        );

    return getParsedResponseHandler(
      responseHandler: response,
      parser: (Map<String, dynamic> value) {
        return BaseResponse<List<TradeResponse>>.fromJson(value, (
          Object? json,
        ) {
          final List<dynamic> list = json as List<dynamic>? ?? <dynamic>[];
          return list
              .map(
                (dynamic t) =>
                    TradeResponse.fromJson(t as Map<String, dynamic>),
              )
              .toList();
        });
      },
    );
  }

  @override
  Future<ResponseHandler<BaseResponse<List<TradeResponse>>>> getClientMyTrades({
    int? limit,
    int? offset,
  }) async {
    final Map<String, dynamic> params = <String, dynamic>{};
    if (limit != null) {
      params['limit'] = limit;
    }
    if (offset != null) {
      params['offset'] = offset;
    }

    final ResponseHandler<Map<String, dynamic>?> response = await MainConfig
        .apiClient
        .handleApiCall<Map<String, dynamic>>(
          endUrl: Apis.clientMyTrades,
          params: params,
        );

    return getParsedResponseHandler(
      responseHandler: response,
      parser: (Map<String, dynamic> value) {
        return BaseResponse<List<TradeResponse>>.fromJson(value, (
          Object? json,
        ) {
          final List<dynamic> list = json as List<dynamic>? ?? <dynamic>[];
          return list
              .map(
                (dynamic t) =>
                    TradeResponse.fromJson(t as Map<String, dynamic>),
              )
              .toList();
        });
      },
    );
  }

  @override
  Future<ResponseHandler<BaseResponse<dynamic>>> takeTrade(
    String tradePublicId,
  ) async {
    final ResponseHandler<Map<String, dynamic>?> response = await MainConfig
        .apiClient
        .handleApiCall<Map<String, dynamic>>(
          endUrl: '${Apis.takeTrade}/$tradePublicId/take',
          apiType: ApiType.post,
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
  Future<ResponseHandler<BaseResponse<List<TradeResponse>>>> searchTrades({
    required String keyword,
  }) async {
    final Map<String, dynamic> params = <String, dynamic>{'keyword': keyword};

    final ResponseHandler<Map<String, dynamic>?> response = await MainConfig
        .apiClient
        .handleApiCall<Map<String, dynamic>>(
          endUrl: Apis.searchTrades,
          params: params,
        );

    return getParsedResponseHandler(
      responseHandler: response,
      parser: (Map<String, dynamic> value) {
        return BaseResponse<List<TradeResponse>>.fromJson(value, (
          Object? json,
        ) {
          final List<dynamic> list = json as List<dynamic>? ?? <dynamic>[];
          return list
              .map(
                (dynamic t) =>
                    TradeResponse.fromJson(t as Map<String, dynamic>),
              )
              .toList();
        });
      },
    );
  }

  @override
  Future<ResponseHandler<BaseResponse<TradeResponse>>> getTradeDetails(
    String tradePublicId,
  ) async {
    final ResponseHandler<Map<String, dynamic>?> response = await MainConfig
        .apiClient
        .handleApiCall<Map<String, dynamic>>(
          endUrl: '${Apis.getTradeDetails}/$tradePublicId',
        );

    return getParsedResponseHandler(
      responseHandler: response,
      parser: (Map<String, dynamic> value) {
        return BaseResponse<TradeResponse>.fromJson(value, (Object? json) {
          return TradeResponse.fromJson(json as Map<String, dynamic>);
        });
      },
    );
  }

  @override
  Future<ResponseHandler<BaseResponse<List<CurrencyPairResponse>>>>
  getCurrencyPairs({required String market}) async {
    final ResponseHandler<Map<String, dynamic>?> response = await MainConfig
        .apiClient
        .handleApiCall<Map<String, dynamic>>(
          endUrl: Apis.getCurrencyPairs,
          params: <String, dynamic>{'market': market},
        );

    return getParsedResponseHandler(
      responseHandler: response,
      parser: (Map<String, dynamic> value) {
        return BaseResponse<List<CurrencyPairResponse>>.fromJson(value, (
          Object? json,
        ) {
          final List<dynamic> list = json as List<dynamic>? ?? <dynamic>[];
          return list
              .map(
                (dynamic t) =>
                    CurrencyPairResponse.fromJson(t as Map<String, dynamic>),
              )
              .toList();
        });
      },
    );
  }

  @override
  Future<ResponseHandler<BaseResponse<dynamic>>> createTrade(
    CreateSignalRequest request,
  ) async {
    final ResponseHandler<Map<String, dynamic>?> response = await MainConfig
        .apiClient
        .handleApiCall<Map<String, dynamic>>(
          endUrl: Apis.createTrade,
          apiType: ApiType.post,
          data: request.toMap(),
          showLoader: true,
        );

    return getParsedResponseHandler(
      responseHandler: response,
      parser: (Map<String, dynamic> value) {
        return BaseResponse<dynamic>.fromJson(value, (Object? json) => json);
      },
    );
  }

  //https://thevinaymalviya.org/api/trade/TRCC78E0/status
  @override
  Future<ResponseHandler<BaseResponse<dynamic>>> closeTrade({
    required String tradePublicId,
    String? outcome,
    double? exitPrice,
    double? resultInPips,
    String? note,
  }) async {
    final String endUrl = Apis.closeTrade(tradePublicId);

    final Map<String, dynamic> data = <String, dynamic>{
      'status': 'CLOSED',
      if (outcome != null && outcome.isNotEmpty) 'outcome': outcome,
      if (exitPrice != null) 'exitPrice': exitPrice,
      if (resultInPips != null) 'resultInPips': resultInPips,
      if (note != null && note.isNotEmpty) 'note': note,
    };

    final ResponseHandler<Map<String, dynamic>?> response = await MainConfig
        .apiClient
        .handleApiCall<Map<String, dynamic>>(
          endUrl: endUrl,
          apiType: ApiType.patch,
          data: data,
        );

    return getParsedResponseHandler(
      responseHandler: response,
      parser: (Map<String, dynamic> value) {
        return BaseResponse<dynamic>.fromJson(value, (Object? json) => json);
      },
    );
  }
}
