import '../../../utils/exports.dart';

/// A page for adding or editing an address.
///
/// This page supports responsive layouts for desktop, tablet, and mobile devices.
/// It can be used for checkout addresses, billing addresses, or selecting the current location.
@RoutePage()
class AddNewAddressPage extends BaseResponsiveView {
  /// Creates an [AddNewAddressPage].
  ///
  /// [isEdit] indicates whether the page is in edit mode.
  /// [billingAddress] provides the existing address details if editing.
  /// [isForCheckOut] specifies if this address is used for checkout.
  /// [isForCurrentLocation] indicates if the page should prefill the current location.
  /// [isFromAddressList] specifies whether this page is opened from the address list.
  const AddNewAddressPage({
    super.key,
    this.isEdit,
    this.billingAddress,
    this.isForCheckOut,
    this.isForCurrentLocation = false,
    this.isFromAddressList = false,
  });

  /// Whether the page is in edit mode.
  final bool? isEdit;

  /// The billing or existing address details, if editing.
  final BillingAddress? billingAddress;

  /// Whether this address is for checkout purposes.
  final bool? isForCheckOut;

  /// Whether the page should prefill the current location.
  final bool isForCurrentLocation;

  /// Whether this page was opened from the address list.
  final bool isFromAddressList;

  @override
  Widget buildDesktopWidget(BuildContext context) {
    return buildViews(context, ScreenType.desktop);
  }

  @override
  Widget buildMobileWidget(BuildContext context) {
    return buildViews(context, ScreenType.mobile);
  }

  @override
  Widget buildTabletWidget(BuildContext context) {
    return buildViews(context, ScreenType.tablet);
  }

  /// Builds the page view based on the [device] type.
  ///
  /// This sets up the [AddressCubit] with the appropriate initial state
  /// and loads the map if necessary.
  Widget buildViews(BuildContext context, ScreenType device) {
    return BlocProvider<AddressCubit>(
      create: (BuildContext c) => AddressCubit(
        addressRepositoryImpl: AddressRepositoryImpl(),
        initialState: AddressState.init(
          isForCheckOut: isForCheckOut ?? false,
        ),
      )..loadMap(
        billingAddress,
        isForCurrentLocation: isForCurrentLocation,
      ),
      child: AddressFieldForm(
        device: device,
        isFromAddressList: isFromAddressList,
      ),
    );
  }
}
