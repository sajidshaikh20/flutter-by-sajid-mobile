// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'forgot_password_with_email_request_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ForgotPasswordWithEmailRequestModel
    _$ForgotPasswordWithEmailRequestModelFromJson(Map<String, dynamic> json) {
  return _ForgotPasswordWithEmailRequestModel.fromJson(json);
}

/// @nodoc
mixin _$ForgotPasswordWithEmailRequestModel {
  String? get platform => throw _privateConstructorUsedError;
  String? get version => throw _privateConstructorUsedError;
  String? get email => throw _privateConstructorUsedError;
  String? get languageId => throw _privateConstructorUsedError;

  /// Serializes this ForgotPasswordWithEmailRequestModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ForgotPasswordWithEmailRequestModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ForgotPasswordWithEmailRequestModelCopyWith<
          ForgotPasswordWithEmailRequestModel>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ForgotPasswordWithEmailRequestModelCopyWith<$Res> {
  factory $ForgotPasswordWithEmailRequestModelCopyWith(
          ForgotPasswordWithEmailRequestModel value,
          $Res Function(ForgotPasswordWithEmailRequestModel) then) =
      _$ForgotPasswordWithEmailRequestModelCopyWithImpl<$Res,
          ForgotPasswordWithEmailRequestModel>;
  @useResult
  $Res call(
      {String? platform, String? version, String? email, String? languageId});
}

/// @nodoc
class _$ForgotPasswordWithEmailRequestModelCopyWithImpl<$Res,
        $Val extends ForgotPasswordWithEmailRequestModel>
    implements $ForgotPasswordWithEmailRequestModelCopyWith<$Res> {
  _$ForgotPasswordWithEmailRequestModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ForgotPasswordWithEmailRequestModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? platform = freezed,
    Object? version = freezed,
    Object? email = freezed,
    Object? languageId = freezed,
  }) {
    return _then(_value.copyWith(
      platform: freezed == platform
          ? _value.platform
          : platform // ignore: cast_nullable_to_non_nullable
              as String?,
      version: freezed == version
          ? _value.version
          : version // ignore: cast_nullable_to_non_nullable
              as String?,
      email: freezed == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String?,
      languageId: freezed == languageId
          ? _value.languageId
          : languageId // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ForgotPasswordWithEmailRequestModelImplCopyWith<$Res>
    implements $ForgotPasswordWithEmailRequestModelCopyWith<$Res> {
  factory _$$ForgotPasswordWithEmailRequestModelImplCopyWith(
          _$ForgotPasswordWithEmailRequestModelImpl value,
          $Res Function(_$ForgotPasswordWithEmailRequestModelImpl) then) =
      __$$ForgotPasswordWithEmailRequestModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? platform, String? version, String? email, String? languageId});
}

/// @nodoc
class __$$ForgotPasswordWithEmailRequestModelImplCopyWithImpl<$Res>
    extends _$ForgotPasswordWithEmailRequestModelCopyWithImpl<$Res,
        _$ForgotPasswordWithEmailRequestModelImpl>
    implements _$$ForgotPasswordWithEmailRequestModelImplCopyWith<$Res> {
  __$$ForgotPasswordWithEmailRequestModelImplCopyWithImpl(
      _$ForgotPasswordWithEmailRequestModelImpl _value,
      $Res Function(_$ForgotPasswordWithEmailRequestModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of ForgotPasswordWithEmailRequestModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? platform = freezed,
    Object? version = freezed,
    Object? email = freezed,
    Object? languageId = freezed,
  }) {
    return _then(_$ForgotPasswordWithEmailRequestModelImpl(
      platform: freezed == platform
          ? _value.platform
          : platform // ignore: cast_nullable_to_non_nullable
              as String?,
      version: freezed == version
          ? _value.version
          : version // ignore: cast_nullable_to_non_nullable
              as String?,
      email: freezed == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String?,
      languageId: freezed == languageId
          ? _value.languageId
          : languageId // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ForgotPasswordWithEmailRequestModelImpl
    implements _ForgotPasswordWithEmailRequestModel {
  const _$ForgotPasswordWithEmailRequestModelImpl(
      {this.platform, this.version, this.email, this.languageId});

  factory _$ForgotPasswordWithEmailRequestModelImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$ForgotPasswordWithEmailRequestModelImplFromJson(json);

  @override
  final String? platform;
  @override
  final String? version;
  @override
  final String? email;
  @override
  final String? languageId;

  @override
  String toString() {
    return 'ForgotPasswordWithEmailRequestModel(platform: $platform, version: $version, email: $email, languageId: $languageId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ForgotPasswordWithEmailRequestModelImpl &&
            (identical(other.platform, platform) ||
                other.platform == platform) &&
            (identical(other.version, version) || other.version == version) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.languageId, languageId) ||
                other.languageId == languageId));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, platform, version, email, languageId);

  /// Create a copy of ForgotPasswordWithEmailRequestModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ForgotPasswordWithEmailRequestModelImplCopyWith<
          _$ForgotPasswordWithEmailRequestModelImpl>
      get copyWith => __$$ForgotPasswordWithEmailRequestModelImplCopyWithImpl<
          _$ForgotPasswordWithEmailRequestModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ForgotPasswordWithEmailRequestModelImplToJson(
      this,
    );
  }
}

abstract class _ForgotPasswordWithEmailRequestModel
    implements ForgotPasswordWithEmailRequestModel {
  const factory _ForgotPasswordWithEmailRequestModel(
      {final String? platform,
      final String? version,
      final String? email,
      final String? languageId}) = _$ForgotPasswordWithEmailRequestModelImpl;

  factory _ForgotPasswordWithEmailRequestModel.fromJson(
          Map<String, dynamic> json) =
      _$ForgotPasswordWithEmailRequestModelImpl.fromJson;

  @override
  String? get platform;
  @override
  String? get version;
  @override
  String? get email;
  @override
  String? get languageId;

  /// Create a copy of ForgotPasswordWithEmailRequestModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ForgotPasswordWithEmailRequestModelImplCopyWith<
          _$ForgotPasswordWithEmailRequestModelImpl>
      get copyWith => throw _privateConstructorUsedError;
}
