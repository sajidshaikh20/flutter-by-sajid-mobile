// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'address_data_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddressDataModel _$AddressDataModelFromJson(Map<String, dynamic> json) =>
    AddressDataModel(
      firstname: json['firstname'] as String?,
      mobilenumber: json['mobilenumber'] as String?,
      city: json['city'] as String?,
      prefix: json['prefix'] as String?,
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      suffix: json['suffix'] as String?,
      vatRequestDate: json['vat_request_date'] as String?,
      vatRequestId: json['vat_request_id'] as String?,
      updatedAt: json['updated_at'] == null
          ? null
          : DateTime.parse(json['updated_at'] as String),
      addressTitle: json['address_title'] as String?,
      incrementId: json['increment_id'] as String?,
      street:
          (json['street'] as List<dynamic>?)?.map((e) => e as String).toList(),
      vatRequestSuccess: json['vat_request_success'] as String?,
      vatId: json['vat_id'] as String?,
      company: json['company'] as String?,
      fax: json['fax'] as String?,
      isDefaultShipping: json['isDefaultShipping'] as bool?,
      isActive: json['is_active'] as String?,
      postcode: json['postcode'] as String?,
      regionId: json['region_id'] as String?,
      middlename: json['middlename'] as String?,
      telephone: json['telephone'] as String?,
      entityId: json['entity_id'] as String?,
      mobileNumberPrefix: json['mobileNumberPrefix'] as String?,
      lastname: json['lastname'] as String?,
      parentId: json['parent_id'] as String?,
      vatIsValid: json['vat_is_valid'] as String?,
      region: json['region'] as String?,
      countryId: json['country_id'] as String?,
    );

Map<String, dynamic> _$AddressDataModelToJson(AddressDataModel instance) =>
    <String, dynamic>{
      'firstname': instance.firstname,
      'mobilenumber': instance.mobilenumber,
      'city': instance.city,
      'prefix': instance.prefix,
      'created_at': instance.createdAt?.toIso8601String(),
      'suffix': instance.suffix,
      'vat_request_date': instance.vatRequestDate,
      'vat_request_id': instance.vatRequestId,
      'updated_at': instance.updatedAt?.toIso8601String(),
      'address_title': instance.addressTitle,
      'increment_id': instance.incrementId,
      'street': instance.street,
      'vat_request_success': instance.vatRequestSuccess,
      'vat_id': instance.vatId,
      'company': instance.company,
      'fax': instance.fax,
      'isDefaultShipping': instance.isDefaultShipping,
      'is_active': instance.isActive,
      'postcode': instance.postcode,
      'region_id': instance.regionId,
      'middlename': instance.middlename,
      'telephone': instance.telephone,
      'entity_id': instance.entityId,
      'mobileNumberPrefix': instance.mobileNumberPrefix,
      'lastname': instance.lastname,
      'parent_id': instance.parentId,
      'vat_is_valid': instance.vatIsValid,
      'region': instance.region,
      'country_id': instance.countryId,
    };
