// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'logout_request_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

LogoutRequestModel _$LogoutRequestModelFromJson(Map<String, dynamic> json) {
  return _LogoutRequestModel.fromJson(json);
}

/// @nodoc
mixin _$LogoutRequestModel {
  /// The language ID for localization.
  int? get languageId => throw _privateConstructorUsedError;

  /// The platform identifier (e.g., 'android', 'ios', 'web').
  String? get platform => throw _privateConstructorUsedError;

  /// The app version.
  String? get version => throw _privateConstructorUsedError;

  /// The customer authentication token.
  String? get customerToken => throw _privateConstructorUsedError;

  /// Serializes this LogoutRequestModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of LogoutRequestModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $LogoutRequestModelCopyWith<LogoutRequestModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LogoutRequestModelCopyWith<$Res> {
  factory $LogoutRequestModelCopyWith(
          LogoutRequestModel value, $Res Function(LogoutRequestModel) then) =
      _$LogoutRequestModelCopyWithImpl<$Res, LogoutRequestModel>;
  @useResult
  $Res call(
      {int? languageId,
      String? platform,
      String? version,
      String? customerToken});
}

/// @nodoc
class _$LogoutRequestModelCopyWithImpl<$Res, $Val extends LogoutRequestModel>
    implements $LogoutRequestModelCopyWith<$Res> {
  _$LogoutRequestModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of LogoutRequestModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? languageId = freezed,
    Object? platform = freezed,
    Object? version = freezed,
    Object? customerToken = freezed,
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
      customerToken: freezed == customerToken
          ? _value.customerToken
          : customerToken // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$LogoutRequestModelImplCopyWith<$Res>
    implements $LogoutRequestModelCopyWith<$Res> {
  factory _$$LogoutRequestModelImplCopyWith(_$LogoutRequestModelImpl value,
          $Res Function(_$LogoutRequestModelImpl) then) =
      __$$LogoutRequestModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int? languageId,
      String? platform,
      String? version,
      String? customerToken});
}

/// @nodoc
class __$$LogoutRequestModelImplCopyWithImpl<$Res>
    extends _$LogoutRequestModelCopyWithImpl<$Res, _$LogoutRequestModelImpl>
    implements _$$LogoutRequestModelImplCopyWith<$Res> {
  __$$LogoutRequestModelImplCopyWithImpl(_$LogoutRequestModelImpl _value,
      $Res Function(_$LogoutRequestModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of LogoutRequestModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? languageId = freezed,
    Object? platform = freezed,
    Object? version = freezed,
    Object? customerToken = freezed,
  }) {
    return _then(_$LogoutRequestModelImpl(
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
      customerToken: freezed == customerToken
          ? _value.customerToken
          : customerToken // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$LogoutRequestModelImpl implements _LogoutRequestModel {
  const _$LogoutRequestModelImpl(
      {this.languageId, this.platform, this.version, this.customerToken});

  factory _$LogoutRequestModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$LogoutRequestModelImplFromJson(json);

  /// The language ID for localization.
  @override
  final int? languageId;

  /// The platform identifier (e.g., 'android', 'ios', 'web').
  @override
  final String? platform;

  /// The app version.
  @override
  final String? version;

  /// The customer authentication token.
  @override
  final String? customerToken;

  @override
  String toString() {
    return 'LogoutRequestModel(languageId: $languageId, platform: $platform, version: $version, customerToken: $customerToken)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LogoutRequestModelImpl &&
            (identical(other.languageId, languageId) ||
                other.languageId == languageId) &&
            (identical(other.platform, platform) ||
                other.platform == platform) &&
            (identical(other.version, version) || other.version == version) &&
            (identical(other.customerToken, customerToken) ||
                other.customerToken == customerToken));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, languageId, platform, version, customerToken);

  /// Create a copy of LogoutRequestModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LogoutRequestModelImplCopyWith<_$LogoutRequestModelImpl> get copyWith =>
      __$$LogoutRequestModelImplCopyWithImpl<_$LogoutRequestModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$LogoutRequestModelImplToJson(
      this,
    );
  }
}

abstract class _LogoutRequestModel implements LogoutRequestModel {
  const factory _LogoutRequestModel(
      {final int? languageId,
      final String? platform,
      final String? version,
      final String? customerToken}) = _$LogoutRequestModelImpl;

  factory _LogoutRequestModel.fromJson(Map<String, dynamic> json) =
      _$LogoutRequestModelImpl.fromJson;

  /// The language ID for localization.
  @override
  int? get languageId;

  /// The platform identifier (e.g., 'android', 'ios', 'web').
  @override
  String? get platform;

  /// The app version.
  @override
  String? get version;

  /// The customer authentication token.
  @override
  String? get customerToken;

  /// Create a copy of LogoutRequestModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LogoutRequestModelImplCopyWith<_$LogoutRequestModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
