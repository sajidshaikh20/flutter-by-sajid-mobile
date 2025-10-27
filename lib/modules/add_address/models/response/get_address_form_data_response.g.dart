// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_address_form_data_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetAddressFormDataResponse _$GetAddressFormDataResponseFromJson(
        Map<String, dynamic> json) =>
    GetAddressFormDataResponse(
      success: json['success'] as bool?,
      message: json['message'] as String?,
      addressDataModel: json['addressData'] == null
          ? null
          : AddressDataModel.fromJson(
              json['addressData'] as Map<String, dynamic>),
      isCompanyVisible: json['isCompanyVisible'] as bool?,
      isCompanyRequired: json['isCompanyRequired'] as bool?,
      isTelephoneVisible: json['isTelephoneVisible'] as bool?,
      isTelephoneRequired: json['isTelephoneRequired'] as bool?,
      isFaxVisible: json['isFaxVisible'] as bool?,
      isPrefixVisible: json['isPrefixVisible'] as bool?,
      isMiddlenameVisible: json['isMiddlenameVisible'] as bool?,
      isSuffixVisible: json['isSuffixVisible'] as bool?,
      isDOBVisible: json['isDOBVisible'] as bool?,
      isTaxVisible: json['isTaxVisible'] as bool?,
      isGenderVisible: json['isGenderVisible'] as bool?,
      isAddressTitleVisible: json['isAddressTitleVisible'] as bool?,
      isAddressTitleRequired: json['isAddressTitleRequired'] as bool?,
      countryData: (json['countryData'] as List<dynamic>?)
          ?.map((e) => CountryData.fromJson(e as Map<String, dynamic>))
          .toList(),
      countryDatas: (json['countryDatas'] as List<dynamic>?)
          ?.map((e) => CountryData.fromJson(e as Map<String, dynamic>))
          .toList(),
      lastname: json['lastname'] as String?,
      firstname: json['firstname'] as String?,
      defaultCountry: json['defaultCountry'] as String?,
      streetLineCount: (json['streetLineCount'] as num?)?.toInt(),
      allowToChooseState: json['allowToChooseState'] as bool?,
      eTag: json['eTag'] as String?,
    );

Map<String, dynamic> _$GetAddressFormDataResponseToJson(
        GetAddressFormDataResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'message': instance.message,
      'addressData': instance.addressDataModel,
      'isCompanyVisible': instance.isCompanyVisible,
      'isCompanyRequired': instance.isCompanyRequired,
      'isTelephoneVisible': instance.isTelephoneVisible,
      'isTelephoneRequired': instance.isTelephoneRequired,
      'isFaxVisible': instance.isFaxVisible,
      'isPrefixVisible': instance.isPrefixVisible,
      'isMiddlenameVisible': instance.isMiddlenameVisible,
      'isSuffixVisible': instance.isSuffixVisible,
      'isDOBVisible': instance.isDOBVisible,
      'isTaxVisible': instance.isTaxVisible,
      'isGenderVisible': instance.isGenderVisible,
      'isAddressTitleVisible': instance.isAddressTitleVisible,
      'isAddressTitleRequired': instance.isAddressTitleRequired,
      'countryData': instance.countryData,
      'countryDatas': instance.countryDatas,
      'lastname': instance.lastname,
      'firstname': instance.firstname,
      'defaultCountry': instance.defaultCountry,
      'streetLineCount': instance.streetLineCount,
      'allowToChooseState': instance.allowToChooseState,
      'eTag': instance.eTag,
    };

CountryData _$CountryDataFromJson(Map<String, dynamic> json) => CountryData(
      name: json['name'] as String?,
      countryId: json['country_id'] as String?,
      isStateRequired: json['isStateRequired'] as bool?,
      isZipOptional: json['isZipOptional'] as bool?,
      states: (json['states'] as List<dynamic>?)
          ?.map((e) => States.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$CountryDataToJson(CountryData instance) =>
    <String, dynamic>{
      'name': instance.name,
      'country_id': instance.countryId,
      'isStateRequired': instance.isStateRequired,
      'isZipOptional': instance.isZipOptional,
      'states': instance.states,
    };

States _$StatesFromJson(Map<String, dynamic> json) => States(
      code: json['code'] as String?,
      name: json['name'] as String?,
      regionId: json['region_id'] as String?,
    );

Map<String, dynamic> _$StatesToJson(States instance) => <String, dynamic>{
      'code': instance.code,
      'name': instance.name,
      'region_id': instance.regionId,
    };
