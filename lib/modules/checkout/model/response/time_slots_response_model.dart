import 'package:json_annotation/json_annotation.dart';

part 'time_slots_response_model.g.dart';

@JsonSerializable(ignoreUnannotated: false)
/// A model class representing the response for available time slots.
class TimeSlotsResponseModel {

  /// Creates a new instance of [TimeSlotsResponseModel].
  ///
  /// [status] The status code of the response.
  /// [message] A message associated with the response.
  /// [data] A list of [TimeSlotData] containing the available time slots.
  TimeSlotsResponseModel({this.status, this.message, this.data});

  /// Creates a [TimeSlotsResponseModel] instance from a JSON map.
  ///
  /// The [json] map must contain keys matching the parameters of the constructor.
  factory TimeSlotsResponseModel.fromJson(Map<String, dynamic> json) =>
      _$TimeSlotsResponseModelFromJson(json);

  /// The status code of the response.
  @JsonKey(name: 'status')
  final int? status;

  /// A message associated with the response.
  @JsonKey(name: 'message')
  final String? message;

  /// A list of [TimeSlotData] containing the available time slots.
  @JsonKey(name: 'data')
  final List<TimeSlotData>? data;

  /// Converts the [TimeSlotsResponseModel] instance into a JSON map.
  ///
  /// Returns a map of key-value pairs representing the time slots response data.
  Map<String, dynamic> toJson() => _$TimeSlotsResponseModelToJson(this);
}

@JsonSerializable(ignoreUnannotated: false)
/// A model class representing a single time slot data.
class TimeSlotData {

  /// Creates a new instance of [TimeSlotData].
  ///
  /// [date] The date of the time slot.
  /// [day] The day of the week for the time slot.
  /// [slots] A list of [Slot] objects representing available time slots.
  /// [isSelected] A boolean indicating whether the time slot is selected.
  TimeSlotData({this.date, this.day, this.slots, this.isSelected});

  /// Creates a [TimeSlotData] instance from a JSON map.
  ///
  /// The [json] map must contain keys matching the parameters of the constructor.
  factory TimeSlotData.fromJson(Map<String, dynamic> json) =>
      _$TimeSlotDataFromJson(json);

  /// The date of the time slot.
  @JsonKey(name: 'date')
  final String? date;

  /// The day of the week for the time slot.
  @JsonKey(name: 'day')
  final String? day;

  /// A list of [Slot] objects representing the available time slots.
  @JsonKey(name: 'slots')
  final List<Slot>? slots;

  /// A boolean indicating whether the time slot is selected.
  bool? isSelected = false;

  /// Converts the [TimeSlotData] instance into a JSON map.
  ///
  /// Returns a map of key-value pairs representing the time slot data.
  Map<String, dynamic> toJson() => _$TimeSlotDataToJson(this);
}

@JsonSerializable(ignoreUnannotated: false)
/// A model class representing a single time slot.
class Slot {

  /// Creates a new instance of [Slot].
  ///
  /// [id] The identifier for the slot.
  /// [time] The time of the slot.
  /// [availability] The availability of the slot (e.g., 1 for available, 0 for unavailable).
  /// [enable] A boolean indicating if the slot is enabled.
  /// [isSelected] A boolean indicating whether the slot is selected.
  Slot({this.id, this.time, this.availability, this.enable, this.isSelected});

  /// Creates a [Slot] instance from a JSON map.
  ///
  /// The [json] map must contain keys matching the parameters of the constructor.
  factory Slot.fromJson(Map<String, dynamic> json) => _$SlotFromJson(json);

  /// The identifier for the slot.
  @JsonKey(name: 'id')
  final String? id;

  /// The time of the slot.
  @JsonKey(name: 'time')
  final String? time;

  /// The availability of the slot (e.g., 1 for available, 0 for unavailable).
  @JsonKey(name: 'availability')
  final int? availability;

  /// A boolean indicating if the slot is enabled.
  @JsonKey(name: 'enable')
  final bool? enable;

  /// A boolean indicating whether the slot is selected.
  bool? isSelected = false;

  /// Converts the [Slot] instance into a JSON map.
  ///
  /// Returns a map of key-value pairs representing the slot data.
  Map<String, dynamic> toJson() => _$SlotToJson(this);
}
