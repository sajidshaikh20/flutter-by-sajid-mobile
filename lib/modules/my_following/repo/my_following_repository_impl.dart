import '../../../utils/exports.dart';
import 'my_following_repository.dart';

class MyFollowingRepositoryImpl extends MyFollowingRepository {
  @override
  Future<ResponseHandler<BaseResponse<List<TradeResponse>>>> getWishlistTrades({
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
          endUrl: Apis.getFollowing,
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
