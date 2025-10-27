import '../../../utils/exports.dart';

/// Abstract repository for view reward history operations.
abstract class ViewRewardHistoryRepository extends BaseRepository {
  /// Fetches the rewards history list for the customer.
  ///
  /// Returns a [ResponseHandler] containing the [ViewRewardHistoryResponse].
  Future<ResponseHandler<ViewRewardHistoryResponse>> getRewardsList(
      ViewRewardHistoryRequest viewRewardHistoryRequest);
}
