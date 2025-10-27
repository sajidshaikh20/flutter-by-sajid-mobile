/// Model for sort options with ID, label, and Arabic label
class SortOptionModel {
  /// Constructor
  SortOptionModel({
    required this.id,
    required this.label,
    required this.arabicLabel,
  });

  /// Factory constructor for creating a new instance
  /// from a map (JSON deserialization)
  factory SortOptionModel.fromJson(Map<String, dynamic> json) => SortOptionModel(
    id: json['id'] as String,
    label: json['label'] as String,
    arabicLabel: json['arabicLabel'] as String,
  );

  /// Sort option ID (used for API calls)
  final String id;

  /// Display label for the sort option (default language)
  final String label;

  /// Arabic display label for the sort option
  final String arabicLabel;

  /// Method to convert this class instance into a map (JSON serialization)
  Map<String, dynamic> toJson() => <String, dynamic>{
    'id': id,
    'label': label,
    'arabicLabel': arabicLabel,
  };

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is SortOptionModel &&
        other.id == id &&
        other.label == label &&
        other.arabicLabel == arabicLabel;
  }

  @override
  int get hashCode => id.hashCode ^ label.hashCode ^ (arabicLabel.hashCode);

  @override
  String toString() =>
      'SortOption(id: $id, label: $label, arabicLabel: $arabicLabel)';
}
