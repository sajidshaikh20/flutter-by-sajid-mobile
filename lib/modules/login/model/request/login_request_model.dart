
import 'package:freezed_annotation/freezed_annotation.dart';

part 'login_request_model.freezed.dart';
part 'login_request_model.g.dart';

/// Model for login request containing user credentials.
@freezed
abstract class LoginRequestModel with _$LoginRequestModel {
  /// Creates a new [LoginRequestModel] instance.
  const factory LoginRequestModel({
    /// User's email or username for login.
    @JsonKey(name: 'emailOrUsername') required String emailOrUsername,

    /// User's password for authentication.
    required String password,
  }) = _LoginRequestModel;

  /// Creates a [LoginRequestModel] instance from a JSON map.
  factory LoginRequestModel.fromJson(Map<String, dynamic> json) =>
      _$LoginRequestModelFromJson(json);
}
