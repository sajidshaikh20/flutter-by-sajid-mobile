import '../../../utils/exports.dart';

/// Extension for [AddressCubit] to handle retrieving city data from the API.
extension GetCityData on AddressCubit {
  /// Fetches city data from the API based on the selected state.
  ///
  /// This method constructs a request with necessary parameters like store ID,
  /// website ID, customer token, and region ID (from the selected state). It
  /// then calls the repository to fetch the city data. Based on the response,
  /// it either emits a success state with the city data or a failure state with
  /// an error message.
  Future<void> getCityDataFromApi() {
    // Emit loading state before making the API call
    emitData(state.copyWith(status: BaseStateStatus.loading));

    GetCityAddressRequestModel getCityData = GetCityAddressRequestModel(
      websiteId: getIt<CountryService>().websiteId,
      // Website ID from CountryService
      customerToken: getIt<UserProfileService>().customerToken,
      // Customer token
      fieldId: APIConstant.regionId,
      // Field ID for the region
      regionId: state.selectedState?.regionId, // Region ID from selected state
    );

    return addressRepositoryImpl
        .getCityAddressFormData(cityAddressListRequestModel: getCityData)
        .then(
      (ResponseHandler<GetCityAddressResponse> value) {
        // Handle success response
        if (value.isSuccess()) {
          GetCityAddressResponse? response =
              value.getSuccessInstance()?.response;

          if (response?.success ?? false) {
            // Emit success state with the fetched city data
            emitData(
              state.copyWith(
                status: BaseStateStatus.success, // Success state
                listOfCity:
                    response?.cityArea ?? <CityArea>[], // List of cities
              ),
            );
          } else {
            // Emit failure state with error message from response
            emitData(
              state.copyWith(
                errorMessage: response?.message ?? '', // Error message
                status: BaseStateStatus.failure, // Failure state
              ),
            );
          }
        }
        // Handle failure response
        else if (value.isFailure()) {
          ErrorResult? response = value.getFailureInstance()?.error;
          emitData(
            state.copyWith(
              errorMessage: response?.errorMessage ?? '', // Error message
              status: BaseStateStatus.failure, // Failure state
            ),
          );
        }
      },
    );
  }
}
