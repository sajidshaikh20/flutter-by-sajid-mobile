import '../../../utils/exports.dart';

@RoutePage()
/// Page that allows users to select or manage delivery addresses.
class SelectAddressPage extends BaseResponsiveView {


  /// Indicates if this page was opened from login flow.
  final bool? isFromLogin;

  /// Indicates if this page was opened from first address flow.
  final bool? isFromFirstAddress;

  /// Indicates if this page was opened from address list.
  final bool? isFromAddressList;

  /// The ID of the address to select (optional).
  final String? addressId;

  /// Indicates if this page was opened from store selection middleware.
  /// When true, after saving store, it will navigate to dashboard instead of going back.
  final bool? isFromStoreSelection;

  /// Creates a select address page.
  const SelectAddressPage({
    super.key,
    this.isFromLogin = false,
    this.isFromFirstAddress = false,
    this.isFromAddressList = false,
    this.addressId,
    this.isFromStoreSelection = false,
  });

  @override
  Widget buildDesktopWidget(BuildContext context) =>
      buildViews(context, ScreenType.desktop);

  @override
  Widget buildMobileWidget(BuildContext context) =>
      buildViews(context, ScreenType.mobile);

  @override
  Widget buildTabletWidget(BuildContext context) =>
      buildViews(context, ScreenType.tablet);
/// build class
  Widget buildViews(BuildContext context, ScreenType device) {
    return MultiBlocProvider(
      providers:  <BlocProvider<dynamic>>[
        BlocProvider<SelectAddressCubit>(
          create: (BuildContext context) => SelectAddressCubit(
            initialState: SelectAddressState.initial().copyWith(
              isFromLogin: isFromLogin,
              isFromFirstAddress: isFromFirstAddress,
              addressId: addressId,
              isFromStoreSelection: isFromStoreSelection,
            ),
            addressRepositoryImpl: AddressRepositoryImpl(),
          ),
        ),
        // Add more BlocProviders as needed for this page
        BlocProvider<AddressCubit>(
          create: (BuildContext context) => AddressCubit(
              addressRepositoryImpl: AddressRepositoryImpl(),
              initialState: AddressState(
                  status: BaseStateStatus.initial,
                  apartmentRoadAreaController: TextEditingController(),
                  houseFlatFloorController: TextEditingController(),
                  formKey: GlobalKey<FormState>(),
                  apartmentRoadAeraFocusNode: FocusNode(),
                  houseFlatFloorFocusNode: FocusNode(),
                  areaController: TextEditingController(),
                  blockController: TextEditingController(),
                  streetNameController: TextEditingController(),
                  buildingVillaController: TextEditingController(),
                  floorController: TextEditingController(),
                  flatApartmentController: TextEditingController(),
                  landmarkController: TextEditingController(),
                  firstNameTextEditingController: TextEditingController(),
                  lastNameTextEditingController: TextEditingController(),
                  streetAddress1TextEditingController: TextEditingController(),
                  streetAddress2TextEditingController: TextEditingController(),
                  streetAddress3TextEditingController: TextEditingController(),
                  cityTextEditingController: TextEditingController(),
                  mobileCode: '',
                  stateTextEditingController: TextEditingController(),
                  postalCodeTextEditingController: TextEditingController(),
                  countryTextEditingController: TextEditingController(),
                  mobileNumberEditingController: TextEditingController(),
                  searchTextEditingController: TextEditingController(),
                  addressListResponseModel: AddressListResponseModel(),
                  firstNameFocusNode: FocusNode(),
                  lastNameTextFocusNode: FocusNode(),
                  streetAddress1FocusNode: FocusNode(),
                  streetAddress2FocusNode: FocusNode(),
                  streetAddress3FocusNode: FocusNode(),
                  cityTextFocusNode: FocusNode(),
                  stateTextFocusNode: FocusNode(),
                  postalCodeFocusNode: FocusNode(),
                  countryFocusNode: FocusNode(),
                  mobileNumberFocusNode: FocusNode(),
                  mobileNoController: TextEditingController(),

                  mobileNoFocusNode: FocusNode(),
                  // Enhanced focus nodes
                  blockFocusNode: FocusNode(),
                  streetFocusNode: FocusNode(),
                  buildingVillaFocusNode: FocusNode(),
                  floorFocusNode: FocusNode(),
                  flatApartmentFocusNode: FocusNode(),
                  landmarkFocusNode: FocusNode())),
        ),
      ],
      child: SelectAddressWidget(
        device: device,
      ),
    );
  }
}
