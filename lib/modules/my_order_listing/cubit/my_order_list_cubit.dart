import '../../../utils/exports.dart';

/// Cubit responsible for managing the order list state and API interactions.
class MyOrderListCubit extends Cubit<MyOrderListState> {
  /// Creates an instance of [MyOrderListCubit].
  ///
  /// Requires a [CartCountCubit] to manage the cart count.
  MyOrderListCubit({required this.cartCountCubit})
      : super(
          MyOrderListState(
            scrollController: ScrollController(),
          ),
        ) {
    _initializeScrollListener();
    scheduleMicrotask(() async => callMyOrderListApi(limit: 8, offset: 0));
  }

  /// Cubit to manage cart count.
  final CartCountCubit cartCountCubit;

  /// Repository for fetching order list data.
  final MyOrderRepository _repository = MyOrderRepositoryImpl();

  /// Initialize scroll listener for pagination
  void _initializeScrollListener() {
    state.scrollController.addListener(_onScroll);
  }

  /// Handle scroll events for pagination
  void _onScroll() {
    if (state.scrollController.position.pixels >=
        state.scrollController.position.maxScrollExtent - 200) {
      if (state.hasMore && !state.isLoadingMore) {
        unawaited(loadMoreOrders());
      }
    }
  }

  /// Load more orders for pagination
  Future<void> loadMoreOrders() async {
    if (state.isLoadingMore || !state.hasMore) return;
    
    emit(state.copyWith(isLoadingMore: true));
    
    final int nextOffset = state.myOrderList.length;
    await callMyOrderListApi(
      limit: 8,
      offset: nextOffset,
      isLoadMore: true,
    );
  }

  /// Refresh orders (pull to refresh)
  Future<void> refreshOrders() async {
    emit(state.copyWith(
      status: BaseStateStatus.loading,
      pageNumber: 1,
      hasMore: true,
      myOrderList: const <ListOfMyOrderResponse>[],
    ));
    
    await callMyOrderListApi(limit: 8, offset: 0);
  }



  /// Hides the snackbar after a short delay.
  void displaySnackBarFalse() {
    Future<void>.delayed(const Duration(milliseconds: Dimens.milliseconds200),
        () {
      emit(
        state.copyWith(
          isSnackBarDisplay: false,
          status: BaseStateStatus.success,
        ),
      );
    });
  }

