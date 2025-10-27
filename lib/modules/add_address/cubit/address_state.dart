import '../../../utils/exports.dart';

/// Immutable state for the Add Address flow.
class AddressState extends BaseState {
  /// Creates a new immutable instance of [AddressState].
  ///
  /// [status] - Current state status (loading, success, failure).
  /// [firstNameTextEditingController] - Controller for the "First Name" input.
  /// [lastNameTextEditingController] - Controller for the "Last Name" input.
  /// [streetAddress1TextEditingController] - Controller for the primary street address field.
  /// [mobileCode] - Selected country dial code for the mobile number.
  /// [latLng] - Selected location coordinates from the map.
  const AddressState({
    required super.status,
    super.msg,
    required this.firstNameTextEditingController,
    required this.lastNameTextEditingController,
    required this.streetAddress1TextEditingController,
    required this.streetAddress2TextEditingController,
    required this.streetAddress3TextEditingController,
    required this.cityTextEditingController,
    required this.stateTextEditingController,
    required this.postalCodeTextEditingController,
    required this.countryTextEditingController,
    required this.mobileNumberEditingController,
    required this.mobileCode,
    required this.searchTextEditingController,
    required this.addressListResponseModel,
    required this.formKey,
    required this.firstNameFocusNode,
    required this.lastNameTextFocusNode,
    required this.streetAddress1FocusNode,
    required this.streetAddress2FocusNode,
    required this.streetAddress3FocusNode,
    required this.cityTextFocusNode,
    required this.stateTextFocusNode,
    required this.postalCodeFocusNode,
    required this.countryFocusNode,
    required this.mobileNumberFocusNode,
    this.latLng,
    this.listOfCountry = const <CountryData>[],
    this.listOfCity = const <CityArea>[],

    this.isBilling,
    this.saveButtonEnable,
    super.redirectRoute,
    this.currentSelectedAddress,
    this.selectedCountry,
    this.selectedState,
    this.showLocationPermissionDialog,
    this.isForCheckOut,

    // New fields
    required this.houseFlatFloorController,
    required this.apartmentRoadAreaController,
    required this.mobileNoController,

    // New error messages
    this.houseFlatFloorErrorMessage = '',
    this.apartmentRoadAeraErrorMessage = '',
    this.mobileNoErrorMessage = '',

    // New focus nodes
    required this.houseFlatFloorFocusNode,
    required this.apartmentRoadAeraFocusNode,
    required this.mobileNoFocusNode,

    // Enhanced Add Address fields (per new spec)
    required this.areaController,
    required this.blockController,
    required this.streetNameController,
    required this.buildingVillaController,
    required this.floorController,
    required this.flatApartmentController,
    required this.landmarkController,

    // Error messages for new spec fields
    this.areaErrorMessage = '',
    this.blockErrorMessage = '',
    this.streetErrorMessage = '',
    this.buildingVillaErrorMessage = '',
    this.floorErrorMessage = '',
    this.flatApartmentErrorMessage = '',
    this.landmarkErrorMessage = '',

    // Focus nodes for new spec fields
    required this.blockFocusNode,
    required this.streetFocusNode,
    required this.buildingVillaFocusNode,
    required this.floorFocusNode,
    required this.flatApartmentFocusNode,
    required this.landmarkFocusNode,
  });

  /// Currently selected address type (e.g., home, office).
  final String? currentSelectedAddress;
  /// Controller for the first name input field.
  final TextEditingController firstNameTextEditingController;
  /// Controller for the last name input field.
  final TextEditingController lastNameTextEditingController;
  /// Controller for the primary street address field.
  final TextEditingController streetAddress1TextEditingController;
  /// Controller for the secondary street address field.
  final TextEditingController streetAddress2TextEditingController;
  /// Controller for the tertiary street address field.
  final TextEditingController streetAddress3TextEditingController;
  /// Controller for the city input field.
  final TextEditingController cityTextEditingController;
  /// Controller for the state/region input field.
  final TextEditingController stateTextEditingController;
  /// Controller for the postal/ZIP code input field.
  final TextEditingController postalCodeTextEditingController;
  /// Controller for the country input field.
  final TextEditingController countryTextEditingController;
  /// Controller for the mobile number input field.
  final TextEditingController mobileNumberEditingController;

