import 'package:freezed_annotation/freezed_annotation.dart';

part 'change_password_request_model.freezed.dart';
part 'change_password_request_model.g.dart';

@freezed
///ChangePasswordRequestModel
class ChangePasswordRequestModel with _$ChangePasswordRequestModel {
  /// Creates a new instance of [ChangePasswordRequestModel].
  const factory ChangePasswordRequestModel({
    /// Customer authentication token.
    required String customerToken,

    /// Current password of the user.
    required String currentPassword,

    /// New password to update.
    required String newPassword,

    /// Language ID for localization.
    int? languageId,

    /// Store ID for multi-store support.
    int? storeId,
  }) = _ChangePasswordRequestModel;

  /// Factory method to create a [ChangePasswordRequestModel] from a JSON map.
  ///
  /// Useful for parsing API request payloads or storing data locally.
  factory ChangePasswordRequestModel.fromJson(Map<String, dynamic> json) =>
      _$ChangePasswordRequestModelFromJson(json);
}
