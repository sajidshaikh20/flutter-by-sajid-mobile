import '../../utils/exports.dart';

/// A service responsible for managing selected address data.
///
/// This service provides functionality to load, update, and store selected
/// address information, such as delivery addresses and pickup stores.
class AddressService {
  /// The model that holds the selected address data.
  SelectedAddressModel? _selectedAddressModel;

  /// Singleton instance of `AddressService`.
  static AddressService instance() => getIt<AddressService>();

  /// Loads the selected address data from shared preferences.
  ///
  /// If the data is available, it decodes the JSON string and populates the
  /// `_selectedAddressModel` with the decoded data. If the data is unavailable,
  /// it initializes the `_selectedAddressModel` as null.
  Future<void> loadSelectedAddress() async {
    dynamic jsonString = await SharedPref.instance.getValue(PrefsKey.selectedAddressKey);
    DebugLog.instance.i('AddressService.loadSelectedAddress: Raw data from SharedPref: "$jsonString" (type: ${jsonString.runtimeType})');

    if (jsonString is String && jsonString != 'null' && jsonString.isNotEmpty) {
      try {
        dynamic jsonMap = jsonDecode(jsonString);
        _selectedAddressModel = SelectedAddressModel.fromJson(jsonMap);
        DebugLog.instance.i('AddressService.loadSelectedAddress: SUCCESS - Address loaded: title="${_selectedAddressModel?.title}", storeId="${_selectedAddressModel?.storeId}", addressId="${_selectedAddressModel?.addressId}"');
      } on Exception catch (e) {
        DebugLog.instance.e('AddressService.loadSelectedAddress: ERROR parsing JSON: $e');
        _selectedAddressModel = null;
      }
    } else {
      DebugLog.instance.w('AddressService.loadSelectedAddress: No valid address data found - jsonString: "$jsonString"');
      _selectedAddressModel = null;
    }
  }

  /// Ensures selected address data is loaded before accessing
  Future<void> ensureAddressDataLoaded() async {
    if (_selectedAddressModel == null) {
      await loadSelectedAddress();
    }
  }

  /// Clears the selected address data from memory
  void clearSelectedAddress() {
    _selectedAddressModel = null;
    DebugLog.instance.i('AddressService: Selected address cleared from memory');
  }

  /// Saves the selected address to SharedPreferences and updates in-memory model
  Future<void> saveSelectedAddress(SelectedAddressModel address) async {
    _selectedAddressModel = address;
    await SharedPref.instance.saveSelectedAddress(address);
    DebugLog.instance.i('AddressService.saveSelectedAddress: SUCCESS - Address saved: title="${address.title}", storeId="${address.storeId}", addressId="${address.addressId}"');
  }

  /// Updates the selected address in SharedPreferences and memory
  Future<void> updateSelectedAddress(SelectedAddressModel address) async {
    await saveSelectedAddress(address);
  }

  /// Removes the selected address from SharedPreferences and memory
  Future<void> removeSelectedAddress() async {
    _selectedAddressModel = null;
    await SharedPref.instance.remove(PrefsKey.selectedAddressKey);
    DebugLog.instance.i('AddressService.removeSelectedAddress: SUCCESS - Address removed from SharedPreferences');
  }

  // Getters for selected address data

  /// The selected address model
  SelectedAddressModel? get selectedAddress => _selectedAddressModel;

  /// The address title (store name for pickup, address type for delivery)
  String get addressTitle => _selectedAddressModel?.title ?? '';

  /// The address details
  String get addressDetails => _selectedAddressModel?.details ?? '';

  /// The address latitude
  double? get latitude => _selectedAddressModel?.latitude;

  /// The address longitude
  double? get longitude => _selectedAddressModel?.longitude;

  /// The address LatLng coordinates
  LatLng? get latLng => _selectedAddressModel?.latLng;

  /// The street address line 1
  String get streetAddress1 => _selectedAddressModel?.streetAddress1 ?? '';

  /// The street address line 2
  String get streetAddress2 => _selectedAddressModel?.streetAddress2 ?? '';

  /// The street address line 3
  String get streetAddress3 => _selectedAddressModel?.streetAddress3 ?? '';

  /// The city
  String get city => _selectedAddressModel?.city ?? '';

  /// The postal code
  String get postalCode => _selectedAddressModel?.postalCode ?? '';

  /// The country
  String get country => _selectedAddressModel?.country ?? '';

  /// The store ID (for pickup stores)
  int? get storeId => _selectedAddressModel?.storeId;

  /// The address ID (for delivery addresses)
  int? get addressId => _selectedAddressModel?.addressId;

  /// Checks if address data is loaded
  bool get isAddressDataLoaded => _selectedAddressModel != null;

  /// Checks if a valid address is selected
  bool get hasValidAddress => _selectedAddressModel?.isValid ?? false;

  /// Checks if the selected address is a pickup store
  bool get isPickupStore => _selectedAddressModel?.isPickupStore ?? false;

  /// Checks if the selected address is a delivery address
  bool get isDeliveryAddress => _selectedAddressModel?.isDeliveryAddress ?? false;

  /// Gets the formatted address string
  String get formattedAddress => _selectedAddressModel?.formattedAddress ?? '';

  ///addressType
  String get addressType => _selectedAddressModel?.addressType ?? '';


  /// Update the delivery type
  /// @param type - The delivery type to set ('pickup' or 'delivery')
  Future<void> updateDeliveryType(String type) async {
    if (type != 'pickup' && type != 'delivery') {
      DebugLog.instance.w('AddressService.updateDeliveryType: Invalid delivery type: $type. Must be "pickup" or "delivery"');
      return;
    }

    await SharedPref.instance.saveDeliveryType(type);
    DebugLog.instance.i('AddressService.updateDeliveryType: Delivery type updated to: $type');
  }
}
