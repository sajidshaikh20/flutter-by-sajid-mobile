import '../../../utils/exports.dart';

/// Handles UI interactions for selecting an address.
class SelectAddressCubit extends Cubit<SelectAddressState>
    with WidgetsBindingObserver {
  /// Repository for handling address-related API calls and data.
  final AddressRepositoryImpl addressRepositoryImpl;

  /// Creates a [SelectAddressCubit] with the initial state.
  SelectAddressCubit({
    SelectAddressState? initialState,
    required this.addressRepositoryImpl,
  }) : super(initialState ?? SelectAddressState.initial()) {
    // Add observer to listen for app lifecycle changes
    WidgetsBinding.instance.addObserver(this);
    unawaited(_checkLocationPermission());
    unawaited(_callGetAddressListApi());
    setUpScrollListener();
    _initializeSegmentIndex();
    _handleFirstAddressFlow();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);

    // When app is resumed, re-check location permission
    if (state == AppLifecycleState.resumed) {
      DebugLog.instance.d('App resumed, re-checking location permission');
      unawaited(_checkLocationPermission());
    }
  }

  /// Initialize segment index based on saved delivery type
  void _initializeSegmentIndex() {
    // Skip normal initialization if we have first address flow
    if (state.isFromFirstAddress == true && state.addressId != null) {
      DebugLog.instance.d('First address flow detected, skipping normal initialization');
      return;
    }

    String deliveryType = SharedPref.instance.getDeliveryType();
    int segmentIndex = 1;
    // Also update AddressService with current delivery type
    unawaited(getIt<AddressService>().updateDeliveryType(deliveryType));

    DebugLog.instance.d('Initializing segment index - saved delivery type: $deliveryType, segment index: $segmentIndex');

    emit(state.copyWith(selectedSegmentIndex: 0));

    // If pickup is selected and permission is granted, load store list
    if (segmentIndex == 1 && state.locationPermissionGranted) {
      DebugLog.instance.d('Initializing with pickup mode and permission granted, setting loading and loading stores');

      // Set loading state immediately for consistent UX
      emit(state.copyWith(
        apiCallForStore: BaseStateStatus.loading,
      ));

      unawaited(_callGetStoreListApi());
    } else if (segmentIndex == 1 && !state.locationPermissionGranted) {
      DebugLog.instance.d(
          'Initializing with pickup mode but no permission, skipping store load');
      // Permission will be requested when user interacts with pickup mode
    }
  }

  /// Handle the first address flow when isFromFirstAddress is true and addressId is provided
  void _handleFirstAddressFlow() {
    if (state.isFromFirstAddress == true && state.addressId != null) {
      DebugLog.instance.d('First address flow initialized - addressId: ${state.addressId}, waiting for address list API');
      DebugLog.instance.d('First address flow will automatically find address and load stores');
    }
  }


  /// Process the first address flow after address list is loaded
  void _processFirstAddressFlow(List<MyAddressListingResponse> addresses) {
    if (state.addressId == null) {
      DebugLog.instance.e('Address ID is null in first address flow');
      return;
    }
    DebugLog.instance.d('Processing first address flow - looking for addressId: ${state.addressId}');
    // Find the address with matching ID
    MyAddressListingResponse? targetAddress;
    try {
      targetAddress = addresses.firstWhere(
        (MyAddressListingResponse address) => address.id == state.addressId,
      );
    } on StateError {
      targetAddress = null;
    }

    if (targetAddress == null) {
      DebugLog.instance.e('Address with ID ${state.addressId} not found in address list');
      emit(state.copyWith(
        apiCallForAddress: BaseStateStatus.failure,
        msg: '',
        selectedSegmentIndex: 0, // Reset to delivery tab
        isFromFirstAddress: false, // Disable first address flow
      ));
      return;
    }

    DebugLog.instance.d('Found target address: ${targetAddress.id}');

    // Store the selected address temporarily for later use
    tempSelectedAddress = targetAddress;
    DebugLog.instance.d('Stored target address as temporary address');

    // Explicitly store and validate target address coordinates for store listing
    // These coordinates will be used by _callGetStoreListApi() to fetch nearby stores
    final double? targetLat = targetAddress.latitude;
    final double? targetLng = targetAddress.longitude;

    if (targetLat == null || targetLng == null) {
      DebugLog.instance.e('Target address coordinates are null');
      emit(state.copyWith(
        apiCallForAddress: BaseStateStatus.failure,
        msg: '',
        selectedSegmentIndex: 0, // Reset to delivery tab
        isFromFirstAddress: false, // Disable first address flow
      ));
      return;
    }

    DebugLog.instance.d('Target address coordinates stored and validated: lat=$targetLat, lng=$targetLng');

    // Switch to pickup tab automatically
    emit(state.copyWith(
      selectedSegmentIndex: 1, // Switch to pickup tab
      selectedStoreIndex: -1,
      storeList: <ListOfStoreResponse>[],
      apiCallForStore: BaseStateStatus.loading,
    ));

    DebugLog.instance.d('Switched to pickup tab for first address flow');

    // Load stores based on the target address coordinates
    unawaited(_callGetStoreListApi());
    DebugLog.instance.d('Started loading stores for first address flow - address: ${targetAddress.street}, using stored coordinates');
  }

  /// Updates the segmented control index when changed by the user.
  void onSegmentChangedIndex(int newIndex) {
    tempSelectedAddress =null;
    // Check if we're already on the same segment to prevent unnecessary reloads
    if (state.selectedSegmentIndex == newIndex) {
      DebugLog.instance.d('Already on segment index $newIndex, skipping reload');
      return;
    }
    // Determine delivery type based on index
    String deliveryType = newIndex == 0 ? 'delivery' : 'pickup';
    bool isSwitchingToPickup = newIndex == 1;
    emit(state.copyWith(
      selectedSegmentIndex: newIndex,
      selectedStoreIndex: -1,
      storeList:
          isSwitchingToPickup ? <ListOfStoreResponse>[] : state.storeList,
      apiCallForStore:
          isSwitchingToPickup ? BaseStateStatus.initial : state.apiCallForStore,
    ));
    // Update home screen delivery type
    _updateHomeScreenDeliveryType(deliveryType);

    if (newIndex == 1) {
      // Check if we already have stores loaded and permission is granted
      if (state.locationPermissionGranted && 
          state.storeList.isNotEmpty && 
          state.apiCallForStore == BaseStateStatus.success) {
        DebugLog.instance.d('Stores already loaded, skipping API call');
        return;
      }
      
      if (!state.locationPermissionGranted) {
        unawaited(requestLocationPermission());
      } else {
        emit(state.copyWith(
          apiCallForStore: BaseStateStatus.loading,
        ));
        // Call API immediately without delay
        unawaited(_callGetStoreListApi());
      }
    }

    DebugLog.instance.i('Delivery type changed to: $deliveryType (index: $newIndex)');
  }

  /// Update home screen delivery type
  void _updateHomeScreenDeliveryType(String deliveryType) {
    // This method is now simplified - the home screen will refresh from preferences
    // when it becomes visible again
    DebugLog.instance.i('Delivery type updated in preferences: $deliveryType');
  }

  /// Check location permission status
  Future<void> _checkLocationPermission() async {
    bool hasPermission =
        await PermissionManager().checkLocationPermissionEnhanced();
    bool previousPermission = state.locationPermissionGranted;

    emit(state.copyWith(locationPermissionGranted: hasPermission));

    // If permission was previously denied but is now granted, and we're on pickup tab,
    // load the store list
    if (!previousPermission &&
        hasPermission &&
        state.selectedSegmentIndex == 1) {
      DebugLog.instance.d('Location permission granted, loading store list');
      unawaited(_callGetStoreListApi());
    }
  }

  /// Request location permission using PermissionManager
  Future<void> requestLocationPermission() async {
    bool hasPermission = await PermissionManager().requestLocationPermission();
    emit(state.copyWith(locationPermissionGranted: hasPermission));

    // If permission is granted and we're on pickup tab, load the store list immediately
    if (hasPermission && state.selectedSegmentIndex == 1) {
      DebugLog.instance.d('Location permission granted, setting loading state and loading store list immediately');
      // Set loading state immediately to show shimmer while API call is being prepared
      emit(state.copyWith(
        apiCallForStore: BaseStateStatus.loading,
      ));

      // Call API immediately after state update
      unawaited(_callGetStoreListApi());
    }
  }

  /// Fetches the list of addresses from the repository and updates the state.
  Future<void> _callGetAddressListApi({bool isLoadMore = false}) async {
    // Create the request model for address listing
    AddressListRequestModelDukkan addressRequestModel =
      AddressListRequestModelDukkan(
      customerToken: getIt<UserProfileService>().customerToken,
      languageId: int.tryParse(getIt<LanguageService>().languageId) ?? 1,
      platform: getPlatformName(),
      version: getIt<MainConfig>().packageInfo.version,
      limit: AppConstant.limitProduct,
      offset: isLoadMore ? state.addressList.length : 0,
    );

    if (isLoadMore) {
      emit(state.copyWith(
        isAddressPaginationLoading: true,
      ));
    } else {
      emit(state.copyWith(
        apiCallForAddress: BaseStateStatus.loading,
      ));
    }

    // Call the repository to get address list
    await addressRepositoryImpl.getAddressList(addressRequestModel).then(
      (ResponseHandler<BaseResponse<List<MyAddressListingResponse>>> value) {
        if (value.isSuccess()) {
          final OnSuccessResponse<BaseResponse<List<MyAddressListingResponse>>>?
              successResponse = value.getSuccessInstance();
          BaseResponse<List<MyAddressListingResponse>>? response =
              successResponse?.response;

          if (response?.success ?? false) {
            final List<MyAddressListingResponse> addresses =
                response?.data ?? <MyAddressListingResponse>[];

            // Get total count from response if available
            final int totalCount = response?.totalCount ?? 0;
            // Combine existing addresses with new ones for pagination
            final List<MyAddressListingResponse> updatedAddresses = isLoadMore
                ? <MyAddressListingResponse>[...state.addressList, ...addresses]
                : addresses;

            // Check if more addresses can be loaded
            final bool hasMore =
                addresses.length >= 10 && updatedAddresses.length < totalCount;

            emit(state.copyWith(
              apiCallForAddress: BaseStateStatus.success,
              addressList: updatedAddresses,
              currentAddressPage: isLoadMore ? state.currentAddressPage + 1 : 1,
              totalAddressCount: totalCount,
              hasMoreAddresses: hasMore,
              isAddressPaginationLoading: false,
            ));

            // Handle first address flow after address list is loaded
            if (!isLoadMore &&
                state.isFromFirstAddress == true &&
                state.addressId != null &&
                tempSelectedAddress == null) {
              DebugLog.instance.d('Triggering first address flow processing');
              _processFirstAddressFlow(updatedAddresses);
            }
          } else {
            emit(state.copyWith(
              apiCallForAddress: BaseStateStatus.failure,
              isAddressPaginationLoading: false,
            ));
          }
        } else if (value.isFailure()) {
          emit(state.copyWith(
            apiCallForAddress: BaseStateStatus.failure,
            isAddressPaginationLoading: false,
          ));
        }
      },
    );
  }

  /// Gets the current location coordinates.
  /// Returns null if location services are not available or permission is denied.
  Future<Position?> _getCurrentLocation() async {
    try {
      // Check if location services are enabled
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        if (Platform.isIOS) {
          DebugLog.instance.d(
              'Please enable location services in Settings > Privacy & Security > Location Services');
        } else {
          DebugLog.instance
              .d('Please enable location services in device settings');
        }
        return null;
      }

      // Check location permission
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          DebugLog.instance.d('Location permissions are denied');
          return null;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        DebugLog.instance.d('Location permissions are permanently denied');
        // Show guidance for both platforms
        if (Platform.isIOS) {
          DebugLog.instance.d(
              'Please enable location permission in Settings > Dukkan > Location');
        } else {
          DebugLog.instance
              .d('Please enable location permission in app settings');
        }
        return null;
      }

      // Try to get last known position first for instant results
      Position? lastKnownPosition = await Geolocator.getLastKnownPosition();
      if (lastKnownPosition != null) {
        DebugLog.instance.d(
            'Using last known position: ${lastKnownPosition.latitude}, ${lastKnownPosition.longitude}');
        return lastKnownPosition;
      }

      // Get current position with low accuracy for fastest results
      Position position = await Geolocator.getCurrentPosition(
        locationSettings: const LocationSettings(
          accuracy: LocationAccuracy.low,
          timeLimit: Duration(seconds: 2),
        ),
      );
      DebugLog.instance
          .d('Current location: ${position.latitude}, ${position.longitude}');
      return position;
    } on Exception catch (e) {
      DebugLog.instance.e('Error getting current location: $e');
      return null;
    }
  }

  /// Fetches the list of stores from the repository and updates the state.
  Future<void> _callGetStoreListApi({bool isLoadMore = false}) async {
    // Create the request model for store listing

    // Get latitude and longitude - prioritize temp address, then saved address, then current location
    String latitude;
    String longitude;

    if (tempSelectedAddress?.latitude != null &&
        tempSelectedAddress?.longitude != null &&
        tempSelectedAddress!.latitude != 0.0 &&
        tempSelectedAddress!.longitude != 0.0) {
      // Use temp address coordinates (when user clicked on saved address)
      latitude = tempSelectedAddress!.latitude!.toString();
      longitude = tempSelectedAddress!.longitude!.toString();
      DebugLog.instance.d("Using temp address coordinates: $latitude, $longitude (from first address flow)");
    } else {
      // Fallback to saved address or current location
      final SelectedAddressModel? address = await SharedPref.instance.getSelectedAddress();
      if (address?.latitude != null &&
          address?.longitude != null &&
          address!.latitude != 0.0 &&
          address.longitude != 0.0) {
        // Use saved address coordinates if available
        latitude = address.latitude!.toString();
        longitude = address.longitude!.toString();
        DebugLog.instance.d("Using saved address coordinates: $latitude, $longitude");
      } else {
        // For pickup mode, location coordinates are required
        final Position? currentPosition = await _getCurrentLocation();
        if (currentPosition != null) {
          latitude = currentPosition.latitude.toString();
          longitude = currentPosition.longitude.toString();
          DebugLog.instance.d("Using current location coordinates: $latitude, $longitude");
        } else {
          if (isLoadMore) {
            emit(state.copyWith(
              isPaginationLoading: false,
            ));
          } else {
            emit(state.copyWith(
              apiCallForStore: BaseStateStatus.failure,
            ));
          }
          return;
        }
      }
    }
    final bool hasAddress = tempSelectedAddress?.id != null && tempSelectedAddress!.id!.isNotEmpty;

    DebugLog.instance.e("temp address   ${tempSelectedAddress?.toJson()}");
    StoreListRequestModelDukkan storeRequestModel = StoreListRequestModelDukkan(
      customerToken: getIt<UserProfileService>().customerToken,
      languageId: int.tryParse(getIt<LanguageService>().languageId) ?? 1,
      platform: getPlatformName(),
      version: getIt<MainConfig>().packageInfo.version,
      orderMethod: hasAddress ? AppConstant.delivery : AppConstant.pickup,
      limit: AppConstant.limitProduct,
      addressId: hasAddress ? int.tryParse(tempSelectedAddress!.id!) : null,
      lat: latitude,
      lang: longitude,
      offset: isLoadMore ? state.storeList.length : 0,
    );
    if (isLoadMore) {
      emit(state.copyWith(
        isPaginationLoading: true,
      ));
    } else {
      emit(state.copyWith(
        apiCallForStore: BaseStateStatus.loading,
      ));
    }

    // Call the repository to get store list
    await addressRepositoryImpl.getPickupStoreListing(storeRequestModel).then(
      (ResponseHandler<BaseResponse<List<ListOfStoreResponse>>> value) {
        if (value.isSuccess()) {
          final OnSuccessResponse<BaseResponse<List<ListOfStoreResponse>>>?
              successResponse = value.getSuccessInstance();
          BaseResponse<List<ListOfStoreResponse>>? response =
              successResponse?.response;
          if (response?.success ?? false) {
            final List<ListOfStoreResponse> stores =
                response?.data ?? <ListOfStoreResponse>[];
            // Get total count from response if available
            final int totalCount = response?.totalCount ?? 0;
            // Combine existing stores with new ones for pagination
            final List<ListOfStoreResponse> updatedStores = isLoadMore
                ? <ListOfStoreResponse>[...state.storeList, ...stores]
                : stores;

            // Check if more stores can be loaded
            final bool hasMore =
                stores.length >= 10 && updatedStores.length < totalCount;

            emit(state.copyWith(
              apiCallForStore: BaseStateStatus.success,
              storeList: updatedStores,
              currentStorePage: isLoadMore ? state.currentStorePage + 1 : 1,
              totalStoreCount: totalCount,
              hasMoreStores: hasMore,
              isPaginationLoading: false,
            ));

            // First address flow completed - stores loaded, user can select manually
            if (!isLoadMore && state.isFromFirstAddress == true) {
              DebugLog.instance.d('First address flow completed - stores loaded for manual selection (${stores.length} stores available)');
            }
          } else {
            emit(state.copyWith(
              apiCallForStore: BaseStateStatus.failure,
              isPaginationLoading: false,
            ));
          }
        } else if (value.isFailure()) {
          emit(state.copyWith(
            apiCallForStore: BaseStateStatus.failure,
            isPaginationLoading: false,
          ));
        }
      },
    );
  }

  /// Loads more stores for pagination.
  Future<void> loadMoreStores() async {
    if (state.hasMoreStores &&
        state.apiCallForStore != BaseStateStatus.loading) {
      await _callGetStoreListApi(isLoadMore: true);
    }
  }

  /// Refreshes the store list.
  Future<void> refreshStoreList() async {
    emit(state.copyWith(
      currentStorePage: 1,
      hasMoreStores: true,
    ));
    await _callGetStoreListApi();
  }

  /// Loads more addresses for pagination.
  Future<void> loadMoreAddresses() async {
    if (state.hasMoreAddresses &&
        state.apiCallForAddress != BaseStateStatus.loading) {
      await _callGetAddressListApi(isLoadMore: true);
    }
  }

  /// Refreshes the address list.
  Future<void> refreshAddressList() async {
    emit(state.copyWith(
      currentAddressPage: 1,
      hasMoreAddresses: true,
    ));
    await _callGetAddressListApi();
  }

  /// Selects a store by index.
  void selectStore(int index) {
    if (index >= 0 && index < state.storeList.length) {
      emit(state.copyWith(
        selectedStoreIndex: index,
      ));
    }
  }

  /// Deselects the currently selected store.
  void deselectStore() {
    emit(state.copyWith(selectedStoreIndex: -1));
  }

  /// Gets the currently selected store.
  ListOfStoreResponse? getSelectedStore() {
    if (state.selectedStoreIndex != null &&
        state.selectedStoreIndex! >= 0 &&
        state.selectedStoreIndex! < state.storeList.length) {
      return state.storeList[state.selectedStoreIndex!];
    }
    return null;
  }

  /// Saves the selected store as the pickup address
  /// Handles two scenarios:
  /// 1. When _tempSelectedAddress is null: Saves store directly as pickup address
  /// 2. When _tempSelectedAddress exists: Merges store info with temp address
  /// Returns true if successful, false if failed
  Future<bool> saveSelectedStoreAsAddress(BuildContext context) async {
    try {
      DebugLog.instance.d('Starting saveSelectedStoreAsAddress process...');
      final ListOfStoreResponse? selectedStore = getSelectedStore();
      if (selectedStore == null) {
        DebugLog.instance.e('No store selected for pickup');
        emit(state.copyWith(status: BaseStateStatus.failure, msg: ''));
        return false;
      }
      DebugLog.instance.d('Store validation passed, proceeding with save...');


     final String? quatidsdf = getIt<UserProfileService>().quoteId?.toString();

      // Call changeStoreApi when starting shopping with selected store
      DebugLog.instance.d('Calling changeStoreApi for store: $selectedStore.storeId');
      DebugLog.instance.d('Calling changeStoreApi for quateID: $quatidsdf');
      final ChangeStoreRequest changeStoreRequest = ChangeStoreRequest(
        customerToken: getIt<UserProfileService>().customerToken,
        languageId: int.tryParse(getIt<LanguageService>().languageId) ?? 1,
        platform: getPlatformName(),
        version: getIt<MainConfig>().packageInfo.version,
        currency: getIt<LanguageService>().defaultCurrency,
        addressId: tempSelectedAddress?.id != null ? int.tryParse(tempSelectedAddress!.id!) : null,
        storeId: selectedStore.storeId,
        quoteId: getIt<UserProfileService>().quoteId,
        orderMethod: tempSelectedAddress != null ? AppConstant.delivery : AppConstant.pickup,
      );

      final ResponseHandler<DeleteAddressResponse> changeStoreResponse = await addressRepositoryImpl.changeStoreApi(changeStoreRequest: changeStoreRequest);

      if (changeStoreResponse.isSuccess()) {
        DebugLog.instance.d('changeStoreApi call successful');
      } else {
        DebugLog.instance.w('changeStoreApi call failed, aborting save process');
        emit(state.copyWith(status: BaseStateStatus.failure, msg: changeStoreResponse.getSuccessInstance()?.response.message));
        return false;
      }

      final SelectedAddressModel storeAddress;

      if (tempSelectedAddress == null) {
        // Scenario 1: No temporary address - save store directly as pickup address
        DebugLog.instance.d('No temporary address found, creating store-only address...');
        storeAddress = SelectedAddressModel(
          title: selectedStore.storeName ?? '',
          details: _buildStoreAddress(selectedStore),
          latitude: selectedStore.lat ?? 0.0,
          longitude: selectedStore.lang ?? 0.0,
          streetAddress1: selectedStore.street?.toString() ?? '',
          city: selectedStore.city?.toString() ?? '',
          country: selectedStore.country ?? '',
          storeId: selectedStore.storeId,
        );
      } else
      {
        // Scenario 2: Temporary address exists - keep original address details, just add store ID
        DebugLog.instance.d('Temporary address found, keeping address details and adding store ID...');
        final MyAddressListingResponse selectedAddress = tempSelectedAddress!;
        storeAddress = SelectedAddressModel(
            title: selectedStore.storeName,
            details: selectedAddress.mapAddress ??
                _buildAddressFromTempAddress(selectedAddress),
            latitude: selectedAddress.latitude,
            longitude: selectedAddress.longitude,
            streetAddress1: selectedAddress.street ?? '',
            city: selectedAddress.area ?? '',
            country: '',
            storeId: selectedStore.storeId,
            addressId: int.tryParse(selectedAddress.id ?? ''),
            addressType: selectedAddress.addressType ?? "");
      }
      // Perform all operations concurrently (following language selection pattern)
      await Future.wait(<Future<void>>[
        getIt<AddressService>().saveSelectedAddress(storeAddress),
        selectedStore.storeId != null
            ? getIt<CountryService>().updateStore(selectedStore.storeId!)
            : Future<void>.value(),
        tempSelectedAddress == null
            ? SharedPref.instance.saveDeliveryType('pickup')
            : SharedPref.instance.saveDeliveryType('delivery')
        //  getIt<AddressService>().setDeliveryMode(),
      ]).then((_) {
        // Clear the temporary address
        tempSelectedAddress = null;
        // Emit success state to trigger navigation back
        emit(state.copyWith(
          status: BaseStateStatus.success,
          msg: '',
        ));
        return true;
      });
    } on Exception catch (e) {
      DebugLog.instance.e('AddressService.saveSelectedStoreAsAddress: Error saving store address: $e');
      // Emit failure state (following language selection pattern)
      emit(state.copyWith(
        status: BaseStateStatus.failure,
        msg: '',
      ));
      return false;
    }
    // This should never be reached, but added for completeness
    return true;
  }

  /// Builds store address from API response.
  String _buildStoreAddress(ListOfStoreResponse store) {
    final List<String> addressParts = <String>[];

    if (store.street != null &&
        store.street.toString().isNotEmpty &&
        store.street != false) {
      addressParts.add(store.street.toString());
    }

    if (store.district?.isNotEmpty ?? false) {
      addressParts.add(store.district!);
    }

    if (store.city != null &&
        store.city.toString().isNotEmpty &&
        store.city != false) {
      addressParts.add(store.city.toString());
    }

    if (store.country?.isNotEmpty ?? false) {
      addressParts.add(store.country!);
    }

    return addressParts.isEmpty ? 'Store Location' : addressParts.join(', ');
  }

  /// Builds address details from temporary address response.
  String _buildAddressFromTempAddress(MyAddressListingResponse address) {
    final List<String> addressParts = <String>[];

    if (address.street?.isNotEmpty ?? false) {
      addressParts.add(address.street!);
    }

    if (address.area?.isNotEmpty ?? false) {
      addressParts.add(address.area!);
    }

    if (address.landmark?.isNotEmpty ?? false) {
      addressParts.add(address.landmark!);
    }

    if (address.postcode?.isNotEmpty ?? false) {
      addressParts.add(address.postcode!);
    }
    return addressParts.isEmpty ? '' : addressParts.join(', ');
  }

  /// Loads stores based on selected address location (without saving the address yet)
  Future<void> loadStoresForAddress(
      MyAddressListingResponse selectedAddress) async {
    DebugLog.instance.d("Loading stores for address: ${selectedAddress.id}");

    // Store the selected address temporarily (for later use when store is selected)
    tempSelectedAddress = selectedAddress;
    DebugLog.instance.d("Temporary address stored: lat=${selectedAddress.latitude}, lng=${selectedAddress.longitude}");

    // Switch to pickup tab to show stores
    emit(state.copyWith(
      selectedSegmentIndex: 1,
      selectedStoreIndex: -1,
      storeList: <ListOfStoreResponse>[],
      apiCallForStore: BaseStateStatus.loading,
    ));

    DebugLog.instance.d("Switched to pickup tab, loading stores...");

    // Load stores based on the selected address coordinates
    await _callGetStoreListApi();

    DebugLog.instance.d("Store loading process completed");
  }

  /// Temporary storage for the selected address (used when store is selected)
  MyAddressListingResponse? tempSelectedAddress;

  /// Sets up a scroll listener to handle infinite scrolling.
  void setUpScrollListener() {
    state.scrollController.addListener(
      () async {
        if (state.scrollController.position.pixels >=
            (state.scrollController.position.maxScrollExtent - 200)) {
          // Handle store pagination (pickup tab)
          if (state.selectedSegmentIndex == 1 &&
              !state.isPaginationLoading &&
              state.hasMoreStores &&
              state.storeList.isNotEmpty) {
            await loadMoreStores();
          }

          // Handle address pagination (delivery tab)
          if (state.selectedSegmentIndex == 0 &&
              !state.isAddressPaginationLoading &&
              state.hasMoreAddresses &&
              state.addressList.isNotEmpty) {
            await loadMoreAddresses();
          }
        }
      },
    );
  }

  /// Disposes resources when the cubit is closed.
  @override
  Future<void> close() {
    // Remove observer when cubit is disposed
    WidgetsBinding.instance.removeObserver(this);
    state.scrollController.dispose();
    return super.close();
  }
}
