// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'contact_us_response_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ContactUsResponseModel _$ContactUsResponseModelFromJson(
    Map<String, dynamic> json) {
  return _ContactUsResponseModel.fromJson(json);
}

/// @nodoc
mixin _$ContactUsResponseModel {
  bool get success => throw _privateConstructorUsedError;
  String get message => throw _privateConstructorUsedError;

  /// Serializes this ContactUsResponseModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ContactUsResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ContactUsResponseModelCopyWith<ContactUsResponseModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ContactUsResponseModelCopyWith<$Res> {
  factory $ContactUsResponseModelCopyWith(ContactUsResponseModel value,
          $Res Function(ContactUsResponseModel) then) =
      _$ContactUsResponseModelCopyWithImpl<$Res, ContactUsResponseModel>;
  @useResult
  $Res call({bool success, String message});
}

/// @nodoc
class _$ContactUsResponseModelCopyWithImpl<$Res,
        $Val extends ContactUsResponseModel>
    implements $ContactUsResponseModelCopyWith<$Res> {
  _$ContactUsResponseModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ContactUsResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? success = null,
    Object? message = null,
  }) {
    return _then(_value.copyWith(
      success: null == success
          ? _value.success
          : success // ignore: cast_nullable_to_non_nullable
              as bool,
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ContactUsResponseModelImplCopyWith<$Res>
    implements $ContactUsResponseModelCopyWith<$Res> {
  factory _$$ContactUsResponseModelImplCopyWith(
          _$ContactUsResponseModelImpl value,
          $Res Function(_$ContactUsResponseModelImpl) then) =
      __$$ContactUsResponseModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({bool success, String message});
}

/// @nodoc
class __$$ContactUsResponseModelImplCopyWithImpl<$Res>
    extends _$ContactUsResponseModelCopyWithImpl<$Res,
        _$ContactUsResponseModelImpl>
    implements _$$ContactUsResponseModelImplCopyWith<$Res> {
  __$$ContactUsResponseModelImplCopyWithImpl(
      _$ContactUsResponseModelImpl _value,
      $Res Function(_$ContactUsResponseModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of ContactUsResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? success = null,
    Object? message = null,
  }) {
    return _then(_$ContactUsResponseModelImpl(
      success: null == success
          ? _value.success
          : success // ignore: cast_nullable_to_non_nullable
              as bool,
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ContactUsResponseModelImpl implements _ContactUsResponseModel {
  const _$ContactUsResponseModelImpl(
      {required this.success, required this.message});

  factory _$ContactUsResponseModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$ContactUsResponseModelImplFromJson(json);

  @override
  final bool success;
  @override
  final String message;

  @override
  String toString() {
    return 'ContactUsResponseModel(success: $success, message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ContactUsResponseModelImpl &&
            (identical(other.success, success) || other.success == success) &&
            (identical(other.message, message) || other.message == message));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, success, message);

  /// Create a copy of ContactUsResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ContactUsResponseModelImplCopyWith<_$ContactUsResponseModelImpl>
      get copyWith => __$$ContactUsResponseModelImplCopyWithImpl<
          _$ContactUsResponseModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ContactUsResponseModelImplToJson(
      this,
    );
  }
}

abstract class _ContactUsResponseModel implements ContactUsResponseModel {
  const factory _ContactUsResponseModel(
      {required final bool success,
      required final String message}) = _$ContactUsResponseModelImpl;

  factory _ContactUsResponseModel.fromJson(Map<String, dynamic> json) =
      _$ContactUsResponseModelImpl.fromJson;

  @override
  bool get success;
  @override
  String get message;

  /// Create a copy of ContactUsResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ContactUsResponseModelImplCopyWith<_$ContactUsResponseModelImpl>
      get copyWith => throw _privateConstructorUsedError;
}
