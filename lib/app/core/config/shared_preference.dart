import '../../../utils/exports.dart';

/// A class containing keys for shared preferences or other storage mechanisms.
class PrefsKey {
  /// Key to check if the user is logged in.
  static const String isLoggedInKey = 'isLoggedInKey';


  /// Key for the currently selected locale.
  static const String currentLocaleKey = 'currentLocaleKey';

  /// Key for contact us information.
  static const String contactUsKey = 'contactUsKey';

  /// Key for storing the entity ID.
  static const String entityIdKey = 'entityIdKey';

  /// Key for country data.
  static const String countryDataKey = 'countryDataKey';

  /// Key for country list data.
  static const String countryListKey = 'countryListKey';

  /// Key for profile data.
  static const String profileDataKey = 'profileDataKey';

  /// Key for language data.
  static const String languageDataKey = 'languageDataKey';

  /// Key for language list data.
  static const String languageListKey = 'languageListKey';

  /// Key for user profile data.
  static const String userProfileKey = 'userProfileKey';

  /// Key to check if the country and language are selected.
  static const String isCountryAndLanguageSelectedKey =
      'isCountryAndLanguageSelectedKey';

  /// Key for the offer type.
  static const String offerTypeKey = 'offerType';

  /// Key for the offer category ID.
  static const String offerCategoryIdKey = 'offerCategoryId';

  /// Key for the FCM token.
  static const String fcmTokenKey = 'fcmTokenKey';

  /// Key for the quote ID.
  static const String quoteIdKey = 'quoteIdKey';

  /// Key to check if the English language is loaded.
  static const String isEnglishLanguageLoadedKey = 'isEnglishLanguageLoaded';

  /// Key for biometric model data.
  static const String isBioMetricModelKey = 'isBioMetricModelKey';

  /// Key for social login type.
  static const String socialLoginTypeKey = 'socialLoginTypeKey';

  /// Key for selected address data.
  static const String selectedAddressKey = 'selectedAddressKey';

  /// Key for selected address coordinates.
  static const String selectedAddressLatLngKey = 'selectedAddressLatLngKey';

  /// Key for selected address title.
  static const String selectedAddressTitleKey = 'selectedAddressTitleKey';

  /// Key for selected address details.
  static const String selectedAddressDetailsKey = 'selectedAddressDetailsKey';

  /// Key for delivery type (delivery/pickup).
  static const String deliveryTypeKey = 'deliveryTypeKey';

  /// Key for selected store ID.
  static const String selectedStoreIdKey = 'selectedStoreIdKey';

  /// Key for Facebook URL.
  static const String facebookUrlKey = 'facebookUrlKey';
  
  /// Key for Instagram URL.
  static const String instagramUrlKey = 'instagramUrlKey';
  
  /// Key for YouTube URL.
  static const String youTubeUrlKey = 'youTubeUrlKey';

  /// Key indicating whether we have already asked for notification permission
  /// at least once. Used to avoid auto-request loops on subsequent launches.
  static const String notificationPermissionAskedKey = 'notificationPermissionAskedKey';
}

/// Minimal model for storing biometric login data in SharedPreferences.
class BiometricModel {
  BiometricModel();
  factory BiometricModel.fromJson(Map<String, dynamic> _) => BiometricModel();
  Map<String, dynamic> toJson() => <String, dynamic>{};
}

/// A class to manage shared preferences with encryption support.
class SharedPref {
  ///Instance of sharedPref
  static SharedPref instance = getIt<SharedPref>();

  /// The instance of GetStorage used for storing preferences.
  GetStorage? _prefsInstance;

  /// The encryption key for securing stored data.
  String encryptKey = '';

  /// The encryption initialization vector.
  String encryptIv = '';

  /// Initializes the shared preferences instance and sets encryption keys.
  Future<void> init() async {

    _prefsInstance ??= GetStorage();

    _getEncryptionKey();

    if (kIsWeb) {
      encryptIv = AppConstant.web.padLeft(AppConstant.encryptionLength, '0');
    } else {
      if (Platform.isAndroid) {
        encryptIv =
            AppConstant.android.padLeft(AppConstant.encryptionLength, '0');
      } else if (Platform.isIOS) {
        encryptIv = AppConstant.ios.padLeft(AppConstant.encryptionLength, '0');
      }
    }
  }

