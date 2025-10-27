import '../../../utils/exports.dart';

/// Immutable state for the My Orders listing screen.
class MyOrderListState extends BaseState {
  /// Paginated list of orders.
  final List<ListOfMyOrderResponse> myOrderList;
  /// Whether a page load is in progress.
  final bool isApiLoading;
  /// Cached order details for the last selection.
  final MyOrderDetailResponseModel? oderDetailsResponse;
  /// Transient message or error text.
  final String error;
  /// Response of reorder action.
  final ReOrderModel? reOrderModel;
  /// Total available orders for pagination.
  final int totalCount;
  /// Current page cursor.
  final int pageNumber;
  /// Whether to show a snackbar.
  final bool isSnackBarDisplay;

  /// Whether list end has been reached.
  final bool isLimitReached;
  /// Whether more orders are available to load.
  final bool hasMore;
  /// Whether currently loading more orders.
  final bool isLoadingMore;
  /// Scroll controller for infinite scroll.
  final ScrollController scrollController;
  /// Selected tab index.
  final int indexOfTheTabBar;
  /// Success message for operations.
  final String successMsg;

  /// Creates a [MyOrderListState].
  const MyOrderListState(
      {
        this.myOrderList = const <ListOfMyOrderResponse>[],
        this.isApiLoading = false,
        this.oderDetailsResponse,
        this.error = '',
        this.reOrderModel,
        super.status = BaseStateStatus.initial,
        super.msg = '',
        this.isSnackBarDisplay = false,
        this.totalCount = -1,
        this.pageNumber = 1,
        this.isLimitReached = false,
        this.hasMore = true,
        this.isLoadingMore = false,
        super.redirectRoute,
        required this.scrollController,
        this.indexOfTheTabBar=0,
        this.successMsg = ''});

  /// Returns a copy with updated fields.
  MyOrderListState copyWith({
    BaseStateStatus? status,
    List<ListOfMyOrderResponse>? myOrderList,
    bool? isApiLoading,
    MyOrderDetailResponseModel? oderDetailsResponse,
    ReOrderModel? reOrderModel,
    String? error,
    int? totalCount,
    int? pageNumber,
    bool? isLimitReached,
    bool? hasMore,
    bool? isLoadingMore,
    bool? isSnackBarDisplay,
    PageRouteInfo? redirectRoute,
    int? indexOfTheTabBar,
    String? msg,
    String? successMsg,
  }) {
    return MyOrderListState(
      status: status ?? this.status,
      myOrderList: myOrderList ?? this.myOrderList,
      isApiLoading: isApiLoading ?? this.isApiLoading,
      reOrderModel: reOrderModel ?? this.reOrderModel,
      error: error ?? this.error,
      scrollController: scrollController,
      oderDetailsResponse: oderDetailsResponse ?? this.oderDetailsResponse,
      totalCount: totalCount ?? this.totalCount,
      pageNumber: pageNumber ?? this.pageNumber,
      isLimitReached: isLimitReached ?? this.isLimitReached,
      hasMore: hasMore ?? this.hasMore,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      redirectRoute: redirectRoute,
      isSnackBarDisplay: isSnackBarDisplay ?? this.isSnackBarDisplay,
      indexOfTheTabBar: indexOfTheTabBar ?? this.indexOfTheTabBar,
      msg: msg,
      successMsg: successMsg ?? this.successMsg,
    );
  }

  @override
  /// Props for equality comparison.
  List<Object?> get props => <Object?>[
    ...super.props,
    myOrderList,
    isApiLoading,
    oderDetailsResponse,
    error,
    reOrderModel,
    scrollController,
    totalCount,
    pageNumber,
    isLimitReached,
    hasMore,
    isLoadingMore,
    isSnackBarDisplay,
    indexOfTheTabBar,
    successMsg,
  ];
}
