import '../../../utils/exports.dart';

abstract class MyFollowingRepository extends BaseRepository {
  Future<ResponseHandler<BaseResponse<List<TradeResponse>>>> getWishlistTrades({
    String? status,
    int? limit,
    int? offset,
    String? fromDate,
    String? toDate,
  });

  Future<ResponseHandler<BaseResponse<List<TradeResponse>>>> searchTrades({
    required String keyword,
  });
}