  /// Focus node for the first name field.
  final FocusNode firstNameFocusNode;
  /// Focus node for the last name field.
  final FocusNode lastNameTextFocusNode;
  /// Focus node for the primary street address field.
  final FocusNode streetAddress1FocusNode;
  /// Focus node for the secondary street address field.
  final FocusNode streetAddress2FocusNode;
  /// Focus node for the tertiary street address field.
  final FocusNode streetAddress3FocusNode;
  /// Focus node for the city field.
  final FocusNode cityTextFocusNode;
  /// Focus node for the state/region field.
  final FocusNode stateTextFocusNode;
  /// Focus node for the postal code field.
  final FocusNode postalCodeFocusNode;
  /// Focus node for the country field.
  final FocusNode countryFocusNode;
  /// Focus node for the mobile number field.
  final FocusNode mobileNumberFocusNode;

  /// Selected country dial code for the mobile number.
  final String mobileCode;
  /// Controller for the address search text field.
  final TextEditingController searchTextEditingController;
  /// Address list response model returned from API.
  final AddressListResponseModel addressListResponseModel;
  /// List of available countries for selection.
  final List<CountryData> listOfCountry;
  /// List of available cities/areas based on country/state selection.
  final List<CityArea> listOfCity;
  /// List of stores available for selection.

  /// Form key used to validate the Add Address form.
  final GlobalKey<FormState> formKey;
  /// Whether the address is to be used as a billing address.
  final bool? isBilling;
  /// Whether the Save button should be enabled.
  final bool? saveButtonEnable;
  /// Selected coordinates from the map for this address.
  final LatLng? latLng;
  /// Currently selected country model.
  final CountryData? selectedCountry;
  /// Currently selected state/region model.
  final States? selectedState;

  /// The default camera position for map-based location selection.
  static const CameraPosition cameraPosition = CameraPosition(
    target: AppConstant.defaultLatLang,
    zoom: Dimens.zoom5,
  );
  /// Default map location used before a position is selected.
  static const LatLng defaultLocation = AppConstant.defaultLatLang;

  /// Default marker used for the location on the map.
  static const Marker marker = Marker(
    draggable: true,
    // Default marker icon
    markerId: MarkerId(AppConstant.markerId),
    position: AppConstant.defaultLatLang,
  );

  /// Determines whether the location permission dialog should be shown.
  final bool? showLocationPermissionDialog;
  /// Whether this state is used in the checkout flow.
  final bool? isForCheckOut;
    // Add selectedTimeSlot to copyWith

  // New fields for additional inputs
  /// Controller for House/Flat/Floor input.
  final TextEditingController houseFlatFloorController;
  /// Controller for Apartment/Road/Area input.
  final TextEditingController apartmentRoadAreaController;
  /// Controller for alternate Mobile Number input.
  final TextEditingController mobileNoController;

  // Controllers for enhanced Add Address spec
  /// Area (auto-fetched/editable).
  final TextEditingController areaController; // Area (auto-fetched/editable)
  /// Block (mandatory, up to 5 digits).
  final TextEditingController blockController; // Block (mandatory, max 5, digits)
  /// Street name (mandatory).
  final TextEditingController streetNameController; // Street (mandatory)
  /// Building/Villa (mandatory).
  final TextEditingController buildingVillaController; // Building/Villa (mandatory)
  /// Floor (optional, digits only).
  final TextEditingController floorController; // Floor (optional, digits)
  /// Flat/Apartment (optional, digits only).
  final TextEditingController flatApartmentController; // Flat/Apartment (optional, digits)
  /// Landmark (optional).
  final TextEditingController landmarkController; // Landmark (optional)

  // New error messages
  /// Error message displayed when the "House/Flat/Floor" field is invalid.
  final String houseFlatFloorErrorMessage;
  /// Error message displayed when the "Apartment/Road/Area" field is invalid.
  final String apartmentRoadAeraErrorMessage;
  /// Error message displayed when the alternate mobile number field is invalid.
  final String mobileNoErrorMessage;

