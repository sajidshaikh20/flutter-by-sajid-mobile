import 'package:freezed_annotation/freezed_annotation.dart';

part 'logout_request_model.freezed.dart';
part 'logout_request_model.g.dart';

/// Request model for logging out a user.
@freezed
class LogoutRequestModel with _$LogoutRequestModel {
  /// Creates a [LogoutRequestModel] instance.
  const factory LogoutRequestModel({
    /// The language ID for localization.
    int? languageId,
    /// The platform identifier (e.g., 'android', 'ios', 'web').
    String? platform,
    /// The app version.
    String? version,
    /// The customer authentication token.
    String? customerToken,
  }) = _LogoutRequestModel;

  /// Creates a [LogoutRequestModel] from a JSON map.
  factory LogoutRequestModel.fromJson(Map<String, dynamic> json) =>
      _$LogoutRequestModelFromJson(json);
}

