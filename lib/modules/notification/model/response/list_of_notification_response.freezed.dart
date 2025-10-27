// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'list_of_notification_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ListOfNotificationResponse _$ListOfNotificationResponseFromJson(
    Map<String, dynamic> json) {
  return _ListOfNotificationResponse.fromJson(json);
}

/// @nodoc
mixin _$ListOfNotificationResponse {
  /// The unique identifier for the notification.
  int? get notificationId => throw _privateConstructorUsedError;

  /// The title of the notification.
  String? get notificationTitle => throw _privateConstructorUsedError;

  /// The subtitle of the notification.
  String? get notificationSubTitle => throw _privateConstructorUsedError;

  /// The detailed description of the notification.
  String? get notificationDescription => throw _privateConstructorUsedError;

  /// The detailed description of the notification in Arabic.
  String? get notificationDescriptionArabic =>
      throw _privateConstructorUsedError;

  /// The date and time when the notification was created.
  String? get dateTime => throw _privateConstructorUsedError;

  /// The type of notification (e.g., 'order', 'promotion', 'loyalty').
  String? get notificationType => throw _privateConstructorUsedError;

  ///order Id
  int? get orderId => throw _privateConstructorUsedError;

  ///Product id array
  String? get entityId => throw _privateConstructorUsedError;

  /// Whether the notification has been read by the user.
  bool get isRead => throw _privateConstructorUsedError;

  /// Serializes this ListOfNotificationResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ListOfNotificationResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ListOfNotificationResponseCopyWith<ListOfNotificationResponse>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ListOfNotificationResponseCopyWith<$Res> {
  factory $ListOfNotificationResponseCopyWith(ListOfNotificationResponse value,
          $Res Function(ListOfNotificationResponse) then) =
      _$ListOfNotificationResponseCopyWithImpl<$Res,
          ListOfNotificationResponse>;
  @useResult
  $Res call(
      {int? notificationId,
      String? notificationTitle,
      String? notificationSubTitle,
      String? notificationDescription,
      String? notificationDescriptionArabic,
      String? dateTime,
      String? notificationType,
      int? orderId,
      String? entityId,
      bool isRead});
}

