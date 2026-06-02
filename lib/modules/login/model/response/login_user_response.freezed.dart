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

/// Unique user identifier.
 int? get id;/// User's display name.
 String? get name;/// User's login identifier (email/username).
 String? get login;/// User's phone number.
 String? get phoneNumber;/// Customer's full name.
 String? get customerName;/// Customer's email address.
 String? get customerEmail;/// Customer's unique identifier.
 String? get customerId;/// Authentication token for the customer.
 String? get customerToken;/// Number of items in the user's cart.
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
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LoginUserResponse&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.login, login) || other.login == login)&&(identical(other.phoneNumber, phoneNumber) || other.phoneNumber == phoneNumber)&&(identical(other.customerName, customerName) || other.customerName == customerName)&&(identical(other.customerEmail, customerEmail) || other.customerEmail == customerEmail)&&(identical(other.customerId, customerId) || other.customerId == customerId)&&(identical(other.customerToken, customerToken) || other.customerToken == customerToken)&&(identical(other.cartCount, cartCount) || other.cartCount == cartCount)&&const DeepCollectionEquality().equals(other.quoteId, quoteId)&&(identical(other.totalOrderValue, totalOrderValue) || other.totalOrderValue == totalOrderValue)&&(identical(other.lastOrderDate, lastOrderDate) || other.lastOrderDate == lastOrderDate)&&(identical(other.walletBalance, walletBalance) || other.walletBalance == walletBalance)&&(identical(other.loyaltyPoints, loyaltyPoints) || other.loyaltyPoints == loyaltyPoints)&&(identical(other.totalOrder, totalOrder) || other.totalOrder == totalOrder)&&(identical(other.referralCode, referralCode) || other.referralCode == referralCode)&&(identical(other.gender, gender) || other.gender == gender)&&(identical(other.birthday, birthday) || other.birthday == birthday)&&(identical(other.nationality, nationality) || other.nationality == nationality)&&(identical(other.arabicNationality, arabicNationality) || other.arabicNationality == arabicNationality)&&const DeepCollectionEquality().equals(other.prefix, prefix));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,id,name,login,phoneNumber,customerName,customerEmail,customerId,customerToken,cartCount,const DeepCollectionEquality().hash(quoteId),totalOrderValue,lastOrderDate,walletBalance,loyaltyPoints,totalOrder,referralCode,gender,birthday,nationality,arabicNationality,const DeepCollectionEquality().hash(prefix)]);

@override
String toString() {
  return 'LoginUserResponse(id: $id, name: $name, login: $login, phoneNumber: $phoneNumber, customerName: $customerName, customerEmail: $customerEmail, customerId: $customerId, customerToken: $customerToken, cartCount: $cartCount, quoteId: $quoteId, totalOrderValue: $totalOrderValue, lastOrderDate: $lastOrderDate, walletBalance: $walletBalance, loyaltyPoints: $loyaltyPoints, totalOrder: $totalOrder, referralCode: $referralCode, gender: $gender, birthday: $birthday, nationality: $nationality, arabicNationality: $arabicNationality, prefix: $prefix)';
}


}

