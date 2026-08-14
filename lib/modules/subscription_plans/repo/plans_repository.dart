import '../../../utils/exports.dart';

abstract class PlansRepository extends BaseRepository {
  Future<ResponseHandler<BaseResponse<List<PlanResponse>>>> getPlans();
  Future<ResponseHandler<BaseResponse<UserResponseData>>> getMe();
  Future<ResponseHandler<BaseResponse<dynamic>>> createSubscription(
    CreateSubscriptionRequest request,
  );
}