/// @nodoc
class _$ListOfNotificationResponseCopyWithImpl<$Res,
        $Val extends ListOfNotificationResponse>
    implements $ListOfNotificationResponseCopyWith<$Res> {
  _$ListOfNotificationResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ListOfNotificationResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? notificationId = freezed,
    Object? notificationTitle = freezed,
    Object? notificationSubTitle = freezed,
    Object? notificationDescription = freezed,
    Object? notificationDescriptionArabic = freezed,
    Object? dateTime = freezed,
    Object? notificationType = freezed,
    Object? orderId = freezed,
    Object? entityId = freezed,
    Object? isRead = null,
  }) {
    return _then(_value.copyWith(
      notificationId: freezed == notificationId
          ? _value.notificationId
          : notificationId // ignore: cast_nullable_to_non_nullable
              as int?,
      notificationTitle: freezed == notificationTitle
          ? _value.notificationTitle
          : notificationTitle // ignore: cast_nullable_to_non_nullable
              as String?,
      notificationSubTitle: freezed == notificationSubTitle
          ? _value.notificationSubTitle
          : notificationSubTitle // ignore: cast_nullable_to_non_nullable
              as String?,
      notificationDescription: freezed == notificationDescription
          ? _value.notificationDescription
          : notificationDescription // ignore: cast_nullable_to_non_nullable
              as String?,
      notificationDescriptionArabic: freezed == notificationDescriptionArabic
          ? _value.notificationDescriptionArabic
          : notificationDescriptionArabic // ignore: cast_nullable_to_non_nullable
              as String?,
      dateTime: freezed == dateTime
          ? _value.dateTime
          : dateTime // ignore: cast_nullable_to_non_nullable
              as String?,
      notificationType: freezed == notificationType
          ? _value.notificationType
          : notificationType // ignore: cast_nullable_to_non_nullable
              as String?,
      orderId: freezed == orderId
          ? _value.orderId
          : orderId // ignore: cast_nullable_to_non_nullable
              as int?,
      entityId: freezed == entityId
          ? _value.entityId
          : entityId // ignore: cast_nullable_to_non_nullable
              as String?,
      isRead: null == isRead
          ? _value.isRead
          : isRead // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ListOfNotificationResponseImplCopyWith<$Res>
    implements $ListOfNotificationResponseCopyWith<$Res> {
  factory _$$ListOfNotificationResponseImplCopyWith(
          _$ListOfNotificationResponseImpl value,
          $Res Function(_$ListOfNotificationResponseImpl) then) =
      __$$ListOfNotificationResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int? notificationId,
      String? notificationTitle,
      String? notificationSubTitle,
      String? notificationDescription,
      String? notificationDescriptionArabic,
      String? dateTime,
      String? notificationType,
      int? orderId,
      String? entityId,
      bool isRead});
}

/// @nodoc
class __$$ListOfNotificationResponseImplCopyWithImpl<$Res>
    extends _$ListOfNotificationResponseCopyWithImpl<$Res,
        _$ListOfNotificationResponseImpl>
    implements _$$ListOfNotificationResponseImplCopyWith<$Res> {
  __$$ListOfNotificationResponseImplCopyWithImpl(
      _$ListOfNotificationResponseImpl _value,
      $Res Function(_$ListOfNotificationResponseImpl) _then)
      : super(_value, _then);

  /// Create a copy of ListOfNotificationResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? notificationId = freezed,
    Object? notificationTitle = freezed,
    Object? notificationSubTitle = freezed,
    Object? notificationDescription = freezed,
    Object? notificationDescriptionArabic = freezed,
    Object? dateTime = freezed,
    Object? notificationType = freezed,
    Object? orderId = freezed,
    Object? entityId = freezed,
    Object? isRead = null,
  }) {
    return _then(_$ListOfNotificationResponseImpl(
      notificationId: freezed == notificationId
          ? _value.notificationId
          : notificationId // ignore: cast_nullable_to_non_nullable
              as int?,
      notificationTitle: freezed == notificationTitle
          ? _value.notificationTitle
          : notificationTitle // ignore: cast_nullable_to_non_nullable
              as String?,
      notificationSubTitle: freezed == notificationSubTitle
          ? _value.notificationSubTitle
          : notificationSubTitle // ignore: cast_nullable_to_non_nullable
              as String?,
      notificationDescription: freezed == notificationDescription
          ? _value.notificationDescription
          : notificationDescription // ignore: cast_nullable_to_non_nullable
              as String?,
      notificationDescriptionArabic: freezed == notificationDescriptionArabic
          ? _value.notificationDescriptionArabic
          : notificationDescriptionArabic // ignore: cast_nullable_to_non_nullable
              as String?,
      dateTime: freezed == dateTime
          ? _value.dateTime
          : dateTime // ignore: cast_nullable_to_non_nullable
              as String?,
      notificationType: freezed == notificationType
          ? _value.notificationType
          : notificationType // ignore: cast_nullable_to_non_nullable
              as String?,
      orderId: freezed == orderId
          ? _value.orderId
          : orderId // ignore: cast_nullable_to_non_nullable
              as int?,
      entityId: freezed == entityId
          ? _value.entityId
          : entityId // ignore: cast_nullable_to_non_nullable
              as String?,
      isRead: null == isRead
          ? _value.isRead
          : isRead // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ListOfNotificationResponseImpl implements _ListOfNotificationResponse {
  const _$ListOfNotificationResponseImpl(
      {this.notificationId,
      this.notificationTitle,
      this.notificationSubTitle,
      this.notificationDescription,
      this.notificationDescriptionArabic,
      this.dateTime,
      this.notificationType,
      this.orderId,
      this.entityId,
      this.isRead = false});

  factory _$ListOfNotificationResponseImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$ListOfNotificationResponseImplFromJson(json);

  /// The unique identifier for the notification.
  @override
  final int? notificationId;

  /// The title of the notification.
  @override
  final String? notificationTitle;

  /// The subtitle of the notification.
  @override
  final String? notificationSubTitle;

  /// The detailed description of the notification.
  @override
  final String? notificationDescription;

  /// The detailed description of the notification in Arabic.
  @override
  final String? notificationDescriptionArabic;

  /// The date and time when the notification was created.
  @override
  final String? dateTime;

  /// The type of notification (e.g., 'order', 'promotion', 'loyalty').
  @override
  final String? notificationType;

  ///order Id
  @override
  final int? orderId;

  ///Product id array
  @override
  final String? entityId;

  /// Whether the notification has been read by the user.
  @override
  @JsonKey()
  final bool isRead;

  @override
  String toString() {
    return 'ListOfNotificationResponse(notificationId: $notificationId, notificationTitle: $notificationTitle, notificationSubTitle: $notificationSubTitle, notificationDescription: $notificationDescription, notificationDescriptionArabic: $notificationDescriptionArabic, dateTime: $dateTime, notificationType: $notificationType, orderId: $orderId, entityId: $entityId, isRead: $isRead)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ListOfNotificationResponseImpl &&
            (identical(other.notificationId, notificationId) ||
                other.notificationId == notificationId) &&
            (identical(other.notificationTitle, notificationTitle) ||
                other.notificationTitle == notificationTitle) &&
            (identical(other.notificationSubTitle, notificationSubTitle) ||
                other.notificationSubTitle == notificationSubTitle) &&
            (identical(
                    other.notificationDescription, notificationDescription) ||
                other.notificationDescription == notificationDescription) &&
            (identical(other.notificationDescriptionArabic,
                    notificationDescriptionArabic) ||
                other.notificationDescriptionArabic ==
                    notificationDescriptionArabic) &&
            (identical(other.dateTime, dateTime) ||
                other.dateTime == dateTime) &&
            (identical(other.notificationType, notificationType) ||
                other.notificationType == notificationType) &&
            (identical(other.orderId, orderId) || other.orderId == orderId) &&
            (identical(other.entityId, entityId) ||
                other.entityId == entityId) &&
            (identical(other.isRead, isRead) || other.isRead == isRead));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      notificationId,
      notificationTitle,
      notificationSubTitle,
      notificationDescription,
      notificationDescriptionArabic,
      dateTime,
      notificationType,
      orderId,
      entityId,
      isRead);

  /// Create a copy of ListOfNotificationResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ListOfNotificationResponseImplCopyWith<_$ListOfNotificationResponseImpl>
      get copyWith => __$$ListOfNotificationResponseImplCopyWithImpl<
          _$ListOfNotificationResponseImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ListOfNotificationResponseImplToJson(
      this,
    );
  }
}

