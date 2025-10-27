/// Represents a model for storing a map of languages.
class LanguageModel {
  /// Constructs a LanguageModel with a given language map.
  LanguageModel({required this.languageMap});

  /// Creates a LanguageModel instance from JSON data.
  factory LanguageModel.fromJson(Map<String, dynamic> json) => LanguageModel(
    languageMap: json.map((String key, dynamic value) =>
        MapEntry<String, String>(key, value.toString())),
  );

  /// A map where the key is the language code and value is the language name.
  final Map<String, String> languageMap;
}

