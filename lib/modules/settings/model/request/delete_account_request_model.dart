import 'package:freezed_annotation/freezed_annotation.dart';

part 'delete_account_request_model.freezed.dart';
part 'delete_account_request_model.g.dart';

/// Request model for deleting a user account.
@freezed
class DeleteAccountRequestModel with _$DeleteAccountRequestModel {
  /// Creates a [DeleteAccountRequestModel] instance.
  const factory DeleteAccountRequestModel({
    /// The language ID for localization.
    int? languageId,
    /// The store ID for the request.
    int? storeId,
    /// The platform identifier (e.g., 'android', 'ios', 'web').
    String? platform,
    /// The app version.
    String? version,
    /// The customer authentication token.
    String? customerToken,
  }) = _DeleteAccountRequestModel;

  /// Creates a [DeleteAccountRequestModel] from a JSON map.
  factory DeleteAccountRequestModel.fromJson(Map<String, dynamic> json) =>
      _$DeleteAccountRequestModelFromJson(json);
}
