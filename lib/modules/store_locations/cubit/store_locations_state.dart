
import '../../../utils/exports.dart';

/// State class for managing store locations data including store list,
/// selected store, and user preferences.
class StoreLocationsState extends BaseState {
  /// The current count of items in the user's cart.
  final int cartCount;

  /// The index of the currently selected segment (delivery/pickup).
  final int selectedSegmentIndex;
  
  /// The list of stores for pickup.
  final List<ListOfStoreResponse> storeList;
  
  /// The status of the store API call.
  final BaseStateStatus apiCallForStore;
  
  /// Current page for store pagination.
  final int currentStorePage;
  
  /// Total count of stores.
  final int totalStoreCount;
  
  /// Whether more stores can be loaded.
  final bool hasMoreStores;
  
  /// Whether pagination is loading.
  final bool isPaginationLoading;
  
  /// Scroll controller for infinite scroll.
  final ScrollController scrollController;
  
  /// Currently selected store index.
  final int? selectedStoreIndex;

  @override
  List<Object?> get props => <Object?>[
        cartCount,
        selectedSegmentIndex,
        storeList,
        apiCallForStore,
        currentStorePage,
        totalStoreCount,
        hasMoreStores,
        isPaginationLoading,
        scrollController,
        selectedStoreIndex,
        status,
        msg,
      ];

  /// Creates a [StoreLocationsState] instance.
  ///
  /// All parameters are required and define the current state of store locations.
  const StoreLocationsState(
    this.cartCount,
    this.selectedSegmentIndex,
    this.storeList,
    this.apiCallForStore,
    this.currentStorePage,
    this.totalStoreCount,
    this.scrollController,
    this.selectedStoreIndex,
    {
    required this.hasMoreStores,
    required this.isPaginationLoading,
    required super.status,
  });

  /// Creates an initial [StoreLocationsState] with default values.
  factory StoreLocationsState.initial() {
    return StoreLocationsState(
      0,
      0,
      <ListOfStoreResponse>[],
      BaseStateStatus.initial,
      1,
      0,
      ScrollController(),
      null,
      hasMoreStores: true,
      isPaginationLoading: false,
      status: BaseStateStatus.initial,
    );
  }

  /// Creates a copy of this [StoreLocationsState] with optional new values.
  ///
  /// If a parameter is not provided, the current value is used.
  StoreLocationsState copyWith({
    int? cartCount,
    BaseStateStatus? status,
    int? selectedSegmentIndex,
    List<ListOfStoreResponse>? storeList,
    BaseStateStatus? apiCallForStore,
    int? currentStorePage,
    int? totalStoreCount,
    bool? hasMoreStores,
    bool? isPaginationLoading,
    ScrollController? scrollController,
    int? selectedStoreIndex,
  }) {
    return StoreLocationsState(
      cartCount ?? this.cartCount,
      selectedSegmentIndex ?? this.selectedSegmentIndex,
      storeList ?? this.storeList,
      apiCallForStore ?? this.apiCallForStore,
      currentStorePage ?? this.currentStorePage,
      totalStoreCount ?? this.totalStoreCount,
      scrollController ?? this.scrollController,
      selectedStoreIndex ?? this.selectedStoreIndex,
      hasMoreStores: hasMoreStores ?? this.hasMoreStores,
      isPaginationLoading: isPaginationLoading ?? this.isPaginationLoading,
      status: status ?? this.status,
    );
  }
}