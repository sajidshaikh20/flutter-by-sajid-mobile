// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'login_user_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

LoginUserResponse _$LoginUserResponseFromJson(Map<String, dynamic> json) {
  return _LoginUserResponse.fromJson(json);
}

/// @nodoc
mixin _$LoginUserResponse {
  /// Unique user identifier.
  int? get id => throw _privateConstructorUsedError;

  /// User's display name.
  String? get name => throw _privateConstructorUsedError;

  /// User's login identifier (email/username).
  String? get login => throw _privateConstructorUsedError;

  /// User's phone number.
  String? get phoneNumber => throw _privateConstructorUsedError;

  /// Customer's full name.
  String? get customerName => throw _privateConstructorUsedError;

  /// Customer's email address.
  String? get customerEmail => throw _privateConstructorUsedError;

  /// Customer's unique identifier.
  String? get customerId => throw _privateConstructorUsedError;

  /// Authentication token for the customer.
  String? get customerToken => throw _privateConstructorUsedError;

  /// Number of items in the user's cart.
  int? get cartCount => throw _privateConstructorUsedError;

  /// Quote identifier for the current session.
  dynamic get quoteId => throw _privateConstructorUsedError;

  /// Total value of all orders placed by the user.
  String? get totalOrderValue => throw _privateConstructorUsedError;

  /// Date of the user's last order.
  String? get lastOrderDate => throw _privateConstructorUsedError;

  /// Current wallet balance.
  String? get walletBalance => throw _privateConstructorUsedError;

  /// Current loyalty points balance.
  String? get loyaltyPoints => throw _privateConstructorUsedError;

  /// Total number of orders placed by the user.
  int? get totalOrder => throw _privateConstructorUsedError;

  /// User's referral code.
  String? get referralCode => throw _privateConstructorUsedError;

  /// User's gender.
  String? get gender => throw _privateConstructorUsedError;

  /// User's birthday.
  String? get birthday => throw _privateConstructorUsedError;

  /// User's nationality.
  String? get nationality => throw _privateConstructorUsedError;

  /// User's arabicNationality.
  String? get arabicNationality => throw _privateConstructorUsedError;

  /// Phone number prefix/country code.
  dynamic get prefix => throw _privateConstructorUsedError;

  /// Serializes this LoginUserResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of LoginUserResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $LoginUserResponseCopyWith<LoginUserResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LoginUserResponseCopyWith<$Res> {
  factory $LoginUserResponseCopyWith(
          LoginUserResponse value, $Res Function(LoginUserResponse) then) =
      _$LoginUserResponseCopyWithImpl<$Res, LoginUserResponse>;
  @useResult
  $Res call(
      {int? id,
      String? name,
      String? login,
      String? phoneNumber,
      String? customerName,
      String? customerEmail,
      String? customerId,
      String? customerToken,
      int? cartCount,
      dynamic quoteId,
      String? totalOrderValue,
      String? lastOrderDate,
      String? walletBalance,
      String? loyaltyPoints,
      int? totalOrder,
      String? referralCode,
      String? gender,
      String? birthday,
      String? nationality,
      String? arabicNationality,
      dynamic prefix});
}

