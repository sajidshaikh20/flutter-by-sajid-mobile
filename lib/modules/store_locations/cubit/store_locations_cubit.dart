import '../../../utils/exports.dart';

/// Cubit responsible for managing store locations state and operations.
/// Handles fetching store lists, managing selection state, and user interactions.
class StoreLocationsCubit extends Cubit<StoreLocationsState> {
  /// Repository for handling address-related API calls and data.
  final AddressRepositoryImpl addressRepositoryImpl;

  /// Creates a [StoreLocationsCubit].
  ///
  /// [addressRepositoryImpl] is required for API operations.
  /// [initialState] can be provided to override the default initial state.
  StoreLocationsCubit({
    StoreLocationsState? initialState,
    required this.addressRepositoryImpl,
  }) : super(initialState ?? StoreLocationsState.initial()) {
    unawaited(_callGetStoreListApi());
    setUpScrollListener();
  }

  /// Fetches the list of stores from the repository and updates the state.
  Future<void> _callGetStoreListApi({bool isLoadMore = false}) async {
    // Create the request model for store listing
    final SelectedAddressModel? address = await SharedPref.instance.getSelectedAddress();
    
    final String latitude = address?.latitude?.toString() ?? "";
    final String longitude = address?.longitude?.toString() ?? "";

    StoreListRequestModelDukkan storeRequestModel = StoreListRequestModelDukkan(
      customerToken: getIt<UserProfileService>().customerToken,
      languageId: int.tryParse(getIt<LanguageService>().languageId) ?? 1,
      platform: getPlatformName(),
      version: getIt<MainConfig>().packageInfo.version,
      orderMethod: "pickUp",
      limit: AppConstant.limitProduct,
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
          BaseResponse<List<ListOfStoreResponse>>? response =
              value.getSuccessInstance()?.response;

          if (response?.success ?? false) {
            final List<ListOfStoreResponse> stores =
                response?.data ?? <ListOfStoreResponse>[];
            
            // Get total count from response if available
            final int totalCount = value.getSuccessInstance()?.response.totalCount ?? 0;
            
            // Combine existing stores with new ones for pagination
            final List<ListOfStoreResponse> updatedStores = isLoadMore 
                ? <ListOfStoreResponse>[...state.storeList, ...stores]
                : stores;
            
            // Check if more stores can be loaded
            final bool hasMore = stores.length >= 10 && updatedStores.length < totalCount;
            
            emit(state.copyWith(
              apiCallForStore: BaseStateStatus.success,
              storeList: updatedStores,
              currentStorePage: isLoadMore ? state.currentStorePage + 1 : 1,
              totalStoreCount: totalCount,
              hasMoreStores: hasMore,
              isPaginationLoading: false,
            ));
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
    if (state.hasMoreStores && state.apiCallForStore != BaseStateStatus.loading) {
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

  /// Selects a store by index.
  void selectStore(int index) {
    if (index >= 0 && index < state.storeList.length) {
      emit(state.copyWith(
        selectedStoreIndex: index,
      ));
    }
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
  Future<void> saveSelectedStoreAsAddress() async {
    final ListOfStoreResponse? selectedStore = getSelectedStore();
    if (selectedStore != null) {
      // Create address model from selected store
      final SelectedAddressModel storeAddress = SelectedAddressModel(
        title: selectedStore.storeName ?? '',
        details: _buildStoreAddress(selectedStore),
        latitude: selectedStore.lat,
        longitude: selectedStore.lang,
        streetAddress1: selectedStore.street?.toString() ?? '',
        city: selectedStore.city?.toString() ?? '',
        country: selectedStore.country ?? '',
        storeId: selectedStore.storeId, // Add store ID
      );
      
      // Save to SharedPreferences
      await SharedPref.instance.saveSelectedAddress(storeAddress);
    }
  }

  /// Builds store address from API response.
  String _buildStoreAddress(ListOfStoreResponse store) {
    final List<String> addressParts = <String>[];
    
    // Add street if it exists and is not false/empty
    if (store.street != null && store.street.toString().isNotEmpty && store.street != false) {
      addressParts.add(store.street.toString());
    }
    
    // Add district if it exists and is not empty
    if (store.district != null && store.district!.isNotEmpty) {
      addressParts.add(store.district!);
    }
    
    // Add city if it exists and is not false/empty
    if (store.city != null && store.city.toString().isNotEmpty && store.city != false) {
      addressParts.add(store.city.toString());
    }
    
    // Add country if it exists and is not empty
    if (store.country != null && store.country!.isNotEmpty) {
      addressParts.add(store.country!);
    }
    
    // If no address parts, return a default message
    if (addressParts.isEmpty) {
      return 'Store Location';
    }
    
    return addressParts.join(', ');
  }

  /// Sets up a scroll listener to handle infinite scrolling.
  void setUpScrollListener() {
    state.scrollController.addListener(
      () async {
        if (state.scrollController.position.pixels >=
            (state.scrollController.position.maxScrollExtent - 200)) {
          
          // Handle store pagination
          if (!state.isPaginationLoading &&
              state.hasMoreStores &&
              state.storeList.isNotEmpty) {
            await loadMoreStores();
          }
        }
      },
    );
  }

  /// Disposes resources when the cubit is closed.
  @override
  Future<void> close() {
    state.scrollController.dispose();
    return super.close();
  }
}
