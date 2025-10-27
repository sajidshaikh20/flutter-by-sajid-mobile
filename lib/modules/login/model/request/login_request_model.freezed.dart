// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'login_request_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

LoginRequestModel _$LoginRequestModelFromJson(Map<String, dynamic> json) {
  return _LoginRequestModel.fromJson(json);
}

/// @nodoc
mixin _$LoginRequestModel {
  /// Language identifier for the user's preferred language.
  int? get languageId => throw _privateConstructorUsedError;

  /// Platform identifier (e.g., "iOS", "Android", "Web").
  String? get platform => throw _privateConstructorUsedError;

  /// Application version.
  String? get version => throw _privateConstructorUsedError;

  /// User's email or mobile number for login.
  String? get emailMobile => throw _privateConstructorUsedError;

  /// User's password for authentication.
  String? get password => throw _privateConstructorUsedError;

  /// Indicates if this is a social login request.
  bool? get isSocialLogin => throw _privateConstructorUsedError;

  /// Type of social login (e.g., "google", "facebook", "apple").
  String? get socialLoginType => throw _privateConstructorUsedError;

  /// Apple authentication token for Apple Sign-In.
  String? get appleToken => throw _privateConstructorUsedError;

  /// Device identifier for tracking and analytics.
  String? get deviceId => throw _privateConstructorUsedError;

  /// Device token for push notifications (FCM token).
  String? get deviceToken => throw _privateConstructorUsedError;

  /// General authentication token.
  String? get token => throw _privateConstructorUsedError;

  /// Serializes this LoginRequestModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of LoginRequestModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $LoginRequestModelCopyWith<LoginRequestModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LoginRequestModelCopyWith<$Res> {
  factory $LoginRequestModelCopyWith(
          LoginRequestModel value, $Res Function(LoginRequestModel) then) =
      _$LoginRequestModelCopyWithImpl<$Res, LoginRequestModel>;
  @useResult
  $Res call(
      {int? languageId,
      String? platform,
      String? version,
      String? emailMobile,
      String? password,
      bool? isSocialLogin,
      String? socialLoginType,
      String? appleToken,
      String? deviceId,
      String? deviceToken,
      String? token});
}

