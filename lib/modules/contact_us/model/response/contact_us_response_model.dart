import 'package:freezed_annotation/freezed_annotation.dart';

part 'contact_us_response_model.freezed.dart';
part 'contact_us_response_model.g.dart';

/// Response model for the Contact Us API call.
@freezed
class ContactUsResponseModel with _$ContactUsResponseModel {
  /// Constructor for creating a [ContactUsResponseModel].
  const factory ContactUsResponseModel({
    required bool success,
    required String message,
  }) = _ContactUsResponseModel;

  /// Factory constructor for creating an instance from JSON.
  factory ContactUsResponseModel.fromJson(Map<String, dynamic> json) =>
      _$ContactUsResponseModelFromJson(json);
}
