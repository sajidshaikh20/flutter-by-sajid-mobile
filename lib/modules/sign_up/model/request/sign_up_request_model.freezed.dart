// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'sign_up_request_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

SignupRequestModel _$SignupRequestModelFromJson(Map<String, dynamic> json) {
  return _SignupRequestModel.fromJson(json);
}

/// @nodoc
mixin _$SignupRequestModel {
  /// User's email address.
  String get email => throw _privateConstructorUsedError;

  /// User's first name.
  String get firstName => throw _privateConstructorUsedError;

  /// User's last name.
  String get lastName => throw _privateConstructorUsedError;

  /// Mobile number country prefix (e.g., "+1" for US).
  String get mobileNumberPrefix => throw _privateConstructorUsedError;

  /// User's mobile number.
  String get mobileNumber => throw _privateConstructorUsedError;

  /// User's nationality.
  String get Nationality => throw _privateConstructorUsedError;

  /// User's date of birth.
  String get dob => throw _privateConstructorUsedError;

  /// User's gender.
  String get gender => throw _privateConstructorUsedError;

  /// Referral code if applicable.
  String get referralCode => throw _privateConstructorUsedError;

  /// One-time password for verification.
  String get otp => throw _privateConstructorUsedError;

  /// User's password.
  String get password => throw _privateConstructorUsedError;

  /// Language ID for localization.
  int get languageId => throw _privateConstructorUsedError;

  /// Platform name (e.g., "iOS", "Android", "Web").
  String get platform => throw _privateConstructorUsedError;

  /// App version.
  String get version => throw _privateConstructorUsedError;

  /// Device identifier for tracking and analytics.
  String? get deviceId => throw _privateConstructorUsedError;

  /// Serializes this SignupRequestModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SignupRequestModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SignupRequestModelCopyWith<SignupRequestModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SignupRequestModelCopyWith<$Res> {
  factory $SignupRequestModelCopyWith(
          SignupRequestModel value, $Res Function(SignupRequestModel) then) =
      _$SignupRequestModelCopyWithImpl<$Res, SignupRequestModel>;
  @useResult
  $Res call(
      {String email,
      String firstName,
      String lastName,
      String mobileNumberPrefix,
      String mobileNumber,
      String Nationality,
      String dob,
      String gender,
      String referralCode,
      String otp,
      String password,
      int languageId,
      String platform,
      String version,
      String? deviceId});
}

