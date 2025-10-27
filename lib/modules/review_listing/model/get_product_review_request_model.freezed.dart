// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'get_product_review_request_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

GetProductReviewRequestModel _$GetProductReviewRequestModelFromJson(
    Map<String, dynamic> json) {
  return _GetProductReviewRequestModel.fromJson(json);
}

/// @nodoc
mixin _$GetProductReviewRequestModel {
// required String store,
  String get entityId => throw _privateConstructorUsedError;

  /// Serializes this GetProductReviewRequestModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of GetProductReviewRequestModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $GetProductReviewRequestModelCopyWith<GetProductReviewRequestModel>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GetProductReviewRequestModelCopyWith<$Res> {
  factory $GetProductReviewRequestModelCopyWith(
          GetProductReviewRequestModel value,
          $Res Function(GetProductReviewRequestModel) then) =
      _$GetProductReviewRequestModelCopyWithImpl<$Res,
          GetProductReviewRequestModel>;
  @useResult
  $Res call({String entityId});
}

/// @nodoc
class _$GetProductReviewRequestModelCopyWithImpl<$Res,
        $Val extends GetProductReviewRequestModel>
    implements $GetProductReviewRequestModelCopyWith<$Res> {
  _$GetProductReviewRequestModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of GetProductReviewRequestModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? entityId = null,
  }) {
    return _then(_value.copyWith(
      entityId: null == entityId
          ? _value.entityId
          : entityId // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$GetProductReviewRequestModelImplCopyWith<$Res>
    implements $GetProductReviewRequestModelCopyWith<$Res> {
  factory _$$GetProductReviewRequestModelImplCopyWith(
          _$GetProductReviewRequestModelImpl value,
          $Res Function(_$GetProductReviewRequestModelImpl) then) =
      __$$GetProductReviewRequestModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String entityId});
}

/// @nodoc
class __$$GetProductReviewRequestModelImplCopyWithImpl<$Res>
    extends _$GetProductReviewRequestModelCopyWithImpl<$Res,
        _$GetProductReviewRequestModelImpl>
    implements _$$GetProductReviewRequestModelImplCopyWith<$Res> {
  __$$GetProductReviewRequestModelImplCopyWithImpl(
      _$GetProductReviewRequestModelImpl _value,
      $Res Function(_$GetProductReviewRequestModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of GetProductReviewRequestModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? entityId = null,
  }) {
    return _then(_$GetProductReviewRequestModelImpl(
      entityId: null == entityId
          ? _value.entityId
          : entityId // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$GetProductReviewRequestModelImpl
    implements _GetProductReviewRequestModel {
  const _$GetProductReviewRequestModelImpl({required this.entityId});

  factory _$GetProductReviewRequestModelImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$GetProductReviewRequestModelImplFromJson(json);

// required String store,
  @override
  final String entityId;

  @override
  String toString() {
    return 'GetProductReviewRequestModel(entityId: $entityId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GetProductReviewRequestModelImpl &&
            (identical(other.entityId, entityId) ||
                other.entityId == entityId));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, entityId);

  /// Create a copy of GetProductReviewRequestModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$GetProductReviewRequestModelImplCopyWith<
          _$GetProductReviewRequestModelImpl>
      get copyWith => __$$GetProductReviewRequestModelImplCopyWithImpl<
          _$GetProductReviewRequestModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$GetProductReviewRequestModelImplToJson(
      this,
    );
  }
}

abstract class _GetProductReviewRequestModel
    implements GetProductReviewRequestModel {
  const factory _GetProductReviewRequestModel(
      {required final String entityId}) = _$GetProductReviewRequestModelImpl;

  factory _GetProductReviewRequestModel.fromJson(Map<String, dynamic> json) =
      _$GetProductReviewRequestModelImpl.fromJson;

// required String store,
  @override
  String get entityId;

  /// Create a copy of GetProductReviewRequestModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$GetProductReviewRequestModelImplCopyWith<
          _$GetProductReviewRequestModelImpl>
      get copyWith => throw _privateConstructorUsedError;
}
