// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'update_email_request_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

UpdateEmailRequestModel _$UpdateEmailRequestModelFromJson(
    Map<String, dynamic> json) {
  return _UpdateEmailRequestModel.fromJson(json);
}

/// @nodoc
mixin _$UpdateEmailRequestModel {
  /// The customer authentication token.
  String? get customerToken => throw _privateConstructorUsedError;

  /// The new email address to update.
  String? get email => throw _privateConstructorUsedError;

  /// The OTP (One-Time Password) for verification.
  String? get otp => throw _privateConstructorUsedError;

  /// The platform identifier (e.g., 'android', 'ios', 'web').
  String? get platform => throw _privateConstructorUsedError;

  /// The app version.
  String? get version => throw _privateConstructorUsedError;

  /// Device identifier for tracking and analytics.
  String? get deviceId => throw _privateConstructorUsedError;

  /// The website identifier.
  int? get websiteId => throw _privateConstructorUsedError;

  /// The language identifier for localization.
  int? get languageId => throw _privateConstructorUsedError;

  /// The store identifier.
  int? get storeId => throw _privateConstructorUsedError;

  /// Flag indicating if OTP was sent (1 for sent, 0 for not sent).
  int? get sentOtp => throw _privateConstructorUsedError;

  /// Flag indicating if OTP was verified (1 for verified, 0 for not verified).
  int? get verifyOtp => throw _privateConstructorUsedError;

  /// Serializes this UpdateEmailRequestModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of UpdateEmailRequestModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $UpdateEmailRequestModelCopyWith<UpdateEmailRequestModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UpdateEmailRequestModelCopyWith<$Res> {
  factory $UpdateEmailRequestModelCopyWith(UpdateEmailRequestModel value,
          $Res Function(UpdateEmailRequestModel) then) =
      _$UpdateEmailRequestModelCopyWithImpl<$Res, UpdateEmailRequestModel>;
  @useResult
  $Res call(
      {String? customerToken,
      String? email,
      String? otp,
      String? platform,
      String? version,
      String? deviceId,
      int? websiteId,
      int? languageId,
      int? storeId,
      int? sentOtp,
      int? verifyOtp});
}

