import '../../../utils/exports.dart';

/// The state for managing address lists in the AddressListCubit.
/// This state contains
/// information such as the list of addresses, whether
/// the addresses are for checkout,
/// the selected address, and whether the data has been loaded or not.
class AddressListState extends BaseState {
  /// Constructor to initialize the AddressListState with
  ///  required and optional parameters.

  const AddressListState({
    required super.status,
    required this.addressList,
    required this.isForCheckOut,
    super.msg = '',
    super.redirectRoute,
    this.selectedSwitchId,
    this.selectedAddressId,
    this.isDataLoaded,
    this.isRefreshing = false,
  });

  /// The list of addresses from the API response.
  final List<MyAddressListingResponse> addressList;

  /// The ID of the selected address switch (if any).
  final String? selectedSwitchId;

  /// A flag that indicates whether the address list is for checkout or not.
  final bool isForCheckOut;

  /// The ID of the selected address from the list (if any).
  final String? selectedAddressId;

  /// A flag that indicates if the data has been loaded successfully.
  final bool? isDataLoaded;

  /// A flag that indicates if the list is currently being refreshed.
  final bool isRefreshing;

  @override
  List<Object?> get props => <Object?>[
        addressList,
        isForCheckOut,
        selectedAddressId,
        isDataLoaded,
        isRefreshing,
        ...super.props,
      ];

  /// Creates a new instance of AddressListState with the updated values.

  AddressListState copyWith({
    required BaseStateStatus status,
    PageRouteInfo? redirectRoute,
    String? errorMessage,
    List<MyAddressListingResponse>? addressList,
    String? selectedSwitchId,
    bool? isForCheckOut,
    String? selectedAddressId,
    bool? isDataLoaded,
    bool? isRefreshing,
  }) =>
      AddressListState(
        status: status,
        redirectRoute: redirectRoute,
        msg: errorMessage,
        addressList: addressList ?? this.addressList,
        selectedSwitchId: selectedSwitchId ?? this.selectedSwitchId,
        isForCheckOut: isForCheckOut ?? this.isForCheckOut,
        selectedAddressId: selectedAddressId ?? this.selectedAddressId,
        isDataLoaded: isDataLoaded ?? this.isDataLoaded,
        isRefreshing: isRefreshing ?? this.isRefreshing,
      );
}
