import '../../../utils/exports.dart';

/// Abstract class for fetching the user's return orders.
abstract class MyReturnRepository extends BaseRepository {
  /// Fetches the return orders for a user.
  Future<ResponseHandler<MyReturnModel>> getMyReturnList({
    required ReturnOrderRequestModel myReturnRequestModel,
  });
}