/// @nodoc
class _$UpdateEmailRequestModelCopyWithImpl<$Res,
        $Val extends UpdateEmailRequestModel>
    implements $UpdateEmailRequestModelCopyWith<$Res> {
  _$UpdateEmailRequestModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of UpdateEmailRequestModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? customerToken = freezed,
    Object? email = freezed,
    Object? otp = freezed,
    Object? platform = freezed,
    Object? version = freezed,
    Object? deviceId = freezed,
    Object? websiteId = freezed,
    Object? languageId = freezed,
    Object? storeId = freezed,
    Object? sentOtp = freezed,
    Object? verifyOtp = freezed,
  }) {
    return _then(_value.copyWith(
      customerToken: freezed == customerToken
          ? _value.customerToken
          : customerToken // ignore: cast_nullable_to_non_nullable
              as String?,
      email: freezed == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String?,
      otp: freezed == otp
          ? _value.otp
          : otp // ignore: cast_nullable_to_non_nullable
              as String?,
      platform: freezed == platform
          ? _value.platform
          : platform // ignore: cast_nullable_to_non_nullable
              as String?,
      version: freezed == version
          ? _value.version
          : version // ignore: cast_nullable_to_non_nullable
              as String?,
      deviceId: freezed == deviceId
          ? _value.deviceId
          : deviceId // ignore: cast_nullable_to_non_nullable
              as String?,
      websiteId: freezed == websiteId
          ? _value.websiteId
          : websiteId // ignore: cast_nullable_to_non_nullable
              as int?,
      languageId: freezed == languageId
          ? _value.languageId
          : languageId // ignore: cast_nullable_to_non_nullable
              as int?,
      storeId: freezed == storeId
          ? _value.storeId
          : storeId // ignore: cast_nullable_to_non_nullable
              as int?,
      sentOtp: freezed == sentOtp
          ? _value.sentOtp
          : sentOtp // ignore: cast_nullable_to_non_nullable
              as int?,
      verifyOtp: freezed == verifyOtp
          ? _value.verifyOtp
          : verifyOtp // ignore: cast_nullable_to_non_nullable
              as int?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$UpdateEmailRequestModelImplCopyWith<$Res>
    implements $UpdateEmailRequestModelCopyWith<$Res> {
  factory _$$UpdateEmailRequestModelImplCopyWith(
          _$UpdateEmailRequestModelImpl value,
          $Res Function(_$UpdateEmailRequestModelImpl) then) =
      __$$UpdateEmailRequestModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? customerToken,
      String? email,
      String? otp,
      String? platform,
      String? version,
      String? deviceId,
      int? websiteId,
      int? languageId,
      int? storeId,
      int? sentOtp,
      int? verifyOtp});
}

/// @nodoc
class __$$UpdateEmailRequestModelImplCopyWithImpl<$Res>
    extends _$UpdateEmailRequestModelCopyWithImpl<$Res,
        _$UpdateEmailRequestModelImpl>
    implements _$$UpdateEmailRequestModelImplCopyWith<$Res> {
  __$$UpdateEmailRequestModelImplCopyWithImpl(
      _$UpdateEmailRequestModelImpl _value,
      $Res Function(_$UpdateEmailRequestModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of UpdateEmailRequestModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? customerToken = freezed,
    Object? email = freezed,
    Object? otp = freezed,
    Object? platform = freezed,
    Object? version = freezed,
    Object? deviceId = freezed,
    Object? websiteId = freezed,
    Object? languageId = freezed,
    Object? storeId = freezed,
    Object? sentOtp = freezed,
    Object? verifyOtp = freezed,
  }) {
    return _then(_$UpdateEmailRequestModelImpl(
      customerToken: freezed == customerToken
          ? _value.customerToken
          : customerToken // ignore: cast_nullable_to_non_nullable
              as String?,
      email: freezed == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String?,
      otp: freezed == otp
          ? _value.otp
          : otp // ignore: cast_nullable_to_non_nullable
              as String?,
      platform: freezed == platform
          ? _value.platform
          : platform // ignore: cast_nullable_to_non_nullable
              as String?,
      version: freezed == version
          ? _value.version
          : version // ignore: cast_nullable_to_non_nullable
              as String?,
      deviceId: freezed == deviceId
          ? _value.deviceId
          : deviceId // ignore: cast_nullable_to_non_nullable
              as String?,
      websiteId: freezed == websiteId
          ? _value.websiteId
          : websiteId // ignore: cast_nullable_to_non_nullable
              as int?,
      languageId: freezed == languageId
          ? _value.languageId
          : languageId // ignore: cast_nullable_to_non_nullable
              as int?,
      storeId: freezed == storeId
          ? _value.storeId
          : storeId // ignore: cast_nullable_to_non_nullable
              as int?,
      sentOtp: freezed == sentOtp
          ? _value.sentOtp
          : sentOtp // ignore: cast_nullable_to_non_nullable
              as int?,
      verifyOtp: freezed == verifyOtp
          ? _value.verifyOtp
          : verifyOtp // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$UpdateEmailRequestModelImpl implements _UpdateEmailRequestModel {
  const _$UpdateEmailRequestModelImpl(
      {this.customerToken,
      this.email,
      this.otp,
      this.platform,
      this.version,
      this.deviceId,
      this.websiteId,
      this.languageId,
      this.storeId,
      this.sentOtp,
      this.verifyOtp});

  factory _$UpdateEmailRequestModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$UpdateEmailRequestModelImplFromJson(json);

  /// The customer authentication token.
  @override
  final String? customerToken;

  /// The new email address to update.
  @override
  final String? email;

  /// The OTP (One-Time Password) for verification.
  @override
  final String? otp;

  /// The platform identifier (e.g., 'android', 'ios', 'web').
  @override
  final String? platform;

  /// The app version.
  @override
  final String? version;

  /// Device identifier for tracking and analytics.
  @override
  final String? deviceId;

  /// The website identifier.
  @override
  final int? websiteId;

  /// The language identifier for localization.
  @override
  final int? languageId;

  /// The store identifier.
  @override
  final int? storeId;

  /// Flag indicating if OTP was sent (1 for sent, 0 for not sent).
  @override
  final int? sentOtp;

  /// Flag indicating if OTP was verified (1 for verified, 0 for not verified).
  @override
  final int? verifyOtp;

  @override
  String toString() {
    return 'UpdateEmailRequestModel(customerToken: $customerToken, email: $email, otp: $otp, platform: $platform, version: $version, deviceId: $deviceId, websiteId: $websiteId, languageId: $languageId, storeId: $storeId, sentOtp: $sentOtp, verifyOtp: $verifyOtp)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UpdateEmailRequestModelImpl &&
            (identical(other.customerToken, customerToken) ||
                other.customerToken == customerToken) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.otp, otp) || other.otp == otp) &&
            (identical(other.platform, platform) ||
                other.platform == platform) &&
            (identical(other.version, version) || other.version == version) &&
            (identical(other.deviceId, deviceId) ||
                other.deviceId == deviceId) &&
            (identical(other.websiteId, websiteId) ||
                other.websiteId == websiteId) &&
            (identical(other.languageId, languageId) ||
                other.languageId == languageId) &&
            (identical(other.storeId, storeId) || other.storeId == storeId) &&
            (identical(other.sentOtp, sentOtp) || other.sentOtp == sentOtp) &&
            (identical(other.verifyOtp, verifyOtp) ||
                other.verifyOtp == verifyOtp));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      customerToken,
      email,
      otp,
      platform,
      version,
      deviceId,
      websiteId,
      languageId,
      storeId,
      sentOtp,
      verifyOtp);

  /// Create a copy of UpdateEmailRequestModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UpdateEmailRequestModelImplCopyWith<_$UpdateEmailRequestModelImpl>
      get copyWith => __$$UpdateEmailRequestModelImplCopyWithImpl<
          _$UpdateEmailRequestModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UpdateEmailRequestModelImplToJson(
      this,
    );
  }
}