  // Error messages for enhanced fields
  /// Error message for the Area field.
  final String areaErrorMessage;
  /// Error message displayed when the "Block" field is invalid.
  final String blockErrorMessage;
  /// Error message for the Street field.
  final String streetErrorMessage;
  /// Error message for the Building/Villa field.
  final String buildingVillaErrorMessage;
  /// Error message for the Floor field.
  final String floorErrorMessage;
  /// Error message for the Flat/Apartment field.
  final String flatApartmentErrorMessage;
  /// Error message for the Landmark field.
  final String landmarkErrorMessage;

  // New focus nodes
  /// Focus node for the House/Flat/Floor field.
  final FocusNode houseFlatFloorFocusNode;
  /// Focus node for the Apartment/Road/Area field.
  final FocusNode apartmentRoadAeraFocusNode;
  /// Focus node for the alternate mobile number field.
  final FocusNode mobileNoFocusNode;

  // Focus nodes for enhanced fields
  /// Focus node for the Block field.
  final FocusNode blockFocusNode;
  /// Focus node for the Street field.
  final FocusNode streetFocusNode;
  /// Focus node for the Building/Villa field.
  final FocusNode buildingVillaFocusNode;
  /// Focus node for the Floor field.
  final FocusNode floorFocusNode;
  /// Focus node for the Flat/Apartment field.
  final FocusNode flatApartmentFocusNode;
  /// Focus node for the Landmark field.
  final FocusNode landmarkFocusNode;

  @override
  /// Properties used for state equality comparisons.
  List<Object?> get props => <Object?>[
        currentSelectedAddress,
        firstNameTextEditingController,
        lastNameTextEditingController,
        streetAddress1TextEditingController,
        streetAddress2TextEditingController,
        streetAddress3TextEditingController,
        cityTextEditingController,
        stateTextEditingController,
        postalCodeTextEditingController,
        countryTextEditingController,
        mobileNumberEditingController,
        mobileCode,
        searchTextEditingController,
        addressListResponseModel,
        listOfCountry,
        listOfCity,
        formKey,
        isBilling,
        saveButtonEnable,
        latLng,
        selectedCountry,
        selectedState,
        isForCheckOut,

        houseFlatFloorController,
        apartmentRoadAreaController,
        mobileNoController,
        areaController,
        blockController,
        streetNameController,
        buildingVillaController,
        floorController,
        flatApartmentController,
        landmarkController,
        houseFlatFloorErrorMessage,
        apartmentRoadAeraErrorMessage,
        mobileNoErrorMessage,
        areaErrorMessage,
        blockErrorMessage,
        streetErrorMessage,
        buildingVillaErrorMessage,
        floorErrorMessage,
        flatApartmentErrorMessage,
        landmarkErrorMessage,
        houseFlatFloorFocusNode,
        apartmentRoadAeraFocusNode,
        mobileNoFocusNode,
        blockFocusNode,
        streetFocusNode,
        buildingVillaFocusNode,
        floorFocusNode,
        flatApartmentFocusNode,
        landmarkFocusNode,
        ...super.props
      ];

