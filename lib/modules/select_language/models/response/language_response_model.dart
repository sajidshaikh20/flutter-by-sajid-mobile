/// A model class representing the language response from the API.
/// Contains lists of available languages, countries, and social media information.
class LanguageResponseModel {
  /// The list of available languages for the application.
  final List<LanguageList> languageList;

  /// The list of available countries for store selection.
  final List<CountryList> countryList;

  /// Social media links and information.
  final SocialMediaModel? socialMedia;

  /// Creates a [LanguageResponseModel] instance.
  ///
  /// [languageList] defaults to an empty list if not provided.
  /// [countryList] defaults to an empty list if not provided.
  /// [socialMedia] is optional.
  LanguageResponseModel({
    this.languageList = const <LanguageList>[],
    this.countryList = const <CountryList>[],
    this.socialMedia,
  });

  /// Creates a [LanguageResponseModel] instance from a JSON map.
  ///
  /// [json] must contain the language response data in the expected format.
  /// Returns a new instance populated with the JSON data.
  factory LanguageResponseModel.fromJson(Map<String, dynamic> json) {
    return LanguageResponseModel(
      languageList: (json['languageList'] as List<dynamic>?)
          ?.map((dynamic e) => LanguageList.fromJson(e as Map<String, dynamic>))
          .toList() ??
          const <LanguageList>[],
      countryList: (json['countryList'] as List<dynamic>?)
          ?.map((dynamic e) => CountryList.fromJson(e as Map<String, dynamic>))
          .toList() ??
          const <CountryList>[],
      socialMedia: json['social_media'] != null
          ? SocialMediaModel.fromJson(json['social_media'] as Map<String, dynamic>)
          : null,
    );
  }

  /// Converts this [LanguageResponseModel] instance to a JSON map.
  ///
  /// Returns a [Map<String, dynamic>] containing all the language response data
  /// in the format expected by the API.
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'languageList': languageList.map((LanguageList e) => e.toJson()).toList(),
      'countryList': countryList.map((CountryList e) => e.toJson()).toList(),
      'social_media': socialMedia?.toJson(),
    };
  }
}

/// A model class representing a language configuration.
/// Contains language metadata, formatting settings, and currency information.
class LanguageList {
  /// The URL associated with the language.
  final String? url;

  /// The unique identifier for the language.
  final String? languageId;

  /// The display name of the language.
  final String? languageName;

  /// The text alignment for the language (LTR or RTL).
  final String? languageAlignment;

  /// The timestamp of when the language was last updated.
  final String? timeStamp;

  /// The sort code/short code for the language.
  final String? languageSortCode;

  /// The download URL for language resources.
  final String? downloadURL;

  /// The currencies allowed for this language.
  final AllowedCurrencies? allowedCurrencies;

  /// The price formatting configuration for this language.
  final PriceFormat? priceFormat;

  /// The default currency code for this language.
  final String? defaultCurrency;

  /// Creates a [LanguageList] instance.
  ///
  /// All parameters are optional and represent language configuration data.
  LanguageList({
    this.url,
    this.languageId,
    this.languageName,
    this.languageAlignment,
    this.timeStamp,
    this.languageSortCode,
    this.downloadURL,
    this.allowedCurrencies,
    this.priceFormat,
    this.defaultCurrency,
  });

  /// Creates a [LanguageList] instance from a JSON map.
  ///
  /// [json] must contain the language data in the expected format.
  /// Returns a new instance populated with the JSON data.
  factory LanguageList.fromJson(Map<String, dynamic> json) {
    return LanguageList(
      url: json['url'] as String?,
      languageId: json['languageId'] as String?,
      languageName: json['languageName'] as String?,
      languageAlignment: json['languageAlignment'] as String?,
      timeStamp: json['timeStamp'] as String?,
      languageSortCode: json['languageSortCode'] as String?,
      downloadURL: json['downloadURL'] as String?,
      allowedCurrencies: json['allowedCurrencies'] != null
          ? AllowedCurrencies.fromJson(json['allowedCurrencies'] as Map<String, dynamic>)
          : null,
      priceFormat: json['priceFormat'] != null
          ? PriceFormat.fromJson(json['priceFormat'] as Map<String, dynamic>)
          : null,
      defaultCurrency: json['defaultCurrency'] as String?,
    );
  }

