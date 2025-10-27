// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'edit_profile_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

EditProfileModel _$EditProfileModelFromJson(Map<String, dynamic> json) {
  return _EditProfileModel.fromJson(json);
}

/// @nodoc
mixin _$EditProfileModel {
  /// Indicates if the API call was successful.
  bool? get success => throw _privateConstructorUsedError;

  /// Message returned from the API, e.g., success or error message.
  String? get message => throw _privateConstructorUsedError;

  /// Whether an OTP was sent as part of the profile update.
  bool? get otpSent => throw _privateConstructorUsedError;

  /// URL of the user's profile image.
  String? get profileImage => throw _privateConstructorUsedError;

  /// Name of the customer.
  String? get customerName => throw _privateConstructorUsedError;

  /// Serializes this EditProfileModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of EditProfileModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $EditProfileModelCopyWith<EditProfileModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EditProfileModelCopyWith<$Res> {
  factory $EditProfileModelCopyWith(
          EditProfileModel value, $Res Function(EditProfileModel) then) =
      _$EditProfileModelCopyWithImpl<$Res, EditProfileModel>;
  @useResult
  $Res call(
      {bool? success,
      String? message,
      bool? otpSent,
      String? profileImage,
      String? customerName});
}

/// @nodoc
class _$EditProfileModelCopyWithImpl<$Res, $Val extends EditProfileModel>
    implements $EditProfileModelCopyWith<$Res> {
  _$EditProfileModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of EditProfileModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? success = freezed,
    Object? message = freezed,
    Object? otpSent = freezed,
    Object? profileImage = freezed,
    Object? customerName = freezed,
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
      otpSent: freezed == otpSent
          ? _value.otpSent
          : otpSent // ignore: cast_nullable_to_non_nullable
              as bool?,
      profileImage: freezed == profileImage
          ? _value.profileImage
          : profileImage // ignore: cast_nullable_to_non_nullable
              as String?,
      customerName: freezed == customerName
          ? _value.customerName
          : customerName // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$EditProfileModelImplCopyWith<$Res>
    implements $EditProfileModelCopyWith<$Res> {
  factory _$$EditProfileModelImplCopyWith(_$EditProfileModelImpl value,
          $Res Function(_$EditProfileModelImpl) then) =
      __$$EditProfileModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {bool? success,
      String? message,
      bool? otpSent,
      String? profileImage,
      String? customerName});
}

/// @nodoc
class __$$EditProfileModelImplCopyWithImpl<$Res>
    extends _$EditProfileModelCopyWithImpl<$Res, _$EditProfileModelImpl>
    implements _$$EditProfileModelImplCopyWith<$Res> {
  __$$EditProfileModelImplCopyWithImpl(_$EditProfileModelImpl _value,
      $Res Function(_$EditProfileModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of EditProfileModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? success = freezed,
    Object? message = freezed,
    Object? otpSent = freezed,
    Object? profileImage = freezed,
    Object? customerName = freezed,
  }) {
    return _then(_$EditProfileModelImpl(
      success: freezed == success
          ? _value.success
          : success // ignore: cast_nullable_to_non_nullable
              as bool?,
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
      otpSent: freezed == otpSent
          ? _value.otpSent
          : otpSent // ignore: cast_nullable_to_non_nullable
              as bool?,
      profileImage: freezed == profileImage
          ? _value.profileImage
          : profileImage // ignore: cast_nullable_to_non_nullable
              as String?,
      customerName: freezed == customerName
          ? _value.customerName
          : customerName // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$EditProfileModelImpl implements _EditProfileModel {
  const _$EditProfileModelImpl(
      {this.success = false,
      this.message = '',
      this.otpSent = false,
      this.profileImage,
      this.customerName});

  factory _$EditProfileModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$EditProfileModelImplFromJson(json);

  /// Indicates if the API call was successful.
  @override
  @JsonKey()
  final bool? success;

  /// Message returned from the API, e.g., success or error message.
  @override
  @JsonKey()
  final String? message;

  /// Whether an OTP was sent as part of the profile update.
  @override
  @JsonKey()
  final bool? otpSent;

  /// URL of the user's profile image.
  @override
  final String? profileImage;

  /// Name of the customer.
  @override
  final String? customerName;

  @override
  String toString() {
    return 'EditProfileModel(success: $success, message: $message, otpSent: $otpSent, profileImage: $profileImage, customerName: $customerName)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EditProfileModelImpl &&
            (identical(other.success, success) || other.success == success) &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.otpSent, otpSent) || other.otpSent == otpSent) &&
            (identical(other.profileImage, profileImage) ||
                other.profileImage == profileImage) &&
            (identical(other.customerName, customerName) ||
                other.customerName == customerName));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, success, message, otpSent, profileImage, customerName);

  /// Create a copy of EditProfileModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$EditProfileModelImplCopyWith<_$EditProfileModelImpl> get copyWith =>
      __$$EditProfileModelImplCopyWithImpl<_$EditProfileModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$EditProfileModelImplToJson(
      this,
    );
  }
}

abstract class _EditProfileModel implements EditProfileModel {
  const factory _EditProfileModel(
      {final bool? success,
      final String? message,
      final bool? otpSent,
      final String? profileImage,
      final String? customerName}) = _$EditProfileModelImpl;

  factory _EditProfileModel.fromJson(Map<String, dynamic> json) =
      _$EditProfileModelImpl.fromJson;

  /// Indicates if the API call was successful.
  @override
  bool? get success;

  /// Message returned from the API, e.g., success or error message.
  @override
  String? get message;

  /// Whether an OTP was sent as part of the profile update.
  @override
  bool? get otpSent;

  /// URL of the user's profile image.
  @override
  String? get profileImage;

  /// Name of the customer.
  @override
  String? get customerName;

  /// Create a copy of EditProfileModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$EditProfileModelImplCopyWith<_$EditProfileModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
