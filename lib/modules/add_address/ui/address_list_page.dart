import '../../../utils/exports.dart';

/// A page that displays a list of addresses.
///
/// This page supports responsive layouts for desktop, tablet, and mobile devices.
/// It can optionally be used for checkout purposes and highlight a selected address.
@RoutePage()
class ListAddressPage extends BaseResponsiveView {
  /// Creates a [ListAddressPage].
  ///
  /// [isForCheckOut] specifies if this page is being used during checkout.
  /// [selectedAddressId] optionally indicates which address is currently selected.
  const ListAddressPage({
    super.key,
    this.isForCheckOut,
    this.selectedAddressId,
  });

  /// Whether the page is used for checkout.
  final bool? isForCheckOut;

  /// The ID of the currently selected address, if any.
  final String? selectedAddressId;

  /// Builds the main view for this page based on the [device] type.
  ///
  /// Initializes the [AddressListCubit] with the necessary repositories
  /// and initial state, then provides it to the [AddressListWidget].
  Widget buildView(BuildContext context, ScreenType device) {
    return BlocProvider<AddressListCubit>(
      create: (BuildContext c) => AddressListCubit(
        addressRepositoryImpl: AddressRepositoryImpl(),
        addAddressRepositoryImpl: AddAddressRepositoryImpl(),
        initialState: AddressListState(
          addressList: const <MyAddressListingResponse>[],
          status: BaseStateStatus.initial,
          selectedSwitchId: "0",
          isForCheckOut: isForCheckOut ?? false,
          selectedAddressId: selectedAddressId,
          isDataLoaded: false,
        ),
      ),
      child: AddressListWidget(device: device),
    );
  }

  @override
  Widget buildDesktopWidget(BuildContext context) {
    return buildView(context, ScreenType.desktop);
  }

  @override
  Widget buildMobileWidget(BuildContext context) {
    return buildView(context, ScreenType.mobile);
  }

  @override
  Widget buildTabletWidget(BuildContext context) {
    return buildView(context, ScreenType.tablet);
  }
}
