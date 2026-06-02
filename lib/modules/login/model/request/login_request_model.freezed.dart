// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'login_request_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$LoginRequestModel {

/// Language identifier for the user's preferred language.
 int? get languageId;/// Platform identifier (e.g., "iOS", "Android", "Web").
 String? get platform;/// Application version.
 String? get version;/// User's email or mobile number for login.
 String? get emailMobile;/// User's password for authentication.
 String? get password;/// Indicates if this is a social login request.
 bool? get isSocialLogin;/// Type of social login (e.g., "google", "facebook", "apple").
 String? get socialLoginType;/// Apple authentication token for Apple Sign-In.
 String? get appleToken;/// Device identifier for tracking and analytics.
 String? get deviceId;/// Device token for push notifications (FCM token).
 String? get deviceToken;/// General authentication token.
 String? get token;
/// Create a copy of LoginRequestModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LoginRequestModelCopyWith<LoginRequestModel> get copyWith => _$LoginRequestModelCopyWithImpl<LoginRequestModel>(this as LoginRequestModel, _$identity);

  /// Serializes this LoginRequestModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LoginRequestModel&&(identical(other.languageId, languageId) || other.languageId == languageId)&&(identical(other.platform, platform) || other.platform == platform)&&(identical(other.version, version) || other.version == version)&&(identical(other.emailMobile, emailMobile) || other.emailMobile == emailMobile)&&(identical(other.password, password) || other.password == password)&&(identical(other.isSocialLogin, isSocialLogin) || other.isSocialLogin == isSocialLogin)&&(identical(other.socialLoginType, socialLoginType) || other.socialLoginType == socialLoginType)&&(identical(other.appleToken, appleToken) || other.appleToken == appleToken)&&(identical(other.deviceId, deviceId) || other.deviceId == deviceId)&&(identical(other.deviceToken, deviceToken) || other.deviceToken == deviceToken)&&(identical(other.token, token) || other.token == token));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,languageId,platform,version,emailMobile,password,isSocialLogin,socialLoginType,appleToken,deviceId,deviceToken,token);

@override
String toString() {
  return 'LoginRequestModel(languageId: $languageId, platform: $platform, version: $version, emailMobile: $emailMobile, password: $password, isSocialLogin: $isSocialLogin, socialLoginType: $socialLoginType, appleToken: $appleToken, deviceId: $deviceId, deviceToken: $deviceToken, token: $token)';
}


}

