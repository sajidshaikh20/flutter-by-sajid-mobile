// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_address_request_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddAddressRequestModel _$AddAddressRequestModelFromJson(
        Map<String, dynamic> json) =>
    AddAddressRequestModel(
      websiteId: json['websiteId'] as String?,
      storeId: json['storeId'] as String?,
      customerToken: json['customerToken'] as String?,
      addressId: json['addressId'] as String?,
      addressData: json['addressData'] as String?,
    );

Map<String, dynamic> _$AddAddressRequestModelToJson(
        AddAddressRequestModel instance) =>
    <String, dynamic>{
      'websiteId': instance.websiteId,
      'storeId': instance.storeId,
      'customerToken': instance.customerToken,
      'addressId': instance.addressId,
      'addressData': instance.addressData,
    };

AddressDataToAdd _$AddressDataToAddFromJson(Map<String, dynamic> json) =>
    AddressDataToAdd(
      firstName: json['firstName'] as String?,
      lastName: json['lastName'] as String?,
      mobileNumber: json['mobileNumber'] as String?,
      company: json['company'] as String?,
      mobileNumberPrefix: json['mobileNumberPrefix'] as String?,
      addressTitle: json['address_title'] as String?,
      street:
          (json['street'] as List<dynamic>?)?.map((e) => e as String).toList(),
      city: json['city'] as String?,
      regionId: json['region_id'] as String?,
      region: json['region'] as String?,
      latitude: json['latitude'] as String?,
      longitude: json['longitude'] as String?,
      countryId: json['country_id'] as String?,
      defaultBilling: json['default_billing'] as String?,
      defaultShipping: json['default_shipping'] as String?,
      saveInAddressBook: json['saveInAddressBook'] as String?,
      postcode: json['postcode'] as String?,
    );

Map<String, dynamic> _$AddressDataToAddToJson(AddressDataToAdd instance) =>
    <String, dynamic>{
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'mobileNumber': instance.mobileNumber,
      'mobileNumberPrefix': instance.mobileNumberPrefix,
      'address_title': instance.addressTitle,
      'street': instance.street,
      'city': instance.city,
      'region_id': instance.regionId,
      'region': instance.region,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'country_id': instance.countryId,
      'default_billing': instance.defaultBilling,
      'default_shipping': instance.defaultShipping,
      'saveInAddressBook': instance.saveInAddressBook,
      'postcode': instance.postcode,
      'company': instance.company,
    };
