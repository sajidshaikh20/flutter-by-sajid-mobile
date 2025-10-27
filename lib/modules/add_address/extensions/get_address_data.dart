import '../../../utils/exports.dart';

/// Extension for [AddressCubit] to handle retrieving address
/// form data from the API.
extension GetAddressData on AddressCubit {
  /// Fetches address form data from the API.
  ///
  /// This method constructs a request with necessary parameters like store ID,
  /// website ID, customer token, and address ID (if provided), and then calls
  /// the repository to fetch the data. Based on the response, it either emits
  /// a success state with the address data or a failure state with
  /// an error message.
  ///
  /// [addressId]: The ID of the address to retrieve form data for. If null, an
  /// empty string will be used.
  Future<void> getAddressFormDataFromApi(String? addressId) {
    GetAddressFormData getAddressFormData = GetAddressFormData(
      websiteId: getIt<CountryService>().websiteId,
      // Website ID from CountryService
      addressId: addressId ?? '',
      // Address ID, defaults to empty string
      customerToken: getIt<UserProfileService>().customerToken,
      // Customer token
      eTag: '', // Placeholder for eTag
    );

    return addressRepositoryImpl
        .getAddressFormData(addressListRequestModel: getAddressFormData)
        .then(
      (ResponseHandler<GetAddressFormDataResponse> value) {
        // Handle success response
        if (value.isSuccess()) {
          GetAddressFormDataResponse? response =
              value.getSuccessInstance()?.response;
          if (response?.success ?? false) {
            // Emit loading state before updating data
            emitData(state.copyWith(status: BaseStateStatus.loading));

            // Emit the updated state with the fetched address data
            emitData(
              state.copyWith(
                mobileCode:
                    response?.addressDataModel?.mobileNumberPrefix == null
                        ? getIt<UserProfileService>().prefix.toString()
                        : '+${response?.addressDataModel?.mobileNumberPrefix}',
                listOfCountry: response?.countryData ?? <CountryData>[],
                // List of countries
                status: BaseStateStatus.success,
                // Success state
                selectedCountry:
                    response?.countryData?.first, // First country selected
              ),
            );

            // Set the country text in the controller
            state.countryTextEditingController.text =
                state.listOfCountry.isNotEmpty
                    ? state.listOfCountry.first.name.toString()
                    : '';
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
        if (value.isFailure()) {
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