/// @nodoc
class _$LoginUserResponseCopyWithImpl<$Res, $Val extends LoginUserResponse>
    implements $LoginUserResponseCopyWith<$Res> {
  _$LoginUserResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of LoginUserResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? name = freezed,
    Object? login = freezed,
    Object? phoneNumber = freezed,
    Object? customerName = freezed,
    Object? customerEmail = freezed,
    Object? customerId = freezed,
    Object? customerToken = freezed,
    Object? cartCount = freezed,
    Object? quoteId = freezed,
    Object? totalOrderValue = freezed,
    Object? lastOrderDate = freezed,
    Object? walletBalance = freezed,
    Object? loyaltyPoints = freezed,
    Object? totalOrder = freezed,
    Object? referralCode = freezed,
    Object? gender = freezed,
    Object? birthday = freezed,
    Object? nationality = freezed,
    Object? arabicNationality = freezed,
    Object? prefix = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      login: freezed == login
          ? _value.login
          : login // ignore: cast_nullable_to_non_nullable
              as String?,
      phoneNumber: freezed == phoneNumber
          ? _value.phoneNumber
          : phoneNumber // ignore: cast_nullable_to_non_nullable
              as String?,
      customerName: freezed == customerName
          ? _value.customerName
          : customerName // ignore: cast_nullable_to_non_nullable
              as String?,
      customerEmail: freezed == customerEmail
          ? _value.customerEmail
          : customerEmail // ignore: cast_nullable_to_non_nullable
              as String?,
      customerId: freezed == customerId
          ? _value.customerId
          : customerId // ignore: cast_nullable_to_non_nullable
              as String?,
      customerToken: freezed == customerToken
          ? _value.customerToken
          : customerToken // ignore: cast_nullable_to_non_nullable
              as String?,
      cartCount: freezed == cartCount
          ? _value.cartCount
          : cartCount // ignore: cast_nullable_to_non_nullable
              as int?,
      quoteId: freezed == quoteId
          ? _value.quoteId
          : quoteId // ignore: cast_nullable_to_non_nullable
              as dynamic,
      totalOrderValue: freezed == totalOrderValue
          ? _value.totalOrderValue
          : totalOrderValue // ignore: cast_nullable_to_non_nullable
              as String?,
      lastOrderDate: freezed == lastOrderDate
          ? _value.lastOrderDate
          : lastOrderDate // ignore: cast_nullable_to_non_nullable
              as String?,
      walletBalance: freezed == walletBalance
          ? _value.walletBalance
          : walletBalance // ignore: cast_nullable_to_non_nullable
              as String?,
      loyaltyPoints: freezed == loyaltyPoints
          ? _value.loyaltyPoints
          : loyaltyPoints // ignore: cast_nullable_to_non_nullable
              as String?,
      totalOrder: freezed == totalOrder
          ? _value.totalOrder
          : totalOrder // ignore: cast_nullable_to_non_nullable
              as int?,
      referralCode: freezed == referralCode
          ? _value.referralCode
          : referralCode // ignore: cast_nullable_to_non_nullable
              as String?,
      gender: freezed == gender
          ? _value.gender
          : gender // ignore: cast_nullable_to_non_nullable
              as String?,
      birthday: freezed == birthday
          ? _value.birthday
          : birthday // ignore: cast_nullable_to_non_nullable
              as String?,
      nationality: freezed == nationality
          ? _value.nationality
          : nationality // ignore: cast_nullable_to_non_nullable
              as String?,
      arabicNationality: freezed == arabicNationality
          ? _value.arabicNationality
          : arabicNationality // ignore: cast_nullable_to_non_nullable
              as String?,
      prefix: freezed == prefix
          ? _value.prefix
          : prefix // ignore: cast_nullable_to_non_nullable
              as dynamic,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$LoginUserResponseImplCopyWith<$Res>
    implements $LoginUserResponseCopyWith<$Res> {
  factory _$$LoginUserResponseImplCopyWith(_$LoginUserResponseImpl value,
          $Res Function(_$LoginUserResponseImpl) then) =
      __$$LoginUserResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int? id,
      String? name,
      String? login,
      String? phoneNumber,
      String? customerName,
      String? customerEmail,
      String? customerId,
      String? customerToken,
      int? cartCount,
      dynamic quoteId,
      String? totalOrderValue,
      String? lastOrderDate,
      String? walletBalance,
      String? loyaltyPoints,
      int? totalOrder,
      String? referralCode,
      String? gender,
      String? birthday,
      String? nationality,
      String? arabicNationality,
      dynamic prefix});
}