  /// Converts this [LanguageList] instance to a JSON map.
  ///
  /// Returns a [Map<String, dynamic>] containing all the language data
  /// in the format expected by the API.
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'url': url,
      'languageId': languageId,
      'languageName': languageName,
      'languageAlignment': languageAlignment,
      'timeStamp': timeStamp,
      'languageSortCode': languageSortCode,
      'downloadURL': downloadURL,
      'allowedCurrencies': allowedCurrencies?.toJson(),
      'priceFormat': priceFormat?.toJson(),
      'defaultCurrency': defaultCurrency,
    };
  }
}

/// A model class representing currency information.
/// Contains the display label and currency code.
class AllowedCurrencies {
  /// The display label/name of the currency.
  final String? label;

  /// The currency code (e.g., "USD", "EUR").
  final String? code;

  /// Creates an [AllowedCurrencies] instance.
  ///
  /// [label] and [code] are optional parameters representing currency information.
  AllowedCurrencies({this.label, this.code});

  /// Creates an [AllowedCurrencies] instance from a JSON map.
  ///
  /// [json] must contain the currency data in the expected format.
  /// Returns a new instance populated with the JSON data.
  factory AllowedCurrencies.fromJson(Map<String, dynamic> json) {
    return AllowedCurrencies(
      label: json['label'] as String?,
      code: json['code'] as String?,
    );
  }

  /// Converts this [AllowedCurrencies] instance to a JSON map.
  ///
  /// Returns a [Map<String, dynamic>] containing the currency data
  /// in the format expected by the API.
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'label': label,
      'code': code,
    };
  }
}

/// A model class representing price formatting configuration.
/// Defines how prices should be displayed with pattern, precision, and decimal symbols.
class PriceFormat {
  /// The formatting pattern for displaying prices.
  final String? pattern;

  /// The number of decimal places to display.
  final int? precision;

  /// The minimum required precision for price display.
  final int? requiredPrecision;

  /// The symbol used for decimal separation (e.g., ".", ",").
  final String? decimalSymbol;

  /// Creates a [PriceFormat] instance.
  ///
  /// All parameters are optional and define how prices should be formatted.
  PriceFormat({
    this.pattern,
    this.precision,
    this.requiredPrecision,
    this.decimalSymbol,
  });

  /// Creates a [PriceFormat] instance from a JSON map.
  ///
  /// [json] must contain the price format data in the expected format.
  /// Returns a new instance populated with the JSON data.
  factory PriceFormat.fromJson(Map<String, dynamic> json) {
    return PriceFormat(
      pattern: json['pattern'] as String?,
      precision: (json['precision'] as num?)?.toInt(),
      requiredPrecision: (json['requiredPrecision'] as num?)?.toInt(),
      decimalSymbol: json['decimalSymbol'] as String?,
    );
  }

  /// Converts this [PriceFormat] instance to a JSON map.
  ///
  /// Returns a [Map<String, dynamic>] containing the price format data
  /// in the format expected by the API.
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'pattern': pattern,
      'precision': precision,
      'requiredPrecision': requiredPrecision,
      'decimalSymbol': decimalSymbol,
    };
  }
}

/// A model class representing country information.
/// Contains country details, store information, and contact details.
class CountryList {
  /// The unique identifier for the website.
  final String? websiteId;

  /// The store information associated with this country.
  final dynamic store;

  /// The unique identifier for the country.
  final String? countryId;

  /// The display name of the country.
  final String? countryName;

  /// The country flag URL or emoji.
  final String? countryFlag;

  /// Contact information for this country.
  final ContactUs? contactUs;

  /// The country code (e.g., "US", "GB").
  final String? countryCode;