/// @nodoc
abstract mixin class $LoginRequestModelCopyWith<$Res>  {
  factory $LoginRequestModelCopyWith(LoginRequestModel value, $Res Function(LoginRequestModel) _then) = _$LoginRequestModelCopyWithImpl;
@useResult
$Res call({
 int? languageId, String? platform, String? version, String? emailMobile, String? password, bool? isSocialLogin, String? socialLoginType, String? appleToken, String? deviceId, String? deviceToken, String? token
});




}
/// @nodoc
class _$LoginRequestModelCopyWithImpl<$Res>
    implements $LoginRequestModelCopyWith<$Res> {
  _$LoginRequestModelCopyWithImpl(this._self, this._then);

  final LoginRequestModel _self;
  final $Res Function(LoginRequestModel) _then;

/// Create a copy of LoginRequestModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? languageId = freezed,Object? platform = freezed,Object? version = freezed,Object? emailMobile = freezed,Object? password = freezed,Object? isSocialLogin = freezed,Object? socialLoginType = freezed,Object? appleToken = freezed,Object? deviceId = freezed,Object? deviceToken = freezed,Object? token = freezed,}) {
  return _then(_self.copyWith(
languageId: freezed == languageId ? _self.languageId : languageId // ignore: cast_nullable_to_non_nullable
as int?,platform: freezed == platform ? _self.platform : platform // ignore: cast_nullable_to_non_nullable
as String?,version: freezed == version ? _self.version : version // ignore: cast_nullable_to_non_nullable
as String?,emailMobile: freezed == emailMobile ? _self.emailMobile : emailMobile // ignore: cast_nullable_to_non_nullable
as String?,password: freezed == password ? _self.password : password // ignore: cast_nullable_to_non_nullable
as String?,isSocialLogin: freezed == isSocialLogin ? _self.isSocialLogin : isSocialLogin // ignore: cast_nullable_to_non_nullable
as bool?,socialLoginType: freezed == socialLoginType ? _self.socialLoginType : socialLoginType // ignore: cast_nullable_to_non_nullable
as String?,appleToken: freezed == appleToken ? _self.appleToken : appleToken // ignore: cast_nullable_to_non_nullable
as String?,deviceId: freezed == deviceId ? _self.deviceId : deviceId // ignore: cast_nullable_to_non_nullable
as String?,deviceToken: freezed == deviceToken ? _self.deviceToken : deviceToken // ignore: cast_nullable_to_non_nullable
as String?,token: freezed == token ? _self.token : token // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [LoginRequestModel].
extension LoginRequestModelPatterns on LoginRequestModel {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _LoginRequestModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LoginRequestModel() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _LoginRequestModel value)  $default,){
final _that = this;
switch (_that) {
case _LoginRequestModel():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _LoginRequestModel value)?  $default,){
final _that = this;
switch (_that) {
case _LoginRequestModel() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int? languageId,  String? platform,  String? version,  String? emailMobile,  String? password,  bool? isSocialLogin,  String? socialLoginType,  String? appleToken,  String? deviceId,  String? deviceToken,  String? token)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LoginRequestModel() when $default != null:
return $default(_that.languageId,_that.platform,_that.version,_that.emailMobile,_that.password,_that.isSocialLogin,_that.socialLoginType,_that.appleToken,_that.deviceId,_that.deviceToken,_that.token);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int? languageId,  String? platform,  String? version,  String? emailMobile,  String? password,  bool? isSocialLogin,  String? socialLoginType,  String? appleToken,  String? deviceId,  String? deviceToken,  String? token)  $default,) {final _that = this;
switch (_that) {
case _LoginRequestModel():
return $default(_that.languageId,_that.platform,_that.version,_that.emailMobile,_that.password,_that.isSocialLogin,_that.socialLoginType,_that.appleToken,_that.deviceId,_that.deviceToken,_that.token);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int? languageId,  String? platform,  String? version,  String? emailMobile,  String? password,  bool? isSocialLogin,  String? socialLoginType,  String? appleToken,  String? deviceId,  String? deviceToken,  String? token)?  $default,) {final _that = this;
switch (_that) {
case _LoginRequestModel() when $default != null:
return $default(_that.languageId,_that.platform,_that.version,_that.emailMobile,_that.password,_that.isSocialLogin,_that.socialLoginType,_that.appleToken,_that.deviceId,_that.deviceToken,_that.token);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _LoginRequestModel implements LoginRequestModel {
  const _LoginRequestModel({this.languageId, this.platform, this.version, this.emailMobile, this.password, this.isSocialLogin, this.socialLoginType, this.appleToken, this.deviceId, this.deviceToken, this.token});
  factory _LoginRequestModel.fromJson(Map<String, dynamic> json) => _$LoginRequestModelFromJson(json);

/// Language identifier for the user's preferred language.
@override final  int? languageId;
/// Platform identifier (e.g., "iOS", "Android", "Web").
@override final  String? platform;
/// Application version.
@override final  String? version;
/// User's email or mobile number for login.
@override final  String? emailMobile;
/// User's password for authentication.
@override final  String? password;
/// Indicates if this is a social login request.
@override final  bool? isSocialLogin;
/// Type of social login (e.g., "google", "facebook", "apple").
@override final  String? socialLoginType;
/// Apple authentication token for Apple Sign-In.
@override final  String? appleToken;
/// Device identifier for tracking and analytics.
@override final  String? deviceId;
/// Device token for push notifications (FCM token).
@override final  String? deviceToken;
/// General authentication token.
@override final  String? token;

/// Create a copy of LoginRequestModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LoginRequestModelCopyWith<_LoginRequestModel> get copyWith => __$LoginRequestModelCopyWithImpl<_LoginRequestModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$LoginRequestModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LoginRequestModel&&(identical(other.languageId, languageId) || other.languageId == languageId)&&(identical(other.platform, platform) || other.platform == platform)&&(identical(other.version, version) || other.version == version)&&(identical(other.emailMobile, emailMobile) || other.emailMobile == emailMobile)&&(identical(other.password, password) || other.password == password)&&(identical(other.isSocialLogin, isSocialLogin) || other.isSocialLogin == isSocialLogin)&&(identical(other.socialLoginType, socialLoginType) || other.socialLoginType == socialLoginType)&&(identical(other.appleToken, appleToken) || other.appleToken == appleToken)&&(identical(other.deviceId, deviceId) || other.deviceId == deviceId)&&(identical(other.deviceToken, deviceToken) || other.deviceToken == deviceToken)&&(identical(other.token, token) || other.token == token));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,languageId,platform,version,emailMobile,password,isSocialLogin,socialLoginType,appleToken,deviceId,deviceToken,token);

@override
String toString() {
  return 'LoginRequestModel(languageId: $languageId, platform: $platform, version: $version, emailMobile: $emailMobile, password: $password, isSocialLogin: $isSocialLogin, socialLoginType: $socialLoginType, appleToken: $appleToken, deviceId: $deviceId, deviceToken: $deviceToken, token: $token)';
}


}

/// @nodoc
abstract mixin class _$LoginRequestModelCopyWith<$Res> implements $LoginRequestModelCopyWith<$Res> {
  factory _$LoginRequestModelCopyWith(_LoginRequestModel value, $Res Function(_LoginRequestModel) _then) = __$LoginRequestModelCopyWithImpl;
@override @useResult
$Res call({
 int? languageId, String? platform, String? version, String? emailMobile, String? password, bool? isSocialLogin, String? socialLoginType, String? appleToken, String? deviceId, String? deviceToken, String? token
});




}
/// @nodoc
class __$LoginRequestModelCopyWithImpl<$Res>
    implements _$LoginRequestModelCopyWith<$Res> {
  __$LoginRequestModelCopyWithImpl(this._self, this._then);

  final _LoginRequestModel _self;
  final $Res Function(_LoginRequestModel) _then;

/// Create a copy of LoginRequestModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? languageId = freezed,Object? platform = freezed,Object? version = freezed,Object? emailMobile = freezed,Object? password = freezed,Object? isSocialLogin = freezed,Object? socialLoginType = freezed,Object? appleToken = freezed,Object? deviceId = freezed,Object? deviceToken = freezed,Object? token = freezed,}) {
  return _then(_LoginRequestModel(
languageId: freezed == languageId ? _self.languageId : languageId // ignore: cast_nullable_to_non_nullable
as int?,platform: freezed == platform ? _self.platform : platform // ignore: cast_nullable_to_non_nullable
as String?,version: freezed == version ? _self.version : version // ignore: cast_nullable_to_non_nullable
as String?,emailMobile: freezed == emailMobile ? _self.emailMobile : emailMobile // ignore: cast_nullable_to_non_nullable
as String?,password: freezed == password ? _self.password : password // ignore: cast_nullable_to_non_nullable
as String?,isSocialLogin: freezed == isSocialLogin ? _self.isSocialLogin : isSocialLogin // ignore: cast_nullable_to_non_nullable
as bool?,socialLoginType: freezed == socialLoginType ? _self.socialLoginType : socialLoginType // ignore: cast_nullable_to_non_nullable
as String?,appleToken: freezed == appleToken ? _self.appleToken : appleToken // ignore: cast_nullable_to_non_nullable
as String?,deviceId: freezed == deviceId ? _self.deviceId : deviceId // ignore: cast_nullable_to_non_nullable
as String?,deviceToken: freezed == deviceToken ? _self.deviceToken : deviceToken // ignore: cast_nullable_to_non_nullable
as String?,token: freezed == token ? _self.token : token // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
