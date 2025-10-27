import '../../../utils/exports.dart';
import '../models/request/apply_coupon_request_model.dart';
import '../models/request/apply_reward_request_model.dart';

/// Implementation of [CartPageRepository] that handles API calls
/// for cart page operations including payment methods.
class CartPageRepositoryImpl extends CartPageRepository {
  /// Fetches available payment methods for the user.
  ///
  /// [request] The request model containing all necessary parameters
  /// for the payment methods API call.
  ///
  /// Returns a [ResponseHandler] containing [BaseResponse<PaymentMethodResponse>]
  /// with the available payment methods.
  @override
  Future<ResponseHandler<BaseResponse<List<PaymentMethodResponse>>>>
      getPaymentMethods({
    required PaymentMethodRequest request,
  }) async {
    // Make the API call to fetch payment methods
    ResponseHandler<Map<String, dynamic>?> response =
        await MainConfig.apiClient.handleApiCall<Map<String, dynamic>>(
      endUrl: Apis.paymentMethods,
      apiType: ApiType.post,
      data: request.toJson(),
    );

    // Parse and return the response using the response handler
    return getParsedResponseHandler(
      responseHandler: response,
      parser: (Map<String, dynamic> json) =>
          BaseResponse<List<PaymentMethodResponse>>.fromJson(
        json,
        (dynamic data) => (data as List<dynamic>)
            .map((dynamic item) =>
                PaymentMethodResponse.fromJson(item as Map<String, dynamic>))
            .toList(),
      ),
    );
  }

  /// Fetches available time slots for delivery.
  ///
  /// [request] The request model containing all necessary parameters
  /// for the time slots API call.
  ///
  /// Returns a [ResponseHandler] containing [BaseResponse<TimeSlotsResponse>]
  /// with the available time slots.
  @override
  Future<ResponseHandler<BaseResponse<List<TimeSlotsResponse>>>> getTimeSlots({
    required TimeSlotsRequest request,
  }) async {
    // Make the API call to fetch time slots
    ResponseHandler<Map<String, dynamic>?> response =
        await MainConfig.apiClient.handleApiCall<Map<String, dynamic>>(
      endUrl: Apis.timeSlots,
      apiType: ApiType.post,
      data: request.toJson(),
      showLoader: true,
    );

    // Parse and return the response using the response handler
    return getParsedResponseHandler(
      responseHandler: response,
      parser: (Map<String, dynamic> json) =>
      BaseResponse<List<TimeSlotsResponse>>.fromJson(
        json,
            (dynamic data) => (data as List<dynamic>)
            .map((dynamic item) =>
                TimeSlotsResponse.fromJson(item as Map<String, dynamic>))
            .toList(),
      ),
    );

  }

  /// Creates an order from the current cart (checkout confirm).
  @override
  Future<ResponseHandler<BaseResponse<OrderResponse>>> addOrder({
    required CartCheckoutRequest request,
  }) async {
    // Make the API call to add/confirm order
    ResponseHandler<Map<String, dynamic>?> response =
        await MainConfig.apiClient.handleApiCall<Map<String, dynamic>>(
      endUrl: Apis.addOrder,
      apiType: ApiType.post,
      data: request.toJson(),
      showLoader: true,
    );

    // Parse and return as BaseResponse<OrderResponse>
    return getParsedResponseHandler(
      responseHandler: response,
      parser: (Map<String, dynamic> value) {
        return BaseResponse<OrderResponse>.fromJson(
          value,
          (Object? json) =>
              OrderResponse.fromJson(json as Map<String, dynamic>),
        );
      },
    );
  }

  @override
  Future<ResponseHandler<BaseResponse<ApplyCouponResponseModel>>> applyCoupon(
      int? orderId, String? couponcode) async {
    ApplyCouponRequestModel applyCouponRequestModel = ApplyCouponRequestModel(
        languageId: int.tryParse(getIt<LanguageService>().languageId) ?? 1,
        platform: getPlatformName(),
        version: getIt<MainConfig>().packageInfo.version,
        customerToken: getIt<UserProfileService>().customerToken,
        storeId: getIt<CountryService>().store,
        orderId: orderId,
        couponcode: couponcode?.trim());
    DebugLog.instance.i(
        'ApplyCouponRequestModel created: ${applyCouponRequestModel.toJson()}');
    final ResponseHandler<Map<String, dynamic>?> response =
        await MainConfig.apiClient.handleApiCall<Map<String, dynamic>>(
            endUrl: Apis.applyCoupon,
            apiType: ApiType.post,
            data: applyCouponRequestModel.toJson(),
            showLoader: true);

        return getParsedResponseHandler(
          responseHandler: response,
          parser: (Map<String, dynamic> value) {
            return BaseResponse<ApplyCouponResponseModel>.fromJson(
              value,
                  (Object? json) =>
                      ApplyCouponResponseModel.fromJson(json as Map<String, dynamic>),
            );
          },
        );
  }
  @override
  Future<ResponseHandler<BaseResponse<dynamic>>> applyReward(
      int? orderId, int? selectedReward, String? couponcode) async {
    ApplyRewardRequestModel applyRewardRequestModel = ApplyRewardRequestModel(
        languageId: int.tryParse(getIt<LanguageService>().languageId) ?? 1,
        platform: getPlatformName(),
        version: getIt<MainConfig>().packageInfo.version,
        customerToken: getIt<UserProfileService>().customerToken,
        storeId: getIt<CountryService>().store,
        orderId: orderId,
        selectedReward: selectedReward,
        couponcode: couponcode);
    DebugLog.instance.i(
        'ApplyRewardRequestModel created: ${applyRewardRequestModel.toJson()}');
    final ResponseHandler<Map<String, dynamic>?> response =
    await MainConfig.apiClient.handleApiCall<Map<String, dynamic>>(
        endUrl: Apis.applyReward,
        apiType: ApiType.post,
        data: applyRewardRequestModel.toJson(),
        showLoader: true);

    return getParsedResponseHandler(
        responseHandler: response,
        parser: (Map<String, dynamic> value) {
          final BaseResponse<List<void>> result = BaseResponse<List<void>>(
            success: value['success'] == true || value['status_code'] == 200,
            statusCode: value['status_code'] ?? 0,
            message: value['message'] ?? '',
            totalCount: value['total_count'] as int?,
            error: value['error'] as String?,
          );

          return result;
        });
  }
}
