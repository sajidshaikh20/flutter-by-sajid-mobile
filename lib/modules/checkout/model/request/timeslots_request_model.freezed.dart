// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'timeslots_request_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

TimeslotsRequestModel _$TimeslotsRequestModelFromJson(
    Map<String, dynamic> json) {
  return _TimeslotsRequestModel.fromJson(json);
}

/// @nodoc
mixin _$TimeslotsRequestModel {
  /// The ID of the store.
  int? get storeId => throw _privateConstructorUsedError;

  /// The ID of the region for the time slot request.
  int? get regionId => throw _privateConstructorUsedError;

  /// Serializes this TimeslotsRequestModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of TimeslotsRequestModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TimeslotsRequestModelCopyWith<TimeslotsRequestModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TimeslotsRequestModelCopyWith<$Res> {
  factory $TimeslotsRequestModelCopyWith(TimeslotsRequestModel value,
          $Res Function(TimeslotsRequestModel) then) =
      _$TimeslotsRequestModelCopyWithImpl<$Res, TimeslotsRequestModel>;
  @useResult
  $Res call({int? storeId, int? regionId});
}

/// @nodoc
class _$TimeslotsRequestModelCopyWithImpl<$Res,
        $Val extends TimeslotsRequestModel>
    implements $TimeslotsRequestModelCopyWith<$Res> {
  _$TimeslotsRequestModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TimeslotsRequestModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? storeId = freezed,
    Object? regionId = freezed,
  }) {
    return _then(_value.copyWith(
      storeId: freezed == storeId
          ? _value.storeId
          : storeId // ignore: cast_nullable_to_non_nullable
              as int?,
      regionId: freezed == regionId
          ? _value.regionId
          : regionId // ignore: cast_nullable_to_non_nullable
              as int?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TimeslotsRequestModelImplCopyWith<$Res>
    implements $TimeslotsRequestModelCopyWith<$Res> {
  factory _$$TimeslotsRequestModelImplCopyWith(
          _$TimeslotsRequestModelImpl value,
          $Res Function(_$TimeslotsRequestModelImpl) then) =
      __$$TimeslotsRequestModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int? storeId, int? regionId});
}

/// @nodoc
class __$$TimeslotsRequestModelImplCopyWithImpl<$Res>
    extends _$TimeslotsRequestModelCopyWithImpl<$Res,
        _$TimeslotsRequestModelImpl>
    implements _$$TimeslotsRequestModelImplCopyWith<$Res> {
  __$$TimeslotsRequestModelImplCopyWithImpl(_$TimeslotsRequestModelImpl _value,
      $Res Function(_$TimeslotsRequestModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of TimeslotsRequestModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? storeId = freezed,
    Object? regionId = freezed,
  }) {
    return _then(_$TimeslotsRequestModelImpl(
      storeId: freezed == storeId
          ? _value.storeId
          : storeId // ignore: cast_nullable_to_non_nullable
              as int?,
      regionId: freezed == regionId
          ? _value.regionId
          : regionId // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TimeslotsRequestModelImpl implements _TimeslotsRequestModel {
  const _$TimeslotsRequestModelImpl({this.storeId, this.regionId});

  factory _$TimeslotsRequestModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$TimeslotsRequestModelImplFromJson(json);

  /// The ID of the store.
  @override
  final int? storeId;

  /// The ID of the region for the time slot request.
  @override
  final int? regionId;

  @override
  String toString() {
    return 'TimeslotsRequestModel(storeId: $storeId, regionId: $regionId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TimeslotsRequestModelImpl &&
            (identical(other.storeId, storeId) || other.storeId == storeId) &&
            (identical(other.regionId, regionId) ||
                other.regionId == regionId));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, storeId, regionId);

  /// Create a copy of TimeslotsRequestModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TimeslotsRequestModelImplCopyWith<_$TimeslotsRequestModelImpl>
      get copyWith => __$$TimeslotsRequestModelImplCopyWithImpl<
          _$TimeslotsRequestModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TimeslotsRequestModelImplToJson(
      this,
    );
  }
}

abstract class _TimeslotsRequestModel implements TimeslotsRequestModel {
  const factory _TimeslotsRequestModel(
      {final int? storeId, final int? regionId}) = _$TimeslotsRequestModelImpl;

  factory _TimeslotsRequestModel.fromJson(Map<String, dynamic> json) =
      _$TimeslotsRequestModelImpl.fromJson;

  /// The ID of the store.
  @override
  int? get storeId;

  /// The ID of the region for the time slot request.
  @override
  int? get regionId;

  /// Create a copy of TimeslotsRequestModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TimeslotsRequestModelImplCopyWith<_$TimeslotsRequestModelImpl>
      get copyWith => throw _privateConstructorUsedError;
}
