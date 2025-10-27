// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'delete_account_request_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

DeleteAccountRequestModel _$DeleteAccountRequestModelFromJson(
    Map<String, dynamic> json) {
  return _DeleteAccountRequestModel.fromJson(json);
}

/// @nodoc
mixin _$DeleteAccountRequestModel {
  /// The language ID for localization.
  int? get languageId => throw _privateConstructorUsedError;

  /// The store ID for the request.
  int? get storeId => throw _privateConstructorUsedError;

  /// The platform identifier (e.g., 'android', 'ios', 'web').
  String? get platform => throw _privateConstructorUsedError;

  /// The app version.
  String? get version => throw _privateConstructorUsedError;

  /// The customer authentication token.
  String? get customerToken => throw _privateConstructorUsedError;

  /// Serializes this DeleteAccountRequestModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of DeleteAccountRequestModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DeleteAccountRequestModelCopyWith<DeleteAccountRequestModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DeleteAccountRequestModelCopyWith<$Res> {
  factory $DeleteAccountRequestModelCopyWith(DeleteAccountRequestModel value,
          $Res Function(DeleteAccountRequestModel) then) =
      _$DeleteAccountRequestModelCopyWithImpl<$Res, DeleteAccountRequestModel>;
  @useResult
  $Res call(
      {int? languageId,
      int? storeId,
      String? platform,
      String? version,
      String? customerToken});
}

/// @nodoc
class _$DeleteAccountRequestModelCopyWithImpl<$Res,
        $Val extends DeleteAccountRequestModel>
    implements $DeleteAccountRequestModelCopyWith<$Res> {
  _$DeleteAccountRequestModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of DeleteAccountRequestModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? languageId = freezed,
    Object? storeId = freezed,
    Object? platform = freezed,
    Object? version = freezed,
    Object? customerToken = freezed,
  }) {
    return _then(_value.copyWith(
      languageId: freezed == languageId
          ? _value.languageId
          : languageId // ignore: cast_nullable_to_non_nullable
              as int?,
      storeId: freezed == storeId
          ? _value.storeId
          : storeId // ignore: cast_nullable_to_non_nullable
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
abstract class _$$DeleteAccountRequestModelImplCopyWith<$Res>
    implements $DeleteAccountRequestModelCopyWith<$Res> {
  factory _$$DeleteAccountRequestModelImplCopyWith(
          _$DeleteAccountRequestModelImpl value,
          $Res Function(_$DeleteAccountRequestModelImpl) then) =
      __$$DeleteAccountRequestModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int? languageId,
      int? storeId,
      String? platform,
      String? version,
      String? customerToken});
}

/// @nodoc
class __$$DeleteAccountRequestModelImplCopyWithImpl<$Res>
    extends _$DeleteAccountRequestModelCopyWithImpl<$Res,
        _$DeleteAccountRequestModelImpl>
    implements _$$DeleteAccountRequestModelImplCopyWith<$Res> {
  __$$DeleteAccountRequestModelImplCopyWithImpl(
      _$DeleteAccountRequestModelImpl _value,
      $Res Function(_$DeleteAccountRequestModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of DeleteAccountRequestModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? languageId = freezed,
    Object? storeId = freezed,
    Object? platform = freezed,
    Object? version = freezed,
    Object? customerToken = freezed,
  }) {
    return _then(_$DeleteAccountRequestModelImpl(
      languageId: freezed == languageId
          ? _value.languageId
          : languageId // ignore: cast_nullable_to_non_nullable
              as int?,
      storeId: freezed == storeId
          ? _value.storeId
          : storeId // ignore: cast_nullable_to_non_nullable
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
class _$DeleteAccountRequestModelImpl implements _DeleteAccountRequestModel {
  const _$DeleteAccountRequestModelImpl(
      {this.languageId,
      this.storeId,
      this.platform,
      this.version,
      this.customerToken});

  factory _$DeleteAccountRequestModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$DeleteAccountRequestModelImplFromJson(json);

  /// The language ID for localization.
  @override
  final int? languageId;

  /// The store ID for the request.
  @override
  final int? storeId;

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
    return 'DeleteAccountRequestModel(languageId: $languageId, storeId: $storeId, platform: $platform, version: $version, customerToken: $customerToken)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DeleteAccountRequestModelImpl &&
            (identical(other.languageId, languageId) ||
                other.languageId == languageId) &&
            (identical(other.storeId, storeId) || other.storeId == storeId) &&
            (identical(other.platform, platform) ||
                other.platform == platform) &&
            (identical(other.version, version) || other.version == version) &&
            (identical(other.customerToken, customerToken) ||
                other.customerToken == customerToken));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, languageId, storeId, platform, version, customerToken);

  /// Create a copy of DeleteAccountRequestModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DeleteAccountRequestModelImplCopyWith<_$DeleteAccountRequestModelImpl>
      get copyWith => __$$DeleteAccountRequestModelImplCopyWithImpl<
          _$DeleteAccountRequestModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DeleteAccountRequestModelImplToJson(
      this,
    );
  }
}

abstract class _DeleteAccountRequestModel implements DeleteAccountRequestModel {
  const factory _DeleteAccountRequestModel(
      {final int? languageId,
      final int? storeId,
      final String? platform,
      final String? version,
      final String? customerToken}) = _$DeleteAccountRequestModelImpl;

  factory _DeleteAccountRequestModel.fromJson(Map<String, dynamic> json) =
      _$DeleteAccountRequestModelImpl.fromJson;

  /// The language ID for localization.
  @override
  int? get languageId;

  /// The store ID for the request.
  @override
  int? get storeId;

  /// The platform identifier (e.g., 'android', 'ios', 'web').
  @override
  String? get platform;

  /// The app version.
  @override
  String? get version;

  /// The customer authentication token.
  @override
  String? get customerToken;

  /// Create a copy of DeleteAccountRequestModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DeleteAccountRequestModelImplCopyWith<_$DeleteAccountRequestModelImpl>
      get copyWith => throw _privateConstructorUsedError;
}
