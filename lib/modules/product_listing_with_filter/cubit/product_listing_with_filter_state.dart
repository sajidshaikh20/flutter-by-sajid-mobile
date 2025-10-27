import '../../../utils/exports.dart';

/// Immutable state representing the product listing with filter screen.
class ProductListingWithFilterState extends BaseState {
  /// The current cart count.
  final int cartCount;

  /// The index of the currently selected segment/tab.
  final int selectedSegmentIndex;

  /// The list of product responses for the current page.
  final List<ProductListingResponse>? productList;

  /// Whether the data is currently loading.
  final bool isLoading;

  /// Error message to display if loading fails.
  final String? errorMessage;

  /// The type ID for filtering products.
  final int? typeId;

  /// The type name for filtering products.
  final String? type;

  /// The label for the current product listing.
  final String? label;

  /// The list of tab labels for different categories.
  final List<dynamic>? tabLabels;

  /// The product SKU for filtering.
  final String? productSku;

  /// The currently selected sort option.
  final SortOptionModel? selectedSortOption;

  /// The total count of products available.
  final int totalCount;

  /// The current page number for pagination.
  final int currentPage;

  /// Whether there is more data to load.
  final bool hasMore;

  /// Whether additional data is currently loading.
  final bool isLoadingMore;

  /// Scroll controller for the product list.
  final ScrollController scrollController;

  /// The filter data for advanced filtering.
  final GetFilterData? filterData;

  /// The list of currently selected filters.
  final List<Map<String, dynamic>>? selectedFilters;

  @override
  List<Object?> get props => <Object?>[
        cartCount,
        selectedSegmentIndex,
        productList,
        isLoading,
        errorMessage,
        typeId,
        type,
        label,
        status,
        msg,
        tabLabels,
        productSku,
        selectedSortOption,
        totalCount,
        currentPage,
        hasMore,
        isLoadingMore,
        scrollController,
        filterData,
        selectedFilters,
      ];

  /// Creates a new instance of [ProductListingWithFilterState].
  ProductListingWithFilterState(
    this.cartCount,
    this.selectedSegmentIndex, {
    required super.status,
    super.msg = '',
    this.productList,
    this.isLoading = false,
    this.errorMessage,
    this.typeId,
    this.type,
    this.label,
    this.tabLabels = const <dynamic>[],
    this.productSku,
    this.selectedSortOption,
    this.totalCount = 0,
    this.currentPage = 1,
    this.hasMore = true,
    this.isLoadingMore = false,
    ScrollController? scrollController,
    this.filterData,
    this.selectedFilters,
  }) : scrollController = scrollController ?? ScrollController();

  ///initial
  factory ProductListingWithFilterState.initial() {
    return ProductListingWithFilterState(
      0,
      0,
      status: BaseStateStatus.initial,
    );
  }

  /// Creates a copy of this [ProductListingWithFilterState] with optional new values.
  ProductListingWithFilterState copyWith({
    int? cartCount,
    BaseStateStatus? status,
    int? selectedSegmentIndex,
    BaseResponse<List<ProductListingResponse>>? productListingResponse,
    List<ProductListingResponse>? productList,
    bool? isLoading,
    String? errorMessage,
    int? typeId,
    String? type,
    String? label,
    List<dynamic>? tabLabels,
    String? productSku,
    SortOptionModel? selectedSortOption,
    int? totalCount,
    int? currentPage,
    bool? hasMore,
    bool? isLoadingMore,
    ScrollController? scrollController,
    GetFilterData? filterData,
    List<Map<String, dynamic>>? selectedFilters,
    String? msg,
  }) {
    return ProductListingWithFilterState(
      cartCount ?? this.cartCount,
      selectedSegmentIndex ?? this.selectedSegmentIndex,
      status: status ?? this.status,
      msg: msg,
      productList: productList ?? this.productList,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      typeId: typeId ?? this.typeId,
      type: type ?? this.type,
      label: label ?? this.label,
      tabLabels: tabLabels ?? this.tabLabels,
      productSku: productSku ?? this.productSku,
      selectedSortOption: selectedSortOption ?? this.selectedSortOption,
      totalCount: totalCount ?? this.totalCount,
      currentPage: currentPage ?? this.currentPage,
      hasMore: hasMore ?? this.hasMore,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      scrollController: scrollController ?? this.scrollController,
      filterData: filterData ?? this.filterData,
      selectedFilters: selectedFilters ?? this.selectedFilters,
    );
  }
}