  void _isPreferenceReady() {
    // DebugLog.instance.i('Checking if SharedPref is ready...');
    // DebugLog.instance.i('_prefsInstance is null: ${_prefsInstance == null}');
    assert(_prefsInstance != null, 'SharedPreferences not ready yet!');
    // DebugLog.instance.i('SharedPref is ready');
  }

  /// Retrieves a boolean value from shared preferences.
  /// Returns [defValue] if the key does not exist.
  bool getBool(String key, {bool? defValue}) {
    String? value = _decodedValue(key);
    return value.isNotNullOrEmpty ? bool.parse(value!) : defValue ?? false;
  }

  /// Retrieves an integer value from shared preferences.
  /// Returns [defValue] if the key does not exist.
  int getInt(String key, [int? defValue]) {
    String? value = _decodedValue(key);
    return value.isNotNullOrEmpty ? int.parse(value!) : defValue ?? 0;
  }

  /// Retrieves a double value from shared preferences.
  /// Returns [defValue] if the key does not exist.
  double getDouble(String key, [double? defValue]) {
    String? value = _decodedValue(key);
    return value.isNotNullOrEmpty ? double.parse(value!) : defValue ?? 0.0;
  }

  /// Retrieves a string value from shared preferences.
  /// Returns [defValue] if the key does not exist.
  String getString(String key, [String? defValue]) {
    String? value = _decodedValue(key);
    return value.isNotNullOrEmpty ? value! : defValue ?? '';
  }

  /// Sets a value in shared preferences with optional encryption.
  /// Sets a value in shared preferences with optional encryption.
  Future<void> setValue(
      String key,
      dynamic value, {
        bool isNeedToAwait = false,
      }) async {
    String encrypted = AESEncryption.instance.encryptCode(
      encryptKey,
      encryptIv,
      text: value.toString(),
    );
    if (isNeedToAwait) {
      await _prefsInstance?.write(key, encrypted);
    } else {
      await _prefsInstance?.write(key, encrypted);
    }
  }

  /// Retrieves a value from shared preferences.
  /// Returns [defValue] if the key does not exist.
  Future<dynamic> getValue(String key, [dynamic defValue]) async {
    String? value = _decodedValue(key);
    return value.isNotNullOrEmpty ? value! : defValue ?? '';
  }



  /// This function will store all the required selected biometric data
  Future<void> storeBioMetricLogin(BiometricModel bioModel) async {
    String jsonString = jsonEncode(bioModel.toJson());
    await setValue(PrefsKey.isBioMetricModelKey, jsonString);
  }

  /// Retrieves biometric login data from shared preferences.
  Future<BiometricModel?> getBioMetricLoginData() async {
    BiometricModel? bioMetricModel;
    String? jsonString =
    await getValue(PrefsKey.isBioMetricModelKey);
    if (jsonString != null && jsonString.isNotEmpty) {
      Map<String, dynamic> jsonMap = jsonDecode(jsonString);
      bioMetricModel = BiometricModel.fromJson(jsonMap);
    } else {
      bioMetricModel = null;
    }
    return bioMetricModel;
  }




  /// Completes with true once the user
  ///   preferences for the app has been cleared.
  Future<void> clearData() async {

    BiometricModel? bioModel = await getBioMetricLoginData();


    String type = getString(PrefsKey.offerTypeKey, '');
    String quoteId = getString(PrefsKey.quoteIdKey, '');
    bool isEnglishLanguageLoaded =
    getBool(PrefsKey.isEnglishLanguageLoadedKey, defValue: true);
    String offerCategoryIdKey =
    getString(PrefsKey.offerCategoryIdKey, '');
    await _prefsInstance?.erase();

    await Future.wait(
      <Future<void>>[
        setValue(PrefsKey.isCountryAndLanguageSelectedKey, true),
        setValue(PrefsKey.offerTypeKey, type),
        setValue(PrefsKey.offerCategoryIdKey, offerCategoryIdKey),
        setValue(PrefsKey.quoteIdKey, quoteId),



        setValue(
          PrefsKey.isEnglishLanguageLoadedKey,
          isEnglishLanguageLoaded,
        ),
        storeBioMetricLogin(
          bioModel ?? BiometricModel(),
        ),
      ],
    );
  }

