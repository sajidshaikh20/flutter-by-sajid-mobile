// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'get_cart_list_details_request.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

GetCartListDetailsRequest _$GetCartListDetailsRequestFromJson(
    Map<String, dynamic> json) {
  return _GetCartListDetailsRequest.fromJson(json);
}

/// @nodoc
mixin _$GetCartListDetailsRequest {
  /// Customer authentication token.
  String? get customerToken => throw _privateConstructorUsedError;

  /// Store identifier.
  String? get storeId => throw _privateConstructorUsedError;

  /// Unique quote/cart ID.
  String? get quoteId => throw _privateConstructorUsedError;

  /// Website identifier in a multi-website setup.
  String? get websiteId => throw _privateConstructorUsedError;

  /// Currency code (e.g., `USD`, `KWD`).
  String? get currency => throw _privateConstructorUsedError;

  /// HTTP method or API action type (e.g., `GET`, `POST`).
  String? get method => throw _privateConstructorUsedError;

  /// Entity tag for caching or concurrency control.
  String? get eTag => throw _privateConstructorUsedError;

  /// Optional width for display purposes (e.g., for responsive layouts).
  String? get width => throw _privateConstructorUsedError;

  /// Serializes this GetCartListDetailsRequest to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of GetCartListDetailsRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $GetCartListDetailsRequestCopyWith<GetCartListDetailsRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GetCartListDetailsRequestCopyWith<$Res> {
  factory $GetCartListDetailsRequestCopyWith(GetCartListDetailsRequest value,
          $Res Function(GetCartListDetailsRequest) then) =
      _$GetCartListDetailsRequestCopyWithImpl<$Res, GetCartListDetailsRequest>;
  @useResult
  $Res call(
      {String? customerToken,
      String? storeId,
      String? quoteId,
      String? websiteId,
      String? currency,
      String? method,
      String? eTag,
      String? width});
}