abstract class _UpdateEmailRequestModel implements UpdateEmailRequestModel {
  const factory _UpdateEmailRequestModel(
      {final String? customerToken,
      final String? email,
      final String? otp,
      final String? platform,
      final String? version,
      final String? deviceId,
      final int? websiteId,
      final int? languageId,
      final int? storeId,
      final int? sentOtp,
      final int? verifyOtp}) = _$UpdateEmailRequestModelImpl;

  factory _UpdateEmailRequestModel.fromJson(Map<String, dynamic> json) =
      _$UpdateEmailRequestModelImpl.fromJson;

  /// The customer authentication token.
  @override
  String? get customerToken;

  /// The new email address to update.
  @override
  String? get email;

  /// The OTP (One-Time Password) for verification.
  @override
  String? get otp;

  /// The platform identifier (e.g., 'android', 'ios', 'web').
  @override
  String? get platform;

  /// The app version.
  @override
  String? get version;

  /// Device identifier for tracking and analytics.
  @override
  String? get deviceId;

  /// The website identifier.
  @override
  int? get websiteId;

  /// The language identifier for localization.
  @override
  int? get languageId;

  /// The store identifier.
  @override
  int? get storeId;

  /// Flag indicating if OTP was sent (1 for sent, 0 for not sent).
  @override
  int? get sentOtp;

  /// Flag indicating if OTP was verified (1 for verified, 0 for not verified).
  @override
  int? get verifyOtp;

  /// Create a copy of UpdateEmailRequestModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UpdateEmailRequestModelImplCopyWith<_$UpdateEmailRequestModelImpl>
      get copyWith => throw _privateConstructorUsedError;
}
