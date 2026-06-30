// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'login_user_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$LoginUserResponse {

/// Nested user data returned from the backend.
 UserResponseData? get user;/// Unique user identifier.
 int? get id;/// User's display name.
 String? get name;/// User's login identifier (email/username).
 String? get login;/// User's phone number.
 String? get phoneNumber;/// Customer's full name.
 String? get customerName;/// Customer's email address.
 String? get customerEmail;/// Customer's unique identifier.
 String? get customerId;/// Authentication token for the customer.
 String? get customerToken;/// Access token returned from the login endpoint.
 String? get accessToken;/// Refresh token returned from the login endpoint.
 String? get refreshToken;/// Number of items in the user's cart.
 int? get cartCount;/// Quote identifier for the current session.
 dynamic get quoteId;/// Total value of all orders placed by the user.
 String? get totalOrderValue;/// Date of the user's last order.
 String? get lastOrderDate;/// Current wallet balance.
 String? get walletBalance;/// Current loyalty points balance.
 String? get loyaltyPoints;/// Total number of orders placed by the user.
 int? get totalOrder;/// User's referral code.
 String? get referralCode;/// User's gender.
 String? get gender;/// User's birthday.
 String? get birthday;/// User's nationality.
 String? get nationality;/// User's arabicNationality.
 String? get arabicNationality;/// Phone number prefix/country code.
 dynamic get prefix;
/// Create a copy of LoginUserResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LoginUserResponseCopyWith<LoginUserResponse> get copyWith => _$LoginUserResponseCopyWithImpl<LoginUserResponse>(this as LoginUserResponse, _$identity);

  /// Serializes this LoginUserResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LoginUserResponse&&(identical(other.user, user) || other.user == user)&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.login, login) || other.login == login)&&(identical(other.phoneNumber, phoneNumber) || other.phoneNumber == phoneNumber)&&(identical(other.customerName, customerName) || other.customerName == customerName)&&(identical(other.customerEmail, customerEmail) || other.customerEmail == customerEmail)&&(identical(other.customerId, customerId) || other.customerId == customerId)&&(identical(other.customerToken, customerToken) || other.customerToken == customerToken)&&(identical(other.accessToken, accessToken) || other.accessToken == accessToken)&&(identical(other.refreshToken, refreshToken) || other.refreshToken == refreshToken)&&(identical(other.cartCount, cartCount) || other.cartCount == cartCount)&&const DeepCollectionEquality().equals(other.quoteId, quoteId)&&(identical(other.totalOrderValue, totalOrderValue) || other.totalOrderValue == totalOrderValue)&&(identical(other.lastOrderDate, lastOrderDate) || other.lastOrderDate == lastOrderDate)&&(identical(other.walletBalance, walletBalance) || other.walletBalance == walletBalance)&&(identical(other.loyaltyPoints, loyaltyPoints) || other.loyaltyPoints == loyaltyPoints)&&(identical(other.totalOrder, totalOrder) || other.totalOrder == totalOrder)&&(identical(other.referralCode, referralCode) || other.referralCode == referralCode)&&(identical(other.gender, gender) || other.gender == gender)&&(identical(other.birthday, birthday) || other.birthday == birthday)&&(identical(other.nationality, nationality) || other.nationality == nationality)&&(identical(other.arabicNationality, arabicNationality) || other.arabicNationality == arabicNationality)&&const DeepCollectionEquality().equals(other.prefix, prefix));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,user,id,name,login,phoneNumber,customerName,customerEmail,customerId,customerToken,accessToken,refreshToken,cartCount,const DeepCollectionEquality().hash(quoteId),totalOrderValue,lastOrderDate,walletBalance,loyaltyPoints,totalOrder,referralCode,gender,birthday,nationality,arabicNationality,const DeepCollectionEquality().hash(prefix)]);

@override
String toString() {
  return 'LoginUserResponse(user: $user, id: $id, name: $name, login: $login, phoneNumber: $phoneNumber, customerName: $customerName, customerEmail: $customerEmail, customerId: $customerId, customerToken: $customerToken, accessToken: $accessToken, refreshToken: $refreshToken, cartCount: $cartCount, quoteId: $quoteId, totalOrderValue: $totalOrderValue, lastOrderDate: $lastOrderDate, walletBalance: $walletBalance, loyaltyPoints: $loyaltyPoints, totalOrder: $totalOrder, referralCode: $referralCode, gender: $gender, birthday: $birthday, nationality: $nationality, arabicNationality: $arabicNationality, prefix: $prefix)';
}


}

