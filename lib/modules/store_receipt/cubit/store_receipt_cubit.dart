import '../../../utils/exports.dart';

/// Cubit responsible for managing the store receipt list state and API interactions.
class StoreReceiptCubit extends Cubit<StoreReceiptState> {
  /// Creates an instance of [StoreReceiptCubit].
  ///
  /// Requires a [CartCountCubit] to manage the cart count.
  StoreReceiptCubit({required this.cartCountCubit})
      : super(
    StoreReceiptState(
      scrollController: ScrollController(),
    ),
  ) {
    _initializeScrollListener();
    unawaited(Future<void>.microtask(callStoreReceiptListApi));
  }

  /// Cubit to manage cart count.
  final CartCountCubit cartCountCubit;

  /// Repository for fetching store receipt list data.
  final StoreReceiptRepository _repository = StoreReceiptRepositoryImpl();

  /// Initialize scroll listener for infinite scroll pagination
  void _initializeScrollListener() {
    state.scrollController.addListener(_onScroll);
  }

  /// Handle scroll events for infinite scroll pagination
  void _onScroll() {
    if (state.scrollController.position.pixels >=
        state.scrollController.position.maxScrollExtent - 200) {
      // Load more when user is 200 pixels from the bottom
      if (state.hasMore && !state.isLoadingMore) {
        unawaited(loadMoreReceipts());
      }
    }
  }

  /// Loads more receipts for pagination
  Future<void> loadMoreReceipts() async {
    if (!state.hasMore || state.isLoadingMore) {
      return;
    }

    DebugLog.instance.i('StoreReceiptCubit: Loading more receipts - Page: ${state.currentPage + 1}');

    // Set loading more state
    emit(state.copyWith(isLoadingMore: true));

    // Calculate next offset based on current page
    final int nextOffset = state.currentPage * AppConstant.limitProduct;

    try {
      final ResponseHandler<BaseResponse<List<ListOfMyOrderResponse>>> value = await _repository
          .callStoreReceiptList(
        MyOrderRequestModel(
          customerToken: getIt<UserProfileService>().customerToken,
          languageId: int.tryParse(getIt<LanguageService>().languageId) ?? 1,
          storeId: getIt<CountryService>().store,
          orderStatus: "new",
          orderType: AppConstant.pickup,
          limit: AppConstant.limitProduct,
          offset: nextOffset,
        ),
      );

      if (value.isSuccess()) {
        final BaseResponse<List<ListOfMyOrderResponse>>? orderList =
            value.getSuccessInstance()?.response;

        if (orderList?.success ?? false) {
          // Convert new orders to receipts
          final List<StoreReceipt> newReceipts = orderList?.data
                  ?.map((ListOfMyOrderResponse order) => order.toStoreReceipt())
                  .toList() ??
              <StoreReceipt>[];

          // Combine with existing receipts
          final List<StoreReceipt> updatedReceiptList = <StoreReceipt>[
            ...state.receiptList,
            ...newReceipts,
          ];

          // Calculate pagination info
          final int apiTotalCount = orderList?.totalCount ?? 0;
          final bool hasMoreData = updatedReceiptList.length < apiTotalCount;

          emit(state.copyWith(
            status: BaseStateStatus.success,
            receiptList: updatedReceiptList,
            isLoadingMore: false,
            currentPage: state.currentPage + 1,
            hasMore: hasMoreData,
            totalCount: apiTotalCount,
          ));
        } else {
          emit(state.copyWith(
            status: BaseStateStatus.failure,
            isLoadingMore: false,
            error: orderList?.message ?? '',
          ));
        }
      } else if (value.isFailure()) {
        emit(state.copyWith(
          status: BaseStateStatus.failure,
          isLoadingMore: false,
          error: value.getFailureInstance()?.error?.errorMessage ?? '',
        ));
      }
    } on Exception catch (e) {
      emit(state.copyWith(
        status: BaseStateStatus.failure,
        isLoadingMore: false,
        error: e.toString(),
      ));
    }
  }

  /// Refreshes the receipt list (resets pagination)
  Future<void> refreshReceipts() async {
    DebugLog.instance.i('StoreReceiptCubit: Refreshing receipts');

    // Set refreshing state to true
    emit(state.copyWith(isRefreshing: true));
    
    await callStoreReceiptListApi();
    
    // Set refreshing state to false after API call completes
    emit(state.copyWith(isRefreshing: false));
  }


  /// Fetches all store receipts from the API.
  Future<void> callStoreReceiptListApi() async {
    emit(state.copyWith(
      status: BaseStateStatus.loading,
      action: StoreReceiptAction.storeReceiptInitial,
    ));

    try {
      final ResponseHandler<BaseResponse<List<ListOfMyOrderResponse>>> value = await _repository
          .callStoreReceiptList(
        MyOrderRequestModel(
          customerToken: getIt<UserProfileService>().customerToken,
          languageId: int.tryParse(getIt<LanguageService>().languageId) ?? 1,
          storeId: getIt<CountryService>().store,
          orderStatus: "new",
          orderType: AppConstant.pickup,
          limit: AppConstant.limitProduct,
          offset: 0, // Always start from 0 for fresh load
        ),
      );

      if (value.isSuccess()) {
        final BaseResponse<List<ListOfMyOrderResponse>>? orderList =
            value.getSuccessInstance()?.response;

        // Check if API returned success: false (like "Orders not Found")
        if (orderList?.success == false) {
          // API returned success: false with empty data - treat as no data state
          emit(
            state.copyWith(
              status: BaseStateStatus.success,
              receiptList: <StoreReceipt>[],
              action: StoreReceiptAction.storeReceiptNoData,
              totalCount: 0,
              currentPage: 1,
              hasMore: false,
              isLoadingMore: false,
            ),
          );
        } else {
          // API returned success: true - process data
          final List<StoreReceipt> receipts = orderList?.data
                  ?.map((ListOfMyOrderResponse order) => order.toStoreReceipt())
                  .toList() ??
              <StoreReceipt>[];

          // Get pagination info from API
          final int apiTotalCount = orderList?.totalCount ?? 0;
          final bool hasMoreData = receipts.length < apiTotalCount;

          // If we have data, set loaded action, otherwise set no data action
          final StoreReceiptAction action = receipts.isNotEmpty
              ? StoreReceiptAction.storeReceiptLoaded
              : StoreReceiptAction.storeReceiptNoData;

          emit(
            state.copyWith(
              status: BaseStateStatus.success,
              receiptList: receipts,
              action: action,
              totalCount: apiTotalCount,
              currentPage: 1, // Fresh load always starts from page 1
              hasMore: hasMoreData,
              isLoadingMore: false,
            ),
          );
        }
      } else if (value.isFailure()) {
        emit(
          state.copyWith(
            status: BaseStateStatus.failure,
            error: value.getFailureInstance()?.error?.errorMessage ?? '',
            isLoadingMore: false,
          ),
        );
      }
    } on Exception catch (e) {
      emit(
        state.copyWith(
          status: BaseStateStatus.failure,
          error: e.toString(),
          isLoadingMore: false,
        ),
      );
    }
  }

  /// Disposes resources when the cubit is closed.
  @override
  Future<void> close() {
    state.scrollController.dispose();
    return super.close();
  }


} 