/// @nodoc
class __$$LoginUserResponseImplCopyWithImpl<$Res>
    extends _$LoginUserResponseCopyWithImpl<$Res, _$LoginUserResponseImpl>
    implements _$$LoginUserResponseImplCopyWith<$Res> {
  __$$LoginUserResponseImplCopyWithImpl(_$LoginUserResponseImpl _value,
      $Res Function(_$LoginUserResponseImpl) _then)
      : super(_value, _then);

  /// Create a copy of LoginUserResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? name = freezed,
    Object? login = freezed,
    Object? phoneNumber = freezed,
    Object? customerName = freezed,
    Object? customerEmail = freezed,
    Object? customerId = freezed,
    Object? customerToken = freezed,
    Object? cartCount = freezed,
    Object? quoteId = freezed,
    Object? totalOrderValue = freezed,
    Object? lastOrderDate = freezed,
    Object? walletBalance = freezed,
    Object? loyaltyPoints = freezed,
    Object? totalOrder = freezed,
    Object? referralCode = freezed,
    Object? gender = freezed,
    Object? birthday = freezed,
    Object? nationality = freezed,
    Object? arabicNationality = freezed,
    Object? prefix = freezed,
  }) {
    return _then(_$LoginUserResponseImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      login: freezed == login
          ? _value.login
          : login // ignore: cast_nullable_to_non_nullable
              as String?,
      phoneNumber: freezed == phoneNumber
          ? _value.phoneNumber
          : phoneNumber // ignore: cast_nullable_to_non_nullable
              as String?,
      customerName: freezed == customerName
          ? _value.customerName
          : customerName // ignore: cast_nullable_to_non_nullable
              as String?,
      customerEmail: freezed == customerEmail
          ? _value.customerEmail
          : customerEmail // ignore: cast_nullable_to_non_nullable
              as String?,
      customerId: freezed == customerId
          ? _value.customerId
          : customerId // ignore: cast_nullable_to_non_nullable
              as String?,
      customerToken: freezed == customerToken
          ? _value.customerToken
          : customerToken // ignore: cast_nullable_to_non_nullable
              as String?,
      cartCount: freezed == cartCount
          ? _value.cartCount
          : cartCount // ignore: cast_nullable_to_non_nullable
              as int?,
      quoteId: freezed == quoteId
          ? _value.quoteId
          : quoteId // ignore: cast_nullable_to_non_nullable
              as dynamic,
      totalOrderValue: freezed == totalOrderValue
          ? _value.totalOrderValue
          : totalOrderValue // ignore: cast_nullable_to_non_nullable
              as String?,
      lastOrderDate: freezed == lastOrderDate
          ? _value.lastOrderDate
          : lastOrderDate // ignore: cast_nullable_to_non_nullable
              as String?,
      walletBalance: freezed == walletBalance
          ? _value.walletBalance
          : walletBalance // ignore: cast_nullable_to_non_nullable
              as String?,
      loyaltyPoints: freezed == loyaltyPoints
          ? _value.loyaltyPoints
          : loyaltyPoints // ignore: cast_nullable_to_non_nullable
              as String?,
      totalOrder: freezed == totalOrder
          ? _value.totalOrder
          : totalOrder // ignore: cast_nullable_to_non_nullable
              as int?,
      referralCode: freezed == referralCode
          ? _value.referralCode
          : referralCode // ignore: cast_nullable_to_non_nullable
              as String?,
      gender: freezed == gender
          ? _value.gender
          : gender // ignore: cast_nullable_to_non_nullable
              as String?,
      birthday: freezed == birthday
          ? _value.birthday
          : birthday // ignore: cast_nullable_to_non_nullable
              as String?,
      nationality: freezed == nationality
          ? _value.nationality
          : nationality // ignore: cast_nullable_to_non_nullable
              as String?,
      arabicNationality: freezed == arabicNationality
          ? _value.arabicNationality
          : arabicNationality // ignore: cast_nullable_to_non_nullable
              as String?,
      prefix: freezed == prefix
          ? _value.prefix
          : prefix // ignore: cast_nullable_to_non_nullable
              as dynamic,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$LoginUserResponseImpl implements _LoginUserResponse {
  const _$LoginUserResponseImpl(
      {this.id,
      this.name,
      this.login,
      this.phoneNumber,
      this.customerName,
      this.customerEmail,
      this.customerId,
      this.customerToken,
      this.cartCount,
      this.quoteId,
      this.totalOrderValue,
      this.lastOrderDate,
      this.walletBalance,
      this.loyaltyPoints,
      this.totalOrder,
      this.referralCode,
      this.gender,
      this.birthday,
      this.nationality,
      this.arabicNationality,
      this.prefix});

  factory _$LoginUserResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$LoginUserResponseImplFromJson(json);

  /// Unique user identifier.
  @override
  final int? id;

  /// User's display name.
  @override
  final String? name;

  /// User's login identifier (email/username).
  @override
  final String? login;

  /// User's phone number.
  @override
  final String? phoneNumber;

  /// Customer's full name.
  @override
  final String? customerName;

  /// Customer's email address.
  @override
  final String? customerEmail;

  /// Customer's unique identifier.
  @override
  final String? customerId;

  /// Authentication token for the customer.
  @override
  final String? customerToken;

  /// Number of items in the user's cart.
  @override
  final int? cartCount;

  /// Quote identifier for the current session.
  @override
  final dynamic quoteId;

  /// Total value of all orders placed by the user.
  @override
  final String? totalOrderValue;

  /// Date of the user's last order.
  @override
  final String? lastOrderDate;

  /// Current wallet balance.
  @override
  final String? walletBalance;

  /// Current loyalty points balance.
  @override
  final String? loyaltyPoints;

  /// Total number of orders placed by the user.
  @override
  final int? totalOrder;

  /// User's referral code.
  @override
  final String? referralCode;

  /// User's gender.
  @override
  final String? gender;

  /// User's birthday.
  @override
  final String? birthday;

  /// User's nationality.
  @override
  final String? nationality;

  /// User's arabicNationality.
  @override
  final String? arabicNationality;

  /// Phone number prefix/country code.
  @override
  final dynamic prefix;

  @override
  String toString() {
    return 'LoginUserResponse(id: $id, name: $name, login: $login, phoneNumber: $phoneNumber, customerName: $customerName, customerEmail: $customerEmail, customerId: $customerId, customerToken: $customerToken, cartCount: $cartCount, quoteId: $quoteId, totalOrderValue: $totalOrderValue, lastOrderDate: $lastOrderDate, walletBalance: $walletBalance, loyaltyPoints: $loyaltyPoints, totalOrder: $totalOrder, referralCode: $referralCode, gender: $gender, birthday: $birthday, nationality: $nationality, arabicNationality: $arabicNationality, prefix: $prefix)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoginUserResponseImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.login, login) || other.login == login) &&
            (identical(other.phoneNumber, phoneNumber) ||
                other.phoneNumber == phoneNumber) &&
            (identical(other.customerName, customerName) ||
                other.customerName == customerName) &&
            (identical(other.customerEmail, customerEmail) ||
                other.customerEmail == customerEmail) &&
            (identical(other.customerId, customerId) ||
                other.customerId == customerId) &&
            (identical(other.customerToken, customerToken) ||
                other.customerToken == customerToken) &&
            (identical(other.cartCount, cartCount) ||
                other.cartCount == cartCount) &&
            const DeepCollectionEquality().equals(other.quoteId, quoteId) &&
            (identical(other.totalOrderValue, totalOrderValue) ||
                other.totalOrderValue == totalOrderValue) &&
            (identical(other.lastOrderDate, lastOrderDate) ||
                other.lastOrderDate == lastOrderDate) &&
            (identical(other.walletBalance, walletBalance) ||
                other.walletBalance == walletBalance) &&
            (identical(other.loyaltyPoints, loyaltyPoints) ||
                other.loyaltyPoints == loyaltyPoints) &&
            (identical(other.totalOrder, totalOrder) ||
                other.totalOrder == totalOrder) &&
            (identical(other.referralCode, referralCode) ||
                other.referralCode == referralCode) &&
            (identical(other.gender, gender) || other.gender == gender) &&
            (identical(other.birthday, birthday) ||
                other.birthday == birthday) &&
            (identical(other.nationality, nationality) ||
                other.nationality == nationality) &&
            (identical(other.arabicNationality, arabicNationality) ||
                other.arabicNationality == arabicNationality) &&
            const DeepCollectionEquality().equals(other.prefix, prefix));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        id,
        name,
        login,
        phoneNumber,
        customerName,
        customerEmail,
        customerId,
        customerToken,
        cartCount,
        const DeepCollectionEquality().hash(quoteId),
        totalOrderValue,
        lastOrderDate,
        walletBalance,
        loyaltyPoints,
        totalOrder,
        referralCode,
        gender,
        birthday,
        nationality,
        arabicNationality,
        const DeepCollectionEquality().hash(prefix)
      ]);

  /// Create a copy of LoginUserResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LoginUserResponseImplCopyWith<_$LoginUserResponseImpl> get copyWith =>
      __$$LoginUserResponseImplCopyWithImpl<_$LoginUserResponseImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$LoginUserResponseImplToJson(
      this,
    );
  }
}

