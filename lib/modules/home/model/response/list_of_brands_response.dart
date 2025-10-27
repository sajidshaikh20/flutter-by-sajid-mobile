// To parse this JSON data, do
//
//  final listOfBrandsResponse = listOfBrandsResponseFromJson(jsonString);



/// Model class for brand response data.
class ListOfBrandsResponse {
  /// The unique identifier of the brand.
  final int? id;

  /// The image URL of the brand.
  final String? brandImage;

  /// The label or name of the brand.
  final String? brandLabel;

  /// Creates an instance of [ListOfBrandsResponse].
  ListOfBrandsResponse({
    this.id,
    this.brandImage,
    this.brandLabel,
  });
///copyWith
  ListOfBrandsResponse copyWith({
    int? id,
    String? brandImage,
    String? brandLabel,
  }) =>
      ListOfBrandsResponse(
        id: id ?? this.id,
        brandImage: brandImage ?? this.brandImage,
        brandLabel: brandLabel ?? this.brandLabel,
      );
///fromJson
  factory ListOfBrandsResponse.fromJson(Map<String, dynamic> json) => ListOfBrandsResponse(
    id: json["id"],
    brandImage: json["brand_image"],
    brandLabel: json["brand_label"],
  );
///toJson
  Map<String, dynamic> toJson() => <String, dynamic>{
    "id": id,
    "brand_image": brandImage,
    "brand_label": brandLabel,
  };
}
