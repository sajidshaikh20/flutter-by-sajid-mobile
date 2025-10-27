// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'chage_password_request_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ChangePasswordRequestModel _$ChangePasswordRequestModelFromJson(
    Map<String, dynamic> json) {
  return _ChangePasswordRequestModel.fromJson(json);
}

/// @nodoc
mixin _$ChangePasswordRequestModel {
  /// Customer authentication token.
  String get customerToken => throw _privateConstructorUsedError;

  /// Current password of the user.
  String get currentPassword => throw _privateConstructorUsedError;

  /// New password to update.
  String get newPassword => throw _privateConstructorUsedError;

  /// Serializes this ChangePasswordRequestModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ChangePasswordRequestModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ChangePasswordRequestModelCopyWith<ChangePasswordRequestModel>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ChangePasswordRequestModelCopyWith<$Res> {
  factory $ChangePasswordRequestModelCopyWith(ChangePasswordRequestModel value,
          $Res Function(ChangePasswordRequestModel) then) =
      _$ChangePasswordRequestModelCopyWithImpl<$Res,
          ChangePasswordRequestModel>;
  @useResult
  $Res call({String customerToken, String currentPassword, String newPassword});
}

/// @nodoc
class _$ChangePasswordRequestModelCopyWithImpl<$Res,
        $Val extends ChangePasswordRequestModel>
    implements $ChangePasswordRequestModelCopyWith<$Res> {
  _$ChangePasswordRequestModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ChangePasswordRequestModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? customerToken = null,
    Object? currentPassword = null,
    Object? newPassword = null,
  }) {
    return _then(_value.copyWith(
      customerToken: null == customerToken
          ? _value.customerToken
          : customerToken // ignore: cast_nullable_to_non_nullable
              as String,
      currentPassword: null == currentPassword
          ? _value.currentPassword
          : currentPassword // ignore: cast_nullable_to_non_nullable
              as String,
      newPassword: null == newPassword
          ? _value.newPassword
          : newPassword // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ChangePasswordRequestModelImplCopyWith<$Res>
    implements $ChangePasswordRequestModelCopyWith<$Res> {
  factory _$$ChangePasswordRequestModelImplCopyWith(
          _$ChangePasswordRequestModelImpl value,
          $Res Function(_$ChangePasswordRequestModelImpl) then) =
      __$$ChangePasswordRequestModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String customerToken, String currentPassword, String newPassword});
}

/// @nodoc
class __$$ChangePasswordRequestModelImplCopyWithImpl<$Res>
    extends _$ChangePasswordRequestModelCopyWithImpl<$Res,
        _$ChangePasswordRequestModelImpl>
    implements _$$ChangePasswordRequestModelImplCopyWith<$Res> {
  __$$ChangePasswordRequestModelImplCopyWithImpl(
      _$ChangePasswordRequestModelImpl _value,
      $Res Function(_$ChangePasswordRequestModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of ChangePasswordRequestModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? customerToken = null,
    Object? currentPassword = null,
    Object? newPassword = null,
  }) {
    return _then(_$ChangePasswordRequestModelImpl(
      customerToken: null == customerToken
          ? _value.customerToken
          : customerToken // ignore: cast_nullable_to_non_nullable
              as String,
      currentPassword: null == currentPassword
          ? _value.currentPassword
          : currentPassword // ignore: cast_nullable_to_non_nullable
              as String,
      newPassword: null == newPassword
          ? _value.newPassword
          : newPassword // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ChangePasswordRequestModelImpl implements _ChangePasswordRequestModel {
  const _$ChangePasswordRequestModelImpl(
      {required this.customerToken,
      required this.currentPassword,
      required this.newPassword});

  factory _$ChangePasswordRequestModelImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$ChangePasswordRequestModelImplFromJson(json);

  /// Customer authentication token.
  @override
  final String customerToken;

  /// Current password of the user.
  @override
  final String currentPassword;

  /// New password to update.
  @override
  final String newPassword;

  @override
  String toString() {
    return 'ChangePasswordRequestModel(customerToken: $customerToken, currentPassword: $currentPassword, newPassword: $newPassword)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ChangePasswordRequestModelImpl &&
            (identical(other.customerToken, customerToken) ||
                other.customerToken == customerToken) &&
            (identical(other.currentPassword, currentPassword) ||
                other.currentPassword == currentPassword) &&
            (identical(other.newPassword, newPassword) ||
                other.newPassword == newPassword));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, customerToken, currentPassword, newPassword);

  /// Create a copy of ChangePasswordRequestModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ChangePasswordRequestModelImplCopyWith<_$ChangePasswordRequestModelImpl>
      get copyWith => __$$ChangePasswordRequestModelImplCopyWithImpl<
          _$ChangePasswordRequestModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ChangePasswordRequestModelImplToJson(
      this,
    );
  }
}

abstract class _ChangePasswordRequestModel
    implements ChangePasswordRequestModel {
  const factory _ChangePasswordRequestModel(
      {required final String customerToken,
      required final String currentPassword,
      required final String newPassword}) = _$ChangePasswordRequestModelImpl;

  factory _ChangePasswordRequestModel.fromJson(Map<String, dynamic> json) =
      _$ChangePasswordRequestModelImpl.fromJson;

  /// Customer authentication token.
  @override
  String get customerToken;

  /// Current password of the user.
  @override
  String get currentPassword;

  /// New password to update.
  @override
  String get newPassword;

  /// Create a copy of ChangePasswordRequestModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ChangePasswordRequestModelImplCopyWith<_$ChangePasswordRequestModelImpl>
      get copyWith => throw _privateConstructorUsedError;
}