/// @nodoc
class _$LoginRequestModelCopyWithImpl<$Res, $Val extends LoginRequestModel>
    implements $LoginRequestModelCopyWith<$Res> {
  _$LoginRequestModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of LoginRequestModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? languageId = freezed,
    Object? platform = freezed,
    Object? version = freezed,
    Object? emailMobile = freezed,
    Object? password = freezed,
    Object? isSocialLogin = freezed,
    Object? socialLoginType = freezed,
    Object? appleToken = freezed,
    Object? deviceId = freezed,
    Object? deviceToken = freezed,
    Object? token = freezed,
  }) {
    return _then(_value.copyWith(
      languageId: freezed == languageId
          ? _value.languageId
          : languageId // ignore: cast_nullable_to_non_nullable
              as int?,
      platform: freezed == platform
          ? _value.platform
          : platform // ignore: cast_nullable_to_non_nullable
              as String?,
      version: freezed == version
          ? _value.version
          : version // ignore: cast_nullable_to_non_nullable
              as String?,
      emailMobile: freezed == emailMobile
          ? _value.emailMobile
          : emailMobile // ignore: cast_nullable_to_non_nullable
              as String?,
      password: freezed == password
          ? _value.password
          : password // ignore: cast_nullable_to_non_nullable
              as String?,
      isSocialLogin: freezed == isSocialLogin
          ? _value.isSocialLogin
          : isSocialLogin // ignore: cast_nullable_to_non_nullable
              as bool?,
      socialLoginType: freezed == socialLoginType
          ? _value.socialLoginType
          : socialLoginType // ignore: cast_nullable_to_non_nullable
              as String?,
      appleToken: freezed == appleToken
          ? _value.appleToken
          : appleToken // ignore: cast_nullable_to_non_nullable
              as String?,
      deviceId: freezed == deviceId
          ? _value.deviceId
          : deviceId // ignore: cast_nullable_to_non_nullable
              as String?,
      deviceToken: freezed == deviceToken
          ? _value.deviceToken
          : deviceToken // ignore: cast_nullable_to_non_nullable
              as String?,
      token: freezed == token
          ? _value.token
          : token // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$LoginRequestModelImplCopyWith<$Res>
    implements $LoginRequestModelCopyWith<$Res> {
  factory _$$LoginRequestModelImplCopyWith(_$LoginRequestModelImpl value,
          $Res Function(_$LoginRequestModelImpl) then) =
      __$$LoginRequestModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int? languageId,
      String? platform,
      String? version,
      String? emailMobile,
      String? password,
      bool? isSocialLogin,
      String? socialLoginType,
      String? appleToken,
      String? deviceId,
      String? deviceToken,
      String? token});
}

/// @nodoc
class __$$LoginRequestModelImplCopyWithImpl<$Res>
    extends _$LoginRequestModelCopyWithImpl<$Res, _$LoginRequestModelImpl>
    implements _$$LoginRequestModelImplCopyWith<$Res> {
  __$$LoginRequestModelImplCopyWithImpl(_$LoginRequestModelImpl _value,
      $Res Function(_$LoginRequestModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of LoginRequestModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? languageId = freezed,
    Object? platform = freezed,
    Object? version = freezed,
    Object? emailMobile = freezed,
    Object? password = freezed,
    Object? isSocialLogin = freezed,
    Object? socialLoginType = freezed,
    Object? appleToken = freezed,
    Object? deviceId = freezed,
    Object? deviceToken = freezed,
    Object? token = freezed,
  }) {
    return _then(_$LoginRequestModelImpl(
      languageId: freezed == languageId
          ? _value.languageId
          : languageId // ignore: cast_nullable_to_non_nullable
              as int?,
      platform: freezed == platform
          ? _value.platform
          : platform // ignore: cast_nullable_to_non_nullable
              as String?,
      version: freezed == version
          ? _value.version
          : version // ignore: cast_nullable_to_non_nullable
              as String?,
      emailMobile: freezed == emailMobile
          ? _value.emailMobile
          : emailMobile // ignore: cast_nullable_to_non_nullable
              as String?,
      password: freezed == password
          ? _value.password
          : password // ignore: cast_nullable_to_non_nullable
              as String?,
      isSocialLogin: freezed == isSocialLogin
          ? _value.isSocialLogin
          : isSocialLogin // ignore: cast_nullable_to_non_nullable
              as bool?,
      socialLoginType: freezed == socialLoginType
          ? _value.socialLoginType
          : socialLoginType // ignore: cast_nullable_to_non_nullable
              as String?,
      appleToken: freezed == appleToken
          ? _value.appleToken
          : appleToken // ignore: cast_nullable_to_non_nullable
              as String?,
      deviceId: freezed == deviceId
          ? _value.deviceId
          : deviceId // ignore: cast_nullable_to_non_nullable
              as String?,
      deviceToken: freezed == deviceToken
          ? _value.deviceToken
          : deviceToken // ignore: cast_nullable_to_non_nullable
              as String?,
      token: freezed == token
          ? _value.token
          : token // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$LoginRequestModelImpl implements _LoginRequestModel {
  const _$LoginRequestModelImpl(
      {this.languageId,
      this.platform,
      this.version,
      this.emailMobile,
      this.password,
      this.isSocialLogin,
      this.socialLoginType,
      this.appleToken,
      this.deviceId,
      this.deviceToken,
      this.token});

  factory _$LoginRequestModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$LoginRequestModelImplFromJson(json);

  /// Language identifier for the user's preferred language.
  @override
  final int? languageId;

  /// Platform identifier (e.g., "iOS", "Android", "Web").
  @override
  final String? platform;

  /// Application version.
  @override
  final String? version;

  /// User's email or mobile number for login.
  @override
  final String? emailMobile;

  /// User's password for authentication.
  @override
  final String? password;

  /// Indicates if this is a social login request.
  @override
  final bool? isSocialLogin;

  /// Type of social login (e.g., "google", "facebook", "apple").
  @override
  final String? socialLoginType;

  /// Apple authentication token for Apple Sign-In.
  @override
  final String? appleToken;

  /// Device identifier for tracking and analytics.
  @override
  final String? deviceId;

  /// Device token for push notifications (FCM token).
  @override
  final String? deviceToken;

  /// General authentication token.
  @override
  final String? token;

  @override
  String toString() {
    return 'LoginRequestModel(languageId: $languageId, platform: $platform, version: $version, emailMobile: $emailMobile, password: $password, isSocialLogin: $isSocialLogin, socialLoginType: $socialLoginType, appleToken: $appleToken, deviceId: $deviceId, deviceToken: $deviceToken, token: $token)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoginRequestModelImpl &&
            (identical(other.languageId, languageId) ||
                other.languageId == languageId) &&
            (identical(other.platform, platform) ||
                other.platform == platform) &&
            (identical(other.version, version) || other.version == version) &&
            (identical(other.emailMobile, emailMobile) ||
                other.emailMobile == emailMobile) &&
            (identical(other.password, password) ||
                other.password == password) &&
            (identical(other.isSocialLogin, isSocialLogin) ||
                other.isSocialLogin == isSocialLogin) &&
            (identical(other.socialLoginType, socialLoginType) ||
                other.socialLoginType == socialLoginType) &&
            (identical(other.appleToken, appleToken) ||
                other.appleToken == appleToken) &&
            (identical(other.deviceId, deviceId) ||
                other.deviceId == deviceId) &&
            (identical(other.deviceToken, deviceToken) ||
                other.deviceToken == deviceToken) &&
            (identical(other.token, token) || other.token == token));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      languageId,
      platform,
      version,
      emailMobile,
      password,
      isSocialLogin,
      socialLoginType,
      appleToken,
      deviceId,
      deviceToken,
      token);

  /// Create a copy of LoginRequestModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LoginRequestModelImplCopyWith<_$LoginRequestModelImpl> get copyWith =>
      __$$LoginRequestModelImplCopyWithImpl<_$LoginRequestModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$LoginRequestModelImplToJson(
      this,
    );
  }
}

abstract class _LoginRequestModel implements LoginRequestModel {
  const factory _LoginRequestModel(
      {final int? languageId,
      final String? platform,
      final String? version,
      final String? emailMobile,
      final String? password,
      final bool? isSocialLogin,
      final String? socialLoginType,
      final String? appleToken,
      final String? deviceId,
      final String? deviceToken,
      final String? token}) = _$LoginRequestModelImpl;

  factory _LoginRequestModel.fromJson(Map<String, dynamic> json) =
      _$LoginRequestModelImpl.fromJson;

  /// Language identifier for the user's preferred language.
  @override
  int? get languageId;

  /// Platform identifier (e.g., "iOS", "Android", "Web").
  @override
  String? get platform;

  /// Application version.
  @override
  String? get version;

  /// User's email or mobile number for login.
  @override
  String? get emailMobile;

  /// User's password for authentication.
  @override
  String? get password;

  /// Indicates if this is a social login request.
  @override
  bool? get isSocialLogin;

  /// Type of social login (e.g., "google", "facebook", "apple").
  @override
  String? get socialLoginType;

  /// Apple authentication token for Apple Sign-In.
  @override
  String? get appleToken;

  /// Device identifier for tracking and analytics.
  @override
  String? get deviceId;

  /// Device token for push notifications (FCM token).
  @override
  String? get deviceToken;

  /// General authentication token.
  @override
  String? get token;

  /// Create a copy of LoginRequestModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LoginRequestModelImplCopyWith<_$LoginRequestModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
