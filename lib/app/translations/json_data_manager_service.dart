import '../../utils/exports.dart';

/// Service class for managing JSON data operations.
class JsonDataManagerService {
  // Factory constructor to return the same instance
  /// Factory constructor to return a singleton instance
  ///  of [JsonDataManagerService].
  factory JsonDataManagerService() => _instance;

  // Private constructor
  JsonDataManagerService._internal();
  // Singleton instance
  static final JsonDataManagerService _instance =
  JsonDataManagerService._internal();

  // Map to store key-value pairs from the JSON list structure
  Map<String, String>? _keyValueMap;
  Map<String, String>? _keyValueMapForDefault;

  /// Checks if the specified file exists at the given path.
  Future<bool> isFileAvailable(String fileName) async {
    bool fileIsThere = await checkFileFromPath(fileName);
    return fileIsThere;
  }

  /// Checks if a file exists at the specified path in
  /// the application's document directory.
  Future<bool> checkFileFromPath(String fileName) async {
    Directory directory = await getApplicationDocumentsDirectory();
    String filePath = '${directory.path}/$fileName';
    File file = File(filePath);
    return file.existsSync();
  }

  /// Load the JSON file and parse it into a Map.
  Future<bool> loadJsonFileAndIsloadedEnglish(
      String fileName, {
        required bool isDefaultFileLoad,
        required bool isLTR,
      }) async {
    if (isDefaultFileLoad) {
      await loadDefaultEnglishLanguage();
      return true;
    } else {
      try {
        Directory directory = await getApplicationDocumentsDirectory();
        String filePath = '${directory.path}/$fileName';

        File file = File(filePath);
        if (file.existsSync()) {
          String fileContent = await file.readAsString();
          dynamic jsonData = jsonDecode(fileContent);

          // If the JSON is a list of key-value pairs, convert it to a Map
          if (jsonData is List) {
            _keyValueMap = _convertJsonListToMap(jsonData);
          }
          await loadJsonWhenNoDataIsThere();
          return isLTR;
        } else {
          await loadDefaultEnglishLanguage();
          return true;
        }
      } on Exception {
        await loadDefaultEnglishLanguage();
        return true;
      }
    }
  }

  /// Loads the default English JSON file and converts it to a key-value map.
  Future<void> loadJsonWhenNoDataIsThere() async {
    List<dynamic> jsonDataForDefault = await loadEnglishFIleFromAsset();
    _keyValueMapForDefault = _convertJsonListToMap(jsonDataForDefault);
  }

  /// Loads the default English language JSON file from assets and
  ///  returns the data as a list.
  Future<List<dynamic>> loadEnglishFIleFromAsset() async {
    String jsonString = await rootBundle.loadString(Assets.language.en);
    List<dynamic> jsonDataForDefault = jsonDecode(jsonString);
    return jsonDataForDefault;
  }

  /// Loads the default English language JSON file and converts
  ///  it to key-value maps.
  Future<void> loadDefaultEnglishLanguage() async {
    List<dynamic> jsonData = await loadEnglishFIleFromAsset();
    _keyValueMap = _convertJsonListToMap(jsonData);
    _keyValueMapForDefault = _convertJsonListToMap(jsonData);
  }

  /// Converts a List of JSON objects into a `Map<String, String>`.
  Map<String, String> _convertJsonListToMap(List<dynamic> jsonList) => <String, String>{
    for (final dynamic item in jsonList)
      (item as Map<String, dynamic>)['key_name'] as String: item['value'] as String,
  };


  /// Get the key-value map from the JSON list.
  Map<String, String>? get keyValueMap => _keyValueMap;

  /// Access a specific value by key from the key-value map.
  String getValue(String key) =>
      _keyValueMap?[key] ?? _keyValueMapForDefault?[key] ?? '';

  /// Loads the language configuration based on the language sort code.
}
