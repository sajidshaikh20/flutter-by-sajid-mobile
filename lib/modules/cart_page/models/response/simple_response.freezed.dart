// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'simple_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

SimpleResponse _$SimpleResponseFromJson(Map<String, dynamic> json) {
  return _SimpleResponse.fromJson(json);
}

/// @nodoc
mixin _$SimpleResponse {
  /// Indicates whether the operation was successful.
  bool? get success => throw _privateConstructorUsedError;

  /// Message returned by the server, usually describing success or failure.
  String? get message => throw _privateConstructorUsedError;

  /// Serializes this SimpleResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SimpleResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SimpleResponseCopyWith<SimpleResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SimpleResponseCopyWith<$Res> {
  factory $SimpleResponseCopyWith(
          SimpleResponse value, $Res Function(SimpleResponse) then) =
      _$SimpleResponseCopyWithImpl<$Res, SimpleResponse>;
  @useResult
  $Res call({bool? success, String? message});
}

/// @nodoc
class _$SimpleResponseCopyWithImpl<$Res, $Val extends SimpleResponse>
    implements $SimpleResponseCopyWith<$Res> {
  _$SimpleResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SimpleResponse
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
abstract class _$$SimpleResponseImplCopyWith<$Res>
    implements $SimpleResponseCopyWith<$Res> {
  factory _$$SimpleResponseImplCopyWith(_$SimpleResponseImpl value,
          $Res Function(_$SimpleResponseImpl) then) =
      __$$SimpleResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({bool? success, String? message});
}

/// @nodoc
class __$$SimpleResponseImplCopyWithImpl<$Res>
    extends _$SimpleResponseCopyWithImpl<$Res, _$SimpleResponseImpl>
    implements _$$SimpleResponseImplCopyWith<$Res> {
  __$$SimpleResponseImplCopyWithImpl(
      _$SimpleResponseImpl _value, $Res Function(_$SimpleResponseImpl) _then)
      : super(_value, _then);

  /// Create a copy of SimpleResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? success = freezed,
    Object? message = freezed,
  }) {
    return _then(_$SimpleResponseImpl(
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
class _$SimpleResponseImpl implements _SimpleResponse {
  const _$SimpleResponseImpl({this.success = false, this.message = ''});

  factory _$SimpleResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$SimpleResponseImplFromJson(json);

  /// Indicates whether the operation was successful.
  @override
  @JsonKey()
  final bool? success;

  /// Message returned by the server, usually describing success or failure.
  @override
  @JsonKey()
  final String? message;

  @override
  String toString() {
    return 'SimpleResponse(success: $success, message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SimpleResponseImpl &&
            (identical(other.success, success) || other.success == success) &&
            (identical(other.message, message) || other.message == message));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, success, message);

  /// Create a copy of SimpleResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SimpleResponseImplCopyWith<_$SimpleResponseImpl> get copyWith =>
      __$$SimpleResponseImplCopyWithImpl<_$SimpleResponseImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SimpleResponseImplToJson(
      this,
    );
  }
}

abstract class _SimpleResponse implements SimpleResponse {
  const factory _SimpleResponse({final bool? success, final String? message}) =
      _$SimpleResponseImpl;

  factory _SimpleResponse.fromJson(Map<String, dynamic> json) =
      _$SimpleResponseImpl.fromJson;

  /// Indicates whether the operation was successful.
  @override
  bool? get success;

  /// Message returned by the server, usually describing success or failure.
  @override
  String? get message;

  /// Create a copy of SimpleResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SimpleResponseImplCopyWith<_$SimpleResponseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
