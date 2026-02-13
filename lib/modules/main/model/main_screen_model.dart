/// Basic model for the main screen (first screen after splash).
class MainScreenModel {
  /// Creates a [MainScreenModel].
  const MainScreenModel({
    this.title = '',
    this.description = '',
  });

  /// Screen title.
  final String title;

  /// Optional description.
  final String description;

  /// Creates a copy with updated fields.
  MainScreenModel copyWith({
    String? title,
    String? description,
  }) {
    return MainScreenModel(
      title: title ?? this.title,
      description: description ?? this.description,
    );
  }
}
