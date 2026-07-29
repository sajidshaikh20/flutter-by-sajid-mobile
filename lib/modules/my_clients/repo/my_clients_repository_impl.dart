import '../../../utils/exports.dart';


class MyClientsRepositoryImpl extends MyClientsRepository {
  @override
  Future<ResponseHandler<BaseResponse<List<TradeWithClientsModel>>>> getMyClients({
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
          endUrl: Apis.traderClients,
          params: params,
        );

    return getParsedResponseHandler(
      responseHandler: response,
      parser: (Map<String, dynamic> value) {
        return BaseResponse<List<TradeWithClientsModel>>.fromJson(
          value,
          (Object? json) {
            final List<dynamic> list = json as List<dynamic>? ?? <dynamic>[];
            return list
                .map((dynamic t) => TradeWithClientsModel.fromJson(t as Map<String, dynamic>))
                .toList();
          },
        );
      },
    );
  }
}