  /// Calls API to cancel an order.
  Future<void> callCancelOrderApi(String? orderId) async {
    if (orderId == null) {
      emit(state.copyWith(
        status: BaseStateStatus.failure,
        msg: 'Order ID is required',
      ));
      return;
    }

    emit(state.copyWith(status: BaseStateStatus.loading));
    
    try {
      final ResponseHandler<BaseResponse<dynamic>> response =
          await _repository.callCancelOrder(orderId);
      
      if (response.isSuccess()) {
        final BaseResponse<dynamic>? apiResponse =
            response.getSuccessInstance()?.response;
        
        if ((apiResponse?.success ?? false) == true) {
          // Order cancelled successfully
          emit(state.copyWith(
            status: BaseStateStatus.success,
            successMsg: apiResponse?.message ?? 'Order cancelled successfully',
            redirectRoute: const MyAccountRoute(),
          ));
          
          // Refresh order list to get updated status
          await refreshOrders();
        } else {
          // API returned success: false
          emit(state.copyWith(
            status: BaseStateStatus.failure,
            msg: apiResponse?.message ?? 'Failed to cancel order',
          ));
        }
      } else if (response.isFailure()) {
        // HTTP error or network failure
        emit(state.copyWith(
          status: BaseStateStatus.failure,
          msg: response.getFailureInstance()?.error?.errorMessage ?? 'Failed to cancel order',
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

  /// Disposes resources when the cubit is closed.
  @override
  Future<void> close() {
    state.scrollController.dispose();
    return super.close();
  }

  /// Sets up a scroll listener to handle infinite scrolling.
  void setUpScrollListener() {
    state.scrollController.addListener(
      () async {
        if (state.scrollController.position.pixels >=
                (state.scrollController.position.maxScrollExtent -
                    AppConstant.maxScrollExtent) &&
            !state.isApiLoading &&
            !state.isLimitReached) {
          // await getAllOrderListAPI(pageNumbers: state.pageNumber);
        }
      },
    );
  }

  /// Changes the active tab index and resets the order list state.
  ///
  /// [indexOfTab] The new tab index to switch to.
  FutureOr<void> changeIndexOfTheTab(int indexOfTab) {
    emit(state.copyWith(
      indexOfTheTabBar: indexOfTab,
      myOrderList: <ListOfMyOrderResponse>[], // Clear existing order list when switching tabs
      status: BaseStateStatus.loading, // Set loading state when switching tabs
      pageNumber: 1,
      hasMore: true,
      isLoadingMore: false,
    ));
    DebugLog.instance.i("indexOfTheTabBar $indexOfTab");
  }

  /// Displays a shimmer effect by emitting loading state and then success after a delay.
  void displayShimmer() {
    emit(state.copyWith(status: BaseStateStatus.loading));
    Future<void>.delayed(const Duration(seconds: 3), () {
      if (!isClosed) {
        emit(state.copyWith(status: BaseStateStatus.success));
      }
    });
  }

  /// Fetches all orders from the API
  Future<void> callMyOrderListApi({
    required int limit,
    required int offset,
    bool isLoadMore = false,
  }) async {
    if (!isLoadMore) {
      emit(state.copyWith(status: BaseStateStatus.loading));
    }

    await _repository
        .callMyOrderListApi(
      MyOrderRequestModel(
          customerToken: getIt<UserProfileService>().customerToken,
          languageId: int.tryParse(getIt<LanguageService>().languageId) ?? 1,
          storeId: getIt<CountryService>().store,
          orderStatus: state.indexOfTheTabBar == 0 ? AppConstant.newOrderStatus : AppConstant.pastOrderStatus,
          orderType: (SharedPref.instance.getDeliveryType().toLowerCase().trim() == AppConstant.pickup1)
              ? AppConstant.pickup
              : SharedPref.instance.getDeliveryType(),
          limit: limit,
          offset: offset,
      )
    )
        .then(
            (ResponseHandler<BaseResponse<List<ListOfMyOrderResponse>>> value) {
      if (value.isSuccess()) {
        final BaseResponse<List<ListOfMyOrderResponse>>? myOrderList =
            value.getSuccessInstance()?.response;
        
        // Check if API returned success: false (like "Orders not Found")
        if (myOrderList?.success == false) {
          // API returned success: false with empty data - treat as successful empty state
          emit(
            state.copyWith(
              status: BaseStateStatus.success,
              myOrderList: <ListOfMyOrderResponse>[],
              totalCount: 0,
              hasMore: false,
              isLoadingMore: false,
            ),
          );
        } else {
          // Handle pagination logic
          final List<ListOfMyOrderResponse> newOrders = myOrderList?.data ?? <ListOfMyOrderResponse>[];
          final int totalCount = myOrderList?.totalCount ?? 0;
          
          List<ListOfMyOrderResponse> updatedList;
          int newPageNumber;
          
          if (isLoadMore) {
            // Append new orders to existing list
            updatedList = <ListOfMyOrderResponse>[...(state.myOrderList), ...newOrders];
            newPageNumber = state.pageNumber + 1;
          } else {
            // Replace list with new orders
            updatedList = newOrders;
            newPageNumber = 1;
          }
          
          // Check if there are more orders to load
          final bool hasMore = updatedList.length < totalCount;
          
          emit(
            state.copyWith(
              status: BaseStateStatus.success,
              myOrderList: updatedList,
              totalCount: totalCount,
              pageNumber: newPageNumber,
              hasMore: hasMore,
              isLoadingMore: false,
            ),
          );
        }
      } else if (value.isFailure()) {
        emit(
          state.copyWith(
            msg: value.getFailureInstance()?.error?.errorMessage ?? '',
            status: BaseStateStatus.failure,
            isLoadingMore: false,
          ),
        );
      }
    });
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
      await _repository.callReorder(reorderRequestModel);

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

}
