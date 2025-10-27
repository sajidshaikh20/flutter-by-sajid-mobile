// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'set_slot_request_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

SetSlotRequestModel _$SetSlotRequestModelFromJson(Map<String, dynamic> json) {
  return _SetSlotRequestModel.fromJson(json);
}

/// @nodoc
mixin _$SetSlotRequestModel {
  /// The ID of the slot to be set for the order.
  int? get slotId => throw _privateConstructorUsedError;

  /// The ID of the quote associated with the order.
  int? get quoteId => throw _privateConstructorUsedError;

  /// Serializes this SetSlotRequestModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SetSlotRequestModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SetSlotRequestModelCopyWith<SetSlotRequestModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SetSlotRequestModelCopyWith<$Res> {
  factory $SetSlotRequestModelCopyWith(
          SetSlotRequestModel value, $Res Function(SetSlotRequestModel) then) =
      _$SetSlotRequestModelCopyWithImpl<$Res, SetSlotRequestModel>;
  @useResult
  $Res call({int? slotId, int? quoteId});
}

/// @nodoc
class _$SetSlotRequestModelCopyWithImpl<$Res, $Val extends SetSlotRequestModel>
    implements $SetSlotRequestModelCopyWith<$Res> {
  _$SetSlotRequestModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SetSlotRequestModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? slotId = freezed,
    Object? quoteId = freezed,
  }) {
    return _then(_value.copyWith(
      slotId: freezed == slotId
          ? _value.slotId
          : slotId // ignore: cast_nullable_to_non_nullable
              as int?,
      quoteId: freezed == quoteId
          ? _value.quoteId
          : quoteId // ignore: cast_nullable_to_non_nullable
              as int?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SetSlotRequestModelImplCopyWith<$Res>
    implements $SetSlotRequestModelCopyWith<$Res> {
  factory _$$SetSlotRequestModelImplCopyWith(_$SetSlotRequestModelImpl value,
          $Res Function(_$SetSlotRequestModelImpl) then) =
      __$$SetSlotRequestModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int? slotId, int? quoteId});
}

/// @nodoc
class __$$SetSlotRequestModelImplCopyWithImpl<$Res>
    extends _$SetSlotRequestModelCopyWithImpl<$Res, _$SetSlotRequestModelImpl>
    implements _$$SetSlotRequestModelImplCopyWith<$Res> {
  __$$SetSlotRequestModelImplCopyWithImpl(_$SetSlotRequestModelImpl _value,
      $Res Function(_$SetSlotRequestModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of SetSlotRequestModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? slotId = freezed,
    Object? quoteId = freezed,
  }) {
    return _then(_$SetSlotRequestModelImpl(
      slotId: freezed == slotId
          ? _value.slotId
          : slotId // ignore: cast_nullable_to_non_nullable
              as int?,
      quoteId: freezed == quoteId
          ? _value.quoteId
          : quoteId // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SetSlotRequestModelImpl implements _SetSlotRequestModel {
  const _$SetSlotRequestModelImpl({this.slotId, this.quoteId});

  factory _$SetSlotRequestModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$SetSlotRequestModelImplFromJson(json);

  /// The ID of the slot to be set for the order.
  @override
  final int? slotId;

  /// The ID of the quote associated with the order.
  @override
  final int? quoteId;

  @override
  String toString() {
    return 'SetSlotRequestModel(slotId: $slotId, quoteId: $quoteId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SetSlotRequestModelImpl &&
            (identical(other.slotId, slotId) || other.slotId == slotId) &&
            (identical(other.quoteId, quoteId) || other.quoteId == quoteId));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, slotId, quoteId);

  /// Create a copy of SetSlotRequestModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SetSlotRequestModelImplCopyWith<_$SetSlotRequestModelImpl> get copyWith =>
      __$$SetSlotRequestModelImplCopyWithImpl<_$SetSlotRequestModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SetSlotRequestModelImplToJson(
      this,
    );
  }
}

abstract class _SetSlotRequestModel implements SetSlotRequestModel {
  const factory _SetSlotRequestModel({final int? slotId, final int? quoteId}) =
      _$SetSlotRequestModelImpl;

  factory _SetSlotRequestModel.fromJson(Map<String, dynamic> json) =
      _$SetSlotRequestModelImpl.fromJson;

  /// The ID of the slot to be set for the order.
  @override
  int? get slotId;

  /// The ID of the quote associated with the order.
  @override
  int? get quoteId;

  /// Create a copy of SetSlotRequestModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SetSlotRequestModelImplCopyWith<_$SetSlotRequestModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
