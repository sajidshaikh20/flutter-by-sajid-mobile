import 'package:freezed_annotation/freezed_annotation.dart';

part 'timeslots_request_model.freezed.dart';
part 'timeslots_request_model.g.dart';

/// A model class representing a request for available time slots for an order.
///
/// This model contains the necessary information to fetch available
/// delivery or pickup time slots for a specific store and region.
///
///
/// Example usage:
/// ```dart
/// final timeslotRequest = TimeslotsRequestModel(
///   storeId: 123,
///   regionId: 456,
/// );
///
/// final json = timeslotRequest.toJson();
/// print(json);
/// ```
@freezed
class TimeslotsRequestModel with _$TimeslotsRequestModel {
  /// Creates a new [TimeslotsRequestModel] instance.
  const factory TimeslotsRequestModel({
    /// The ID of the store.
    int? storeId,
    
    /// The ID of the region for the time slot request.
    int? regionId,
  }) = _TimeslotsRequestModel;

  /// Creates a [TimeslotsRequestModel] instance from a JSON map.
  factory TimeslotsRequestModel.fromJson(Map<String, dynamic> json) =>
      _$TimeslotsRequestModelFromJson(json);
}
