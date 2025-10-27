import '../../../utils/exports.dart';

/// Extension for [AddressCubit] to handle location-related functionality.
extension GetLocationExtension on AddressCubit {
  // FIXME: [DEV-456] Implement real-time location functionality when required.

  /// Fetches the current location of the user.
  ///
  /// This method checks for location permissions and whether location services
  /// are enabled. If permissions are denied forever or services are disabled,
  /// it shows a location permission dialog. If real-time location is required
  /// (controlled by the [moveToCurrentLocation] flag),
  /// it will fetch the current
  /// location and update the state accordingly.
  ///
  /// It also updates the street address based on the coordinates obtained.
  Future<void> getLocation({bool moveToCurrentLocation = false}) async {
    // Step 1: Request location permission from the user
    LocationPermission locationPermission =
    await Geolocator.requestPermission();
    if (locationPermission == LocationPermission.deniedForever) {
      // Show location permission dialog if permission is denied forever
      emitData(
        state.copyWith(
          status: BaseStateStatus.success,
          showLocationPermission: true, // Show location permission dialog
        ),
      );
      return;
    }

    // Step 2: Check if location services are enabled
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Notify user to enable location services
      emitData(
        state.copyWith(
          status: BaseStateStatus.success,
          showLocationPermission: true, // Show location permission dialog
        ),
      );
      return;
    }

    if (moveToCurrentLocation) {
      // Step 3: Handle real-time location functionality
      try {
        LocationSettings locationSettings = const LocationSettings(
          accuracy: LocationAccuracy.high,
          timeLimit:  Duration(seconds: 10),
        );

        DebugLog.instance.i('Getting current location...');
        Position position = await Geolocator.getCurrentPosition(
          locationSettings: locationSettings,
        );
        
        double lat = position.latitude;
        double long = position.longitude;
        LatLng location = LatLng(lat, long);
        
        DebugLog.instance.i('Current location obtained: $lat, $long');
        DebugLog.instance.i('Default location: ${AddressState.defaultLocation.latitude}, ${AddressState.defaultLocation.longitude}');
        DebugLog.instance.i('Location difference: ${(lat - AddressState.defaultLocation.latitude).abs()}, ${(long - AddressState.defaultLocation.longitude).abs()}');

        // Update state with current location
        emitData(
          state.copyWith(
            status: BaseStateStatus.success, // Success state
            latLng: location, // Current location
          ),
        );
        
        DebugLog.instance.i('State updated with location: ${state.latLng}');
        
        // Animate camera to current location
        await animateCamera();
        
        // Immediately get placemark data for the current location
        DebugLog.instance.i('Getting placemark data for current location...');
        await getPlacemarkData(location);
        
      } on Exception catch (error) {
        DebugLog.instance.e('Error getting current location: $error');
        // Fall back to default location if current location fails
        emitData(
          state.copyWith(
            status: BaseStateStatus.success,
            latLng: AddressState.defaultLocation,
          ),
        );
      }
    }
  }

  /// Get placemark data for a given location
  Future<void> getPlacemarkData(LatLng location) async {
    try {
      DebugLog.instance.i('Getting placemark data for: ${location.latitude}, ${location.longitude}');
      List<Placemark> place = await placemarkFromCoordinates(
        location.latitude,
        location.longitude,
      );

      if (place.isNotEmpty) {
        Placemark placemark = place.first;
        DebugLog.instance.i('Placemark obtained: ${placemark.name} - ${placemark.street}');
        
        // Update primary street address
        state.streetAddress1TextEditingController.text =
        Platform.isIOS ? placemark.name ?? placemark.street ?? '' : placemark.street ?? placemark.name ?? '';
        
        // Update additional address fields for better display
        if (placemark.subThoroughfare?.isNotEmpty ?? false) {
          state.streetAddress2TextEditingController.text = '${placemark.subThoroughfare}';
        }
        
        if (placemark.subLocality?.isNotEmpty ?? false) {
          state.streetAddress3TextEditingController.text = '${placemark.subLocality}';
        }
        
        // Update city field if available
        if (placemark.locality?.isNotEmpty ?? false) {
          state.cityTextEditingController.text = '${placemark.locality}';
        }
        
        // Update postal code if available
        if (placemark.postalCode?.isNotEmpty ?? false) {
          state.postalCodeTextEditingController.text = '${placemark.postalCode}';
        }

        DebugLog.instance.i('Street address updated: ${state.streetAddress1TextEditingController.text}');
        
        // Emit success state with updated address information
        emitData(
          state.copyWith(
            status: BaseStateStatus.success,
            latLng: location,
          ),
        );
      } else {
        DebugLog.instance.w('No placemark data found for location');
      }
    } on Exception catch (error) {
      DebugLog.instance.e('Error getting placemark: $error');
      // Still emit success state even if placemark fails
      emitData(
        state.copyWith(
          status: BaseStateStatus.success,
          latLng: location,
        ),
      );
    }
  }
}