/// @nodoc
class _$SignupRequestModelCopyWithImpl<$Res, $Val extends SignupRequestModel>
    implements $SignupRequestModelCopyWith<$Res> {
  _$SignupRequestModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SignupRequestModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? email = null,
    Object? firstName = null,
    Object? lastName = null,
    Object? mobileNumberPrefix = null,
    Object? mobileNumber = null,
    Object? Nationality = null,
    Object? dob = null,
    Object? gender = null,
    Object? referralCode = null,
    Object? otp = null,
    Object? password = null,
    Object? languageId = null,
    Object? platform = null,
    Object? version = null,
    Object? deviceId = freezed,
  }) {
    return _then(_value.copyWith(
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      firstName: null == firstName
          ? _value.firstName
          : firstName // ignore: cast_nullable_to_non_nullable
              as String,
      lastName: null == lastName
          ? _value.lastName
          : lastName // ignore: cast_nullable_to_non_nullable
              as String,
      mobileNumberPrefix: null == mobileNumberPrefix
          ? _value.mobileNumberPrefix
          : mobileNumberPrefix // ignore: cast_nullable_to_non_nullable
              as String,
      mobileNumber: null == mobileNumber
          ? _value.mobileNumber
          : mobileNumber // ignore: cast_nullable_to_non_nullable
              as String,
      Nationality: null == Nationality
          ? _value.Nationality
          : Nationality // ignore: cast_nullable_to_non_nullable
              as String,
      dob: null == dob
          ? _value.dob
          : dob // ignore: cast_nullable_to_non_nullable
              as String,
      gender: null == gender
          ? _value.gender
          : gender // ignore: cast_nullable_to_non_nullable
              as String,
      referralCode: null == referralCode
          ? _value.referralCode
          : referralCode // ignore: cast_nullable_to_non_nullable
              as String,
      otp: null == otp
          ? _value.otp
          : otp // ignore: cast_nullable_to_non_nullable
              as String,
      password: null == password
          ? _value.password
          : password // ignore: cast_nullable_to_non_nullable
              as String,
      languageId: null == languageId
          ? _value.languageId
          : languageId // ignore: cast_nullable_to_non_nullable
              as int,
      platform: null == platform
          ? _value.platform
          : platform // ignore: cast_nullable_to_non_nullable
              as String,
      version: null == version
          ? _value.version
          : version // ignore: cast_nullable_to_non_nullable
              as String,
      deviceId: freezed == deviceId
          ? _value.deviceId
          : deviceId // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SignupRequestModelImplCopyWith<$Res>
    implements $SignupRequestModelCopyWith<$Res> {
  factory _$$SignupRequestModelImplCopyWith(_$SignupRequestModelImpl value,
          $Res Function(_$SignupRequestModelImpl) then) =
      __$$SignupRequestModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String email,
      String firstName,
      String lastName,
      String mobileNumberPrefix,
      String mobileNumber,
      String Nationality,
      String dob,
      String gender,
      String referralCode,
      String otp,
      String password,
      int languageId,
      String platform,
      String version,
      String? deviceId});
}

/// @nodoc
class __$$SignupRequestModelImplCopyWithImpl<$Res>
    extends _$SignupRequestModelCopyWithImpl<$Res, _$SignupRequestModelImpl>
    implements _$$SignupRequestModelImplCopyWith<$Res> {
  __$$SignupRequestModelImplCopyWithImpl(_$SignupRequestModelImpl _value,
      $Res Function(_$SignupRequestModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of SignupRequestModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? email = null,
    Object? firstName = null,
    Object? lastName = null,
    Object? mobileNumberPrefix = null,
    Object? mobileNumber = null,
    Object? Nationality = null,
    Object? dob = null,
    Object? gender = null,
    Object? referralCode = null,
    Object? otp = null,
    Object? password = null,
    Object? languageId = null,
    Object? platform = null,
    Object? version = null,
    Object? deviceId = freezed,
  }) {
    return _then(_$SignupRequestModelImpl(
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      firstName: null == firstName
          ? _value.firstName
          : firstName // ignore: cast_nullable_to_non_nullable
              as String,
      lastName: null == lastName
          ? _value.lastName
          : lastName // ignore: cast_nullable_to_non_nullable
              as String,
      mobileNumberPrefix: null == mobileNumberPrefix
          ? _value.mobileNumberPrefix
          : mobileNumberPrefix // ignore: cast_nullable_to_non_nullable
              as String,
      mobileNumber: null == mobileNumber
          ? _value.mobileNumber
          : mobileNumber // ignore: cast_nullable_to_non_nullable
              as String,
      Nationality: null == Nationality
          ? _value.Nationality
          : Nationality // ignore: cast_nullable_to_non_nullable
              as String,
      dob: null == dob
          ? _value.dob
          : dob // ignore: cast_nullable_to_non_nullable
              as String,
      gender: null == gender
          ? _value.gender
          : gender // ignore: cast_nullable_to_non_nullable
              as String,
      referralCode: null == referralCode
          ? _value.referralCode
          : referralCode // ignore: cast_nullable_to_non_nullable
              as String,
      otp: null == otp
          ? _value.otp
          : otp // ignore: cast_nullable_to_non_nullable
              as String,
      password: null == password
          ? _value.password
          : password // ignore: cast_nullable_to_non_nullable
              as String,
      languageId: null == languageId
          ? _value.languageId
          : languageId // ignore: cast_nullable_to_non_nullable
              as int,
      platform: null == platform
          ? _value.platform
          : platform // ignore: cast_nullable_to_non_nullable
              as String,
      version: null == version
          ? _value.version
          : version // ignore: cast_nullable_to_non_nullable
              as String,
      deviceId: freezed == deviceId
          ? _value.deviceId
          : deviceId // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SignupRequestModelImpl implements _SignupRequestModel {
  const _$SignupRequestModelImpl(
      {required this.email,
      required this.firstName,
      required this.lastName,
      required this.mobileNumberPrefix,
      required this.mobileNumber,
      required this.Nationality,
      required this.dob,
      required this.gender,
      required this.referralCode,
      required this.otp,
      required this.password,
      required this.languageId,
      required this.platform,
      required this.version,
      this.deviceId});

  factory _$SignupRequestModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$SignupRequestModelImplFromJson(json);

  /// User's email address.
  @override
  final String email;

  /// User's first name.
  @override
  final String firstName;

  /// User's last name.
  @override
  final String lastName;

  /// Mobile number country prefix (e.g., "+1" for US).
  @override
  final String mobileNumberPrefix;

  /// User's mobile number.
  @override
  final String mobileNumber;

  /// User's nationality.
  @override
  final String Nationality;

  /// User's date of birth.
  @override
  final String dob;

  /// User's gender.
  @override
  final String gender;

  /// Referral code if applicable.
  @override
  final String referralCode;

  /// One-time password for verification.
  @override
  final String otp;

  /// User's password.
  @override
  final String password;

  /// Language ID for localization.
  @override
  final int languageId;

  /// Platform name (e.g., "iOS", "Android", "Web").
  @override
  final String platform;

  /// App version.
  @override
  final String version;

  /// Device identifier for tracking and analytics.
  @override
  final String? deviceId;

  @override
  String toString() {
    return 'SignupRequestModel(email: $email, firstName: $firstName, lastName: $lastName, mobileNumberPrefix: $mobileNumberPrefix, mobileNumber: $mobileNumber, Nationality: $Nationality, dob: $dob, gender: $gender, referralCode: $referralCode, otp: $otp, password: $password, languageId: $languageId, platform: $platform, version: $version, deviceId: $deviceId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SignupRequestModelImpl &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.firstName, firstName) ||
                other.firstName == firstName) &&
            (identical(other.lastName, lastName) ||
                other.lastName == lastName) &&
            (identical(other.mobileNumberPrefix, mobileNumberPrefix) ||
                other.mobileNumberPrefix == mobileNumberPrefix) &&
            (identical(other.mobileNumber, mobileNumber) ||
                other.mobileNumber == mobileNumber) &&
            (identical(other.Nationality, Nationality) ||
                other.Nationality == Nationality) &&
            (identical(other.dob, dob) || other.dob == dob) &&
            (identical(other.gender, gender) || other.gender == gender) &&
            (identical(other.referralCode, referralCode) ||
                other.referralCode == referralCode) &&
            (identical(other.otp, otp) || other.otp == otp) &&
            (identical(other.password, password) ||
                other.password == password) &&
            (identical(other.languageId, languageId) ||
                other.languageId == languageId) &&
            (identical(other.platform, platform) ||
                other.platform == platform) &&
            (identical(other.version, version) || other.version == version) &&
            (identical(other.deviceId, deviceId) ||
                other.deviceId == deviceId));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      email,
      firstName,
      lastName,
      mobileNumberPrefix,
      mobileNumber,
      Nationality,
      dob,
      gender,
      referralCode,
      otp,
      password,
      languageId,
      platform,
      version,
      deviceId);

  /// Create a copy of SignupRequestModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SignupRequestModelImplCopyWith<_$SignupRequestModelImpl> get copyWith =>
      __$$SignupRequestModelImplCopyWithImpl<_$SignupRequestModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SignupRequestModelImplToJson(
      this,
    );
  }
}

abstract class _SignupRequestModel implements SignupRequestModel {
  const factory _SignupRequestModel(
      {required final String email,
      required final String firstName,
      required final String lastName,
      required final String mobileNumberPrefix,
      required final String mobileNumber,
      required final String Nationality,
      required final String dob,
      required final String gender,
      required final String referralCode,
      required final String otp,
      required final String password,
      required final int languageId,
      required final String platform,
      required final String version,
      final String? deviceId}) = _$SignupRequestModelImpl;

  factory _SignupRequestModel.fromJson(Map<String, dynamic> json) =
      _$SignupRequestModelImpl.fromJson;

  /// User's email address.
  @override
  String get email;

  /// User's first name.
  @override
  String get firstName;

  /// User's last name.
  @override
  String get lastName;

  /// Mobile number country prefix (e.g., "+1" for US).
  @override
  String get mobileNumberPrefix;

  /// User's mobile number.
  @override
  String get mobileNumber;

  /// User's nationality.
  @override
  String get Nationality;

  /// User's date of birth.
  @override
  String get dob;

  /// User's gender.
  @override
  String get gender;

  /// Referral code if applicable.
  @override
  String get referralCode;

  /// One-time password for verification.
  @override
  String get otp;

  /// User's password.
  @override
  String get password;

  /// Language ID for localization.
  @override
  int get languageId;

  /// Platform name (e.g., "iOS", "Android", "Web").
  @override
  String get platform;

  /// App version.
  @override
  String get version;

  /// Device identifier for tracking and analytics.
  @override
  String? get deviceId;

  /// Create a copy of SignupRequestModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SignupRequestModelImplCopyWith<_$SignupRequestModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