/// @nodoc
abstract mixin class $LoginUserResponseCopyWith<$Res>  {
  factory $LoginUserResponseCopyWith(LoginUserResponse value, $Res Function(LoginUserResponse) _then) = _$LoginUserResponseCopyWithImpl;
@useResult
$Res call({
 int? id, String? name, String? login, String? phoneNumber, String? customerName, String? customerEmail, String? customerId, String? customerToken, int? cartCount, dynamic quoteId, String? totalOrderValue, String? lastOrderDate, String? walletBalance, String? loyaltyPoints, int? totalOrder, String? referralCode, String? gender, String? birthday, String? nationality, String? arabicNationality, dynamic prefix
});




}
/// @nodoc
class _$LoginUserResponseCopyWithImpl<$Res>
    implements $LoginUserResponseCopyWith<$Res> {
  _$LoginUserResponseCopyWithImpl(this._self, this._then);

  final LoginUserResponse _self;
  final $Res Function(LoginUserResponse) _then;

/// Create a copy of LoginUserResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = freezed,Object? name = freezed,Object? login = freezed,Object? phoneNumber = freezed,Object? customerName = freezed,Object? customerEmail = freezed,Object? customerId = freezed,Object? customerToken = freezed,Object? cartCount = freezed,Object? quoteId = freezed,Object? totalOrderValue = freezed,Object? lastOrderDate = freezed,Object? walletBalance = freezed,Object? loyaltyPoints = freezed,Object? totalOrder = freezed,Object? referralCode = freezed,Object? gender = freezed,Object? birthday = freezed,Object? nationality = freezed,Object? arabicNationality = freezed,Object? prefix = freezed,}) {
  return _then(_self.copyWith(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int?,name: freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String?,login: freezed == login ? _self.login : login // ignore: cast_nullable_to_non_nullable
as String?,phoneNumber: freezed == phoneNumber ? _self.phoneNumber : phoneNumber // ignore: cast_nullable_to_non_nullable
as String?,customerName: freezed == customerName ? _self.customerName : customerName // ignore: cast_nullable_to_non_nullable
as String?,customerEmail: freezed == customerEmail ? _self.customerEmail : customerEmail // ignore: cast_nullable_to_non_nullable
as String?,customerId: freezed == customerId ? _self.customerId : customerId // ignore: cast_nullable_to_non_nullable
as String?,customerToken: freezed == customerToken ? _self.customerToken : customerToken // ignore: cast_nullable_to_non_nullable
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int? id,  String? name,  String? login,  String? phoneNumber,  String? customerName,  String? customerEmail,  String? customerId,  String? customerToken,  int? cartCount,  dynamic quoteId,  String? totalOrderValue,  String? lastOrderDate,  String? walletBalance,  String? loyaltyPoints,  int? totalOrder,  String? referralCode,  String? gender,  String? birthday,  String? nationality,  String? arabicNationality,  dynamic prefix)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LoginUserResponse() when $default != null:
return $default(_that.id,_that.name,_that.login,_that.phoneNumber,_that.customerName,_that.customerEmail,_that.customerId,_that.customerToken,_that.cartCount,_that.quoteId,_that.totalOrderValue,_that.lastOrderDate,_that.walletBalance,_that.loyaltyPoints,_that.totalOrder,_that.referralCode,_that.gender,_that.birthday,_that.nationality,_that.arabicNationality,_that.prefix);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int? id,  String? name,  String? login,  String? phoneNumber,  String? customerName,  String? customerEmail,  String? customerId,  String? customerToken,  int? cartCount,  dynamic quoteId,  String? totalOrderValue,  String? lastOrderDate,  String? walletBalance,  String? loyaltyPoints,  int? totalOrder,  String? referralCode,  String? gender,  String? birthday,  String? nationality,  String? arabicNationality,  dynamic prefix)  $default,) {final _that = this;
switch (_that) {
case _LoginUserResponse():
return $default(_that.id,_that.name,_that.login,_that.phoneNumber,_that.customerName,_that.customerEmail,_that.customerId,_that.customerToken,_that.cartCount,_that.quoteId,_that.totalOrderValue,_that.lastOrderDate,_that.walletBalance,_that.loyaltyPoints,_that.totalOrder,_that.referralCode,_that.gender,_that.birthday,_that.nationality,_that.arabicNationality,_that.prefix);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int? id,  String? name,  String? login,  String? phoneNumber,  String? customerName,  String? customerEmail,  String? customerId,  String? customerToken,  int? cartCount,  dynamic quoteId,  String? totalOrderValue,  String? lastOrderDate,  String? walletBalance,  String? loyaltyPoints,  int? totalOrder,  String? referralCode,  String? gender,  String? birthday,  String? nationality,  String? arabicNationality,  dynamic prefix)?  $default,) {final _that = this;
switch (_that) {
case _LoginUserResponse() when $default != null:
return $default(_that.id,_that.name,_that.login,_that.phoneNumber,_that.customerName,_that.customerEmail,_that.customerId,_that.customerToken,_that.cartCount,_that.quoteId,_that.totalOrderValue,_that.lastOrderDate,_that.walletBalance,_that.loyaltyPoints,_that.totalOrder,_that.referralCode,_that.gender,_that.birthday,_that.nationality,_that.arabicNationality,_that.prefix);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _LoginUserResponse implements LoginUserResponse {
  const _LoginUserResponse({this.id, this.name, this.login, this.phoneNumber, this.customerName, this.customerEmail, this.customerId, this.customerToken, this.cartCount, this.quoteId, this.totalOrderValue, this.lastOrderDate, this.walletBalance, this.loyaltyPoints, this.totalOrder, this.referralCode, this.gender, this.birthday, this.nationality, this.arabicNationality, this.prefix});
  factory _LoginUserResponse.fromJson(Map<String, dynamic> json) => _$LoginUserResponseFromJson(json);

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
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LoginUserResponse&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.login, login) || other.login == login)&&(identical(other.phoneNumber, phoneNumber) || other.phoneNumber == phoneNumber)&&(identical(other.customerName, customerName) || other.customerName == customerName)&&(identical(other.customerEmail, customerEmail) || other.customerEmail == customerEmail)&&(identical(other.customerId, customerId) || other.customerId == customerId)&&(identical(other.customerToken, customerToken) || other.customerToken == customerToken)&&(identical(other.cartCount, cartCount) || other.cartCount == cartCount)&&const DeepCollectionEquality().equals(other.quoteId, quoteId)&&(identical(other.totalOrderValue, totalOrderValue) || other.totalOrderValue == totalOrderValue)&&(identical(other.lastOrderDate, lastOrderDate) || other.lastOrderDate == lastOrderDate)&&(identical(other.walletBalance, walletBalance) || other.walletBalance == walletBalance)&&(identical(other.loyaltyPoints, loyaltyPoints) || other.loyaltyPoints == loyaltyPoints)&&(identical(other.totalOrder, totalOrder) || other.totalOrder == totalOrder)&&(identical(other.referralCode, referralCode) || other.referralCode == referralCode)&&(identical(other.gender, gender) || other.gender == gender)&&(identical(other.birthday, birthday) || other.birthday == birthday)&&(identical(other.nationality, nationality) || other.nationality == nationality)&&(identical(other.arabicNationality, arabicNationality) || other.arabicNationality == arabicNationality)&&const DeepCollectionEquality().equals(other.prefix, prefix));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,id,name,login,phoneNumber,customerName,customerEmail,customerId,customerToken,cartCount,const DeepCollectionEquality().hash(quoteId),totalOrderValue,lastOrderDate,walletBalance,loyaltyPoints,totalOrder,referralCode,gender,birthday,nationality,arabicNationality,const DeepCollectionEquality().hash(prefix)]);

