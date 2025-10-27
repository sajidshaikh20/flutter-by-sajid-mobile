import '../../../utils/exports.dart';

/// An abstract repository defining the contract for cart-related API operations.
///
/// This repository provides methods for managing the cart, such as deleting items,
/// removing all items, updating the cart, applying coupons, and handling upsell or free gift API calls.
///
/// Each method returns a [Future] of [ResponseHandler] wrapping the corresponding response model.
abstract class CartPageRepository extends BaseRepository {

  /// Fetches available payment methods for the user.
  ///
  /// [request] The request model containing all necessary parameters
  /// for the payment methods API call.
  ///
  /// Returns a [ResponseHandler] containing [BaseResponse<PaymentMethodResponse>]
  /// with the available payment methods.
  Future<ResponseHandler<BaseResponse<List<PaymentMethodResponse>>>>  getPaymentMethods({
    required PaymentMethodRequest request,
  });

  /// Fetches available time slots for delivery.
  ///
  /// [request] The request model containing all necessary parameters
  /// for the time slots API call.
  ///
  /// Returns a [ResponseHandler] containing [BaseResponse<TimeSlotsResponse>]
  /// with the available time slots.
  Future<ResponseHandler<BaseResponse<List<TimeSlotsResponse>>>> getTimeSlots({
    required TimeSlotsRequest request,
  });

  /// Creates an order from the current cart (checkout confirm).
  ///
  /// [request] The cart checkout request payload.
  ///
  /// Returns a [ResponseHandler] containing [BaseResponse<OrderResponse>].
  Future<ResponseHandler<BaseResponse<OrderResponse>>> addOrder({
    required CartCheckoutRequest request,
  });

  /// Apply Coupon.
  Future<ResponseHandler<BaseResponse<ApplyCouponResponseModel>>> applyCoupon(int? orderId, String? couponcode);


  /// Apply Reward.
  Future<ResponseHandler<BaseResponse<dynamic>>> applyReward(int? orderId, int? selectedReward, String? couponcode);

}
