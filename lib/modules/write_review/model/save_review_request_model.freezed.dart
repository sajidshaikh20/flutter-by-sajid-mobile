// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'save_review_request_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

SaveReviewRequestModel _$SaveReviewRequestModelFromJson(
    Map<String, dynamic> json) {
  return _SaveReviewRequestModel.fromJson(json);
}

/// @nodoc
mixin _$SaveReviewRequestModel {
  /// The ID of the website where the review is being submitted.
  String? get websiteId => throw _privateConstructorUsedError;

  /// The store ID associated with the review submission.
  String? get storeId => throw _privateConstructorUsedError;

  /// The cart/quote ID, if applicable.
  String? get quoteId => throw _privateConstructorUsedError;

  /// The token of the customer submitting the review.
  String? get customerToken => throw _privateConstructorUsedError;

  /// The title or headline of the review.
  String? get title => throw _privateConstructorUsedError;

  /// Detailed content of the review.
  String? get details => throw _privateConstructorUsedError;

  /// The ID of the product being reviewed.
  String? get productID => throw _privateConstructorUsedError;

  /// The nickname or display name of the reviewer.
  String? get nickname => throw _privateConstructorUsedError;

  /// The ratings for the review, represented as a map of criteria and scores.
  Map<String, dynamic>? get ratings => throw _privateConstructorUsedError;

  /// Serializes this SaveReviewRequestModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SaveReviewRequestModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SaveReviewRequestModelCopyWith<SaveReviewRequestModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SaveReviewRequestModelCopyWith<$Res> {
  factory $SaveReviewRequestModelCopyWith(SaveReviewRequestModel value,
          $Res Function(SaveReviewRequestModel) then) =
      _$SaveReviewRequestModelCopyWithImpl<$Res, SaveReviewRequestModel>;
  @useResult
  $Res call(
      {String? websiteId,
      String? storeId,
      String? quoteId,
      String? customerToken,
      String? title,
      String? details,
      String? productID,
      String? nickname,
      Map<String, dynamic>? ratings});
}