/// @nodoc
class _$GetCartListDetailsRequestCopyWithImpl<$Res,
        $Val extends GetCartListDetailsRequest>
    implements $GetCartListDetailsRequestCopyWith<$Res> {
  _$GetCartListDetailsRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of GetCartListDetailsRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? customerToken = freezed,
    Object? storeId = freezed,
    Object? quoteId = freezed,
    Object? websiteId = freezed,
    Object? currency = freezed,
    Object? method = freezed,
    Object? eTag = freezed,
    Object? width = freezed,
  }) {
    return _then(_value.copyWith(
      customerToken: freezed == customerToken
          ? _value.customerToken
          : customerToken // ignore: cast_nullable_to_non_nullable
              as String?,
      storeId: freezed == storeId
          ? _value.storeId
          : storeId // ignore: cast_nullable_to_non_nullable
              as String?,
      quoteId: freezed == quoteId
          ? _value.quoteId
          : quoteId // ignore: cast_nullable_to_non_nullable
              as String?,
      websiteId: freezed == websiteId
          ? _value.websiteId
          : websiteId // ignore: cast_nullable_to_non_nullable
              as String?,
      currency: freezed == currency
          ? _value.currency
          : currency // ignore: cast_nullable_to_non_nullable
              as String?,
      method: freezed == method
          ? _value.method
          : method // ignore: cast_nullable_to_non_nullable
              as String?,
      eTag: freezed == eTag
          ? _value.eTag
          : eTag // ignore: cast_nullable_to_non_nullable
              as String?,
      width: freezed == width
          ? _value.width
          : width // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$GetCartListDetailsRequestImplCopyWith<$Res>
    implements $GetCartListDetailsRequestCopyWith<$Res> {
  factory _$$GetCartListDetailsRequestImplCopyWith(
          _$GetCartListDetailsRequestImpl value,
          $Res Function(_$GetCartListDetailsRequestImpl) then) =
      __$$GetCartListDetailsRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? customerToken,
      String? storeId,
      String? quoteId,
      String? websiteId,
      String? currency,
      String? method,
      String? eTag,
      String? width});
}

/// @nodoc
class __$$GetCartListDetailsRequestImplCopyWithImpl<$Res>
    extends _$GetCartListDetailsRequestCopyWithImpl<$Res,
        _$GetCartListDetailsRequestImpl>
    implements _$$GetCartListDetailsRequestImplCopyWith<$Res> {
  __$$GetCartListDetailsRequestImplCopyWithImpl(
      _$GetCartListDetailsRequestImpl _value,
      $Res Function(_$GetCartListDetailsRequestImpl) _then)
      : super(_value, _then);

  /// Create a copy of GetCartListDetailsRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? customerToken = freezed,
    Object? storeId = freezed,
    Object? quoteId = freezed,
    Object? websiteId = freezed,
    Object? currency = freezed,
    Object? method = freezed,
    Object? eTag = freezed,
    Object? width = freezed,
  }) {
    return _then(_$GetCartListDetailsRequestImpl(
      customerToken: freezed == customerToken
          ? _value.customerToken
          : customerToken // ignore: cast_nullable_to_non_nullable
              as String?,
      storeId: freezed == storeId
          ? _value.storeId
          : storeId // ignore: cast_nullable_to_non_nullable
              as String?,
      quoteId: freezed == quoteId
          ? _value.quoteId
          : quoteId // ignore: cast_nullable_to_non_nullable
              as String?,
      websiteId: freezed == websiteId
          ? _value.websiteId
          : websiteId // ignore: cast_nullable_to_non_nullable
              as String?,
      currency: freezed == currency
          ? _value.currency
          : currency // ignore: cast_nullable_to_non_nullable
              as String?,
      method: freezed == method
          ? _value.method
          : method // ignore: cast_nullable_to_non_nullable
              as String?,
      eTag: freezed == eTag
          ? _value.eTag
          : eTag // ignore: cast_nullable_to_non_nullable
              as String?,
      width: freezed == width
          ? _value.width
          : width // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$GetCartListDetailsRequestImpl implements _GetCartListDetailsRequest {
  const _$GetCartListDetailsRequestImpl(
      {this.customerToken,
      this.storeId,
      this.quoteId,
      this.websiteId,
      this.currency,
      this.method,
      this.eTag,
      this.width});

  factory _$GetCartListDetailsRequestImpl.fromJson(Map<String, dynamic> json) =>
      _$$GetCartListDetailsRequestImplFromJson(json);

  /// Customer authentication token.
  @override
  final String? customerToken;

  /// Store identifier.
  @override
  final String? storeId;

  /// Unique quote/cart ID.
  @override
  final String? quoteId;

  /// Website identifier in a multi-website setup.
  @override
  final String? websiteId;

  /// Currency code (e.g., `USD`, `KWD`).
  @override
  final String? currency;

  /// HTTP method or API action type (e.g., `GET`, `POST`).
  @override
  final String? method;

  /// Entity tag for caching or concurrency control.
  @override
  final String? eTag;

  /// Optional width for display purposes (e.g., for responsive layouts).
  @override
  final String? width;

  @override
  String toString() {
    return 'GetCartListDetailsRequest(customerToken: $customerToken, storeId: $storeId, quoteId: $quoteId, websiteId: $websiteId, currency: $currency, method: $method, eTag: $eTag, width: $width)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GetCartListDetailsRequestImpl &&
            (identical(other.customerToken, customerToken) ||
                other.customerToken == customerToken) &&
            (identical(other.storeId, storeId) || other.storeId == storeId) &&
            (identical(other.quoteId, quoteId) || other.quoteId == quoteId) &&
            (identical(other.websiteId, websiteId) ||
                other.websiteId == websiteId) &&
            (identical(other.currency, currency) ||
                other.currency == currency) &&
            (identical(other.method, method) || other.method == method) &&
            (identical(other.eTag, eTag) || other.eTag == eTag) &&
            (identical(other.width, width) || other.width == width));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, customerToken, storeId, quoteId,
      websiteId, currency, method, eTag, width);

  /// Create a copy of GetCartListDetailsRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$GetCartListDetailsRequestImplCopyWith<_$GetCartListDetailsRequestImpl>
      get copyWith => __$$GetCartListDetailsRequestImplCopyWithImpl<
          _$GetCartListDetailsRequestImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$GetCartListDetailsRequestImplToJson(
      this,
    );
  }
}

abstract class _GetCartListDetailsRequest implements GetCartListDetailsRequest {
  const factory _GetCartListDetailsRequest(
      {final String? customerToken,
      final String? storeId,
      final String? quoteId,
      final String? websiteId,
      final String? currency,
      final String? method,
      final String? eTag,
      final String? width}) = _$GetCartListDetailsRequestImpl;

  factory _GetCartListDetailsRequest.fromJson(Map<String, dynamic> json) =
      _$GetCartListDetailsRequestImpl.fromJson;

  /// Customer authentication token.
  @override
  String? get customerToken;

  /// Store identifier.
  @override
  String? get storeId;

  /// Unique quote/cart ID.
  @override
  String? get quoteId;

  /// Website identifier in a multi-website setup.
  @override
  String? get websiteId;

  /// Currency code (e.g., `USD`, `KWD`).
  @override
  String? get currency;

  /// HTTP method or API action type (e.g., `GET`, `POST`).
  @override
  String? get method;

  /// Entity tag for caching or concurrency control.
  @override
  String? get eTag;

  /// Optional width for display purposes (e.g., for responsive layouts).
  @override
  String? get width;

  /// Create a copy of GetCartListDetailsRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$GetCartListDetailsRequestImplCopyWith<_$GetCartListDetailsRequestImpl>
      get copyWith => throw _privateConstructorUsedError;
}
