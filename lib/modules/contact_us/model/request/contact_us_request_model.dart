import 'package:freezed_annotation/freezed_annotation.dart';

part 'contact_us_request_model.freezed.dart';
part 'contact_us_request_model.g.dart';

/// Request model for the Contact Us API call.
@freezed
class ContactUsRequestModel with _$ContactUsRequestModel {
  /// Constructor for creating a [ContactUsRequestModel].
  const factory ContactUsRequestModel({
    required String? name,
    required String? mobile,
    required String? email,
    required String? comment,
    required String? customerToken,
    required String? platform,
    required String? version,
    required int? languageId,
  }) = _ContactUsRequestModel;

  /// Factory constructor for creating an instance from JSON.
  factory ContactUsRequestModel.fromJson(Map<String, dynamic> json) =>
      _$ContactUsRequestModelFromJson(json);
}
