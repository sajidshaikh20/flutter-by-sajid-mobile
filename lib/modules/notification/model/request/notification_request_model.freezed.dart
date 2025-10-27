// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'notification_request_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

NotificationRequestModel _$NotificationRequestModelFromJson(
    Map<String, dynamic> json) {
  return _NotificationRequestModel.fromJson(json);
}

/// @nodoc
mixin _$NotificationRequestModel {
  /// The language ID for localization.
  int? get languageId => throw _privateConstructorUsedError;

  /// The customer authentication token.
  String? get customerToken => throw _privateConstructorUsedError;

  /// The platform identifier (e.g., 'android', 'ios', 'web').
  String? get platform => throw _privateConstructorUsedError;

  /// The app version.
  String? get version => throw _privateConstructorUsedError;

  /// Device identifier for tracking and analytics.
  String? get deviceId => throw _privateConstructorUsedError;

  /// Serializes this NotificationRequestModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of NotificationRequestModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $NotificationRequestModelCopyWith<NotificationRequestModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NotificationRequestModelCopyWith<$Res> {
  factory $NotificationRequestModelCopyWith(NotificationRequestModel value,
          $Res Function(NotificationRequestModel) then) =
      _$NotificationRequestModelCopyWithImpl<$Res, NotificationRequestModel>;
  @useResult
  $Res call(
      {int? languageId,
      String? customerToken,
      String? platform,
      String? version,
      String? deviceId});
}

/// @nodoc
class _$NotificationRequestModelCopyWithImpl<$Res,
        $Val extends NotificationRequestModel>
    implements $NotificationRequestModelCopyWith<$Res> {
  _$NotificationRequestModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of NotificationRequestModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? languageId = freezed,
    Object? customerToken = freezed,
    Object? platform = freezed,
    Object? version = freezed,
    Object? deviceId = freezed,
  }) {
    return _then(_value.copyWith(
      languageId: freezed == languageId
          ? _value.languageId
          : languageId // ignore: cast_nullable_to_non_nullable
              as int?,
      customerToken: freezed == customerToken
          ? _value.customerToken
          : customerToken // ignore: cast_nullable_to_non_nullable
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
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$NotificationRequestModelImplCopyWith<$Res>
    implements $NotificationRequestModelCopyWith<$Res> {
  factory _$$NotificationRequestModelImplCopyWith(
          _$NotificationRequestModelImpl value,
          $Res Function(_$NotificationRequestModelImpl) then) =
      __$$NotificationRequestModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int? languageId,
      String? customerToken,
      String? platform,
      String? version,
      String? deviceId});
}

/// @nodoc
class __$$NotificationRequestModelImplCopyWithImpl<$Res>
    extends _$NotificationRequestModelCopyWithImpl<$Res,
        _$NotificationRequestModelImpl>
    implements _$$NotificationRequestModelImplCopyWith<$Res> {
  __$$NotificationRequestModelImplCopyWithImpl(
      _$NotificationRequestModelImpl _value,
      $Res Function(_$NotificationRequestModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of NotificationRequestModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? languageId = freezed,
    Object? customerToken = freezed,
    Object? platform = freezed,
    Object? version = freezed,
    Object? deviceId = freezed,
  }) {
    return _then(_$NotificationRequestModelImpl(
      languageId: freezed == languageId
          ? _value.languageId
          : languageId // ignore: cast_nullable_to_non_nullable
              as int?,
      customerToken: freezed == customerToken
          ? _value.customerToken
          : customerToken // ignore: cast_nullable_to_non_nullable
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
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$NotificationRequestModelImpl implements _NotificationRequestModel {
  const _$NotificationRequestModelImpl(
      {this.languageId,
      this.customerToken,
      this.platform,
      this.version,
      this.deviceId});

  factory _$NotificationRequestModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$NotificationRequestModelImplFromJson(json);

  /// The language ID for localization.
  @override
  final int? languageId;

  /// The customer authentication token.
  @override
  final String? customerToken;

  /// The platform identifier (e.g., 'android', 'ios', 'web').
  @override
  final String? platform;

  /// The app version.
  @override
  final String? version;

  /// Device identifier for tracking and analytics.
  @override
  final String? deviceId;

  @override
  String toString() {
    return 'NotificationRequestModel(languageId: $languageId, customerToken: $customerToken, platform: $platform, version: $version, deviceId: $deviceId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NotificationRequestModelImpl &&
            (identical(other.languageId, languageId) ||
                other.languageId == languageId) &&
            (identical(other.customerToken, customerToken) ||
                other.customerToken == customerToken) &&
            (identical(other.platform, platform) ||
                other.platform == platform) &&
            (identical(other.version, version) || other.version == version) &&
            (identical(other.deviceId, deviceId) ||
                other.deviceId == deviceId));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, languageId, customerToken, platform, version, deviceId);

  /// Create a copy of NotificationRequestModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$NotificationRequestModelImplCopyWith<_$NotificationRequestModelImpl>
      get copyWith => __$$NotificationRequestModelImplCopyWithImpl<
          _$NotificationRequestModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$NotificationRequestModelImplToJson(
      this,
    );
  }
}

abstract class _NotificationRequestModel implements NotificationRequestModel {
  const factory _NotificationRequestModel(
      {final int? languageId,
      final String? customerToken,
      final String? platform,
      final String? version,
      final String? deviceId}) = _$NotificationRequestModelImpl;

  factory _NotificationRequestModel.fromJson(Map<String, dynamic> json) =
      _$NotificationRequestModelImpl.fromJson;

  /// The language ID for localization.
  @override
  int? get languageId;

  /// The customer authentication token.
  @override
  String? get customerToken;

  /// The platform identifier (e.g., 'android', 'ios', 'web').
  @override
  String? get platform;

  /// The app version.
  @override
  String? get version;

  /// Device identifier for tracking and analytics.
  @override
  String? get deviceId;

  /// Create a copy of NotificationRequestModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$NotificationRequestModelImplCopyWith<_$NotificationRequestModelImpl>
      get copyWith => throw _privateConstructorUsedError;
}
