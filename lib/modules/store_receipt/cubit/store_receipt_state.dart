import '../../../utils/exports.dart';

/// Actions that can be performed on store receipts.
enum StoreReceiptAction {
  /// Initial state.
  storeReceiptInitial,
  /// Loaded state.
  storeReceiptLoaded,
  /// No data state.
  storeReceiptNoData,
  /// Failed state.
  storeReceiptFailed,
}

/// Represents the state of the Store Receipt feature.
///
/// This state includes the list of receipts, pagination details,
/// loading status, error messages, and UI control flags.
class StoreReceiptState extends BaseState {
  /// The list of store receipts.
  final List<StoreReceipt> receiptList;

  /// Error message if an error occurs during API calls.
  final String error;

  /// Whether the snackbar should be displayed.
  final bool isSnackBarDisplay;

  /// The action currently being performed on the store receipts.
  final StoreReceiptAction action;

  /// Total count of receipts available from API.
  final int totalCount;

  /// Current page number for pagination.
  final int currentPage;

  /// Whether there are more receipts to load.
  final bool hasMore;

  /// Whether more receipts are currently being loaded (pagination).
  final bool isLoadingMore;

  /// Whether the list is currently being refreshed (pull-to-refresh).
  final bool isRefreshing;

  /// Scroll controller for managing scroll events in the receipt list.
  final ScrollController scrollController;

  /// The index of the currently selected tab bar.
  final int indexOfTheTabBar;

  /// Creates a [StoreReceiptState] instance.
  ///
  /// [scrollController] must be provided since it's required for managing scrolling.
  const StoreReceiptState({
    this.receiptList = const <StoreReceipt>[],
    this.error = '',
    super.status = BaseStateStatus.initial,
    this.isSnackBarDisplay = false,
    this.action = StoreReceiptAction.storeReceiptInitial,
    this.totalCount = 0,
    this.currentPage = 1,
    this.hasMore = true,
    this.isLoadingMore = false,
    this.isRefreshing = false,
    super.redirectRoute,
    required this.scrollController,
    this.indexOfTheTabBar = 0,
  });

  /// Returns a new [StoreReceiptState] with updated fields.
  ///
  /// Only the provided parameters will override the current state values.
  StoreReceiptState copyWith({
    BaseStateStatus? status,
    List<StoreReceipt>? receiptList,
    String? error,
    bool? isSnackBarDisplay,
    StoreReceiptAction? action,
    int? totalCount,
    int? currentPage,
    bool? hasMore,
    bool? isLoadingMore,
    bool? isRefreshing,
    PageRouteInfo? redirectRoute,
    int? indexOfTheTabBar,
  }) {
    return StoreReceiptState(
      status: status ?? this.status,
      receiptList: receiptList ?? this.receiptList,
      error: error ?? this.error,
      scrollController: scrollController,
      redirectRoute: redirectRoute,
      isSnackBarDisplay: isSnackBarDisplay ?? this.isSnackBarDisplay,
      action: action ?? this.action,
      totalCount: totalCount ?? this.totalCount,
      currentPage: currentPage ?? this.currentPage,
      hasMore: hasMore ?? this.hasMore,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      isRefreshing: isRefreshing ?? this.isRefreshing,
      indexOfTheTabBar: indexOfTheTabBar ?? this.indexOfTheTabBar,
    );
  }

  @override
  List<Object?> get props => <Object?>[
    ...super.props,
    receiptList,
    error,
    scrollController,
    isSnackBarDisplay,
    action,
    totalCount,
    currentPage,
    hasMore,
    isLoadingMore,
    isRefreshing,
    indexOfTheTabBar,
  ];
}
