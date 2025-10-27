import 'package:json_annotation/json_annotation.dart';

part 'my_wallet_response.g.dart';

@JsonSerializable(ignoreUnannotated: false)
/// A response model representing the wallet data returned by the API.
/// Contains the wallet amount, total count, collection, and status of the request.
class MyWalletResponse {

  /// Constructor to initialize a [MyWalletResponse] with optional parameters.
  MyWalletResponse({
    this.success,
    this.message,
    this.walletAmount,
    this.totalCount,
    this.collection,
  });

  /// Factory constructor to create a [MyWalletResponse] from a JSON object.
  ///
  /// This method uses the `json_serializable` package to parse the JSON data and map it to a [MyWalletResponse] object.
  factory MyWalletResponse.fromJson(Map<String, dynamic> json) =>
      _$MyWalletResponseFromJson(json);

  /// A boolean indicating whether the wallet data request was successful.
  /// If true, the request was successful; if false, there was an issue with the request.
  @JsonKey(name: 'success')
  final bool? success;

  /// A message associated with the response.
  /// This may contain error messages or additional information about the wallet request.
  @JsonKey(name: 'message')
  final String? message;

  /// The wallet amount returned in the response.
  /// This represents the total amount of money in the wallet.
  @JsonKey(name: 'walletAmount')
  final String? walletAmount;

  /// The total count of items in the collection.
  /// This represents the total number of wallet entries or records available.
  @JsonKey(name: 'totalCount')
  final int? totalCount;

  /// A list containing collection data related to the wallet.
  /// This may include specific wallet transactions or records.
  @JsonKey(name: 'collection')
  final List<String>? collection;

  /// Converts the [MyWalletResponse] object to a JSON map.
  ///
  /// This method uses the `json_serializable` package to convert the response object into a JSON format for further processing.
  Map<String, dynamic> toJson() => _$MyWalletResponseToJson(this);
}