/// @nodoc
abstract mixin class $LoginUserResponseCopyWith<$Res>  {
  factory $LoginUserResponseCopyWith(LoginUserResponse value, $Res Function(LoginUserResponse) _then) = _$LoginUserResponseCopyWithImpl;
@useResult
$Res call({
 UserResponseData? user, int? id, String? name, String? login, String? phoneNumber, String? customerName, String? customerEmail, String? customerId, String? customerToken, String? accessToken, String? refreshToken, int? cartCount, dynamic quoteId, String? totalOrderValue, String? lastOrderDate, String? walletBalance, String? loyaltyPoints, int? totalOrder, String? referralCode, String? gender, String? birthday, String? nationality, String? arabicNationality, dynamic prefix
});


$UserResponseDataCopyWith<$Res>? get user;

}
/// @nodoc
class _$LoginUserResponseCopyWithImpl<$Res>
    implements $LoginUserResponseCopyWith<$Res> {
  _$LoginUserResponseCopyWithImpl(this._self, this._then);

  final LoginUserResponse _self;
  final $Res Function(LoginUserResponse) _then;

/// Create a copy of LoginUserResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? user = freezed,Object? id = freezed,Object? name = freezed,Object? login = freezed,Object? phoneNumber = freezed,Object? customerName = freezed,Object? customerEmail = freezed,Object? customerId = freezed,Object? customerToken = freezed,Object? accessToken = freezed,Object? refreshToken = freezed,Object? cartCount = freezed,Object? quoteId = freezed,Object? totalOrderValue = freezed,Object? lastOrderDate = freezed,Object? walletBalance = freezed,Object? loyaltyPoints = freezed,Object? totalOrder = freezed,Object? referralCode = freezed,Object? gender = freezed,Object? birthday = freezed,Object? nationality = freezed,Object? arabicNationality = freezed,Object? prefix = freezed,}) {
  return _then(_self.copyWith(
user: freezed == user ? _self.user : user // ignore: cast_nullable_to_non_nullable
as UserResponseData?,id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int?,name: freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String?,login: freezed == login ? _self.login : login // ignore: cast_nullable_to_non_nullable
as String?,phoneNumber: freezed == phoneNumber ? _self.phoneNumber : phoneNumber // ignore: cast_nullable_to_non_nullable
as String?,customerName: freezed == customerName ? _self.customerName : customerName // ignore: cast_nullable_to_non_nullable
as String?,customerEmail: freezed == customerEmail ? _self.customerEmail : customerEmail // ignore: cast_nullable_to_non_nullable
as String?,customerId: freezed == customerId ? _self.customerId : customerId // ignore: cast_nullable_to_non_nullable
as String?,customerToken: freezed == customerToken ? _self.customerToken : customerToken // ignore: cast_nullable_to_non_nullable
as String?,accessToken: freezed == accessToken ? _self.accessToken : accessToken // ignore: cast_nullable_to_non_nullable
as String?,refreshToken: freezed == refreshToken ? _self.refreshToken : refreshToken // ignore: cast_nullable_to_non_nullable
as String?,cartCount: freezed == cartCount ? _self.cartCount : cartCount // ignore: cast_nullable_to_non_nullable
as int?,quoteId: freezed == quoteId ? _self.quoteId : quoteId // ignore: cast_nullable_to_non_nullable
as dynamic,totalOrderValue: freezed == totalOrderValue ? _self.totalOrderValue : totalOrderValue // ignore: cast_nullable_to_non_nullable
as String?,lastOrderDate: freezed == lastOrderDate ? _self.lastOrderDate : lastOrderDate // ignore: cast_nullable_to_non_nullable
as String?,walletBalance: freezed == walletBalance ? _self.walletBalance : walletBalance // ignore: cast_nullable_to_non_nullable
as String?,loyaltyPoints: freezed == loyaltyPoints ? _self.loyaltyPoints : loyaltyPoints // ignore: cast_nullable_to_non_nullable
as String?,totalOrder: freezed == totalOrder ? _self.totalOrder : totalOrder // ignore: cast_nullable_to_non_nullable
as int?,referralCode: freezed == referralCode ? _self.referralCode : referralCode // ignore: cast_nullable_to_non_nullable
as String?,gender: freezed == gender ? _self.gender : gender // ignore: cast_nullable_to_non_nullable
as String?,birthday: freezed == birthday ? _self.birthday : birthday // ignore: cast_nullable_to_non_nullable
as String?,nationality: freezed == nationality ? _self.nationality : nationality // ignore: cast_nullable_to_non_nullable
as String?,arabicNationality: freezed == arabicNationality ? _self.arabicNationality : arabicNationality // ignore: cast_nullable_to_non_nullable
as String?,prefix: freezed == prefix ? _self.prefix : prefix // ignore: cast_nullable_to_non_nullable
as dynamic,
  ));
}
/// Create a copy of LoginUserResponse
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$UserResponseDataCopyWith<$Res>? get user {
    if (_self.user == null) {
    return null;
  }

  return $UserResponseDataCopyWith<$Res>(_self.user!, (value) {
    return _then(_self.copyWith(user: value));
  });
}
}