abstract class _LoginUserResponse implements LoginUserResponse {
  const factory _LoginUserResponse(
      {final int? id,
      final String? name,
      final String? login,
      final String? phoneNumber,
      final String? customerName,
      final String? customerEmail,
      final String? customerId,
      final String? customerToken,
      final int? cartCount,
      final dynamic quoteId,
      final String? totalOrderValue,
      final String? lastOrderDate,
      final String? walletBalance,
      final String? loyaltyPoints,
      final int? totalOrder,
      final String? referralCode,
      final String? gender,
      final String? birthday,
      final String? nationality,
      final String? arabicNationality,
      final dynamic prefix}) = _$LoginUserResponseImpl;

  factory _LoginUserResponse.fromJson(Map<String, dynamic> json) =
      _$LoginUserResponseImpl.fromJson;

  /// Unique user identifier.
  @override
  int? get id;

  /// User's display name.
  @override
  String? get name;

  /// User's login identifier (email/username).
  @override
  String? get login;

  /// User's phone number.
  @override
  String? get phoneNumber;

  /// Customer's full name.
  @override
  String? get customerName;

  /// Customer's email address.
  @override
  String? get customerEmail;

  /// Customer's unique identifier.
  @override
  String? get customerId;

  /// Authentication token for the customer.
  @override
  String? get customerToken;

  /// Number of items in the user's cart.
  @override
  int? get cartCount;

  /// Quote identifier for the current session.
  @override
  dynamic get quoteId;

  /// Total value of all orders placed by the user.
  @override
  String? get totalOrderValue;

  /// Date of the user's last order.
  @override
  String? get lastOrderDate;

  /// Current wallet balance.
  @override
  String? get walletBalance;

  /// Current loyalty points balance.
  @override
  String? get loyaltyPoints;

  /// Total number of orders placed by the user.
  @override
  int? get totalOrder;

  /// User's referral code.
  @override
  String? get referralCode;

  /// User's gender.
  @override
  String? get gender;

  /// User's birthday.
  @override
  String? get birthday;

  /// User's nationality.
  @override
  String? get nationality;

  /// User's arabicNationality.
  @override
  String? get arabicNationality;

  /// Phone number prefix/country code.
  @override
  dynamic get prefix;

  /// Create a copy of LoginUserResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LoginUserResponseImplCopyWith<_$LoginUserResponseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
