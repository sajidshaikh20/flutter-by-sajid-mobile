import '../../../utils/exports.dart';

/// `AddressCubit` manages the state and interactions for address-related functionalities.
///
/// Responsibilities:
/// - Handle map camera movements and current location
/// - Maintain selected country/state and derived city list
/// - Manage address type, billing flag, and form enablement
/// - Validate enhanced address fields and surface error messages
class AddressCubit extends Cubit<AddressState> {
  /// Creates an [AddressCubit] with the given [initialState] and repository.
  AddressCubit(
      {required AddressState initialState, required this.addressRepositoryImpl})
      : super(initialState) {
    scheduleMicrotask(() async => _initialize());
  }

  /// Repository used for address networking operations.
  AddressRepositoryImpl addressRepositoryImpl;

  /// Flag to check if the address is for editing.
  bool isForEdit = false;

  /// Controller for the Google Map widget.
  GoogleMapController? mapController;

  /// The id of the address when editing an existing one.
  /// For a new address this will remain empty.
  String addressId = "";

  /// Initializes the cubit by fetching the initial location.
  Future<void> _initialize() async {
    await getLocation();
  }

  /// Sets the address type and updates the state.
  void setAddressType(String address) {
    emit(state.copyWith(
        currentSelectedAddress: address, status: BaseStateStatus.success));
  }

  /// Updates the billing status and emits the updated state.
  void updateIsBilling({required bool val}) {
    emit(state.copyWith(status: BaseStateStatus.success, isBilling: val));
  }

  /// Updates the latitude and longitude in the state.
  void updateLatLng(LatLng newLatLang) {
    if (isClosed) return;
    emit(state.copyWith(status: BaseStateStatus.success, latLng: newLatLang));
  }