/// Adds pattern-matching-related methods to [LoginUserResponse].
extension LoginUserResponsePatterns on LoginUserResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _LoginUserResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LoginUserResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _LoginUserResponse value)  $default,){
final _that = this;
switch (_that) {
case _LoginUserResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _LoginUserResponse value)?  $default,){
final _that = this;
switch (_that) {
case _LoginUserResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( UserResponseData? user,  int? id,  String? name,  String? login,  String? phoneNumber,  String? customerName,  String? customerEmail,  String? customerId,  String? customerToken,  String? accessToken,  String? refreshToken,  int? cartCount,  dynamic quoteId,  String? totalOrderValue,  String? lastOrderDate,  String? walletBalance,  String? loyaltyPoints,  int? totalOrder,  String? referralCode,  String? gender,  String? birthday,  String? nationality,  String? arabicNationality,  dynamic prefix)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LoginUserResponse() when $default != null:
return $default(_that.user,_that.id,_that.name,_that.login,_that.phoneNumber,_that.customerName,_that.customerEmail,_that.customerId,_that.customerToken,_that.accessToken,_that.refreshToken,_that.cartCount,_that.quoteId,_that.totalOrderValue,_that.lastOrderDate,_that.walletBalance,_that.loyaltyPoints,_that.totalOrder,_that.referralCode,_that.gender,_that.birthday,_that.nationality,_that.arabicNationality,_that.prefix);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( UserResponseData? user,  int? id,  String? name,  String? login,  String? phoneNumber,  String? customerName,  String? customerEmail,  String? customerId,  String? customerToken,  String? accessToken,  String? refreshToken,  int? cartCount,  dynamic quoteId,  String? totalOrderValue,  String? lastOrderDate,  String? walletBalance,  String? loyaltyPoints,  int? totalOrder,  String? referralCode,  String? gender,  String? birthday,  String? nationality,  String? arabicNationality,  dynamic prefix)  $default,) {final _that = this;
switch (_that) {
case _LoginUserResponse():
return $default(_that.user,_that.id,_that.name,_that.login,_that.phoneNumber,_that.customerName,_that.customerEmail,_that.customerId,_that.customerToken,_that.accessToken,_that.refreshToken,_that.cartCount,_that.quoteId,_that.totalOrderValue,_that.lastOrderDate,_that.walletBalance,_that.loyaltyPoints,_that.totalOrder,_that.referralCode,_that.gender,_that.birthday,_that.nationality,_that.arabicNationality,_that.prefix);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( UserResponseData? user,  int? id,  String? name,  String? login,  String? phoneNumber,  String? customerName,  String? customerEmail,  String? customerId,  String? customerToken,  String? accessToken,  String? refreshToken,  int? cartCount,  dynamic quoteId,  String? totalOrderValue,  String? lastOrderDate,  String? walletBalance,  String? loyaltyPoints,  int? totalOrder,  String? referralCode,  String? gender,  String? birthday,  String? nationality,  String? arabicNationality,  dynamic prefix)?  $default,) {final _that = this;
switch (_that) {
case _LoginUserResponse() when $default != null:
return $default(_that.user,_that.id,_that.name,_that.login,_that.phoneNumber,_that.customerName,_that.customerEmail,_that.customerId,_that.customerToken,_that.accessToken,_that.refreshToken,_that.cartCount,_that.quoteId,_that.totalOrderValue,_that.lastOrderDate,_that.walletBalance,_that.loyaltyPoints,_that.totalOrder,_that.referralCode,_that.gender,_that.birthday,_that.nationality,_that.arabicNationality,_that.prefix);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _LoginUserResponse implements LoginUserResponse {
  const _LoginUserResponse({this.user, this.id, this.name, this.login, this.phoneNumber, this.customerName, this.customerEmail, this.customerId, this.customerToken, this.accessToken, this.refreshToken, this.cartCount, this.quoteId, this.totalOrderValue, this.lastOrderDate, this.walletBalance, this.loyaltyPoints, this.totalOrder, this.referralCode, this.gender, this.birthday, this.nationality, this.arabicNationality, this.prefix});
  factory _LoginUserResponse.fromJson(Map<String, dynamic> json) => _$LoginUserResponseFromJson(json);

/// Nested user data returned from the backend.
@override final  UserResponseData? user;
/// Unique user identifier.
@override final  int? id;
/// User's display name.
@override final  String? name;
/// User's login identifier (email/username).
@override final  String? login;
/// User's phone number.
@override final  String? phoneNumber;
/// Customer's full name.
@override final  String? customerName;
/// Customer's email address.
@override final  String? customerEmail;
/// Customer's unique identifier.
@override final  String? customerId;
/// Authentication token for the customer.
@override final  String? customerToken;
/// Access token returned from the login endpoint.
@override final  String? accessToken;
/// Refresh token returned from the login endpoint.
@override final  String? refreshToken;
/// Number of items in the user's cart.
@override final  int? cartCount;
/// Quote identifier for the current session.
@override final  dynamic quoteId;
/// Total value of all orders placed by the user.
@override final  String? totalOrderValue;
/// Date of the user's last order.
@override final  String? lastOrderDate;
/// Current wallet balance.
@override final  String? walletBalance;
/// Current loyalty points balance.
@override final  String? loyaltyPoints;
/// Total number of orders placed by the user.
@override final  int? totalOrder;
/// User's referral code.
@override final  String? referralCode;
/// User's gender.
@override final  String? gender;
/// User's birthday.
@override final  String? birthday;
/// User's nationality.
@override final  String? nationality;
/// User's arabicNationality.
@override final  String? arabicNationality;
/// Phone number prefix/country code.
@override final  dynamic prefix;

/// Create a copy of LoginUserResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LoginUserResponseCopyWith<_LoginUserResponse> get copyWith => __$LoginUserResponseCopyWithImpl<_LoginUserResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$LoginUserResponseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LoginUserResponse&&(identical(other.user, user) || other.user == user)&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.login, login) || other.login == login)&&(identical(other.phoneNumber, phoneNumber) || other.phoneNumber == phoneNumber)&&(identical(other.customerName, customerName) || other.customerName == customerName)&&(identical(other.customerEmail, customerEmail) || other.customerEmail == customerEmail)&&(identical(other.customerId, customerId) || other.customerId == customerId)&&(identical(other.customerToken, customerToken) || other.customerToken == customerToken)&&(identical(other.accessToken, accessToken) || other.accessToken == accessToken)&&(identical(other.refreshToken, refreshToken) || other.refreshToken == refreshToken)&&(identical(other.cartCount, cartCount) || other.cartCount == cartCount)&&const DeepCollectionEquality().equals(other.quoteId, quoteId)&&(identical(other.totalOrderValue, totalOrderValue) || other.totalOrderValue == totalOrderValue)&&(identical(other.lastOrderDate, lastOrderDate) || other.lastOrderDate == lastOrderDate)&&(identical(other.walletBalance, walletBalance) || other.walletBalance == walletBalance)&&(identical(other.loyaltyPoints, loyaltyPoints) || other.loyaltyPoints == loyaltyPoints)&&(identical(other.totalOrder, totalOrder) || other.totalOrder == totalOrder)&&(identical(other.referralCode, referralCode) || other.referralCode == referralCode)&&(identical(other.gender, gender) || other.gender == gender)&&(identical(other.birthday, birthday) || other.birthday == birthday)&&(identical(other.nationality, nationality) || other.nationality == nationality)&&(identical(other.arabicNationality, arabicNationality) || other.arabicNationality == arabicNationality)&&const DeepCollectionEquality().equals(other.prefix, prefix));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,user,id,name,login,phoneNumber,customerName,customerEmail,customerId,customerToken,accessToken,refreshToken,cartCount,const DeepCollectionEquality().hash(quoteId),totalOrderValue,lastOrderDate,walletBalance,loyaltyPoints,totalOrder,referralCode,gender,birthday,nationality,arabicNationality,const DeepCollectionEquality().hash(prefix)]);

@override
String toString() {
  return 'LoginUserResponse(user: $user, id: $id, name: $name, login: $login, phoneNumber: $phoneNumber, customerName: $customerName, customerEmail: $customerEmail, customerId: $customerId, customerToken: $customerToken, accessToken: $accessToken, refreshToken: $refreshToken, cartCount: $cartCount, quoteId: $quoteId, totalOrderValue: $totalOrderValue, lastOrderDate: $lastOrderDate, walletBalance: $walletBalance, loyaltyPoints: $loyaltyPoints, totalOrder: $totalOrder, referralCode: $referralCode, gender: $gender, birthday: $birthday, nationality: $nationality, arabicNationality: $arabicNationality, prefix: $prefix)';
}


}

/// @nodoc
abstract mixin class _$LoginUserResponseCopyWith<$Res> implements $LoginUserResponseCopyWith<$Res> {
  factory _$LoginUserResponseCopyWith(_LoginUserResponse value, $Res Function(_LoginUserResponse) _then) = __$LoginUserResponseCopyWithImpl;
@override @useResult
$Res call({
 UserResponseData? user, int? id, String? name, String? login, String? phoneNumber, String? customerName, String? customerEmail, String? customerId, String? customerToken, String? accessToken, String? refreshToken, int? cartCount, dynamic quoteId, String? totalOrderValue, String? lastOrderDate, String? walletBalance, String? loyaltyPoints, int? totalOrder, String? referralCode, String? gender, String? birthday, String? nationality, String? arabicNationality, dynamic prefix
});


@override $UserResponseDataCopyWith<$Res>? get user;

}
/// @nodoc
class __$LoginUserResponseCopyWithImpl<$Res>
    implements _$LoginUserResponseCopyWith<$Res> {
  __$LoginUserResponseCopyWithImpl(this._self, this._then);

  final _LoginUserResponse _self;
  final $Res Function(_LoginUserResponse) _then;

/// Create a copy of LoginUserResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? user = freezed,Object? id = freezed,Object? name = freezed,Object? login = freezed,Object? phoneNumber = freezed,Object? customerName = freezed,Object? customerEmail = freezed,Object? customerId = freezed,Object? customerToken = freezed,Object? accessToken = freezed,Object? refreshToken = freezed,Object? cartCount = freezed,Object? quoteId = freezed,Object? totalOrderValue = freezed,Object? lastOrderDate = freezed,Object? walletBalance = freezed,Object? loyaltyPoints = freezed,Object? totalOrder = freezed,Object? referralCode = freezed,Object? gender = freezed,Object? birthday = freezed,Object? nationality = freezed,Object? arabicNationality = freezed,Object? prefix = freezed,}) {
  return _then(_LoginUserResponse(
user: freezed == user ? _self.user : user // ignore: cast_nullable_to_non_nullable
as UserResponseData?,id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int?,name: freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String?,login: freezed == login ? _self.login : login // ignore: cast_nullable_to_non_nullable
as String?,phoneNumber: freezed == phoneNumber ? _self.phoneNumber : phoneNumber // ignore: cast_nullable_to_non_nullable
as String?,customerName: freezed == customerName ? _self.customerName : customerName // ignore: cast_nullable_to_non_nullable
as String?,customerEmail: freezed == customerEmail ? _self.customerEmail : customerEmail // ignore: cast_nullable_to_non_nullable
as String?,customerId: freezed == customerId ? _self.customerId : customerId // ignore: cast_nullable_to_non_nullable
as String?,customerToken: freezed == customerToken ? _self.customerToken : customerToken // ignore: cast_nullable_to_non_nullable
as String?,accessToken: freezed == accessToken ? _self.accessToken : accessToken // ignore: cast_nullable_to_non_nullable
as String?,refreshToken: freezed == refreshToken ? _self.refreshToken : refreshToken // ignore: cast_nullable_to_non_nullable
as String?,cartCount: freezed == cartCount ? _self.cartCount : cartCount // ignore: cast_nullable_to_non_nullable
as int?,quoteId: freezed == quoteId ? _self.quoteId : quoteId // ignore: cast_nullable_to_non_nullable
as dynamic,totalOrderValue: freezed == totalOrderValue ? _self.totalOrderValue : totalOrderValue // ignore: cast_nullable_to_non_nullable
as String?,lastOrderDate: freezed == lastOrderDate ? _self.lastOrderDate : lastOrderDate // ignore: cast_nullable_to_non_nullable
as String?,walletBalance: freezed == walletBalance ? _self.walletBalance : walletBalance // ignore: cast_nullable_to_non_nullable
as String?,loyaltyPoints: freezed == loyaltyPoints ? _self.loyaltyPoints : loyaltyPoints // ignore: cast_nullable_to_non_nullable
as String?,totalOrder: freezed == totalOrder ? _self.totalOrder : totalOrder // ignore: cast_nullable_to_non_nullable
as int?,referralCode: freezed == referralCode ? _self.referralCode : referralCode // ignore: cast_nullable_to_non_nullable
as String?,gender: freezed == gender ? _self.gender : gender // ignore: cast_nullable_to_non_nullable
as String?,birthday: freezed == birthday ? _self.birthday : birthday // ignore: cast_nullable_to_non_nullable
as String?,nationality: freezed == nationality ? _self.nationality : nationality // ignore: cast_nullable_to_non_nullable
as String?,arabicNationality: freezed == arabicNationality ? _self.arabicNationality : arabicNationality // ignore: cast_nullable_to_non_nullable
as String?,prefix: freezed == prefix ? _self.prefix : prefix // ignore: cast_nullable_to_non_nullable
as dynamic,
  ));
}

/// Create a copy of LoginUserResponse
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$UserResponseDataCopyWith<$Res>? get user {
    if (_self.user == null) {
    return null;
  }

  return $UserResponseDataCopyWith<$Res>(_self.user!, (value) {
    return _then(_self.copyWith(user: value));
  });
}
}


/// @nodoc
mixin _$UserResponseData {

 String? get publicId; String? get name; String? get email; String? get username; String? get countryCode; String? get phone; UserRoleData? get role; UserSubscriptionData? get activeSubscription; String? get profilePictureUrl;
/// Create a copy of UserResponseData
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UserResponseDataCopyWith<UserResponseData> get copyWith => _$UserResponseDataCopyWithImpl<UserResponseData>(this as UserResponseData, _$identity);

  /// Serializes this UserResponseData to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UserResponseData&&(identical(other.publicId, publicId) || other.publicId == publicId)&&(identical(other.name, name) || other.name == name)&&(identical(other.email, email) || other.email == email)&&(identical(other.username, username) || other.username == username)&&(identical(other.countryCode, countryCode) || other.countryCode == countryCode)&&(identical(other.phone, phone) || other.phone == phone)&&(identical(other.role, role) || other.role == role)&&(identical(other.activeSubscription, activeSubscription) || other.activeSubscription == activeSubscription)&&(identical(other.profilePictureUrl, profilePictureUrl) || other.profilePictureUrl == profilePictureUrl));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,publicId,name,email,username,countryCode,phone,role,activeSubscription,profilePictureUrl);

@override
String toString() {
  return 'UserResponseData(publicId: $publicId, name: $name, email: $email, username: $username, countryCode: $countryCode, phone: $phone, role: $role, activeSubscription: $activeSubscription, profilePictureUrl: $profilePictureUrl)';
}


}

/// @nodoc
abstract mixin class $UserResponseDataCopyWith<$Res>  {
  factory $UserResponseDataCopyWith(UserResponseData value, $Res Function(UserResponseData) _then) = _$UserResponseDataCopyWithImpl;
@useResult
$Res call({
 String? publicId, String? name, String? email, String? username, String? countryCode, String? phone, UserRoleData? role, UserSubscriptionData? activeSubscription, String? profilePictureUrl
});


$UserRoleDataCopyWith<$Res>? get role;$UserSubscriptionDataCopyWith<$Res>? get activeSubscription;

}
/// @nodoc
class _$UserResponseDataCopyWithImpl<$Res>
    implements $UserResponseDataCopyWith<$Res> {
  _$UserResponseDataCopyWithImpl(this._self, this._then);

  final UserResponseData _self;
  final $Res Function(UserResponseData) _then;

/// Create a copy of UserResponseData
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? publicId = freezed,Object? name = freezed,Object? email = freezed,Object? username = freezed,Object? countryCode = freezed,Object? phone = freezed,Object? role = freezed,Object? activeSubscription = freezed,Object? profilePictureUrl = freezed,}) {
  return _then(_self.copyWith(
publicId: freezed == publicId ? _self.publicId : publicId // ignore: cast_nullable_to_non_nullable
as String?,name: freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String?,email: freezed == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String?,username: freezed == username ? _self.username : username // ignore: cast_nullable_to_non_nullable
as String?,countryCode: freezed == countryCode ? _self.countryCode : countryCode // ignore: cast_nullable_to_non_nullable
as String?,phone: freezed == phone ? _self.phone : phone // ignore: cast_nullable_to_non_nullable
as String?,role: freezed == role ? _self.role : role // ignore: cast_nullable_to_non_nullable
as UserRoleData?,activeSubscription: freezed == activeSubscription ? _self.activeSubscription : activeSubscription // ignore: cast_nullable_to_non_nullable
as UserSubscriptionData?,profilePictureUrl: freezed == profilePictureUrl ? _self.profilePictureUrl : profilePictureUrl // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}
/// Create a copy of UserResponseData
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$UserRoleDataCopyWith<$Res>? get role {
    if (_self.role == null) {
    return null;
  }

  return $UserRoleDataCopyWith<$Res>(_self.role!, (value) {
    return _then(_self.copyWith(role: value));
  });
}/// Create a copy of UserResponseData
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$UserSubscriptionDataCopyWith<$Res>? get activeSubscription {
    if (_self.activeSubscription == null) {
    return null;
  }

  return $UserSubscriptionDataCopyWith<$Res>(_self.activeSubscription!, (value) {
    return _then(_self.copyWith(activeSubscription: value));
  });
}
}


/// Adds pattern-matching-related methods to [UserResponseData].
extension UserResponseDataPatterns on UserResponseData {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _UserResponseData value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _UserResponseData() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _UserResponseData value)  $default,){
final _that = this;
switch (_that) {
case _UserResponseData():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _UserResponseData value)?  $default,){
final _that = this;
switch (_that) {
case _UserResponseData() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? publicId,  String? name,  String? email,  String? username,  String? countryCode,  String? phone,  UserRoleData? role,  UserSubscriptionData? activeSubscription,  String? profilePictureUrl)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _UserResponseData() when $default != null:
return $default(_that.publicId,_that.name,_that.email,_that.username,_that.countryCode,_that.phone,_that.role,_that.activeSubscription,_that.profilePictureUrl);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? publicId,  String? name,  String? email,  String? username,  String? countryCode,  String? phone,  UserRoleData? role,  UserSubscriptionData? activeSubscription,  String? profilePictureUrl)  $default,) {final _that = this;
switch (_that) {
case _UserResponseData():
return $default(_that.publicId,_that.name,_that.email,_that.username,_that.countryCode,_that.phone,_that.role,_that.activeSubscription,_that.profilePictureUrl);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? publicId,  String? name,  String? email,  String? username,  String? countryCode,  String? phone,  UserRoleData? role,  UserSubscriptionData? activeSubscription,  String? profilePictureUrl)?  $default,) {final _that = this;
switch (_that) {
case _UserResponseData() when $default != null:
return $default(_that.publicId,_that.name,_that.email,_that.username,_that.countryCode,_that.phone,_that.role,_that.activeSubscription,_that.profilePictureUrl);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _UserResponseData implements UserResponseData {
  const _UserResponseData({this.publicId, this.name, this.email, this.username, this.countryCode, this.phone, this.role, this.activeSubscription, this.profilePictureUrl});
  factory _UserResponseData.fromJson(Map<String, dynamic> json) => _$UserResponseDataFromJson(json);

@override final  String? publicId;
@override final  String? name;
@override final  String? email;
@override final  String? username;
@override final  String? countryCode;
@override final  String? phone;
@override final  UserRoleData? role;
@override final  UserSubscriptionData? activeSubscription;
@override final  String? profilePictureUrl;

/// Create a copy of UserResponseData
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UserResponseDataCopyWith<_UserResponseData> get copyWith => __$UserResponseDataCopyWithImpl<_UserResponseData>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$UserResponseDataToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UserResponseData&&(identical(other.publicId, publicId) || other.publicId == publicId)&&(identical(other.name, name) || other.name == name)&&(identical(other.email, email) || other.email == email)&&(identical(other.username, username) || other.username == username)&&(identical(other.countryCode, countryCode) || other.countryCode == countryCode)&&(identical(other.phone, phone) || other.phone == phone)&&(identical(other.role, role) || other.role == role)&&(identical(other.activeSubscription, activeSubscription) || other.activeSubscription == activeSubscription)&&(identical(other.profilePictureUrl, profilePictureUrl) || other.profilePictureUrl == profilePictureUrl));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,publicId,name,email,username,countryCode,phone,role,activeSubscription,profilePictureUrl);

@override
String toString() {
  return 'UserResponseData(publicId: $publicId, name: $name, email: $email, username: $username, countryCode: $countryCode, phone: $phone, role: $role, activeSubscription: $activeSubscription, profilePictureUrl: $profilePictureUrl)';
}


}

/// @nodoc
abstract mixin class _$UserResponseDataCopyWith<$Res> implements $UserResponseDataCopyWith<$Res> {
  factory _$UserResponseDataCopyWith(_UserResponseData value, $Res Function(_UserResponseData) _then) = __$UserResponseDataCopyWithImpl;
@override @useResult
$Res call({
 String? publicId, String? name, String? email, String? username, String? countryCode, String? phone, UserRoleData? role, UserSubscriptionData? activeSubscription, String? profilePictureUrl
});


@override $UserRoleDataCopyWith<$Res>? get role;@override $UserSubscriptionDataCopyWith<$Res>? get activeSubscription;

}
/// @nodoc
class __$UserResponseDataCopyWithImpl<$Res>
    implements _$UserResponseDataCopyWith<$Res> {
  __$UserResponseDataCopyWithImpl(this._self, this._then);

  final _UserResponseData _self;
  final $Res Function(_UserResponseData) _then;

/// Create a copy of UserResponseData
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? publicId = freezed,Object? name = freezed,Object? email = freezed,Object? username = freezed,Object? countryCode = freezed,Object? phone = freezed,Object? role = freezed,Object? activeSubscription = freezed,Object? profilePictureUrl = freezed,}) {
  return _then(_UserResponseData(
publicId: freezed == publicId ? _self.publicId : publicId // ignore: cast_nullable_to_non_nullable
as String?,name: freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String?,email: freezed == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String?,username: freezed == username ? _self.username : username // ignore: cast_nullable_to_non_nullable
as String?,countryCode: freezed == countryCode ? _self.countryCode : countryCode // ignore: cast_nullable_to_non_nullable
as String?,phone: freezed == phone ? _self.phone : phone // ignore: cast_nullable_to_non_nullable
as String?,role: freezed == role ? _self.role : role // ignore: cast_nullable_to_non_nullable
as UserRoleData?,activeSubscription: freezed == activeSubscription ? _self.activeSubscription : activeSubscription // ignore: cast_nullable_to_non_nullable
as UserSubscriptionData?,profilePictureUrl: freezed == profilePictureUrl ? _self.profilePictureUrl : profilePictureUrl // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

/// Create a copy of UserResponseData
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$UserRoleDataCopyWith<$Res>? get role {
    if (_self.role == null) {
    return null;
  }

  return $UserRoleDataCopyWith<$Res>(_self.role!, (value) {
    return _then(_self.copyWith(role: value));
  });
}/// Create a copy of UserResponseData
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$UserSubscriptionDataCopyWith<$Res>? get activeSubscription {
    if (_self.activeSubscription == null) {
    return null;
  }

  return $UserSubscriptionDataCopyWith<$Res>(_self.activeSubscription!, (value) {
    return _then(_self.copyWith(activeSubscription: value));
  });
}
}


/// @nodoc
mixin _$UserRoleData {

 int? get id; String? get name;
/// Create a copy of UserRoleData
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UserRoleDataCopyWith<UserRoleData> get copyWith => _$UserRoleDataCopyWithImpl<UserRoleData>(this as UserRoleData, _$identity);

  /// Serializes this UserRoleData to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UserRoleData&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name);

@override
String toString() {
  return 'UserRoleData(id: $id, name: $name)';
}


}

/// @nodoc
abstract mixin class $UserRoleDataCopyWith<$Res>  {
  factory $UserRoleDataCopyWith(UserRoleData value, $Res Function(UserRoleData) _then) = _$UserRoleDataCopyWithImpl;
@useResult
$Res call({
 int? id, String? name
});




}
/// @nodoc
class _$UserRoleDataCopyWithImpl<$Res>
    implements $UserRoleDataCopyWith<$Res> {
  _$UserRoleDataCopyWithImpl(this._self, this._then);

  final UserRoleData _self;
  final $Res Function(UserRoleData) _then;

/// Create a copy of UserRoleData
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = freezed,Object? name = freezed,}) {
  return _then(_self.copyWith(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int?,name: freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [UserRoleData].
extension UserRoleDataPatterns on UserRoleData {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _UserRoleData value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _UserRoleData() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _UserRoleData value)  $default,){
final _that = this;
switch (_that) {
case _UserRoleData():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _UserRoleData value)?  $default,){
final _that = this;
switch (_that) {
case _UserRoleData() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int? id,  String? name)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _UserRoleData() when $default != null:
return $default(_that.id,_that.name);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int? id,  String? name)  $default,) {final _that = this;
switch (_that) {
case _UserRoleData():
return $default(_that.id,_that.name);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int? id,  String? name)?  $default,) {final _that = this;
switch (_that) {
case _UserRoleData() when $default != null:
return $default(_that.id,_that.name);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _UserRoleData implements UserRoleData {
  const _UserRoleData({this.id, this.name});
  factory _UserRoleData.fromJson(Map<String, dynamic> json) => _$UserRoleDataFromJson(json);

@override final  int? id;
@override final  String? name;

/// Create a copy of UserRoleData
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UserRoleDataCopyWith<_UserRoleData> get copyWith => __$UserRoleDataCopyWithImpl<_UserRoleData>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$UserRoleDataToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UserRoleData&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name);

@override
String toString() {
  return 'UserRoleData(id: $id, name: $name)';
}


}

/// @nodoc
abstract mixin class _$UserRoleDataCopyWith<$Res> implements $UserRoleDataCopyWith<$Res> {
  factory _$UserRoleDataCopyWith(_UserRoleData value, $Res Function(_UserRoleData) _then) = __$UserRoleDataCopyWithImpl;
@override @useResult
$Res call({
 int? id, String? name
});




}
/// @nodoc
class __$UserRoleDataCopyWithImpl<$Res>
    implements _$UserRoleDataCopyWith<$Res> {
  __$UserRoleDataCopyWithImpl(this._self, this._then);

  final _UserRoleData _self;
  final $Res Function(_UserRoleData) _then;

/// Create a copy of UserRoleData
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = freezed,Object? name = freezed,}) {
  return _then(_UserRoleData(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int?,name: freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$UserSubscriptionData {

 String? get subscriptionPublicId; String? get planName; String? get planCode; String? get category; String? get billingCycle; dynamic get amount; String? get currencyCode; String? get paymentStatus; String? get subscriptionStatus; String? get startDate; String? get endDate; bool? get isActive; int? get durationDays;
/// Create a copy of UserSubscriptionData
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UserSubscriptionDataCopyWith<UserSubscriptionData> get copyWith => _$UserSubscriptionDataCopyWithImpl<UserSubscriptionData>(this as UserSubscriptionData, _$identity);

  /// Serializes this UserSubscriptionData to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UserSubscriptionData&&(identical(other.subscriptionPublicId, subscriptionPublicId) || other.subscriptionPublicId == subscriptionPublicId)&&(identical(other.planName, planName) || other.planName == planName)&&(identical(other.planCode, planCode) || other.planCode == planCode)&&(identical(other.category, category) || other.category == category)&&(identical(other.billingCycle, billingCycle) || other.billingCycle == billingCycle)&&const DeepCollectionEquality().equals(other.amount, amount)&&(identical(other.currencyCode, currencyCode) || other.currencyCode == currencyCode)&&(identical(other.paymentStatus, paymentStatus) || other.paymentStatus == paymentStatus)&&(identical(other.subscriptionStatus, subscriptionStatus) || other.subscriptionStatus == subscriptionStatus)&&(identical(other.startDate, startDate) || other.startDate == startDate)&&(identical(other.endDate, endDate) || other.endDate == endDate)&&(identical(other.isActive, isActive) || other.isActive == isActive)&&(identical(other.durationDays, durationDays) || other.durationDays == durationDays));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,subscriptionPublicId,planName,planCode,category,billingCycle,const DeepCollectionEquality().hash(amount),currencyCode,paymentStatus,subscriptionStatus,startDate,endDate,isActive,durationDays);

@override
String toString() {
  return 'UserSubscriptionData(subscriptionPublicId: $subscriptionPublicId, planName: $planName, planCode: $planCode, category: $category, billingCycle: $billingCycle, amount: $amount, currencyCode: $currencyCode, paymentStatus: $paymentStatus, subscriptionStatus: $subscriptionStatus, startDate: $startDate, endDate: $endDate, isActive: $isActive, durationDays: $durationDays)';
}


}

/// @nodoc
abstract mixin class $UserSubscriptionDataCopyWith<$Res>  {
  factory $UserSubscriptionDataCopyWith(UserSubscriptionData value, $Res Function(UserSubscriptionData) _then) = _$UserSubscriptionDataCopyWithImpl;
@useResult
$Res call({
 String? subscriptionPublicId, String? planName, String? planCode, String? category, String? billingCycle, dynamic amount, String? currencyCode, String? paymentStatus, String? subscriptionStatus, String? startDate, String? endDate, bool? isActive, int? durationDays
});




}
/// @nodoc
class _$UserSubscriptionDataCopyWithImpl<$Res>
    implements $UserSubscriptionDataCopyWith<$Res> {
  _$UserSubscriptionDataCopyWithImpl(this._self, this._then);

  final UserSubscriptionData _self;
  final $Res Function(UserSubscriptionData) _then;

/// Create a copy of UserSubscriptionData
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? subscriptionPublicId = freezed,Object? planName = freezed,Object? planCode = freezed,Object? category = freezed,Object? billingCycle = freezed,Object? amount = freezed,Object? currencyCode = freezed,Object? paymentStatus = freezed,Object? subscriptionStatus = freezed,Object? startDate = freezed,Object? endDate = freezed,Object? isActive = freezed,Object? durationDays = freezed,}) {
  return _then(_self.copyWith(
subscriptionPublicId: freezed == subscriptionPublicId ? _self.subscriptionPublicId : subscriptionPublicId // ignore: cast_nullable_to_non_nullable
as String?,planName: freezed == planName ? _self.planName : planName // ignore: cast_nullable_to_non_nullable
as String?,planCode: freezed == planCode ? _self.planCode : planCode // ignore: cast_nullable_to_non_nullable
as String?,category: freezed == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as String?,billingCycle: freezed == billingCycle ? _self.billingCycle : billingCycle // ignore: cast_nullable_to_non_nullable
as String?,amount: freezed == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as dynamic,currencyCode: freezed == currencyCode ? _self.currencyCode : currencyCode // ignore: cast_nullable_to_non_nullable
as String?,paymentStatus: freezed == paymentStatus ? _self.paymentStatus : paymentStatus // ignore: cast_nullable_to_non_nullable
as String?,subscriptionStatus: freezed == subscriptionStatus ? _self.subscriptionStatus : subscriptionStatus // ignore: cast_nullable_to_non_nullable
as String?,startDate: freezed == startDate ? _self.startDate : startDate // ignore: cast_nullable_to_non_nullable
as String?,endDate: freezed == endDate ? _self.endDate : endDate // ignore: cast_nullable_to_non_nullable
as String?,isActive: freezed == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool?,durationDays: freezed == durationDays ? _self.durationDays : durationDays // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}

}


/// Adds pattern-matching-related methods to [UserSubscriptionData].
extension UserSubscriptionDataPatterns on UserSubscriptionData {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _UserSubscriptionData value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _UserSubscriptionData() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _UserSubscriptionData value)  $default,){
final _that = this;
switch (_that) {
case _UserSubscriptionData():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _UserSubscriptionData value)?  $default,){
final _that = this;
switch (_that) {
case _UserSubscriptionData() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? subscriptionPublicId,  String? planName,  String? planCode,  String? category,  String? billingCycle,  dynamic amount,  String? currencyCode,  String? paymentStatus,  String? subscriptionStatus,  String? startDate,  String? endDate,  bool? isActive,  int? durationDays)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _UserSubscriptionData() when $default != null:
return $default(_that.subscriptionPublicId,_that.planName,_that.planCode,_that.category,_that.billingCycle,_that.amount,_that.currencyCode,_that.paymentStatus,_that.subscriptionStatus,_that.startDate,_that.endDate,_that.isActive,_that.durationDays);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? subscriptionPublicId,  String? planName,  String? planCode,  String? category,  String? billingCycle,  dynamic amount,  String? currencyCode,  String? paymentStatus,  String? subscriptionStatus,  String? startDate,  String? endDate,  bool? isActive,  int? durationDays)  $default,) {final _that = this;
switch (_that) {
case _UserSubscriptionData():
return $default(_that.subscriptionPublicId,_that.planName,_that.planCode,_that.category,_that.billingCycle,_that.amount,_that.currencyCode,_that.paymentStatus,_that.subscriptionStatus,_that.startDate,_that.endDate,_that.isActive,_that.durationDays);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? subscriptionPublicId,  String? planName,  String? planCode,  String? category,  String? billingCycle,  dynamic amount,  String? currencyCode,  String? paymentStatus,  String? subscriptionStatus,  String? startDate,  String? endDate,  bool? isActive,  int? durationDays)?  $default,) {final _that = this;
switch (_that) {
case _UserSubscriptionData() when $default != null:
return $default(_that.subscriptionPublicId,_that.planName,_that.planCode,_that.category,_that.billingCycle,_that.amount,_that.currencyCode,_that.paymentStatus,_that.subscriptionStatus,_that.startDate,_that.endDate,_that.isActive,_that.durationDays);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _UserSubscriptionData implements UserSubscriptionData {
  const _UserSubscriptionData({this.subscriptionPublicId, this.planName, this.planCode, this.category, this.billingCycle, this.amount, this.currencyCode, this.paymentStatus, this.subscriptionStatus, this.startDate, this.endDate, this.isActive, this.durationDays});
  factory _UserSubscriptionData.fromJson(Map<String, dynamic> json) => _$UserSubscriptionDataFromJson(json);

@override final  String? subscriptionPublicId;
@override final  String? planName;
@override final  String? planCode;
@override final  String? category;
@override final  String? billingCycle;
@override final  dynamic amount;
@override final  String? currencyCode;
@override final  String? paymentStatus;
@override final  String? subscriptionStatus;
@override final  String? startDate;
@override final  String? endDate;
@override final  bool? isActive;
@override final  int? durationDays;

/// Create a copy of UserSubscriptionData
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UserSubscriptionDataCopyWith<_UserSubscriptionData> get copyWith => __$UserSubscriptionDataCopyWithImpl<_UserSubscriptionData>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$UserSubscriptionDataToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UserSubscriptionData&&(identical(other.subscriptionPublicId, subscriptionPublicId) || other.subscriptionPublicId == subscriptionPublicId)&&(identical(other.planName, planName) || other.planName == planName)&&(identical(other.planCode, planCode) || other.planCode == planCode)&&(identical(other.category, category) || other.category == category)&&(identical(other.billingCycle, billingCycle) || other.billingCycle == billingCycle)&&const DeepCollectionEquality().equals(other.amount, amount)&&(identical(other.currencyCode, currencyCode) || other.currencyCode == currencyCode)&&(identical(other.paymentStatus, paymentStatus) || other.paymentStatus == paymentStatus)&&(identical(other.subscriptionStatus, subscriptionStatus) || other.subscriptionStatus == subscriptionStatus)&&(identical(other.startDate, startDate) || other.startDate == startDate)&&(identical(other.endDate, endDate) || other.endDate == endDate)&&(identical(other.isActive, isActive) || other.isActive == isActive)&&(identical(other.durationDays, durationDays) || other.durationDays == durationDays));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,subscriptionPublicId,planName,planCode,category,billingCycle,const DeepCollectionEquality().hash(amount),currencyCode,paymentStatus,subscriptionStatus,startDate,endDate,isActive,durationDays);

@override
String toString() {
  return 'UserSubscriptionData(subscriptionPublicId: $subscriptionPublicId, planName: $planName, planCode: $planCode, category: $category, billingCycle: $billingCycle, amount: $amount, currencyCode: $currencyCode, paymentStatus: $paymentStatus, subscriptionStatus: $subscriptionStatus, startDate: $startDate, endDate: $endDate, isActive: $isActive, durationDays: $durationDays)';
}


}

/// @nodoc
abstract mixin class _$UserSubscriptionDataCopyWith<$Res> implements $UserSubscriptionDataCopyWith<$Res> {
  factory _$UserSubscriptionDataCopyWith(_UserSubscriptionData value, $Res Function(_UserSubscriptionData) _then) = __$UserSubscriptionDataCopyWithImpl;
@override @useResult
$Res call({
 String? subscriptionPublicId, String? planName, String? planCode, String? category, String? billingCycle, dynamic amount, String? currencyCode, String? paymentStatus, String? subscriptionStatus, String? startDate, String? endDate, bool? isActive, int? durationDays
});




}
/// @nodoc
class __$UserSubscriptionDataCopyWithImpl<$Res>
    implements _$UserSubscriptionDataCopyWith<$Res> {
  __$UserSubscriptionDataCopyWithImpl(this._self, this._then);

  final _UserSubscriptionData _self;
  final $Res Function(_UserSubscriptionData) _then;

/// Create a copy of UserSubscriptionData
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? subscriptionPublicId = freezed,Object? planName = freezed,Object? planCode = freezed,Object? category = freezed,Object? billingCycle = freezed,Object? amount = freezed,Object? currencyCode = freezed,Object? paymentStatus = freezed,Object? subscriptionStatus = freezed,Object? startDate = freezed,Object? endDate = freezed,Object? isActive = freezed,Object? durationDays = freezed,}) {
  return _then(_UserSubscriptionData(
subscriptionPublicId: freezed == subscriptionPublicId ? _self.subscriptionPublicId : subscriptionPublicId // ignore: cast_nullable_to_non_nullable
as String?,planName: freezed == planName ? _self.planName : planName // ignore: cast_nullable_to_non_nullable
as String?,planCode: freezed == planCode ? _self.planCode : planCode // ignore: cast_nullable_to_non_nullable
as String?,category: freezed == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as String?,billingCycle: freezed == billingCycle ? _self.billingCycle : billingCycle // ignore: cast_nullable_to_non_nullable
as String?,amount: freezed == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as dynamic,currencyCode: freezed == currencyCode ? _self.currencyCode : currencyCode // ignore: cast_nullable_to_non_nullable
as String?,paymentStatus: freezed == paymentStatus ? _self.paymentStatus : paymentStatus // ignore: cast_nullable_to_non_nullable
as String?,subscriptionStatus: freezed == subscriptionStatus ? _self.subscriptionStatus : subscriptionStatus // ignore: cast_nullable_to_non_nullable
as String?,startDate: freezed == startDate ? _self.startDate : startDate // ignore: cast_nullable_to_non_nullable
as String?,endDate: freezed == endDate ? _self.endDate : endDate // ignore: cast_nullable_to_non_nullable
as String?,isActive: freezed == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool?,durationDays: freezed == durationDays ? _self.durationDays : durationDays // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}

// dart format on
