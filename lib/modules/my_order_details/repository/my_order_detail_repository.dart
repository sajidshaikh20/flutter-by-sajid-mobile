import '../../../utils/exports.dart';

/// Abstract repository class for handling order detail data operations.
abstract class MyOrderDetailRepository extends BaseRepository {
  ///Order detail api
  Future<ResponseHandler<BaseResponse<List<MyOrderDetailResponseModel>>>> callGetOderDetail(MyOrderDetailRequestModel orderDetailReqModel,);
  ///Re-order api
  Future<ResponseHandler<ReOrderModel>> callReOrderAPI(String? orderId);
  ///cancel order
  Future<ResponseHandler<BaseResponse<dynamic>>> callCancelOrder(String? orderId);
  ///Re Order
  Future<ResponseHandler<BaseResponse<dynamic>>> callReorder(
      ReorderRequestModel reorderRequestModel,{bool showLoader = true});

}
