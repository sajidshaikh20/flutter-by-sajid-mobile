// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'place_order_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PlaceOrderResponseModel _$PlaceOrderResponseModelFromJson(
        Map<String, dynamic> json) =>
    PlaceOrderResponseModel(
      success: json['success'] as bool?,
      message: json['message'] as String?,
      cartCount: (json['cartCount'] as num?)?.toInt(),
      isSplitOrder: (json['isSplitOrder'] as num?)?.toInt(),
      email: json['email'] as String?,
      canReorder: json['canReorder'] as bool?,
      customerDetails: json['customerDetails'] == null
          ? null
          : CustomerDetails.fromJson(
              json['customerDetails'] as Map<String, dynamic>),
      orderIds: (json['orderIds'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      incrementIds: (json['incrementIds'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      orderId: json['orderId'] as String?,
      incrementId: json['incrementId'] as String?,
      timeslotDetails: json['timeslotDetails'] == null
          ? null
          : TimeslotDetails.fromJson(
              json['timeslotDetails'] as Map<String, dynamic>),
      date: json['date'] as String?,
      total: (json['total'] as num?)?.toInt(),
      formattedTotal: json['formattedTotal'] as String?,
      amountLabel: json['amountLabel'] as String?,
      orderLabel: json['orderLabel'] as String?,
    );

Map<String, dynamic> _$PlaceOrderResponseModelToJson(
        PlaceOrderResponseModel instance) =>
    <String, dynamic>{
      'success': instance.success,
      'message': instance.message,
      'cartCount': instance.cartCount,
      'isSplitOrder': instance.isSplitOrder,
      'email': instance.email,
      'canReorder': instance.canReorder,
      'customerDetails': instance.customerDetails,
      'orderIds': instance.orderIds,
      'incrementIds': instance.incrementIds,
      'orderId': instance.orderId,
      'incrementId': instance.incrementId,
      'timeslotDetails': instance.timeslotDetails,
      'date': instance.date,
      'total': instance.total,
      'formattedTotal': instance.formattedTotal,
      'amountLabel': instance.amountLabel,
      'orderLabel': instance.orderLabel,
    };

CustomerDetails _$CustomerDetailsFromJson(Map<String, dynamic> json) =>
    CustomerDetails(
      guestCustomer: (json['guestCustomer'] as num?)?.toInt(),
      groupId: (json['groupId'] as num?)?.toInt(),
      firstname: json['firstname'] as String?,
      email: json['email'] as String?,
      lastname: json['lastname'] as String?,
    );

Map<String, dynamic> _$CustomerDetailsToJson(CustomerDetails instance) =>
    <String, dynamic>{
      'guestCustomer': instance.guestCustomer,
      'groupId': instance.groupId,
      'firstname': instance.firstname,
      'email': instance.email,
      'lastname': instance.lastname,
    };