abstract class _ListOfNotificationResponse
    implements ListOfNotificationResponse {
  const factory _ListOfNotificationResponse(
      {final int? notificationId,
      final String? notificationTitle,
      final String? notificationSubTitle,
      final String? notificationDescription,
      final String? notificationDescriptionArabic,
      final String? dateTime,
      final String? notificationType,
      final int? orderId,
      final String? entityId,
      final bool isRead}) = _$ListOfNotificationResponseImpl;

  factory _ListOfNotificationResponse.fromJson(Map<String, dynamic> json) =
      _$ListOfNotificationResponseImpl.fromJson;

  /// The unique identifier for the notification.
  @override
  int? get notificationId;

  /// The title of the notification.
  @override
  String? get notificationTitle;

  /// The subtitle of the notification.
  @override
  String? get notificationSubTitle;

  /// The detailed description of the notification.
  @override
  String? get notificationDescription;

  /// The detailed description of the notification in Arabic.
  @override
  String? get notificationDescriptionArabic;

  /// The date and time when the notification was created.
  @override
  String? get dateTime;

  /// The type of notification (e.g., 'order', 'promotion', 'loyalty').
  @override
  String? get notificationType;

  ///order Id
  @override
  int? get orderId;

  ///Product id array
  @override
  String? get entityId;

  /// Whether the notification has been read by the user.
  @override
  bool get isRead;

  /// Create a copy of ListOfNotificationResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ListOfNotificationResponseImplCopyWith<_$ListOfNotificationResponseImpl>
      get copyWith => throw _privateConstructorUsedError;
}
