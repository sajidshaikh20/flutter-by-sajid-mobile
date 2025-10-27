import '../../../utils/exports.dart';



/// A [Cubit] responsible for managing the state of the "Add New Address" feature.
///
/// This cubit handles validation error messages for different address fields
/// such as house/flat/floor, apartment/road/area, and mobile number.
class AddNewAddressCubit extends Cubit<AddNewAddressState> {
  /// Creates an instance of [AddNewAddressCubit] with the given [initialState].
  ///
  /// The [initialState] contains the initial form field states and error messages.
  AddNewAddressCubit(
      {required AddNewAddressState initialState, required this.repository})
      : super(initialState);

  /// Repository instance for address operations
  final AddAddressRepository repository;

  /// Initialize data for editing an existing address
  void initData(MyAddressListingResponse? myAddress) {
    DebugLog.instance.d(
        'AddNewAddressCubit: Initializing data for editing address: ${myAddress?.id}');

    // Populate all form fields with existing address data
    state.areaController.text = myAddress?.area ?? '';
    state.blockController.text = myAddress?.blockNo ?? '';
    state.streetNameController.text = myAddress?.street ?? '';
    state.buildingVillaController.text = myAddress?.buildingVilla ?? '';
    state.floorController.text = myAddress?.floor ?? '';
    state.flatApartmentController.text = myAddress?.flatAppartment ?? '';
    state.landmarkController.text = myAddress?.landmark ?? '';
    state.mobileNoController.text = myAddress?.mobileNo ?? '';

    // Clear all error messages
    emit(state.copyWith(
      areaErrorMessage: '',
      blockErrorMessage: '',
      streetErrorMessage: '',
      buildingVillaErrorMessage: '',
      floorErrorMessage: '',
      flatApartmentErrorMessage: '',
      landmarkErrorMessage: '',
      mobileNoErrorMessage: '',
    ));
  }

  /// Add Update Address API call method
  Future<void> addUpdateAddress({
    required String area,
    required String blockNo,
    required String streetName,
    required String buildingVilla,
    required String floor,
    required String flatApartment,
    required String landmark,
    bool isEdit = false,
    bool isFromAddressList = false,
    String addressId = '',
    String? addressType,
  }) async {
    try {
      emit(state.copyWith(status: BaseStateStatus.loading));

      // Get saved address from AddressService for lat/lng
      await getIt<AddressService>().ensureAddressDataLoaded();
      final SelectedAddressModel? savedAddress =
          getIt<AddressService>().selectedAddress;
      // Use provided address type or default to home
      final String selectedAddressType = addressType ?? AddressType.home.name;

      // Create address data
      final AddressData addressData = AddressData(
        area: area,
        blockNo: blockNo,
        street: streetName,
        buildingVilla: buildingVilla,
        floor: floor,
        flatAppartment: flatApartment,
        landmark: landmark,
        latitude: savedAddress?.latitude ?? 29.3407,
        longitude: savedAddress?.longitude ?? 48.0839,
        addressType: selectedAddressType,

        // Use selected address type from widget
        postcode: savedAddress?.postalCode ?? '20010',
        mobileNo: state.mobileNoController.text,
        isDefaultBilling: true,
        mapAddressTitle: savedAddress?.title ?? selectedAddressType,
        mapAddress:
            savedAddress?.formattedAddress ?? AppConstant.salmiyahAddress,
      );
      DebugLog.instance.i('AddressData created: ${addressData.toJson()}');

      // Get user profile data
      final UserProfileService userProfileService = getIt<UserProfileService>();
      final LanguageService languageService = getIt<LanguageService>();
      final MainConfig mainConfig = getIt<MainConfig>();

      // Ensure user profile data is loaded
      final String customerToken = await userProfileService.getCustomerToken();

      // Create add new address request model
      final AddNewAddressRequestModel request = AddNewAddressRequestModel(
        languageId: int.tryParse(languageService.languageId) ?? 1,
        quoteId: userProfileService.quoteId ?? 0,
        customerToken: customerToken,
        addressId: addressId,
        platform: getPlatformName(),
        version: mainConfig.packageInfo.version,
        addressData: addressData,
      );
      DebugLog.instance
          .i('AddNewAddressRequestModel created: ${request.toJson()}');

      // Call the repository to save address using AddAddressRepository
      final ResponseHandler<BaseResponse<AddNewAddressResponseModel>> response =
          await repository.callAddUpdateAddress(request);

      if (response.isSuccess()) {
        final OnSuccessResponse<BaseResponse<AddNewAddressResponseModel>>?
            successInstance = response.getSuccessInstance();

        if (successInstance != null) {
          final BaseResponse<AddNewAddressResponseModel> saveResponse =
              successInstance.response;

          // Check if the save operation was successful
          if (saveResponse.success) {
            emit(state.copyWith(
              status: BaseStateStatus.success,
              msg: saveResponse.message,
              redirectRoute: isEdit || isFromAddressList
                  ? ListAddressRoute()
                  : SelectAddressRoute(
                      isFromFirstAddress: true,
                      isFromStoreSelection: true,
                      isFromAddressList: isFromAddressList,
                      addressId: saveResponse.data?.id ?? ""),
            ));

            // Reset form state after successful save (without emitting new state)
            _resetFormStateWithoutEmit();
          } else {
            DebugLog.instance
                .e('Address save failed - API returned success: false');
            DebugLog.instance.e('Error message: ${saveResponse.message}');
            emit(state.copyWith(
              status: BaseStateStatus.failure,
              msg: saveResponse.message,
            ));
          }
        }
      }
    } on Exception catch (e) {
      DebugLog.instance.e('Exception occurred in addUpdateAddress: $e');
    }
  }

