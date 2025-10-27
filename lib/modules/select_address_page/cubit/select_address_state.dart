import '../../../utils/exports.dart';

/// State for the Select Address screen.
class SelectAddressState extends BaseState {
  /// Cart item count to display in the UI.
  final int cartCount;

  /// Currently selected segment index.
  final int selectedSegmentIndex;

  /// Indicates if this page was opened from login flow.
  final bool isFromLogin;

  /// Indicates if this page was opened from first address flow.
  final bool isFromFirstAddress;

  /// The ID of the address to select.
  final String? addressId;

  /// Indicates if this page was opened from store selection middleware.
  /// When true, after saving store, it will navigate to dashboard instead of going back.
  final bool isFromStoreSelection;

  /// Indicates if location permission is granted.
  final bool locationPermissionGranted;

  /// The list of user addresses.
  final List<MyAddressListingResponse> addressList;

  /// The status of the address API call.
  final BaseStateStatus apiCallForAddress;

  /// Current page for address pagination.
  final int currentAddressPage;

  /// Total count of addresses.
  final int totalAddressCount;

  /// Whether more addresses can be loaded.
  final bool hasMoreAddresses;

  /// Whether address pagination is loading.
  final bool isAddressPaginationLoading;

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
        isFromLogin,
        isFromFirstAddress,
        addressId,
        isFromStoreSelection,
        locationPermissionGranted,
        addressList,
        apiCallForAddress,
        currentAddressPage,
        totalAddressCount,
        hasMoreAddresses,
        isAddressPaginationLoading,
        storeList,
        apiCallForStore,
        currentStorePage,
        totalStoreCount,
        hasMoreStores,
        isPaginationLoading,
        scrollController,
        selectedStoreIndex,
      ];

  /// Creates a [SelectAddressState].
  const SelectAddressState(this.cartCount, this.selectedSegmentIndex,
      {required this.isFromLogin,
      required this.isFromFirstAddress,
      required this.addressId,
      required this.isFromStoreSelection,
      required this.locationPermissionGranted,
      required this.addressList,
      required this.apiCallForAddress,
      required this.currentAddressPage,
      required this.totalAddressCount,
      required this.hasMoreAddresses,
      required this.isAddressPaginationLoading,
      required this.storeList,
      required this.apiCallForStore,
      required this.currentStorePage,
      required this.totalStoreCount,
      required this.hasMoreStores,
      required this.isPaginationLoading,
      required this.scrollController,
      required this.selectedStoreIndex,
      required super.status,
      super.redirectRoute,
      super.msg});

  /// Initial state with default values.
  factory SelectAddressState.initial() {
    return SelectAddressState(
      0,
      0,
      isFromLogin: false,
      isFromFirstAddress: false,
      addressId: null,
      isFromStoreSelection: false,
      locationPermissionGranted: false,
      addressList: const <MyAddressListingResponse>[],
      apiCallForAddress: BaseStateStatus.initial,
      currentAddressPage: 1,
      totalAddressCount: 0,
      hasMoreAddresses: true,
      isAddressPaginationLoading: false,
      storeList: const <ListOfStoreResponse>[],
      apiCallForStore: BaseStateStatus.initial,
      currentStorePage: 1,
      totalStoreCount: 0,
      hasMoreStores: true,
      isPaginationLoading: false,
      scrollController: ScrollController(),
      selectedStoreIndex: null,
      status: BaseStateStatus.initial,
    );
  }

  /// Returns a copy with updated fields.
  SelectAddressState copyWith({
    int? cartCount,
    BaseStateStatus? status,
    int? selectedSegmentIndex,
    bool? isFromLogin,
    bool? isFromFirstAddress,
    String? addressId,
    bool? isFromStoreSelection,
    bool? locationPermissionGranted,
    List<MyAddressListingResponse>? addressList,
    BaseStateStatus? apiCallForAddress,
    int? currentAddressPage,
    int? totalAddressCount,
    bool? hasMoreAddresses,
    bool? isAddressPaginationLoading,
    List<ListOfStoreResponse>? storeList,
    BaseStateStatus? apiCallForStore,
    int? currentStorePage,
    int? totalStoreCount,
    bool? hasMoreStores,
    bool? isPaginationLoading,
    ScrollController? scrollController,
    int? selectedStoreIndex,
    String? msg,
    PageRouteInfo? redirectRoute,
  }) {
    return SelectAddressState(
      cartCount ?? this.cartCount,
      selectedSegmentIndex ?? this.selectedSegmentIndex,
      isFromLogin: isFromLogin ?? this.isFromLogin,
      isFromFirstAddress: isFromFirstAddress ?? this.isFromFirstAddress,
      addressId: addressId ?? this.addressId,
      isFromStoreSelection: isFromStoreSelection ?? this.isFromStoreSelection,
      locationPermissionGranted:
          locationPermissionGranted ?? this.locationPermissionGranted,
      addressList: addressList ?? this.addressList,
      apiCallForAddress: apiCallForAddress ?? this.apiCallForAddress,
      currentAddressPage: currentAddressPage ?? this.currentAddressPage,
      totalAddressCount: totalAddressCount ?? this.totalAddressCount,
      hasMoreAddresses: hasMoreAddresses ?? this.hasMoreAddresses,
      isAddressPaginationLoading:
          isAddressPaginationLoading ?? this.isAddressPaginationLoading,
      storeList: storeList ?? this.storeList,
      apiCallForStore: apiCallForStore ?? this.apiCallForStore,
      currentStorePage: currentStorePage ?? this.currentStorePage,
      totalStoreCount: totalStoreCount ?? this.totalStoreCount,
      hasMoreStores: hasMoreStores ?? this.hasMoreStores,
      isPaginationLoading: isPaginationLoading ?? this.isPaginationLoading,
      scrollController: scrollController ?? this.scrollController,
      selectedStoreIndex: selectedStoreIndex ?? this.selectedStoreIndex,
      status: status ?? this.status,
      redirectRoute: redirectRoute ?? this.redirectRoute,
      msg: msg ?? this.msg,
    );
  }
}
