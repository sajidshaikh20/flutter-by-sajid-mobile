import 'package:json_annotation/json_annotation.dart';

part 'set_slot_response_model.g.dart';

@JsonSerializable(ignoreUnannotated: false)
/// A model class representing the response for setting a slot.
class SetSlotResponseModel {

  /// Creates a new instance of [SetSlotResponseModel].
  ///
  /// [status] The status of the response, typically indicating success or failure.
  /// [message] A message providing details about the response status.
  SetSlotResponseModel({
    this.status,
    this.message,
  });

  /// Creates a [SetSlotResponseModel] from a JSON map.
  ///
  /// The [json] map must contain keys matching the parameters of the constructor.
  factory SetSlotResponseModel.fromJson(Map<String, dynamic> json) =>
      _$SetSlotResponseModelFromJson(json);

  /// The status of the response, typically indicating success or failure.
  @JsonKey(name: 'status')
  final int? status;

  /// A message providing details about the response status.
  @JsonKey(name: 'message')
  final String? message;

  /// Converts the [SetSlotResponseModel] instance into a JSON map.
  ///
  /// Returns a map of key-value pairs representing the slot response.
  Map<String, dynamic> toJson() => _$SetSlotResponseModelToJson(this);
}
