import '../../../utils/exports.dart';

/// Extension for saving an address in the AddressCubit.
extension SaveAddress on AddressCubit {
  /// Saves the address if the form is valid.
  Future<void> saveAddress() async {
    // Validate the form before proceeding
    if (state.formKey.currentState?.validate() ?? false) {
      emitData(state.copyWith(status: BaseStateStatus.loading));

      // Create the address data from the form fields
      AddressDataToAdd addressData = AddressDataToAdd(
        firstName: state.firstNameTextEditingController.text,
        lastName: state.lastNameTextEditingController.text,
        mobileNumber: state.mobileNumberEditingController.text,
        mobileNumberPrefix: state.mobileCode,
        addressTitle: state.currentSelectedAddress ?? '',
        street: <String>[
          state.streetAddress1TextEditingController.text,
        ],
        company: '',
        city: state.cityTextEditingController.text,
        regionId: state.selectedState?.regionId ?? '',
        region: state.selectedState?.name ?? '',
        latitude: state.latLng?.latitude.toString(),
        longitude: state.latLng?.longitude.toString(),
        countryId: state.selectedCountry?.countryId ?? '',
        defaultBilling:
            (state.isBilling ?? false) ? APIConstant.yes : APIConstant.no,
        defaultShipping:
            (state.isBilling ?? false) ? APIConstant.yes : APIConstant.no,
        saveInAddressBook:
            (state.isBilling ?? false) ? APIConstant.yes : APIConstant.no,
        postcode: state.postalCodeTextEditingController.text,
      );

      // Create the request model for adding the address
      AddAddressRequestModel addAddressRequestModel = AddAddressRequestModel(
        websiteId: getIt<CountryService>().websiteId,
        customerToken: getIt<UserProfileService>().customerToken,
        addressId: isForEdit ? addressId : '',
        addressData: jsonEncode(
          addressData.toJson(),
        ),
      );

      // Call the repository to add the address
      await addressRepositoryImpl
          .addAddressFormData(
        addAddressListRequestModel: addAddressRequestModel,
      )
          .then(
        (ResponseHandler<SaveAddressResponseModel> value) {
          // Handle success response
          if (value.isSuccess()) {
            SaveAddressResponseModel? response =
                value.getSuccessInstance()?.response;
            if (response?.success ?? false) {
              emitData(
                state.copyWith(
                  status: BaseStateStatus.success,
                  redirectRoute: (state.isForCheckOut ?? false)
                      ? const CartListRoute()
                      : ListAddressRoute(),
                ),
              );
            } else {
              // Handle failure response
              emitData(
                state.copyWith(
                  errorMessage: response?.message,
                  status: BaseStateStatus.failure,
                ),
              );
            }
          } else {
            // Handle failure case
            if (value.isFailure()) {
              ErrorResult? response = value.getFailureInstance()?.error;
              emitData(
                state.copyWith(
                  errorMessage: response?.errorMessage ?? '',
                  status: BaseStateStatus.failure,
                ),
              );
            }
          }
        },
      );
    }
  }
}
