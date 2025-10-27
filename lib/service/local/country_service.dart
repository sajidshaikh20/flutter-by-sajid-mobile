import '../../utils/exports.dart';

/// A service to manage country-related data.
///
/// This service handles loading country data from shared preferences
/// and provides getters for accessing country information such as
/// country ID, name, flag, store, and contact details.
class CountryService {
  CountryModel? _countryModel;
  List<CountryList>? _cachedCountryList;
  int? _store; // Separate store value that can be updated independently

  /// Returns the singleton instance of the [CountryService].
  static CountryService instance() => getIt<CountryService>();

  /// Loads the country data from shared preferences and parses it into
  /// the [CountryModel]. If no data is found, the country model is set to null.
  Future<void> loadCountryData() async {
    dynamic jsonString =
        await SharedPref.instance.getValue(PrefsKey.countryDataKey);
    /*if (jsonString != null && jsonString.length > 0) {
      dynamic jsonMap = jsonDecode(jsonString);
      _countryModel = CountryModel.fromJson(jsonMap);
    }*/
    if (jsonString is String && jsonString != 'null' && jsonString.isNotEmpty) {
      dynamic jsonMap = jsonDecode(jsonString);
      _countryModel = CountryModel.fromJson(jsonMap);
      // Load the selected store from SharedPreferences
      String? selectedStoreStr = await SharedPref.instance.getValue(PrefsKey.selectedStoreIdKey);
      if (selectedStoreStr != null && selectedStoreStr.isNotEmpty && selectedStoreStr != 'null') {
        _store = int.tryParse(selectedStoreStr);
        DebugLog.instance.d('Selected store loaded from SharedPreferences: $_store');
      } else {
        _store = null;
      }
      DebugLog.instance.d('Country data loaded: ${_countryModel?.countryName} (store: ${_countryModel?.store}, selected store: $_store)');
    } else {
      _countryModel = null;
      _store = null;
      DebugLog.instance.d('No country data found in SharedPreferences');
    }
  }

  /// Ensures country data is loaded before accessing
  Future<void> ensureCountryDataLoaded() async {
    if (_countryModel == null) {
      await loadCountryData();
    }
  }



  /// Store the complete country list from API response
  Future<void> storeCountryList(List<CountryList> countryList) async {
    _cachedCountryList = countryList;
    String jsonString = jsonEncode(countryList.map((CountryList country) => country.toJson()).toList());
    await SharedPref.instance.setValue(PrefsKey.countryListKey, jsonString);
    DebugLog.instance.d('Country list stored with ${countryList.length} countries');
  }

  /// Load the complete country list from SharedPreferences
  Future<List<CountryList>> loadCountryList() async {
    String? jsonString = await SharedPref.instance.getValue(PrefsKey.countryListKey);
    if (jsonString != null && jsonString.isNotEmpty) {
      List<dynamic> jsonList = jsonDecode(jsonString);
      List<CountryList> countryList = jsonList.map((dynamic json) => CountryList.fromJson(json)).toList();
      _cachedCountryList = countryList;
      DebugLog.instance.d('Country list loaded with ${countryList.length} countries');
      return countryList;
    }
    return <CountryList>[];
  }

  /// Gets the cached country list
  List<CountryList> getCountryList() {
    return _cachedCountryList ?? <CountryList>[];
  }

  /// Updates only the store value without changing other country data
  /// This is useful when you want to update the store on selection change
  Future<void> updateStore(int? newStore) async {
    try {
      _store = newStore;
      DebugLog.instance.d('Updating store to: $newStore');

      // Persist the selected store to SharedPreferences with timeout protection
      if (newStore != null) {
        await SharedPref.instance.setValue(
          PrefsKey.selectedStoreIdKey,
          newStore.toString(),
        );
      } else {
        await SharedPref.instance.remove(PrefsKey.selectedStoreIdKey);
      }

      DebugLog.instance.d('Store updated to: $newStore and persisted to SharedPreferences');

    } on Exception catch (e) {
      DebugLog.instance.e('Error updating store in CountryService: $e');
      // Don't rethrow - we want the store update to be non-blocking
      // The in-memory _store value is still updated even if persistence fails
    }
  }

  /// Saves the selected country data to SharedPreferences
  Future<void> saveCountryData(CountryModel countryModel) async {
    _countryModel = countryModel;
    // Reset the separate store value when saving new country data
    //_store = null;
    // Clear the persisted selected store when saving complete country data
   // await SharedPref.instance.remove(PrefsKey.selectedStoreIdKey);
    String jsonString = jsonEncode(countryModel.toJson());
    await SharedPref.instance.setValue(PrefsKey.countryDataKey, jsonString);
    DebugLog.instance.d('Country data saved: ${countryModel.countryName} (store: ${countryModel.store})');
  }

  /// Gets the store value from the API response data for a specific country
  /// This method looks up the country in the cached country list and returns its store value
  int? getStoreFromApiData(String? countryId) {
    if (countryId == null || _cachedCountryList == null) {
      return _countryModel?.store; // Fallback to saved data
    }
    
    final CountryList? countryFromApi = _cachedCountryList!.firstWhereOrNull(
      (CountryList country) => country.countryId == countryId,
    );
    
    if (countryFromApi != null) {
      DebugLog.instance.d('Found country in API data: ${countryFromApi.countryName} (store: ${countryFromApi.store})');
      return countryFromApi.store;
    }
    
    DebugLog.instance.d('Country not found in API data, using saved data: ${_countryModel?.store}');
    return _countryModel?.store; // Fallback to saved data
  }

  /// Gets the store value from the API response data for the currently selected country
  int? get storeFromApiData => getStoreFromApiData(_countryModel?.countryId);

  // Getters

  /// Returns the website ID for the country, or a default
  /// value if not available.
  String get websiteId =>
      _countryModel?.websiteId ?? APIConstant.defaultWebsiteId;

  /// Returns the store ID for the country, or a default value if not available.
  /// Uses the separate _store value if set, otherwise falls back to country model store.
  int? get store {
    final int? storeValue = _store ?? _countryModel?.store;
    DebugLog.instance.d('CountryService.store accessed: $storeValue (isDataLoaded: ${_countryModel != null})');
    return storeValue;
  }

  /// Returns the country ID if available, otherwise null.
  String? get countryId => _countryModel?.countryId;

  /// Returns the country name if available, otherwise null.
  String? get countryName => _countryModel?.countryName;

  /// Returns the country flag if available, otherwise null.
  String? get countryFlag => _countryModel?.countryFlag;

  /// Returns the country code if available, or a default
  /// value if not available.
  String? get countryCode =>
      _countryModel?.countryCode ?? AppConstant.defaultCountryCode;

  /// Returns the contact information for the country,
  ///  or a default contact model
  /// if no information is available.
  ContactUsModel? get contactus =>
      _countryModel?.contactUs ??
      ContactUsModel(email: '', phone: '', subject: '', whatsapp: '');
}
