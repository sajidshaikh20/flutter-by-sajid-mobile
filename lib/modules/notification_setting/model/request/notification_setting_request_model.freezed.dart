// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'notification_setting_request_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

NotificationSettingRequestModel _$NotificationSettingRequestModelFromJson(
    Map<String, dynamic> json) {
  return _NotificationSettingRequestModel.fromJson(json);
}

/// @nodoc
mixin _$NotificationSettingRequestModel {
  /// The language ID for localization.
  int? get languageId => throw _privateConstructorUsedError;

  /// The platform identifier (e.g., 'android', 'ios', 'web').
  String? get platform => throw _privateConstructorUsedError;

  /// The app version.
  String? get version => throw _privateConstructorUsedError;

  /// The customer authentication token.
  String? get customerToken => throw _privateConstructorUsedError;

  /// Whether to receive order status notifications.
  bool? get orderStatus => throw _privateConstructorUsedError;

  /// Whether to receive loyalty points notifications.
  bool? get loyalityPoints => throw _privateConstructorUsedError;

  /// Whether to receive promotion and offers notifications.
  bool? get promotionOffers => throw _privateConstructorUsedError;

  /// Serializes this NotificationSettingRequestModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of NotificationSettingRequestModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $NotificationSettingRequestModelCopyWith<NotificationSettingRequestModel>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NotificationSettingRequestModelCopyWith<$Res> {
  factory $NotificationSettingRequestModelCopyWith(
          NotificationSettingRequestModel value,
          $Res Function(NotificationSettingRequestModel) then) =
      _$NotificationSettingRequestModelCopyWithImpl<$Res,
          NotificationSettingRequestModel>;
  @useResult
  $Res call(
      {int? languageId,
      String? platform,
      String? version,
      String? customerToken,
      bool? orderStatus,
      bool? loyalityPoints,
      bool? promotionOffers});
}

