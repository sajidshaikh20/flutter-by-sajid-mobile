// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'list_of_notification_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ListOfNotificationResponseImpl _$$ListOfNotificationResponseImplFromJson(
        Map<String, dynamic> json) =>
    _$ListOfNotificationResponseImpl(
      notificationId: (json['notificationId'] as num?)?.toInt(),
      notificationTitle: json['notificationTitle'] as String?,
      notificationSubTitle: json['notificationSubTitle'] as String?,
      notificationDescription: json['notificationDescription'] as String?,
      notificationDescriptionArabic:
          json['notificationDescriptionArabic'] as String?,
      dateTime: json['dateTime'] as String?,
      notificationType: json['notificationType'] as String?,
      orderId: (json['orderId'] as num?)?.toInt(),
      entityId: json['entityId'] as String?,
      isRead: json['isRead'] as bool? ?? false,
    );

Map<String, dynamic> _$$ListOfNotificationResponseImplToJson(
        _$ListOfNotificationResponseImpl instance) =>
    <String, dynamic>{
      'notificationId': instance.notificationId,
      'notificationTitle': instance.notificationTitle,
      'notificationSubTitle': instance.notificationSubTitle,
      'notificationDescription': instance.notificationDescription,
      'notificationDescriptionArabic': instance.notificationDescriptionArabic,
      'dateTime': instance.dateTime,
      'notificationType': instance.notificationType,
      'orderId': instance.orderId,
      'entityId': instance.entityId,
      'isRead': instance.isRead,
    };
