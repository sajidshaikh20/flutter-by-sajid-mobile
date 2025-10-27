// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'loyalty_points_request_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

LoyaltyPointsRequestModel _$LoyaltyPointsRequestModelFromJson(
    Map<String, dynamic> json) {
  return _LoyaltyPointsRequestModel.fromJson(json);
}

/// @nodoc
mixin _$LoyaltyPointsRequestModel {
  String get customerToken => throw _privateConstructorUsedError;
  String get platform => throw _privateConstructorUsedError;
  String get version => throw _privateConstructorUsedError;
  int? get languageId => throw _privateConstructorUsedError;

  /// Serializes this LoyaltyPointsRequestModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of LoyaltyPointsRequestModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $LoyaltyPointsRequestModelCopyWith<LoyaltyPointsRequestModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LoyaltyPointsRequestModelCopyWith<$Res> {
  factory $LoyaltyPointsRequestModelCopyWith(LoyaltyPointsRequestModel value,
          $Res Function(LoyaltyPointsRequestModel) then) =
      _$LoyaltyPointsRequestModelCopyWithImpl<$Res, LoyaltyPointsRequestModel>;
  @useResult
  $Res call(
      {String customerToken, String platform, String version, int? languageId});
}

/// @nodoc
class _$LoyaltyPointsRequestModelCopyWithImpl<$Res,
        $Val extends LoyaltyPointsRequestModel>
    implements $LoyaltyPointsRequestModelCopyWith<$Res> {
  _$LoyaltyPointsRequestModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of LoyaltyPointsRequestModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? customerToken = null,
    Object? platform = null,
    Object? version = null,
    Object? languageId = freezed,
  }) {
    return _then(_value.copyWith(
      customerToken: null == customerToken
          ? _value.customerToken
          : customerToken // ignore: cast_nullable_to_non_nullable
              as String,
      platform: null == platform
          ? _value.platform
          : platform // ignore: cast_nullable_to_non_nullable
              as String,
      version: null == version
          ? _value.version
          : version // ignore: cast_nullable_to_non_nullable
              as String,
      languageId: freezed == languageId
          ? _value.languageId
          : languageId // ignore: cast_nullable_to_non_nullable
              as int?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$LoyaltyPointsRequestModelImplCopyWith<$Res>
    implements $LoyaltyPointsRequestModelCopyWith<$Res> {
  factory _$$LoyaltyPointsRequestModelImplCopyWith(
          _$LoyaltyPointsRequestModelImpl value,
          $Res Function(_$LoyaltyPointsRequestModelImpl) then) =
      __$$LoyaltyPointsRequestModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String customerToken, String platform, String version, int? languageId});
}

/// @nodoc
class __$$LoyaltyPointsRequestModelImplCopyWithImpl<$Res>
    extends _$LoyaltyPointsRequestModelCopyWithImpl<$Res,
        _$LoyaltyPointsRequestModelImpl>
    implements _$$LoyaltyPointsRequestModelImplCopyWith<$Res> {
  __$$LoyaltyPointsRequestModelImplCopyWithImpl(
      _$LoyaltyPointsRequestModelImpl _value,
      $Res Function(_$LoyaltyPointsRequestModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of LoyaltyPointsRequestModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? customerToken = null,
    Object? platform = null,
    Object? version = null,
    Object? languageId = freezed,
  }) {
    return _then(_$LoyaltyPointsRequestModelImpl(
      customerToken: null == customerToken
          ? _value.customerToken
          : customerToken // ignore: cast_nullable_to_non_nullable
              as String,
      platform: null == platform
          ? _value.platform
          : platform // ignore: cast_nullable_to_non_nullable
              as String,
      version: null == version
          ? _value.version
          : version // ignore: cast_nullable_to_non_nullable
              as String,
      languageId: freezed == languageId
          ? _value.languageId
          : languageId // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$LoyaltyPointsRequestModelImpl implements _LoyaltyPointsRequestModel {
  const _$LoyaltyPointsRequestModelImpl(
      {required this.customerToken,
      required this.platform,
      required this.version,
      this.languageId});

  factory _$LoyaltyPointsRequestModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$LoyaltyPointsRequestModelImplFromJson(json);

  @override
  final String customerToken;
  @override
  final String platform;
  @override
  final String version;
  @override
  final int? languageId;

  @override
  String toString() {
    return 'LoyaltyPointsRequestModel(customerToken: $customerToken, platform: $platform, version: $version, languageId: $languageId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoyaltyPointsRequestModelImpl &&
            (identical(other.customerToken, customerToken) ||
                other.customerToken == customerToken) &&
            (identical(other.platform, platform) ||
                other.platform == platform) &&
            (identical(other.version, version) || other.version == version) &&
            (identical(other.languageId, languageId) ||
                other.languageId == languageId));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, customerToken, platform, version, languageId);

  /// Create a copy of LoyaltyPointsRequestModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LoyaltyPointsRequestModelImplCopyWith<_$LoyaltyPointsRequestModelImpl>
      get copyWith => __$$LoyaltyPointsRequestModelImplCopyWithImpl<
          _$LoyaltyPointsRequestModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$LoyaltyPointsRequestModelImplToJson(
      this,
    );
  }
}

abstract class _LoyaltyPointsRequestModel implements LoyaltyPointsRequestModel {
  const factory _LoyaltyPointsRequestModel(
      {required final String customerToken,
      required final String platform,
      required final String version,
      final int? languageId}) = _$LoyaltyPointsRequestModelImpl;

  factory _LoyaltyPointsRequestModel.fromJson(Map<String, dynamic> json) =
      _$LoyaltyPointsRequestModelImpl.fromJson;

  @override
  String get customerToken;
  @override
  String get platform;
  @override
  String get version;
  @override
  int? get languageId;

  /// Create a copy of LoyaltyPointsRequestModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LoyaltyPointsRequestModelImplCopyWith<_$LoyaltyPointsRequestModelImpl>
      get copyWith => throw _privateConstructorUsedError;
}
