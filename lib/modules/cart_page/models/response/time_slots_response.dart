/// Model class representing a time slot response.
class TimeSlotsResponse {
  /// The unique identifier of the time slot.
  final int? id;

  /// The time string of the slot (e.g., "10:00 AM - 11:00 AM").
  final String? time;

  /// Creates a [TimeSlotsResponse] instance.
  ///
  /// Both [id] and [time] are optional and can be null.
  TimeSlotsResponse({
    this.id,
    this.time,
  });

  /// Creates a copy of this [TimeSlotsResponse] with optional updated values.
  ///
  /// If a value is not provided, the existing value is retained.
  TimeSlotsResponse copyWith({
    int? id,
    String? time,
  }) =>
      TimeSlotsResponse(
        id: id ?? this.id,
        time: time ?? this.time,
      );

  /// Creates a [TimeSlotsResponse] instance from a JSON map.
  ///
  /// The [json] map should contain:
  /// - `id`: The time slot ID.
  /// - `time`: The time string.
  factory TimeSlotsResponse.fromJson(Map<String, dynamic> json) =>
      TimeSlotsResponse(
        id: json["id"],
        time: json["time"],
      );

  /// Converts this [TimeSlotsResponse] instance into a JSON map.
  Map<String, dynamic> toJson() => <String, dynamic>{
    "id": id,
    "time": time,
  };
}
