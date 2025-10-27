import '../../../utils/exports.dart';

/// Abstract repository class for handling order-related API calls.
abstract class MyOrderRepository extends BaseRepository {
  /// Default constructor for [MyOrderRepository].
  MyOrderRepository();


  /// Fetches the list of user's orders.
  ///
  /// [myOrderRequestModel] The request model containing parameters for the order list API.
  ///
  /// Returns a [ResponseHandler] containing [BaseResponse<List<ListOfMyOrderResponse>>]
  /// with the list of user's orders.
  Future<ResponseHandler<BaseResponse<List<ListOfMyOrderResponse>>>> callMyOrderListApi(MyOrderRequestModel myOrderRequestModel);

  /// Cancels an order by its ID.
  ///
  /// [orderId] The ID of the order to cancel.
  ///
  /// Returns a [ResponseHandler] containing [BaseResponse<dynamic>]
  /// indicating the success or failure of the cancellation.
  Future<ResponseHandler<BaseResponse<dynamic>>> callCancelOrder(String? orderId);

  /// Reorders a previous order.
  ///
  /// [reorderRequestModel] The request model containing parameters for reordering.
  ///
  /// Returns a [ResponseHandler] containing [BaseResponse<dynamic>]
  /// indicating the success or failure of the reorder operation.
  Future<ResponseHandler<BaseResponse<dynamic>>> callReorder(
      ReorderRequestModel reorderRequestModel,{bool showLoader = true});

}