  /// Best to clean up by calling this
  ///   function in the State object's dispose() function.
  void dispose() {
    _prefsInstance = null;
  }

  String? _decodedValue(String key) {
    _isPreferenceReady();
    if (_prefsInstance?.read(key) != null) {
      dynamic value = _prefsInstance?.read(key);
      if (value.toString().trim().isNotEmpty) {
        return AESEncryption.instance.decryptCode(encryptKey, encryptIv, text: value);
      } else {
        return '';
      }
    } else {
      return null;
    }
  }

  void _getEncryptionKey() {
    encryptKey =
        getIt<MainConfig>().packageInfo.packageName.replaceAll('.', '0');

    //check if encryption key is less than
    //AppConstant.encryptionLength digit then
    //add 0 in the end
    if (encryptKey.length > AppConstant.encryptionLength) {
      encryptKey = encryptKey.substring(0, AppConstant.encryptionLength);
    } else {
      encryptKey = encryptKey.padLeft(AppConstant.encryptionLength, '0');
    }
  }

  /// Clear selected address data from SharedPreferences
  Future<void> clearSelectedAddress() async {
    await remove(PrefsKey.selectedAddressKey);
  }

  /// Removes an entry from persistent storage.
  Future<void> remove(String key) async {
    await _prefsInstance?.remove(key);
  }

  /// Save delivery type (delivery/pickup) to SharedPreferences
  Future<void> saveDeliveryType(String deliveryType) async {
    await setValue(PrefsKey.deliveryTypeKey, deliveryType);
  }

  /// Get delivery type (delivery/pickup) from SharedPreferences
  String getDeliveryType() {
    return getString(PrefsKey.deliveryTypeKey, 'delivery'); // Default to delivery
  }


  /// Check if CountryService data is stored
  bool isCountryServiceStored() {
    String countryData = getString(PrefsKey.countryDataKey, '');
    String countryListData = getString(PrefsKey.countryListKey, '');
    bool isStored = countryData.isNotEmpty || countryListData.isNotEmpty;
    DebugLog.instance.i('CountryService storage check: $isStored (data: ${countryData.isNotEmpty}, list: ${countryListData.isNotEmpty})');
    return isStored;
  }

  /// Load and store LanguageService data
  Future<void> loadAndStoreLanguageService() async {
    DebugLog.instance.i('LanguageService data loaded from SharedPreferences');
  }

  /// Check if LanguageService data is stored
  bool isLanguageServiceStored() {
    String languageData = getString(PrefsKey.languageDataKey, '');
    String languageListData = getString(PrefsKey.languageListKey, '');
    bool isStored = languageData.isNotEmpty || languageListData.isNotEmpty;
    DebugLog.instance.i('LanguageService storage check: $isStored (data: ${languageData.isNotEmpty}, list: ${languageListData.isNotEmpty})');
    return isStored;
  }

  /// Clear only user-related data from SharedPreferences
  Future<void> clearUserDataOnly() async {
    // Keys related to user session, login, and personal info
    final List<String> userRelatedKeys = <String>[
      PrefsKey.isLoggedInKey,
      PrefsKey.userProfileKey,
      PrefsKey.selectedAddressKey,
      PrefsKey.selectedAddressLatLngKey,
      PrefsKey.selectedAddressTitleKey,
      PrefsKey.selectedAddressDetailsKey,
      PrefsKey.deliveryTypeKey,
      PrefsKey.fcmTokenKey,
      PrefsKey.socialLoginTypeKey,
      PrefsKey.quoteIdKey,
      PrefsKey.selectedAddressKey,
    ];

    // Remove only user-related keys
    for (final String key in userRelatedKeys) {
      await remove(key);
    }

    DebugLog.instance.i("SharedPref: Cleared only user-related data successfully");
  }

}