  /// Returns a new [AddressState] with updated values for provided fields.
  AddressState copyWith({
    required BaseStateStatus status,
    String? msg,
    String? currentSelectedAddress,
    AddressListResponseModel? addressListResponseModel,
    String? errorMessage,
    List<CountryData>? listOfCountry,
    List<CityArea>? listOfCity,
    GlobalKey<FormState>? formKey,
    bool? isBilling,
    bool? saveButtonEnable,
    LatLng? latLng,
    PageRouteInfo? redirectRoute,
    CountryData? selectedCountry,
    States? selectedState,
    String? mobileCode,
    bool? showLocationPermission,
    bool? isForCheckOut,
    // New parameters for copyWith
    TextEditingController? houseFlatFloorController,
    TextEditingController? apartmentRoadAreaController,
    TextEditingController? mobileNoController,
    String? houseFlatFloorErrorMessage,
    String? apartmentRoadAeraErrorMessage,
    String? mobileNoErrorMessage,
    FocusNode? houseFlatFloorFocusNode,
    FocusNode? apartmentRoadAeraFocusNode,
    FocusNode? mobileNoFocusNode,
    // Enhanced fields
    TextEditingController? areaController,
    TextEditingController? blockController,
    TextEditingController? streetNameController,
    TextEditingController? buildingVillaController,
    TextEditingController? floorController,
    TextEditingController? flatApartmentController,
    TextEditingController? landmarkController,
    String? areaErrorMessage,
    String? blockErrorMessage,
    String? streetErrorMessage,
    String? buildingVillaErrorMessage,
    String? floorErrorMessage,
    String? flatApartmentErrorMessage,
    String? landmarkErrorMessage,
    FocusNode? blockFocusNode,
    FocusNode? streetFocusNode,
    FocusNode? buildingVillaFocusNode,
    FocusNode? floorFocusNode,
    FocusNode? flatApartmentFocusNode,
    FocusNode? landmarkFocusNode,
  }) {
    return AddressState(
        status: status,
        msg: msg,
        currentSelectedAddress:
            currentSelectedAddress ?? this.currentSelectedAddress,
        firstNameTextEditingController: firstNameTextEditingController,
        lastNameTextEditingController: lastNameTextEditingController,
        streetAddress1TextEditingController:
            streetAddress1TextEditingController,
        streetAddress2TextEditingController:
            streetAddress2TextEditingController,
        streetAddress3TextEditingController:
            streetAddress3TextEditingController,
        cityTextEditingController: cityTextEditingController,
        stateTextEditingController: stateTextEditingController,
        postalCodeTextEditingController: postalCodeTextEditingController,
        countryTextEditingController: countryTextEditingController,
        mobileNumberEditingController: mobileNumberEditingController,
        mobileCode: mobileCode ?? this.mobileCode,
        searchTextEditingController: searchTextEditingController,
        addressListResponseModel:
            addressListResponseModel ?? this.addressListResponseModel,
        listOfCountry: listOfCountry ?? this.listOfCountry,
        listOfCity: listOfCity ?? this.listOfCity,
        formKey: formKey ?? this.formKey,
        isBilling: isBilling ?? this.isBilling,
        saveButtonEnable: saveButtonEnable ?? this.saveButtonEnable,
        latLng: latLng ?? this.latLng,
        selectedCountry: selectedCountry ?? this.selectedCountry,
        selectedState: selectedState ?? this.selectedState,
        redirectRoute: redirectRoute,
        showLocationPermissionDialog:
            showLocationPermission ?? showLocationPermissionDialog,
        isForCheckOut: isForCheckOut ?? this.isForCheckOut,
        houseFlatFloorController:
            houseFlatFloorController ?? this.houseFlatFloorController,
        apartmentRoadAreaController:
            apartmentRoadAreaController ?? this.apartmentRoadAreaController,
        mobileNoController: mobileNoController ?? this.mobileNoController,
        areaController: areaController ?? this.areaController,
        blockController: blockController ?? this.blockController,
        streetNameController:
            streetNameController ?? this.streetNameController,
        buildingVillaController:
            buildingVillaController ?? this.buildingVillaController,
        floorController: floorController ?? this.floorController,
        flatApartmentController:
            flatApartmentController ?? this.flatApartmentController,
        landmarkController: landmarkController ?? this.landmarkController,
        houseFlatFloorErrorMessage:
            houseFlatFloorErrorMessage ?? this.houseFlatFloorErrorMessage,
        apartmentRoadAeraErrorMessage:
            apartmentRoadAeraErrorMessage ?? this.apartmentRoadAeraErrorMessage,
        mobileNoErrorMessage: mobileNoErrorMessage ?? this.mobileNoErrorMessage,
        areaErrorMessage: areaErrorMessage ?? this.areaErrorMessage,
        blockErrorMessage: blockErrorMessage ?? this.blockErrorMessage,
        streetErrorMessage: streetErrorMessage ?? this.streetErrorMessage,
        buildingVillaErrorMessage:
            buildingVillaErrorMessage ?? this.buildingVillaErrorMessage,
        floorErrorMessage: floorErrorMessage ?? this.floorErrorMessage,
        flatApartmentErrorMessage:
            flatApartmentErrorMessage ?? this.flatApartmentErrorMessage,
        landmarkErrorMessage:
            landmarkErrorMessage ?? this.landmarkErrorMessage,
        houseFlatFloorFocusNode:
            houseFlatFloorFocusNode ?? this.houseFlatFloorFocusNode,
        apartmentRoadAeraFocusNode:
            apartmentRoadAeraFocusNode ?? this.apartmentRoadAeraFocusNode,
        mobileNoFocusNode: mobileNoFocusNode ?? this.mobileNoFocusNode,
        blockFocusNode: blockFocusNode ?? this.blockFocusNode,
        streetFocusNode: streetFocusNode ?? this.streetFocusNode,
        buildingVillaFocusNode:
            buildingVillaFocusNode ?? this.buildingVillaFocusNode,
        floorFocusNode: floorFocusNode ?? this.floorFocusNode,
        flatApartmentFocusNode:
            flatApartmentFocusNode ?? this.flatApartmentFocusNode,
        landmarkFocusNode: landmarkFocusNode ?? this.landmarkFocusNode,
        firstNameFocusNode: firstNameFocusNode,
        lastNameTextFocusNode: lastNameTextFocusNode,
        streetAddress1FocusNode: streetAddress1FocusNode,
        streetAddress2FocusNode: streetAddress2FocusNode,
        streetAddress3FocusNode: streetAddress3FocusNode,
        cityTextFocusNode: cityTextFocusNode,
        stateTextFocusNode: stateTextFocusNode,
        postalCodeFocusNode: postalCodeFocusNode,
        countryFocusNode: countryFocusNode,
        mobileNumberFocusNode: mobileNumberFocusNode);
  }