  /// Handle validation error for area field
  void handleValidationErrorArea(String errorMessage) {
    emit(state.copyWith(areaErrorMessage: errorMessage));
  }

  /// Handle validation error for block field
  void handleValidationErrorBlock(String errorMessage) {
    emit(state.copyWith(blockErrorMessage: errorMessage));
  }

  /// Handle validation error for street field
  void handleValidationErrorStreet(String errorMessage) {
    emit(state.copyWith(streetErrorMessage: errorMessage));
  }

  /// Handle validation error for building/villa field
  void handleValidationErrorBuildingVilla(String errorMessage) {
    emit(state.copyWith(buildingVillaErrorMessage: errorMessage));
  }

  /// Handle validation error for floor field
  void handleValidationErrorFloor(String errorMessage) {
    emit(state.copyWith(floorErrorMessage: errorMessage));
  }

  /// Handle validation error for flat/apartment field
  void handleValidationErrorFlatApartment(String errorMessage) {
    emit(state.copyWith(flatApartmentErrorMessage: errorMessage));
  }

  /// Handle validation error for landmark field
  void handleValidationErrorLandmark(String errorMessage) {
    emit(state.copyWith(landmarkErrorMessage: errorMessage));
  }

  /// Handle validation error for mobile number field
  void handleValidationErrormobileNo(String errorMessage) {
    emit(state.copyWith(mobileNoErrorMessage: errorMessage));
  }

  /// Update mobile code
  void updateMobileCode(String code) {
    emit(state.copyWith(mobileCode: code));
  }

  /// Move to next field
  void moveToNextField(FocusNode nextFocusNode) {
    nextFocusNode.requestFocus();
  }

  /// Populate area field from saved address
  void populateAreaFromSavedAddress(String area) {
    state.areaController.text = area;
    // Clear any existing area error message
    emit(state.copyWith(areaErrorMessage: ''));
    DebugLog.instance.d('Area field populated: $area');

    // Force a rebuild to ensure the UI updates
    emit(state.copyWith());
  }

  /// Populate form fields for editing an existing address
  void populateFormForEditing({
    required String area,
    required String blockNo,
    required String streetName,
    required String buildingVilla,
    required String floor,
    required String flatApartment,
    required String landmark,
    required String mobileNo,
    required String addressType,
  }) {
    // Populate all form fields
    state.areaController.text = area;
    state.blockController.text = blockNo;
    state.streetNameController.text = streetName;
    state.buildingVillaController.text = buildingVilla;
    state.floorController.text = floor;
    state.flatApartmentController.text = flatApartment;
    state.landmarkController.text = landmark;
    state.mobileNoController.text = mobileNo;

    // Clear all error messages
    emit(state.copyWith(
      areaErrorMessage: '',
      blockErrorMessage: '',
      streetErrorMessage: '',
      buildingVillaErrorMessage: '',
      floorErrorMessage: '',
      flatApartmentErrorMessage: '',
      landmarkErrorMessage: '',
      mobileNoErrorMessage: '',
    ));
  }

  /// Reset form state after successful save (without emitting new state)
  void _resetFormStateWithoutEmit() {
    // Clear all text controllers
    state.areaController.clear();
    state.blockController.clear();
    state.streetNameController.clear();
    state.buildingVillaController.clear();
    state.floorController.clear();
    state.flatApartmentController.clear();
    state.landmarkController.clear();
    state.mobileNoController.clear();

    DebugLog.instance
        .d('Form state reset after successful save (without emit)');
  }
}
