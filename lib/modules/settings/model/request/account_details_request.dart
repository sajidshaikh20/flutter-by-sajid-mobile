import 'package:json_annotation/json_annotation.dart'; 

part 'account_details_request.g.dart'; 

/// Model class for account details request parameters.
@JsonSerializable(ignoreUnannotated: false)
class AccountDetailsRequest {
  /// The customer authentication token.
  @JsonKey(name: 'customerToken')
  final  String? customerToken;

  /// The ETag for caching.
  @JsonKey(name: 'eTag')
  final  String? etag;

  /// The website identifier.
  @JsonKey(name: 'websiteId')
  final  String? websiteId;

  /// The store identifier.
  @JsonKey(name: 'storeId')
  final  String? storeId;

  /// Creates an instance of [AccountDetailsRequest].
  AccountDetailsRequest({this.customerToken, this.etag, this.websiteId, this.storeId});

  /// Creates an instance of [AccountDetailsRequest] from a JSON map.
  factory AccountDetailsRequest.fromJson(Map<String, dynamic> json) => _$AccountDetailsRequestFromJson(json);

  /// Converts the model to a JSON map.
  Map<String, dynamic> toJson() => _$AccountDetailsRequestToJson(this);
}

