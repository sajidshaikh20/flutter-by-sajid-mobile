import 'package:json_annotation/json_annotation.dart';

part 'my_wallet_request.g.dart';

@JsonSerializable(ignoreUnannotated: false)
/// A request model for fetching wallet data from the API.
/// Contains all the necessary parameters for making a wallet data request.
class MyWalletRequest {

  /// Constructor to initialize a [MyWalletRequest] with optional parameters.
  MyWalletRequest({
    this.websiteId,
    this.storeId,
    this.customerToken,
    this.pageNumber,
  });

  /// Factory constructor to create a [MyWalletRequest] from a JSON object.
  ///
  /// This method uses the `json_serializable` package to parse the JSON data and map it to a [MyWalletRequest] object.
  factory MyWalletRequest.fromJson(Map<String, dynamic> json) =>
      _$MyWalletRequestFromJson(json);

  /// The website ID associated with the request.
  /// This is used to specify which website the request is targeting.
  @JsonKey(name: 'websiteId')
  final String? websiteId;

  /// The store ID associated with the request.
  /// This identifies the specific store for which wallet data is being requested.
  @JsonKey(name: 'storeId')
  final String? storeId;

  /// The customer token associated with the user.
  /// This token is used for authentication or to track the user's wallet data.
  @JsonKey(name: 'customerToken')
  final String? customerToken;

  /// The page number for pagination when requesting wallet data.
  /// This helps in loading the data in chunks or pages.
  @JsonKey(name: 'pageNumber')
  final String? pageNumber;

  /// Converts the [MyWalletRequest] object to a JSON map.
  ///
  /// This method uses the `json_serializable` package to convert the request object into a JSON format for making the API call.
  Map<String, dynamic> toJson() => _$MyWalletRequestToJson(this);
}