  /// Factory constructor for the initial/default state.
  factory AddressState.init({bool? isForCheckOut}) {
    return AddressState(
      currentSelectedAddress: AddressType.home.name,
      firstNameTextEditingController: TextEditingController(),
      lastNameTextEditingController: TextEditingController(),
      streetAddress1TextEditingController: TextEditingController(),
      streetAddress2TextEditingController: TextEditingController(),
      streetAddress3TextEditingController: TextEditingController(),
      cityTextEditingController: TextEditingController(),
      stateTextEditingController: TextEditingController(),
      postalCodeTextEditingController: TextEditingController(),
      countryTextEditingController: TextEditingController(),
      mobileNumberEditingController: TextEditingController(),
      mobileCode: "",
      searchTextEditingController: TextEditingController(),
      addressListResponseModel: AddressListResponseModel(),
      formKey: GlobalKey<FormState>(),
      isBilling: false,
      showLocationPermissionDialog: false,
      status: BaseStateStatus.initial,
      isForCheckOut: isForCheckOut,
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

      // New fields in the init factory
      houseFlatFloorController: TextEditingController(),
      apartmentRoadAreaController: TextEditingController(),
      mobileNoController: TextEditingController(),

      houseFlatFloorFocusNode: FocusNode(),
      apartmentRoadAeraFocusNode: FocusNode(),
      mobileNoFocusNode: FocusNode(),

      // Enhanced fields init
      areaController: TextEditingController(),
      blockController: TextEditingController(),
      streetNameController: TextEditingController(),
      buildingVillaController: TextEditingController(),
      floorController: TextEditingController(),
      flatApartmentController: TextEditingController(),
      landmarkController: TextEditingController(),

      blockFocusNode: FocusNode(),
      streetFocusNode: FocusNode(),
      buildingVillaFocusNode: FocusNode(),
      floorFocusNode: FocusNode(),
      flatApartmentFocusNode: FocusNode(),
      landmarkFocusNode: FocusNode(),
    );
  }
}
