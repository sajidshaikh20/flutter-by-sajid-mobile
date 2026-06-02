import '../../utils/exports.dart';

/// A service class that handles language-related data and preferences.
class LanguageService {
  LanguageList? _dataModel;

  /// Singleton instance using getIt (dependency injection)
  static LanguageService instance() => getIt<LanguageService>();

  /// Loads language data from SharedPreferences
  Future<void> loadLanguageData() async {
    String? jsonString = await SharedPref.instance.getValue(
      PrefsKey.languageDataKey,
    );
    if (jsonString != null && jsonString.isNotEmpty) {
      Map<String, dynamic> jsonMap = jsonDecode(jsonString);
      _dataModel = LanguageList.fromJson(jsonMap);
      DebugLog.instance.d(
        'Language data loaded: ${_dataModel?.languageName} (ID: ${_dataModel?.languageId})',
      );
    } else {
      _dataModel = null;
      DebugLog.instance.d('No language data found in SharedPreferences');
    }
  }

  /// Ensures language data is loaded before accessing
  Future<void> ensureLanguageDataLoaded() async {
    if (_dataModel == null) {
      await loadLanguageData();
    }
  }

  // Getters for language properties

  /// Retrieves the URL from the data model or returns an empty string if null.
  String get url => _dataModel?.url ?? '';

  /// Retrieves the code from the data model or returns an empty string if null.
  // String get code => _dataModel?.code ?? '';

  /// Retrieves the language ID from the data model or returns an
  ///  empty string if null.
  String get languageId {
    final String id = _dataModel?.languageId ?? '';
    DebugLog.instance.d(
      'LanguageService.languageId accessed: "$id" (isDataLoaded: ${_dataModel != null})',
    );
    return id;
  }

  /// Retrieves the language name from the data model or returns
  ///  an empty string if null.
  String get languageName => _dataModel?.languageName ?? '';

  /// Retrieves the language sort code from the data model or returns
  ///  an empty string if null.
  String get languageSortCode => _dataModel?.languageSortCode ?? '';

  /// Retrieves the default currency from the data model or returns
  ///  the default currency if null.
  String get defaultCurrency =>
      _dataModel?.defaultCurrency ?? APIConstant.defaultCurrency;

  /// Retrieves the language alignment from the data model or returns
  /// the default language alignment if null.
  String get languageAlignment =>
      _dataModel?.languageAlignment ?? AppConstant.defaultLanguageAlignment;

  /// Gets the current language data model
  LanguageList? get languageData => _dataModel;

  // Additional getters for easy access to language properties

  /// Gets the allowed currencies label
  String get allowedCurrenciesLabel =>
      _dataModel?.allowedCurrencies?.label ?? '';

  /// Gets the allowed currencies code
  String get allowedCurrenciesCode => _dataModel?.allowedCurrencies?.code ?? '';

  /// Gets the price format pattern
  String get priceFormatPattern => _dataModel?.priceFormat?.pattern ?? '';

  /// Gets the price format precision
  int get priceFormatPrecision => _dataModel?.priceFormat?.precision ?? 2;

  /// Gets the price format required precision
  int get priceFormatRequiredPrecision =>
      _dataModel?.priceFormat?.requiredPrecision ?? 2;

  /// Gets the price format decimal symbol
  String get priceFormatDecimalSymbol =>
      _dataModel?.priceFormat?.decimalSymbol ?? '.';

  /// Gets the download URL for language files
  String get downloadURL => _dataModel?.downloadURL ?? '';

  /// Gets the timestamp
  String get timeStamp => _dataModel?.timeStamp ?? '';

  /// Store the complete language list from API response
  Future<void> storeLanguageList(List<LanguageList> languageList) async {
    String jsonString = jsonEncode(
      languageList.map((LanguageList lang) => lang.toJson()).toList(),
    );
    await SharedPref.instance.setValue(PrefsKey.languageListKey, jsonString);
    DebugLog.instance.d(
      'Language list stored with ${languageList.length} languages',
    );
  }

  /// Load the complete language list from SharedPreferences
  Future<List<LanguageList>> loadLanguageList() async {
    String? jsonString = await SharedPref.instance.getValue(
      PrefsKey.languageListKey,
    );
    if (jsonString != null && jsonString.isNotEmpty) {
      List<dynamic> jsonList = jsonDecode(jsonString);
      List<LanguageList> languageList = jsonList
          .map((dynamic json) => LanguageList.fromJson(json))
          .toList();
      DebugLog.instance.d(
        'Language list loaded with ${languageList.length} languages',
      );
      return languageList;
    }
    return <LanguageList>[];
  }

  /// Get the complete language list
  Future<List<LanguageList>> getLanguageList() async {
    return loadLanguageList();
  }

  /// Store the selected language model (similar to how CountryService works)
  Future<void> storeSelectedLanguage(LanguageList selectedLanguage) async {
    _dataModel = selectedLanguage;
    String jsonString = jsonEncode(selectedLanguage.toJson());
    await SharedPref.instance.setValue(PrefsKey.languageDataKey, jsonString);
    DebugLog.instance.d(
      'Selected language stored: ${selectedLanguage.languageName} (ID: ${selectedLanguage.languageId})',
    );
  }
}
