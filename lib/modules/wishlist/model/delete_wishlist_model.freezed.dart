// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'delete_wishlist_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

DeleteWishlistModel _$DeleteWishlistModelFromJson(Map<String, dynamic> json) {
  return _DeleteWishlistModel.fromJson(json);
}

/// @nodoc
mixin _$DeleteWishlistModel {
  /// The website ID associated with the delete wish list request.
  String get websiteId => throw _privateConstructorUsedError;

  /// The customer token used for authentication in the request.
  String get customerToken => throw _privateConstructorUsedError;

  /// The ID of the item to be deleted from the wish list.
  String get itemId => throw _privateConstructorUsedError;

  /// Serializes this DeleteWishlistModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of DeleteWishlistModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DeleteWishlistModelCopyWith<DeleteWishlistModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DeleteWishlistModelCopyWith<$Res> {
  factory $DeleteWishlistModelCopyWith(
          DeleteWishlistModel value, $Res Function(DeleteWishlistModel) then) =
      _$DeleteWishlistModelCopyWithImpl<$Res, DeleteWishlistModel>;
  @useResult
  $Res call({String websiteId, String customerToken, String itemId});
}

/// @nodoc
class _$DeleteWishlistModelCopyWithImpl<$Res, $Val extends DeleteWishlistModel>
    implements $DeleteWishlistModelCopyWith<$Res> {
  _$DeleteWishlistModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of DeleteWishlistModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? websiteId = null,
    Object? customerToken = null,
    Object? itemId = null,
  }) {
    return _then(_value.copyWith(
      websiteId: null == websiteId
          ? _value.websiteId
          : websiteId // ignore: cast_nullable_to_non_nullable
              as String,
      customerToken: null == customerToken
          ? _value.customerToken
          : customerToken // ignore: cast_nullable_to_non_nullable
              as String,
      itemId: null == itemId
          ? _value.itemId
          : itemId // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$DeleteWishlistModelImplCopyWith<$Res>
    implements $DeleteWishlistModelCopyWith<$Res> {
  factory _$$DeleteWishlistModelImplCopyWith(_$DeleteWishlistModelImpl value,
          $Res Function(_$DeleteWishlistModelImpl) then) =
      __$$DeleteWishlistModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String websiteId, String customerToken, String itemId});
}

/// @nodoc
class __$$DeleteWishlistModelImplCopyWithImpl<$Res>
    extends _$DeleteWishlistModelCopyWithImpl<$Res, _$DeleteWishlistModelImpl>
    implements _$$DeleteWishlistModelImplCopyWith<$Res> {
  __$$DeleteWishlistModelImplCopyWithImpl(_$DeleteWishlistModelImpl _value,
      $Res Function(_$DeleteWishlistModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of DeleteWishlistModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? websiteId = null,
    Object? customerToken = null,
    Object? itemId = null,
  }) {
    return _then(_$DeleteWishlistModelImpl(
      websiteId: null == websiteId
          ? _value.websiteId
          : websiteId // ignore: cast_nullable_to_non_nullable
              as String,
      customerToken: null == customerToken
          ? _value.customerToken
          : customerToken // ignore: cast_nullable_to_non_nullable
              as String,
      itemId: null == itemId
          ? _value.itemId
          : itemId // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$DeleteWishlistModelImpl implements _DeleteWishlistModel {
  const _$DeleteWishlistModelImpl(
      {required this.websiteId,
      required this.customerToken,
      required this.itemId});

  factory _$DeleteWishlistModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$DeleteWishlistModelImplFromJson(json);

  /// The website ID associated with the delete wish list request.
  @override
  final String websiteId;

  /// The customer token used for authentication in the request.
  @override
  final String customerToken;

  /// The ID of the item to be deleted from the wish list.
  @override
  final String itemId;

  @override
  String toString() {
    return 'DeleteWishlistModel(websiteId: $websiteId, customerToken: $customerToken, itemId: $itemId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DeleteWishlistModelImpl &&
            (identical(other.websiteId, websiteId) ||
                other.websiteId == websiteId) &&
            (identical(other.customerToken, customerToken) ||
                other.customerToken == customerToken) &&
            (identical(other.itemId, itemId) || other.itemId == itemId));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, websiteId, customerToken, itemId);

  /// Create a copy of DeleteWishlistModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DeleteWishlistModelImplCopyWith<_$DeleteWishlistModelImpl> get copyWith =>
      __$$DeleteWishlistModelImplCopyWithImpl<_$DeleteWishlistModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DeleteWishlistModelImplToJson(
      this,
    );
  }
}

abstract class _DeleteWishlistModel implements DeleteWishlistModel {
  const factory _DeleteWishlistModel(
      {required final String websiteId,
      required final String customerToken,
      required final String itemId}) = _$DeleteWishlistModelImpl;

  factory _DeleteWishlistModel.fromJson(Map<String, dynamic> json) =
      _$DeleteWishlistModelImpl.fromJson;

  /// The website ID associated with the delete wish list request.
  @override
  String get websiteId;

  /// The customer token used for authentication in the request.
  @override
  String get customerToken;

  /// The ID of the item to be deleted from the wish list.
  @override
  String get itemId;

  /// Create a copy of DeleteWishlistModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DeleteWishlistModelImplCopyWith<_$DeleteWishlistModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
