// Define a class for TimelineStep to hold the icon and status

/// Represents a single step in a timeline, containing status details, time, and date.
class TimelineStep {
  /// The key used to fetch the main status text (usually from localization).
  final String statusKey;

  /// The key used to fetch the status details text (usually from localization).
  final String statusDetailsKey;

  /// The time at which this status occurred (in a human-readable format).
  final String statusDetailsTime;

  /// The date at which this status occurred (in a human-readable format).
  final String statusDetailsDate;

  /// Whether this status step is completed (true) or waiting (false).
  final bool isDone;

  /// Creates a [TimelineStep] with the given status and details.
  ///
  /// All parameters are required and should not be null.
  TimelineStep({
    required this.statusKey,
    required this.statusDetailsKey,
    required this.statusDetailsTime,
    required this.statusDetailsDate,
    this.isDone = true,
  });
}
