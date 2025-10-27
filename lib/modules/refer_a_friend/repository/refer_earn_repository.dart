import '../../../utils/exports.dart';
/// Abstract repository for refer and earn operations.
abstract class ReferEarnRepository extends BaseRepository{
  /// Fetches refer and earn data from the API.
  ///
  /// Returns a [ResponseHandler] containing the [ReferEarnResponse].
  Future<ResponseHandler<ReferEarnResponse>> getReferEarnApiCall(
      String websiteId, String customerToken);

}