  /// The Arabic name of the country.
  final String? arabicName;

  /// Creates a [CountryList] instance.
  ///
  /// All parameters are optional and represent country-specific information.
  CountryList({
    this.websiteId,
    this.store,
    this.countryId,
    this.countryName,
    this.countryFlag,
    this.contactUs,
    this.countryCode,
    this.arabicName, // ✅ Add in constructor
  });

  /// Creates a [CountryList] instance from a JSON map.
  ///
  /// [json] must contain the country data in the expected format.
  /// Returns a new instance populated with the JSON data.
  factory CountryList.fromJson(Map<String, dynamic> json) {
    return CountryList(
      websiteId: json['websiteId'] as String?,
      store: json['store'] as dynamic,
      countryId: json['countryId'] as String?,
      countryName: json['countryName'] as String?,
      countryFlag: json['countryFlag'] as String?,
      contactUs: json['contactUs'] != null
          ? ContactUs.fromJson(json['contactUs'] as Map<String, dynamic>)
          : null,
      countryCode: json['countryCode'] as String?,
      arabicName: json['arabicName'] as String?, // ✅ Parse from JSON
    );
  }

  /// Converts this [CountryList] instance to a JSON map.
  ///
  /// Returns a [Map<String, dynamic>] containing the country data
  /// in the format expected by the API.
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'websiteId': websiteId,
      'store': store,
      'countryId': countryId,
      'countryName': countryName,
      'countryFlag': countryFlag,
      'contactUs': contactUs?.toJson(),
      'countryCode': countryCode,
      'arabicName': arabicName, // ✅ Add in toJson
    };
  }
}


/// A model class representing contact information.
/// Contains phone, email, and WhatsApp contact details.
class ContactUs {
  /// The phone number for contact.
  final String? phone;

  /// The email address for contact.
  final String? email;

  /// The WhatsApp number for contact.
  final String? whatsapp;

  /// Creates a [ContactUs] instance.
  ///
  /// [phone], [email], and [whatsapp] are optional contact information fields.
  ContactUs({this.phone, this.email, this.whatsapp});

  /// Creates a [ContactUs] instance from a JSON map.
  ///
  /// [json] must contain the contact information in the expected format.
  /// Returns a new instance populated with the JSON data.
  factory ContactUs.fromJson(Map<String, dynamic> json) {
    return ContactUs(
      phone: json['phone'] as String?,
      email: json['email'] as String?,
      whatsapp: json['whatsapp'] as String?,
    );
  }

  /// Converts this [ContactUs] instance to a JSON map.
  ///
  /// Returns a [Map<String, dynamic>] containing the contact information
  /// in the format expected by the API.
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'phone': phone,
      'email': email,
      'whatsapp': whatsapp,
    };
  }
}

/// A model class representing social media links.
/// Contains URLs for YouTube, Instagram, and Facebook.
class SocialMediaModel {
  /// The YouTube channel URL.
  final String? youtube;

  /// The Instagram profile URL.
  final String? insta;

  /// The Facebook page URL.
  final String? facebook;

  /// Creates a [SocialMediaModel] instance.
  ///
  /// [youtube], [insta], and [facebook] are optional social media URLs.
  SocialMediaModel({this.youtube, this.insta, this.facebook});

  /// Creates a [SocialMediaModel] instance from a JSON map.
  ///
  /// [json] must contain the social media URLs in the expected format.
  /// Returns a new instance populated with the JSON data.
  factory SocialMediaModel.fromJson(Map<String, dynamic> json) {
    return SocialMediaModel(
      youtube: json['youtube'] as String?,
      insta: json['insta'] as String?,
      facebook: json['facebook'] as String?,
    );
  }

  /// Converts this [SocialMediaModel] instance to a JSON map.
  ///
  /// Returns a [Map<String, dynamic>] containing the social media URLs
  /// in the format expected by the API.
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'youtube': youtube,
      'insta': insta,
      'facebook': facebook,
    };
  }
}
