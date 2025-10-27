import '../../../utils/exports.dart';

/// Manages the state of order details in the app.
/// Handles fetching and updating order details.
class MyOrderDetailCubit extends Cubit<MyOrderDetailState> {
  /// Initializes the cubit and fetches order details asynchronously.
  MyOrderDetailCubit({
    required this.repository,
    required MyOrderDetailState initialState,
    required this.orderId,
  }) : super(initialState)
  {
    scheduleMicrotask(() async => callGetOrderDetailApi());
  }

  /// Repository for fetching order details data.
  final MyOrderDetailRepository repository;
  
  /// The order ID for fetching order details.
  final int? orderId;

  /// Fetches order details from the repository using request parameters.
  Future<void> callGetOrderDetailApi() async {
    if (orderId == null) {
      emit(state.copyWith(
        status: BaseStateStatus.failure,
        msg: 'Order ID is required',
      ));
      return;
    }

    MyOrderDetailRequestModel orderDetailReqModel = MyOrderDetailRequestModel(
      customerToken: getIt<UserProfileService>().customerToken,
      languageId: int.tryParse(getIt<LanguageService>().languageId) ?? 1,
      storeId: getIt<CountryService>().store,
      orderId: orderId, // Use orderId parameter
    );

    emit(state.copyWith(status: BaseStateStatus.loading));
    
    try {
      final ResponseHandler<BaseResponse<List<MyOrderDetailResponseModel>>> response =
          await repository.callGetOderDetail(orderDetailReqModel);
      
      if (response.isSuccess()) {
        final BaseResponse<List<MyOrderDetailResponseModel>>? apiResponse =
            response.getSuccessInstance()?.response;
        
        if ((apiResponse?.success ?? false) == true) {
          // API returned success: true with data
          final List<MyOrderDetailResponseModel> orderDetailsList = apiResponse?.data ?? <MyOrderDetailResponseModel>[];
          emit(state.copyWith(
            status: BaseStateStatus.success,
            successMsg: apiResponse?.message ?? '',
            orderDetailsList: orderDetailsList,
            response: orderDetailsList.isNotEmpty ? orderDetailsList.first : null, // Keep first item for backward compatibility
          ));
        } else {
          // API returned success: false (like "Order not found")
          emit(state.copyWith(
            status: BaseStateStatus.failure,
            msg: apiResponse?.message ?? '',
          ));
        }
      } else if (response.isFailure()) {
        // HTTP error or network failure
        emit(state.copyWith(
          status: BaseStateStatus.failure,
          msg: response.getFailureInstance()?.error?.errorMessage ?? '',
        ));
      }
    } on Exception catch (e) {
      // Handle any unexpected errors
      emit(state.copyWith(
        status: BaseStateStatus.failure,
        msg: e.toString(),
      ));
    }
  }


  /// Calls API to cancel an order.
  Future<void> callCancelOrderApi() async {

    emit(state.copyWith(status: BaseStateStatus.loading));
    
    try {
      final ResponseHandler<BaseResponse<dynamic>> response =
          await repository.callCancelOrder(orderId.toString());
      
      if (response.isSuccess()) {
        final BaseResponse<dynamic>? apiResponse =
            response.getSuccessInstance()?.response;
        
        if ((apiResponse?.success ?? false) == true) {
          // Order cancelled successfully
          emit(state.copyWith(
            status: BaseStateStatus.success,
            successMsg: apiResponse?.message ?? '',
            redirectRoute: const MyOrderListingRoute(),
          ));
          
          // Refresh order details to get updated status
          await callGetOrderDetailApi();
        } else {
          // API returned success: false
          emit(state.copyWith(
            status: BaseStateStatus.failure,
            msg: apiResponse?.message ?? '',
          ));
        }
      } else if (response.isFailure()) {
        // HTTP error or network failure
        emit(state.copyWith(
          status: BaseStateStatus.failure,
          msg: response.getFailureInstance()?.error?.errorMessage ?? '',
        ));
      }
    } on Exception catch (e) {
      // Handle any unexpected errors
      emit(state.copyWith(
        status: BaseStateStatus.failure,
        msg: e.toString(),
      ));
    }
  }

  /// Calls API to reorder products from an order.
  Future<void> callReOrderApi(String? orderId) async {
    emit(state.copyWith(status: BaseStateStatus.loading));
    try {
      final ReorderRequestModel reorderRequestModel = ReorderRequestModel(
        languageId: int.tryParse(getIt<LanguageService>().languageId) ?? 1,
        storeId: getIt<CountryService>().store,
        customerToken: getIt<UserProfileService>().customerToken,
        platform: getPlatformName(),
        version: getIt<MainConfig>().packageInfo.version,
        orderId: orderId
      );

      final ResponseHandler<BaseResponse<dynamic>> response =
          await repository.callReorder(reorderRequestModel);

      if (response.isSuccess()) {
        final BaseResponse<dynamic>? apiResponse =
            response.getSuccessInstance()?.response;

        if ((apiResponse?.success ?? false) == true) {
          // Order cancelled successfully
          emit(state.copyWith(
            status: BaseStateStatus.success,
            successMsg: apiResponse?.message ?? '',
            redirectRoute:  MyOrderDetailRoute(orderId: int.tryParse(orderId!)),
          ));

          // Refresh order details to get updated status
          await callGetOrderDetailApi();
        } else {
          // API returned success: false
          emit(state.copyWith(
            status: BaseStateStatus.failure,
            msg: apiResponse?.message ?? '',
          ));
        }
      } else if (response.isFailure()) {
        // HTTP error or network failure
        emit(state.copyWith(
          status: BaseStateStatus.failure,
          msg: response.getFailureInstance()?.error?.errorMessage ?? '',
        ));
      }
    } on Exception catch (e) {
      // Handle any unexpected errors
      emit(state.copyWith(
        status: BaseStateStatus.failure,
        msg: e.toString(),
      ));
    }
  }

  /// Helper method to get quoteId as int - handles both string and int types
  int getQuoteIdAsInt() {
    final dynamic quoteId = getIt<UserProfileService>().quoteId;
    
    if (quoteId is String) {
      return int.tryParse(quoteId) ?? 0;
    } else if (quoteId is int) {
      return quoteId;
    } else {
      return 0; // Default fallback
    }
  }
}
