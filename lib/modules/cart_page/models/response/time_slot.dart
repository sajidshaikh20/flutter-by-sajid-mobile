/// A model representing a time slot for scheduling or delivery purposes.
///
/// This class tracks the time range of the slot, whether it is currently
/// selected by the user, and whether the slot is unavailable.
///
/// Example usage:
/// ```dart
/// final slot = TimeSlot(timeRange: "10:00 AM - 12:00 PM");
/// if (!slot.isUnavailable) {
///   slot.isSelected = true;
/// }
/// ```
class TimeSlot {
  /// The time range of this slot (e.g., "10:00 AM - 12:00 PM").
  final String timeRange;

  /// Indicates whether the user has selected this time slot.
  bool isSelected;

  /// Indicates whether this time slot is unavailable for selection.
  final bool isUnavailable;

  /// Creates a new [TimeSlot] instance.
  ///
  /// By default, [isSelected] is false and [isUnavailable] is false.
  TimeSlot({
    required this.timeRange,
    this.isSelected = false,
    this.isUnavailable = false,
  });
}
