import 'package:json_annotation/json_annotation.dart';

part 'save_address_response_model.g.dart';

@JsonSerializable(ignoreUnannotated: false)
/// A class representing the response for saving an address.
class SaveAddressResponseModel {
  /// Creates a [SaveAddressResponseModel] with the provided values.
  SaveAddressResponseModel({
    this.success,
    this.message,
    this.id,
  });

  /// Creates a [SaveAddressResponseModel] from a JSON map.
  factory SaveAddressResponseModel.fromJson(Map<String, dynamic> json) =>
      _$SaveAddressResponseModelFromJson(json);

  /// Indicates whether the address save operation was successful.
  @JsonKey(name: 'success')
  final bool? success;

  /// A message providing additional details about the save operation.
  @JsonKey(name: 'message')
  final String? message;

  /// The unique ID of the saved address.
  @JsonKey(name: 'id')
  final String? id;

  /// Converts the [SaveAddressResponseModel] instance to a JSON map.
  Map<String, dynamic> toJson() => _$SaveAddressResponseModelToJson(this);
}