/// @nodoc
class _$SaveReviewRequestModelCopyWithImpl<$Res,
        $Val extends SaveReviewRequestModel>
    implements $SaveReviewRequestModelCopyWith<$Res> {
  _$SaveReviewRequestModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SaveReviewRequestModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? websiteId = freezed,
    Object? storeId = freezed,
    Object? quoteId = freezed,
    Object? customerToken = freezed,
    Object? title = freezed,
    Object? details = freezed,
    Object? productID = freezed,
    Object? nickname = freezed,
    Object? ratings = freezed,
  }) {
    return _then(_value.copyWith(
      websiteId: freezed == websiteId
          ? _value.websiteId
          : websiteId // ignore: cast_nullable_to_non_nullable
              as String?,
      storeId: freezed == storeId
          ? _value.storeId
          : storeId // ignore: cast_nullable_to_non_nullable
              as String?,
      quoteId: freezed == quoteId
          ? _value.quoteId
          : quoteId // ignore: cast_nullable_to_non_nullable
              as String?,
      customerToken: freezed == customerToken
          ? _value.customerToken
          : customerToken // ignore: cast_nullable_to_non_nullable
              as String?,
      title: freezed == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String?,
      details: freezed == details
          ? _value.details
          : details // ignore: cast_nullable_to_non_nullable
              as String?,
      productID: freezed == productID
          ? _value.productID
          : productID // ignore: cast_nullable_to_non_nullable
              as String?,
      nickname: freezed == nickname
          ? _value.nickname
          : nickname // ignore: cast_nullable_to_non_nullable
              as String?,
      ratings: freezed == ratings
          ? _value.ratings
          : ratings // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SaveReviewRequestModelImplCopyWith<$Res>
    implements $SaveReviewRequestModelCopyWith<$Res> {
  factory _$$SaveReviewRequestModelImplCopyWith(
          _$SaveReviewRequestModelImpl value,
          $Res Function(_$SaveReviewRequestModelImpl) then) =
      __$$SaveReviewRequestModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? websiteId,
      String? storeId,
      String? quoteId,
      String? customerToken,
      String? title,
      String? details,
      String? productID,
      String? nickname,
      Map<String, dynamic>? ratings});
}

/// @nodoc
class __$$SaveReviewRequestModelImplCopyWithImpl<$Res>
    extends _$SaveReviewRequestModelCopyWithImpl<$Res,
        _$SaveReviewRequestModelImpl>
    implements _$$SaveReviewRequestModelImplCopyWith<$Res> {
  __$$SaveReviewRequestModelImplCopyWithImpl(
      _$SaveReviewRequestModelImpl _value,
      $Res Function(_$SaveReviewRequestModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of SaveReviewRequestModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? websiteId = freezed,
    Object? storeId = freezed,
    Object? quoteId = freezed,
    Object? customerToken = freezed,
    Object? title = freezed,
    Object? details = freezed,
    Object? productID = freezed,
    Object? nickname = freezed,
    Object? ratings = freezed,
  }) {
    return _then(_$SaveReviewRequestModelImpl(
      websiteId: freezed == websiteId
          ? _value.websiteId
          : websiteId // ignore: cast_nullable_to_non_nullable
              as String?,
      storeId: freezed == storeId
          ? _value.storeId
          : storeId // ignore: cast_nullable_to_non_nullable
              as String?,
      quoteId: freezed == quoteId
          ? _value.quoteId
          : quoteId // ignore: cast_nullable_to_non_nullable
              as String?,
      customerToken: freezed == customerToken
          ? _value.customerToken
          : customerToken // ignore: cast_nullable_to_non_nullable
              as String?,
      title: freezed == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String?,
      details: freezed == details
          ? _value.details
          : details // ignore: cast_nullable_to_non_nullable
              as String?,
      productID: freezed == productID
          ? _value.productID
          : productID // ignore: cast_nullable_to_non_nullable
              as String?,
      nickname: freezed == nickname
          ? _value.nickname
          : nickname // ignore: cast_nullable_to_non_nullable
              as String?,
      ratings: freezed == ratings
          ? _value._ratings
          : ratings // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SaveReviewRequestModelImpl implements _SaveReviewRequestModel {
  const _$SaveReviewRequestModelImpl(
      {this.websiteId,
      this.storeId,
      this.quoteId,
      this.customerToken,
      this.title,
      this.details,
      this.productID,
      this.nickname,
      final Map<String, dynamic>? ratings})
      : _ratings = ratings;

  factory _$SaveReviewRequestModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$SaveReviewRequestModelImplFromJson(json);

  /// The ID of the website where the review is being submitted.
  @override
  final String? websiteId;

  /// The store ID associated with the review submission.
  @override
  final String? storeId;

  /// The cart/quote ID, if applicable.
  @override
  final String? quoteId;

  /// The token of the customer submitting the review.
  @override
  final String? customerToken;

  /// The title or headline of the review.
  @override
  final String? title;

  /// Detailed content of the review.
  @override
  final String? details;

  /// The ID of the product being reviewed.
  @override
  final String? productID;

  /// The nickname or display name of the reviewer.
  @override
  final String? nickname;

  /// The ratings for the review, represented as a map of criteria and scores.
  final Map<String, dynamic>? _ratings;

  /// The ratings for the review, represented as a map of criteria and scores.
  @override
  Map<String, dynamic>? get ratings {
    final value = _ratings;
    if (value == null) return null;
    if (_ratings is EqualUnmodifiableMapView) return _ratings;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  @override
  String toString() {
    return 'SaveReviewRequestModel(websiteId: $websiteId, storeId: $storeId, quoteId: $quoteId, customerToken: $customerToken, title: $title, details: $details, productID: $productID, nickname: $nickname, ratings: $ratings)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SaveReviewRequestModelImpl &&
            (identical(other.websiteId, websiteId) ||
                other.websiteId == websiteId) &&
            (identical(other.storeId, storeId) || other.storeId == storeId) &&
            (identical(other.quoteId, quoteId) || other.quoteId == quoteId) &&
            (identical(other.customerToken, customerToken) ||
                other.customerToken == customerToken) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.details, details) || other.details == details) &&
            (identical(other.productID, productID) ||
                other.productID == productID) &&
            (identical(other.nickname, nickname) ||
                other.nickname == nickname) &&
            const DeepCollectionEquality().equals(other._ratings, _ratings));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      websiteId,
      storeId,
      quoteId,
      customerToken,
      title,
      details,
      productID,
      nickname,
      const DeepCollectionEquality().hash(_ratings));

  /// Create a copy of SaveReviewRequestModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SaveReviewRequestModelImplCopyWith<_$SaveReviewRequestModelImpl>
      get copyWith => __$$SaveReviewRequestModelImplCopyWithImpl<
          _$SaveReviewRequestModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SaveReviewRequestModelImplToJson(
      this,
    );
  }
}

abstract class _SaveReviewRequestModel implements SaveReviewRequestModel {
  const factory _SaveReviewRequestModel(
      {final String? websiteId,
      final String? storeId,
      final String? quoteId,
      final String? customerToken,
      final String? title,
      final String? details,
      final String? productID,
      final String? nickname,
      final Map<String, dynamic>? ratings}) = _$SaveReviewRequestModelImpl;

  factory _SaveReviewRequestModel.fromJson(Map<String, dynamic> json) =
      _$SaveReviewRequestModelImpl.fromJson;

  /// The ID of the website where the review is being submitted.
  @override
  String? get websiteId;

  /// The store ID associated with the review submission.
  @override
  String? get storeId;

  /// The cart/quote ID, if applicable.
  @override
  String? get quoteId;

  /// The token of the customer submitting the review.
  @override
  String? get customerToken;

  /// The title or headline of the review.
  @override
  String? get title;

  /// Detailed content of the review.
  @override
  String? get details;

  /// The ID of the product being reviewed.
  @override
  String? get productID;

  /// The nickname or display name of the reviewer.
  @override
  String? get nickname;

  /// The ratings for the review, represented as a map of criteria and scores.
  @override
  Map<String, dynamic>? get ratings;

  /// Create a copy of SaveReviewRequestModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SaveReviewRequestModelImplCopyWith<_$SaveReviewRequestModelImpl>
      get copyWith => throw _privateConstructorUsedError;
}
