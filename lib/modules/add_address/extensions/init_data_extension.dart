import '../../../utils/exports.dart';

/// Extension for [AddressCubit] to initialize address data for the form.
extension InitDataExtension on AddressCubit {
  /// Initializes data for the address form.
  ///
  /// This method sets the form values based on whether the user is editing
  /// an existing billing address or adding a new one. It fetches the address
  /// data, sets the values in the form fields, and updates the state with the
  /// appropriate data (e.g., country, state, and location).
  ///
  /// [billingAddress] - The existing billing address to load if editing.
  /// [isForCurrentLocation] - A flag to determine whether to get current location.
  ///
  void loadMap(BillingAddress? billingAddress, {bool isForCurrentLocation = false}) {
    // Parse latitude and longitude for location
    String? latLang = billingAddress?.latLong ?? "";
    LatLng latLng;

    if (isForCurrentLocation) {
      // If user wants current location, set a default and get current location
      latLng = AddressState.defaultLocation;
      // Schedule getting current location
      scheduleMicrotask(() async {
        await getLocation(moveToCurrentLocation: true);
      });
    } else if (latLang.isNotNullOrEmpty && latLang.contains(',')) {
      List<String> splittedLatLang = latLang.split(',');
      latLng = LatLng(
        double.parse(splittedLatLang[0]),
        double.parse(splittedLatLang[1]),
      );
    } else {
      latLng = AddressState.defaultLocation;
    }

    // Update state with the loaded address data
    emitData(state.copyWith(status: BaseStateStatus.loading));
    emitData(
      state.copyWith(
        status: BaseStateStatus.success,
        //  isBilling: (billingAddress.isBilling ?? 0) == 1,
        //    currentSelectedAddress: billingAddress.addressTitle,
        latLng: latLng,
        //   selectedState: selectedState,
        //  selectedCountry: selectedCountry,
      ),
    );
  }
  ///initData
  void initData({
    bool? isEdit,
    BillingAddress? billingAddress,
    bool? shouldGetList,
  }) {
    isForEdit = isEdit ?? false;

    if (isEdit ?? false) {
      // Fetch address form data from API if editing existing address
      unawaited(getAddressFormDataFromApi(billingAddress?.id ?? '').then(
            (void value) async {
          if (billingAddress != null) {
            // Set form fields based on the billing address
            addressId = billingAddress.id ?? '';
            state.firstNameTextEditingController.text =
                billingAddress.firstname ?? '';
            state.lastNameTextEditingController.text =
                billingAddress.lastname ?? '';


            if (billingAddress.street?.isNotEmpty ?? false) {
              List<String> streets = billingAddress.street!;
              state.streetAddress1TextEditingController.text = streets.isNotEmpty ? streets[0] : '';
              state.streetAddress2TextEditingController.text = streets.length > 1 ? streets[1] : '';
              state.streetAddress3TextEditingController.text = streets.length > 2 ? streets[2] : '';
            }

            // Set city, state, postal code, and mobile number fields
            state.cityTextEditingController.text = billingAddress.city ?? '';
            state.stateTextEditingController.text = billingAddress.region ?? '';
            state.postalCodeTextEditingController.text =
                billingAddress.postcode ?? '';
            String countryCode = state.mobileCode;
            String phoneNumber = billingAddress.telephone ?? '';
            if (phoneNumber.startsWith(countryCode.replaceFirst('+', ''))) {
              phoneNumber = phoneNumber.replaceFirst(
                countryCode.replaceFirst('+', ''),
                '',
              );
            }
            state.mobileNumberEditingController.text = phoneNumber;

            // Find the selected country and state from the list
            CountryData? selectedCountry;
            States? selectedState;
            for (int i = 0; i < state.listOfCountry.length; i++) {
              if (state.listOfCountry[i].countryId ==
                  billingAddress.countryId) {
                selectedCountry = state.listOfCountry[i];
                state.countryTextEditingController.text =
                    selectedCountry.name ?? '';
                if (selectedCountry.states?.isNotEmpty ?? false) {
                  for (int j = 0; j < selectedCountry.states!.length; j++) {
                    if (selectedCountry.states?[j].regionId ==
                        billingAddress.regionId?.toString()) {
                      selectedState = selectedCountry.states?[j];
                      state.stateTextEditingController.text =
                          selectedState?.name ?? '';
                      break;
                    }
                  }
                }
                break;
              }
            }

            // Parse latitude and longitude for location
            String? latLang = billingAddress.latLong;
            LatLng latLng;
            if (latLang.isNotNullOrEmpty && latLang!.contains(',')) {
              List<String> splittedLatLang = latLang.split(',');
              latLng = LatLng(
                double.parse(splittedLatLang[0]),
                double.parse(splittedLatLang[1]),
              );
            } else {
              latLng = AddressState.defaultLocation;
            }

            // Update state with the loaded address data
            emitData(state.copyWith(status: BaseStateStatus.loading));
            emitData(
              state.copyWith(
                status: BaseStateStatus.success,
                isBilling: (billingAddress.isBilling ?? 0) == 1,
                currentSelectedAddress: billingAddress.addressTitle,
                latLng: latLng,
                selectedState: selectedState,
                selectedCountry: selectedCountry,
              ),
            );

            // If a state and country were selected, update the selected
            // state
            if (selectedState != null && selectedCountry != null) {
              emitData(state.copyWith(status: BaseStateStatus.loading));
              await setSelectedState(selectedState);
            }

            // Optionally animate the camera (if using a map)
            await animateCamera();
          }
        },
      ));
    } else
    {
      // Load user profile data if creating a new address
      String name = getIt<UserProfileService>().customerName;
      if (name.contains(' ')) {
        List<String> names = name.split(' ');
        state.firstNameTextEditingController.text = names[0];
        state.lastNameTextEditingController.text = names[1];
      } else {
        state.firstNameTextEditingController.text =
            getIt<UserProfileService>().customerName;
        state.lastNameTextEditingController.text =
            getIt<UserProfileService>().customerLastName;
      }
      state.mobileNumberEditingController.text =
          getIt<UserProfileService>().mobileNumber;

      // Set default status as loading
      emitData(state.copyWith(status: BaseStateStatus.loading));

      // Update state with the mobile code (phone prefix)
      emitData(
        state.copyWith(
          status: BaseStateStatus.success,
          mobileCode: getIt<UserProfileService>().prefix.toString(),
        ),
      );

      // Fetch address form data for new address creation
      unawaited(getAddressFormDataFromApi(''));
    }
  }
}
