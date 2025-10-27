import 'package:json_annotation/json_annotation.dart'; 

part 'cms_request_model.g.dart'; 

/// Model class for CMS content request parameters.
@JsonSerializable(ignoreUnannotated: false)
class CmsRequestModel {
  /// The website identifier.
  @JsonKey(name: 'website')
  final  String? website;

  /// The store identifier.
  @JsonKey(name: 'store')
  final  String? store;

  /// Creates an instance of [CmsRequestModel].
  CmsRequestModel({this.website, this.store});

  /// Creates an instance of [CmsRequestModel] from a JSON map.
  factory CmsRequestModel.fromJson(Map<String, dynamic> json) => _$CmsRequestModelFromJson(json);

  /// Converts the model to a JSON map.
  Map<String, dynamic> toJson() => _$CmsRequestModelToJson(this);
}