@override
String toString() {
  return 'LoginUserResponse(id: $id, name: $name, login: $login, phoneNumber: $phoneNumber, customerName: $customerName, customerEmail: $customerEmail, customerId: $customerId, customerToken: $customerToken, cartCount: $cartCount, quoteId: $quoteId, totalOrderValue: $totalOrderValue, lastOrderDate: $lastOrderDate, walletBalance: $walletBalance, loyaltyPoints: $loyaltyPoints, totalOrder: $totalOrder, referralCode: $referralCode, gender: $gender, birthday: $birthday, nationality: $nationality, arabicNationality: $arabicNationality, prefix: $prefix)';
}


}

/// @nodoc
abstract mixin class _$LoginUserResponseCopyWith<$Res> implements $LoginUserResponseCopyWith<$Res> {
  factory _$LoginUserResponseCopyWith(_LoginUserResponse value, $Res Function(_LoginUserResponse) _then) = __$LoginUserResponseCopyWithImpl;
@override @useResult
$Res call({
 int? id, String? name, String? login, String? phoneNumber, String? customerName, String? customerEmail, String? customerId, String? customerToken, int? cartCount, dynamic quoteId, String? totalOrderValue, String? lastOrderDate, String? walletBalance, String? loyaltyPoints, int? totalOrder, String? referralCode, String? gender, String? birthday, String? nationality, String? arabicNationality, dynamic prefix
});




}
/// @nodoc
class __$LoginUserResponseCopyWithImpl<$Res>
    implements _$LoginUserResponseCopyWith<$Res> {
  __$LoginUserResponseCopyWithImpl(this._self, this._then);

  final _LoginUserResponse _self;
  final $Res Function(_LoginUserResponse) _then;

/// Create a copy of LoginUserResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = freezed,Object? name = freezed,Object? login = freezed,Object? phoneNumber = freezed,Object? customerName = freezed,Object? customerEmail = freezed,Object? customerId = freezed,Object? customerToken = freezed,Object? cartCount = freezed,Object? quoteId = freezed,Object? totalOrderValue = freezed,Object? lastOrderDate = freezed,Object? walletBalance = freezed,Object? loyaltyPoints = freezed,Object? totalOrder = freezed,Object? referralCode = freezed,Object? gender = freezed,Object? birthday = freezed,Object? nationality = freezed,Object? arabicNationality = freezed,Object? prefix = freezed,}) {
  return _then(_LoginUserResponse(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int?,name: freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String?,login: freezed == login ? _self.login : login // ignore: cast_nullable_to_non_nullable
as String?,phoneNumber: freezed == phoneNumber ? _self.phoneNumber : phoneNumber // ignore: cast_nullable_to_non_nullable
as String?,customerName: freezed == customerName ? _self.customerName : customerName // ignore: cast_nullable_to_non_nullable
as String?,customerEmail: freezed == customerEmail ? _self.customerEmail : customerEmail // ignore: cast_nullable_to_non_nullable
as String?,customerId: freezed == customerId ? _self.customerId : customerId // ignore: cast_nullable_to_non_nullable
as String?,customerToken: freezed == customerToken ? _self.customerToken : customerToken // ignore: cast_nullable_to_non_nullable
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


}

// dart format on