/// @nodoc
class _$NotificationSettingRequestModelCopyWithImpl<$Res,
        $Val extends NotificationSettingRequestModel>
    implements $NotificationSettingRequestModelCopyWith<$Res> {
  _$NotificationSettingRequestModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of NotificationSettingRequestModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? languageId = freezed,
    Object? platform = freezed,
    Object? version = freezed,
    Object? customerToken = freezed,
    Object? orderStatus = freezed,
    Object? loyalityPoints = freezed,
    Object? promotionOffers = freezed,
  }) {
    return _then(_value.copyWith(
      languageId: freezed == languageId
          ? _value.languageId
          : languageId // ignore: cast_nullable_to_non_nullable
              as int?,
      platform: freezed == platform
          ? _value.platform
          : platform // ignore: cast_nullable_to_non_nullable
              as String?,
      version: freezed == version
          ? _value.version
          : version // ignore: cast_nullable_to_non_nullable
              as String?,
      customerToken: freezed == customerToken
          ? _value.customerToken
          : customerToken // ignore: cast_nullable_to_non_nullable
              as String?,
      orderStatus: freezed == orderStatus
          ? _value.orderStatus
          : orderStatus // ignore: cast_nullable_to_non_nullable
              as bool?,
      loyalityPoints: freezed == loyalityPoints
          ? _value.loyalityPoints
          : loyalityPoints // ignore: cast_nullable_to_non_nullable
              as bool?,
      promotionOffers: freezed == promotionOffers
          ? _value.promotionOffers
          : promotionOffers // ignore: cast_nullable_to_non_nullable
              as bool?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$NotificationSettingRequestModelImplCopyWith<$Res>
    implements $NotificationSettingRequestModelCopyWith<$Res> {
  factory _$$NotificationSettingRequestModelImplCopyWith(
          _$NotificationSettingRequestModelImpl value,
          $Res Function(_$NotificationSettingRequestModelImpl) then) =
      __$$NotificationSettingRequestModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int? languageId,
      String? platform,
      String? version,
      String? customerToken,
      bool? orderStatus,
      bool? loyalityPoints,
      bool? promotionOffers});
}

/// @nodoc
class __$$NotificationSettingRequestModelImplCopyWithImpl<$Res>
    extends _$NotificationSettingRequestModelCopyWithImpl<$Res,
        _$NotificationSettingRequestModelImpl>
    implements _$$NotificationSettingRequestModelImplCopyWith<$Res> {
  __$$NotificationSettingRequestModelImplCopyWithImpl(
      _$NotificationSettingRequestModelImpl _value,
      $Res Function(_$NotificationSettingRequestModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of NotificationSettingRequestModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? languageId = freezed,
    Object? platform = freezed,
    Object? version = freezed,
    Object? customerToken = freezed,
    Object? orderStatus = freezed,
    Object? loyalityPoints = freezed,
    Object? promotionOffers = freezed,
  }) {
    return _then(_$NotificationSettingRequestModelImpl(
      languageId: freezed == languageId
          ? _value.languageId
          : languageId // ignore: cast_nullable_to_non_nullable
              as int?,
      platform: freezed == platform
          ? _value.platform
          : platform // ignore: cast_nullable_to_non_nullable
              as String?,
      version: freezed == version
          ? _value.version
          : version // ignore: cast_nullable_to_non_nullable
              as String?,
      customerToken: freezed == customerToken
          ? _value.customerToken
          : customerToken // ignore: cast_nullable_to_non_nullable
              as String?,
      orderStatus: freezed == orderStatus
          ? _value.orderStatus
          : orderStatus // ignore: cast_nullable_to_non_nullable
              as bool?,
      loyalityPoints: freezed == loyalityPoints
          ? _value.loyalityPoints
          : loyalityPoints // ignore: cast_nullable_to_non_nullable
              as bool?,
      promotionOffers: freezed == promotionOffers
          ? _value.promotionOffers
          : promotionOffers // ignore: cast_nullable_to_non_nullable
              as bool?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$NotificationSettingRequestModelImpl
    implements _NotificationSettingRequestModel {
  const _$NotificationSettingRequestModelImpl(
      {this.languageId,
      this.platform,
      this.version,
      this.customerToken,
      this.orderStatus,
      this.loyalityPoints,
      this.promotionOffers});

  factory _$NotificationSettingRequestModelImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$NotificationSettingRequestModelImplFromJson(json);

  /// The language ID for localization.
  @override
  final int? languageId;

  /// The platform identifier (e.g., 'android', 'ios', 'web').
  @override
  final String? platform;

  /// The app version.
  @override
  final String? version;

  /// The customer authentication token.
  @override
  final String? customerToken;

  /// Whether to receive order status notifications.
  @override
  final bool? orderStatus;

  /// Whether to receive loyalty points notifications.
  @override
  final bool? loyalityPoints;

  /// Whether to receive promotion and offers notifications.
  @override
  final bool? promotionOffers;

  @override
  String toString() {
    return 'NotificationSettingRequestModel(languageId: $languageId, platform: $platform, version: $version, customerToken: $customerToken, orderStatus: $orderStatus, loyalityPoints: $loyalityPoints, promotionOffers: $promotionOffers)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NotificationSettingRequestModelImpl &&
            (identical(other.languageId, languageId) ||
                other.languageId == languageId) &&
            (identical(other.platform, platform) ||
                other.platform == platform) &&
            (identical(other.version, version) || other.version == version) &&
            (identical(other.customerToken, customerToken) ||
                other.customerToken == customerToken) &&
            (identical(other.orderStatus, orderStatus) ||
                other.orderStatus == orderStatus) &&
            (identical(other.loyalityPoints, loyalityPoints) ||
                other.loyalityPoints == loyalityPoints) &&
            (identical(other.promotionOffers, promotionOffers) ||
                other.promotionOffers == promotionOffers));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, languageId, platform, version,
      customerToken, orderStatus, loyalityPoints, promotionOffers);

  /// Create a copy of NotificationSettingRequestModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$NotificationSettingRequestModelImplCopyWith<
          _$NotificationSettingRequestModelImpl>
      get copyWith => __$$NotificationSettingRequestModelImplCopyWithImpl<
          _$NotificationSettingRequestModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$NotificationSettingRequestModelImplToJson(
      this,
    );
  }
}

abstract class _NotificationSettingRequestModel
    implements NotificationSettingRequestModel {
  const factory _NotificationSettingRequestModel(
      {final int? languageId,
      final String? platform,
      final String? version,
      final String? customerToken,
      final bool? orderStatus,
      final bool? loyalityPoints,
      final bool? promotionOffers}) = _$NotificationSettingRequestModelImpl;

  factory _NotificationSettingRequestModel.fromJson(Map<String, dynamic> json) =
      _$NotificationSettingRequestModelImpl.fromJson;

  /// The language ID for localization.
  @override
  int? get languageId;

  /// The platform identifier (e.g., 'android', 'ios', 'web').
  @override
  String? get platform;

  /// The app version.
  @override
  String? get version;

  /// The customer authentication token.
  @override
  String? get customerToken;

  /// Whether to receive order status notifications.
  @override
  bool? get orderStatus;

  /// Whether to receive loyalty points notifications.
  @override
  bool? get loyalityPoints;

  /// Whether to receive promotion and offers notifications.
  @override
  bool? get promotionOffers;

  /// Create a copy of NotificationSettingRequestModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$NotificationSettingRequestModelImplCopyWith<
          _$NotificationSettingRequestModelImpl>
      get copyWith => throw _privateConstructorUsedError;
}
