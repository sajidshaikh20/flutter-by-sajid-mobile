
import '../../../utils/exports.dart';
/// A responsive page for adding a new address.
///
/// This page adapts its layout based on screen size using
/// [BaseResponsiveView], making it suitable for mobile, tablet,
/// and web platforms.
///
/// {@category Address}
///
/// Example usage:
/// ```dart
/// AutoRouter.of(context).push(const NewAddressAddRoute());
/// ```
@RoutePage()
class NewAddressAddPage extends BaseResponsiveView {
  /// Creates a new instance of [NewAddressAddPage].
  const NewAddressAddPage({
    super.key,
    this.isEdit,
    this.isFromAddressList,
    this.myAddress,
  });

  /// Whether this page is for editing an existing address
  final bool? isEdit;

  /// Whether this page is for editing an existing address
  final bool? isFromAddressList;

  /// The address to edit (only used when isEdit is true)
  final MyAddressListingResponse? myAddress;

  @override
  Widget buildDesktopWidget(BuildContext context) =>
      _buildViews(context, ScreenType.desktop);

  @override
  Widget buildMobileWidget(BuildContext context) =>
      _buildViews(context, ScreenType.mobile);

  @override
  Widget buildTabletWidget(BuildContext context) =>
      _buildViews(context, ScreenType.tablet);

  // Refactored to avoid repetition by using a helper method
  Widget _buildViews(BuildContext context, ScreenType device) {
    return MultiBlocProvider(
      providers: <SingleChildWidget>[
        BlocProvider<AddNewAddressCubit>(
          create: (BuildContext context) {
            final AddNewAddressCubit addNewAddressCubit = AddNewAddressCubit(
              repository: AddAddressRepositoryImpl(),
              initialState: AddNewAddressState(
                status: BaseStateStatus.initial,
                formKey: GlobalKey<FormState>(),
                // Form controllers
                areaController: TextEditingController(),
                blockController: TextEditingController(),
                streetNameController: TextEditingController(),
                buildingVillaController: TextEditingController(),
                floorController: TextEditingController(),
                flatApartmentController: TextEditingController(),
                landmarkController: TextEditingController(),
                mobileNoController: TextEditingController(),
                // Focus nodes
                areaFocusNode: FocusNode(),
                blockFocusNode: FocusNode(),
                streetFocusNode: FocusNode(),
                buildingVillaFocusNode: FocusNode(),
                floorFocusNode: FocusNode(),
                flatApartmentFocusNode: FocusNode(),
                landmarkFocusNode: FocusNode(),
                mobileNoFocusNode: FocusNode(),
              ),
            )..initData(myAddress);
            final AddressCubit addressCubit = AddressCubit(
              addressRepositoryImpl: AddressRepositoryImpl(),
              initialState: AddressState.init(isForCheckOut: false),
            );
            // Explicitly set the address type to ensure it's initialized
            // Set the address type based on myAddress.addressType
            if (myAddress?.addressType != null && isEdit!) {
              final String addressType = myAddress!.addressType!.toLowerCase();
              if (addressType == 'home') {
                addressCubit.setAddressType(AddressType.home.name);
              } else if (addressType == 'work') {
                addressCubit.setAddressType(AddressType.work.name);
              } else {
                addressCubit.setAddressType(AddressType.other.name);
              }
            } else {
              // Default to home if no address type is provided
              addressCubit.setAddressType(AddressType.home.name);
            }

            return addNewAddressCubit;
          },
        ),
        BlocProvider<AddressCubit>(
          create: (BuildContext context) {
            final AddressCubit addressCubit = AddressCubit(
              addressRepositoryImpl: AddressRepositoryImpl(),
              initialState: AddressState.init(isForCheckOut: false),
            )
              // Explicitly set the address type to ensure it's initialized
              ..setAddressType(AddressType.home.name);
            return addressCubit;
          },
        ),
      ],
      child: NewAddressAddWidget(
        device: device,
        isEdit: isEdit ?? false,
        isFromAddressList: isFromAddressList ?? false,
        myAddress: myAddress,
      ),
    );
  }
}
