import '../../../utils/exports.dart';

/// This cubit handles the state of the address list, including fetching
/// addresses, setting default addresses, and deleting addresses. It interacts
/// with the `AddressRepositoryImpl` to perform network calls and update the
/// state accordingly.
class AddressListCubit extends Cubit<AddressListState> {
  /// The repository used to fetch, save, and delete addresses.
  final AddressRepositoryImpl addressRepositoryImpl;
  /// The repository used to fetch, edit, and save addresses.
  final AddAddressRepositoryImpl addAddressRepositoryImpl;

  ///constructor
  AddressListCubit({
    required AddressListState initialState,
    required this.addressRepositoryImpl,
    required this.addAddressRepositoryImpl,
  }) : super(initialState) {
    _initializeAddressList();
  }

  /// Initialize address list
  void _initializeAddressList() {
    scheduleMicrotask(() async {
      await callGetAddressListApi(isComeFromDelete: false);
    });
  }

  /// Refreshes the address list and shows shimmer
  Future<void> refreshAddressList() async {
    await callGetAddressListApi(isComeFromDelete: false, isRefreshing: true);
  }

  /// Fetches the list of addresses from the repository and updates the state.
  Future<void> callGetAddressListApi({required bool isComeFromDelete, bool isRefreshing = false}) async {
    try {
      if (isClosed) return; // Check if cubit is still active
      
      // Create the request model for address listing
      AddressListRequestModelDukkan addressRequestModel =
          AddressListRequestModelDukkan(
        customerToken: getIt<UserProfileService>().customerToken,
        languageId: int.tryParse(getIt<LanguageService>().languageId) ?? 1,
        platform: getPlatformName(),
        version: getIt<MainConfig>().packageInfo.version,
        limit: AppConstant.limitProduct,
        offset: 0,
      );
      
      // If the request is not coming from delete, reset the state to loading.
      if (!isComeFromDelete && !isClosed) {
        emit(
          state.copyWith(
            status: BaseStateStatus.loading,
            isDataLoaded: false,
            isRefreshing: isRefreshing,
          ),
        );
      }
      
      // Call the repository to get address list
      await addressRepositoryImpl.getAddressList(addressRequestModel).then(
        (ResponseHandler<BaseResponse<List<MyAddressListingResponse>>> value) {
          if (isClosed) return; // Check again before emitting
          
          if (value.isSuccess()) {
            BaseResponse<List<MyAddressListingResponse>>? response = value.getSuccessInstance()?.response;
            if (response?.success ?? false) {
              final List<MyAddressListingResponse> addresses = response?.data ?? <MyAddressListingResponse>[];
              emit(
                state.copyWith(
                  status: BaseStateStatus.success,
                  addressList: addresses,
                  errorMessage: response?.message??"",
                  isDataLoaded: true,
                  isRefreshing: false,
                ),
              );
            } else {
              emit(
                state.copyWith(
                  status: BaseStateStatus.failure,
                  errorMessage: response?.message ?? '',
                  isDataLoaded: false,
                  isRefreshing: false,
                ),
              );
            }
          } else if (value.isFailure()) {
            emit(
              state.copyWith(
                status: BaseStateStatus.failure,
                errorMessage: value.getFailureInstance()?.error?.errorMessage ??
                    '',
                isDataLoaded: false,
                isRefreshing: false,
              ),
            );
          }
        },
      );
    }on Exception catch (e) {
      DebugLog.instance.e('Error fetching address list: $e');
      if (!isClosed) {
        emit(
          state.copyWith(
            status: BaseStateStatus.failure,
            errorMessage: 'Failed to fetch address list',
            isDataLoaded: false,
            isRefreshing: false,
          ),
        );
      }
    }
  }

  /// Deletes an address and refreshes the address list
  Future<void> deleteAddress(String addressId) async {
    try {
      if (isClosed) return; // Check if cubit is still active
      
      // Create the delete address request model
      DeleteAddressRequestModel deleteRequestModel = DeleteAddressRequestModel(
        customerToken: getIt<UserProfileService>().customerToken,
        languageId: int.tryParse(getIt<LanguageService>().languageId) ?? 1,
        platform: getPlatformName(),
        version: getIt<MainConfig>().packageInfo.version,
        addressId: addressId,
      );

      // Call the repository to delete address
      await addressRepositoryImpl.deleteAddressApi(
        deleteAddressRequestModel: deleteRequestModel,
      ).then(
        (ResponseHandler<BaseResponse<void>> value) async {
          if (isClosed) return; // Check again before emitting
          
          if (value.isSuccess()) {
            BaseResponse<void>? response = value.getSuccessInstance()?.response;
            if (response?.success ?? false) {
              // Check if this is the last address being deleted
              if (state.addressList.length == 1) {
                await getIt<AddressService>().removeSelectedAddress();
                await getIt<CountryService>().updateStore(null);
                final CountryService countryService = getIt<CountryService>();
                await countryService.ensureCountryDataLoaded();
              }
              // Refresh the address list
              await callGetAddressListApi(isComeFromDelete: true);
            } else {
              // Show error message
              emit(
                state.copyWith(
                  status: BaseStateStatus.failure,
                  errorMessage: response?.message ?? "",
                ),
              );
            }
          } else if (value.isFailure()) {
            // Show failure message
            emit(
              state.copyWith(
                status: BaseStateStatus.failure,
                errorMessage: value.getFailureInstance()?.error?.errorMessage ?? '',
              ),
            );
          }
        },
      );
    } on Exception catch (e) {
      DebugLog.instance.e('Error deleting address: $e');
      if (!isClosed) {
        emit(
          state.copyWith(
            status: BaseStateStatus.failure,
            errorMessage: 'Failed to delete address',
          ),
        );
      }
    }
  }

}