  /// Animates the camera on the map to the current location.
  Future<void> animateCamera() async {
    await mapController?.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: state.latLng ?? AddressState.defaultLocation,
          //initial position
          zoom: Dimens.zoom10, //initial zoom level
        ),
      ),
    );
  }

  /// Sets the selected state and fetches the city data.
  Future<void> setSelectedState(States? stateData) async {
    emit(state.copyWith(
        selectedState: stateData, status: BaseStateStatus.success));
    await getCityDataFromApi();
  }

  /// Sets the selected country and updates the state.
  void setSelectedCountry(CountryData? countryData) {
    emit(state.copyWith(
        selectedCountry: countryData, status: BaseStateStatus.success));
  }

  /// Updates the mobile code and emits the updated state.
  void updateMobileCode(String mobileCode) {
    emit(state.copyWith(
        status: BaseStateStatus.success, mobileCode: mobileCode));
  }

  /// Handles validation errors for the house/flat/floor field.
  void handleValidationErrorHouseFlatFloor(String value) {
    emit(state.copyWith(
        status: BaseStateStatus.success, houseFlatFloorErrorMessage: value));
  }

  /// Handles validation errors for the apartment/road/area field.
  void handleValidationErrorApartmentRoadAera(String value) {
    emit(state.copyWith(
        status: BaseStateStatus.success, apartmentRoadAeraErrorMessage: value));
  }

  /// Handles validation errors for the mobile number field.
  void handleValidationErrormobileNo(String value) {
    emit(state.copyWith(
        status: BaseStateStatus.success, mobileNoErrorMessage: value));
  }

  /// Handles validation errors for the Area field.
  void handleValidationErrorArea(String value) {
    emit(state.copyWith(status: BaseStateStatus.success, areaErrorMessage: value));
  }

  /// Handles validation errors for Block field.
  void handleValidationErrorBlock(String value) {
    emit(state.copyWith(status: BaseStateStatus.success, blockErrorMessage: value));
  }

  /// Handles validation errors for Street field.
  void handleValidationErrorStreet(String value) {
    emit(state.copyWith(status: BaseStateStatus.success, streetErrorMessage: value));
  }

  /// Handles validation errors for Building/Villa field.
  void handleValidationErrorBuildingVilla(String value) {
    emit(state.copyWith(status: BaseStateStatus.success, buildingVillaErrorMessage: value));
  }

  /// Handles validation errors for Floor field (optional).
  void handleValidationErrorFloor(String value) {
    emit(state.copyWith(status: BaseStateStatus.success, floorErrorMessage: value));
  }

  /// Handles validation errors for Flat/Apartment field (optional).
  void handleValidationErrorFlatApartment(String value) {
    emit(state.copyWith(status: BaseStateStatus.success, flatApartmentErrorMessage: value));
  }

  /// Handles validation errors for Landmark field (optional).
  void handleValidationErrorLandmark(String value) {
    emit(state.copyWith(status: BaseStateStatus.success, landmarkErrorMessage: value));
  }

  /// Validates all required address fields and returns validation result.
  /// 
  /// This method checks all required fields (area, block, street, building/villa)
  /// and sets appropriate error messages if any field is empty.
  /// 
  /// Returns true if all validations pass, false otherwise.
  bool validateAddressFields({
    required String pleaseEnterAreaMsg,
    required String pleaseEnterBlockMsg,
    required String pleaseEnterStreetMsg,
    required String pleaseEnterBuildingVillaMsg,
  }) {
    final String area = state.areaController.text.trim();
    final String block = state.blockController.text.trim();
    final String street = state.streetNameController.text.trim();
    final String building = state.buildingVillaController.text.trim();

    bool isValid = true;

    if (area.isEmpty) {
      handleValidationErrorArea(pleaseEnterAreaMsg);
      isValid = false;
    } else {
      handleValidationErrorArea("");
    }

    if (block.isEmpty) {
      handleValidationErrorBlock(pleaseEnterBlockMsg);
      isValid = false;
    } else {
      handleValidationErrorBlock("");
    }

    if (street.isEmpty) {
      handleValidationErrorStreet(pleaseEnterStreetMsg);
      isValid = false;
    } else {
      handleValidationErrorStreet("");
    }

    if (building.isEmpty) {
      handleValidationErrorBuildingVilla(pleaseEnterBuildingVillaMsg);
      isValid = false;
    } else {
      handleValidationErrorBuildingVilla("");
    }

    return isValid;
  }

  /// Checks if the save button should be enabled based on current form state.
  /// 
  /// The button is enabled only if:
  /// - Area, block, street, and building/villa fields are filled
  /// - Street field does not have a validation error
  /// - Address type (Home/Work/Other) is selected
  /// - Mobile number has no validation error (if provided)
  bool isSaveButtonEnabled() {
    final bool isAreaValid = state.areaController.text.trim().isNotEmpty;
    final bool isBlockValid = state.blockController.text.trim().isNotEmpty;
    final bool isStreetValid = state.streetNameController.text.trim().isNotEmpty && 
                              state.streetErrorMessage.isEmpty;
    final bool isBuildingValid = state.buildingVillaController.text.trim().isNotEmpty;
    final bool isAddressTypeSelected = state.currentSelectedAddress != null && 
                                      state.currentSelectedAddress!.isNotEmpty;
    final bool isMobileValid = state.mobileNoErrorMessage.isEmpty;
    
    return isAreaValid && isBlockValid && isStreetValid && 
           isBuildingValid && isAddressTypeSelected && isMobileValid;
  }

  /// Emits the provided state.
  void emitData(AddressState stateToEmit) {
    emit(stateToEmit);
  }

  /// Enables the save button and updates the state.
  void setSaveButtonEnable({required bool saveButtonEnable}) {
    emit(state.copyWith(
        status: BaseStateStatus.success, saveButtonEnable: true));
  }

  /// Enables the start shopping button and updates the state.
  void setStartShoppingButtonEnable({required bool saveButtonEnable}) {
    emit(state.copyWith(
        status: BaseStateStatus.success, saveButtonEnable: true));
  }

  ///Change focus to next field
  void moveToNextField(FocusNode nextFocusNode) {
    nextFocusNode.requestFocus();
  }



  /// Closes the cubit and disposes of the text editing controllers and focus nodes.
  @override
  Future<void> close() {
    state.firstNameTextEditingController.dispose();
    state.lastNameTextEditingController.dispose();
    state.streetAddress1TextEditingController.dispose();
    state.streetAddress2TextEditingController.dispose();
    state.streetAddress3TextEditingController.dispose();
    state.cityTextEditingController.dispose();
    state.stateTextEditingController.dispose();
    state.postalCodeTextEditingController.dispose();
    state.countryTextEditingController.dispose();
    state.mobileNumberEditingController.dispose();
    state.searchTextEditingController.dispose();
    state.firstNameFocusNode.dispose();
    state.lastNameTextFocusNode.dispose();
    state.streetAddress1FocusNode.dispose();
    state.streetAddress2FocusNode.dispose();
    state.streetAddress3FocusNode.dispose();
    state.cityTextFocusNode.dispose();
    state.stateTextFocusNode.dispose();
    state.postalCodeFocusNode.dispose();
    state.countryFocusNode.dispose();
    state.mobileNumberFocusNode.dispose();
    // New enhanced controllers
    state.areaController.dispose();
    state.blockController.dispose();
    state.streetNameController.dispose();
    state.buildingVillaController.dispose();
    state.floorController.dispose();
    state.flatApartmentController.dispose();
    state.landmarkController.dispose();

    // New enhanced focus nodes
    state.blockFocusNode.dispose();
    state.streetFocusNode.dispose();
    state.buildingVillaFocusNode.dispose();
    state.floorFocusNode.dispose();
    state.flatApartmentFocusNode.dispose();
    state.landmarkFocusNode.dispose();
    return super.close();
  }
}
