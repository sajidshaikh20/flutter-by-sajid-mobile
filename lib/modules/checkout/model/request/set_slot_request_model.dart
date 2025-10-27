import 'package:freezed_annotation/freezed_annotation.dart';

part 'set_slot_request_model.freezed.dart';
part 'set_slot_request_model.g.dart';

/// A model class representing a request to set a slot for an order.
///
/// This model contains the necessary information to assign a specific
/// time slot to an order, including the slot identifier and quote
/// association details.
///
///
/// Example usage:
/// ```dart
/// final slotRequest = SetSlotRequestModel(
///   slotId: 123,
///   quoteId: 456,
/// );
///
/// final json = slotRequest.toJson();
/// print(json);
/// ```
@freezed
class SetSlotRequestModel with _$SetSlotRequestModel {
  /// Creates a new [SetSlotRequestModel] instance.
  const factory SetSlotRequestModel({
    /// The ID of the slot to be set for the order.
    int? slotId,
    
    /// The ID of the quote associated with the order.
    int? quoteId,
  }) = _SetSlotRequestModel;

  /// Creates a [SetSlotRequestModel] instance from a JSON map.
  factory SetSlotRequestModel.fromJson(Map<String, dynamic> json) =>
      _$SetSlotRequestModelFromJson(json);
}
