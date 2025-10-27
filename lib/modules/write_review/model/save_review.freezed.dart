// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'save_review.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

SaveReview _$SaveReviewFromJson(Map<String, dynamic> json) {
  return _SaveReview.fromJson(json);
}

/// @nodoc
mixin _$SaveReview {
  /// Indicates whether the review save operation was successful.
  bool get success => throw _privateConstructorUsedError;

  /// Message describing the result of the operation.
  String get message => throw _privateConstructorUsedError;

  /// Serializes this SaveReview to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SaveReview
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SaveReviewCopyWith<SaveReview> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SaveReviewCopyWith<$Res> {
  factory $SaveReviewCopyWith(
          SaveReview value, $Res Function(SaveReview) then) =
      _$SaveReviewCopyWithImpl<$Res, SaveReview>;
  @useResult
  $Res call({bool success, String message});
}

/// @nodoc
class _$SaveReviewCopyWithImpl<$Res, $Val extends SaveReview>
    implements $SaveReviewCopyWith<$Res> {
  _$SaveReviewCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SaveReview
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
abstract class _$$SaveReviewImplCopyWith<$Res>
    implements $SaveReviewCopyWith<$Res> {
  factory _$$SaveReviewImplCopyWith(
          _$SaveReviewImpl value, $Res Function(_$SaveReviewImpl) then) =
      __$$SaveReviewImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({bool success, String message});
}

/// @nodoc
class __$$SaveReviewImplCopyWithImpl<$Res>
    extends _$SaveReviewCopyWithImpl<$Res, _$SaveReviewImpl>
    implements _$$SaveReviewImplCopyWith<$Res> {
  __$$SaveReviewImplCopyWithImpl(
      _$SaveReviewImpl _value, $Res Function(_$SaveReviewImpl) _then)
      : super(_value, _then);

  /// Create a copy of SaveReview
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? success = null,
    Object? message = null,
  }) {
    return _then(_$SaveReviewImpl(
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
class _$SaveReviewImpl implements _SaveReview {
  const _$SaveReviewImpl({required this.success, required this.message});

  factory _$SaveReviewImpl.fromJson(Map<String, dynamic> json) =>
      _$$SaveReviewImplFromJson(json);

  /// Indicates whether the review save operation was successful.
  @override
  final bool success;

  /// Message describing the result of the operation.
  @override
  final String message;

  @override
  String toString() {
    return 'SaveReview(success: $success, message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SaveReviewImpl &&
            (identical(other.success, success) || other.success == success) &&
            (identical(other.message, message) || other.message == message));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, success, message);

  /// Create a copy of SaveReview
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SaveReviewImplCopyWith<_$SaveReviewImpl> get copyWith =>
      __$$SaveReviewImplCopyWithImpl<_$SaveReviewImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SaveReviewImplToJson(
      this,
    );
  }
}

abstract class _SaveReview implements SaveReview {
  const factory _SaveReview(
      {required final bool success,
      required final String message}) = _$SaveReviewImpl;

  factory _SaveReview.fromJson(Map<String, dynamic> json) =
      _$SaveReviewImpl.fromJson;

  /// Indicates whether the review save operation was successful.
  @override
  bool get success;

  /// Message describing the result of the operation.
  @override
  String get message;

  /// Create a copy of SaveReview
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SaveReviewImplCopyWith<_$SaveReviewImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
