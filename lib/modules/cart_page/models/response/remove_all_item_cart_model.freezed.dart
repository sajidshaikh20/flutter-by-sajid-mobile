// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'remove_all_item_cart_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

RemoveAllItemCartModel _$RemoveAllItemCartModelFromJson(
    Map<String, dynamic> json) {
  return _RemoveAllItemCartModel.fromJson(json);
}

/// @nodoc
mixin _$RemoveAllItemCartModel {
  /// Indicates whether the removal of all cart items was successful.
  bool? get success => throw _privateConstructorUsedError;

  /// Message returned by the server, usually describing success or failure.
  String? get message => throw _privateConstructorUsedError;

  /// Serializes this RemoveAllItemCartModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of RemoveAllItemCartModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $RemoveAllItemCartModelCopyWith<RemoveAllItemCartModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RemoveAllItemCartModelCopyWith<$Res> {
  factory $RemoveAllItemCartModelCopyWith(RemoveAllItemCartModel value,
          $Res Function(RemoveAllItemCartModel) then) =
      _$RemoveAllItemCartModelCopyWithImpl<$Res, RemoveAllItemCartModel>;
  @useResult
  $Res call({bool? success, String? message});
}

/// @nodoc
class _$RemoveAllItemCartModelCopyWithImpl<$Res,
        $Val extends RemoveAllItemCartModel>
    implements $RemoveAllItemCartModelCopyWith<$Res> {
  _$RemoveAllItemCartModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of RemoveAllItemCartModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? success = freezed,
    Object? message = freezed,
  }) {
    return _then(_value.copyWith(
      success: freezed == success
          ? _value.success
          : success // ignore: cast_nullable_to_non_nullable
              as bool?,
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$RemoveAllItemCartModelImplCopyWith<$Res>
    implements $RemoveAllItemCartModelCopyWith<$Res> {
  factory _$$RemoveAllItemCartModelImplCopyWith(
          _$RemoveAllItemCartModelImpl value,
          $Res Function(_$RemoveAllItemCartModelImpl) then) =
      __$$RemoveAllItemCartModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({bool? success, String? message});
}

/// @nodoc
class __$$RemoveAllItemCartModelImplCopyWithImpl<$Res>
    extends _$RemoveAllItemCartModelCopyWithImpl<$Res,
        _$RemoveAllItemCartModelImpl>
    implements _$$RemoveAllItemCartModelImplCopyWith<$Res> {
  __$$RemoveAllItemCartModelImplCopyWithImpl(
      _$RemoveAllItemCartModelImpl _value,
      $Res Function(_$RemoveAllItemCartModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of RemoveAllItemCartModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? success = freezed,
    Object? message = freezed,
  }) {
    return _then(_$RemoveAllItemCartModelImpl(
      success: freezed == success
          ? _value.success
          : success // ignore: cast_nullable_to_non_nullable
              as bool?,
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$RemoveAllItemCartModelImpl implements _RemoveAllItemCartModel {
  const _$RemoveAllItemCartModelImpl({this.success = false, this.message = ''});

  factory _$RemoveAllItemCartModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$RemoveAllItemCartModelImplFromJson(json);

  /// Indicates whether the removal of all cart items was successful.
  @override
  @JsonKey()
  final bool? success;

  /// Message returned by the server, usually describing success or failure.
  @override
  @JsonKey()
  final String? message;

  @override
  String toString() {
    return 'RemoveAllItemCartModel(success: $success, message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RemoveAllItemCartModelImpl &&
            (identical(other.success, success) || other.success == success) &&
            (identical(other.message, message) || other.message == message));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, success, message);

  /// Create a copy of RemoveAllItemCartModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RemoveAllItemCartModelImplCopyWith<_$RemoveAllItemCartModelImpl>
      get copyWith => __$$RemoveAllItemCartModelImplCopyWithImpl<
          _$RemoveAllItemCartModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$RemoveAllItemCartModelImplToJson(
      this,
    );
  }
}

abstract class _RemoveAllItemCartModel implements RemoveAllItemCartModel {
  const factory _RemoveAllItemCartModel(
      {final bool? success,
      final String? message}) = _$RemoveAllItemCartModelImpl;

  factory _RemoveAllItemCartModel.fromJson(Map<String, dynamic> json) =
      _$RemoveAllItemCartModelImpl.fromJson;

  /// Indicates whether the removal of all cart items was successful.
  @override
  bool? get success;

  /// Message returned by the server, usually describing success or failure.
  @override
  String? get message;

  /// Create a copy of RemoveAllItemCartModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RemoveAllItemCartModelImplCopyWith<_$RemoveAllItemCartModelImpl>
      get copyWith => throw _privateConstructorUsedError;
}
