import 'package:json_annotation/json_annotation.dart'; 

part 'view_reward_history_request.g.dart'; 

@JsonSerializable(ignoreUnannotated: false)
/// Model class for view reward history request parameters.
class ViewRewardHistoryRequest {
  /// The website ID for the request.
  @JsonKey(name: 'websiteId')
  final String? websiteId;

  /// The store ID for the request.
  @JsonKey(name: 'storeId')
  final String? storeId;

  /// The customer authentication token.
  @JsonKey(name: 'customerToken')
  final String? customerToken;

  /// The page number for pagination.
  @JsonKey(name: 'pageNumber')
  final String? pageNumber;

  /// Creates a new instance of [ViewRewardHistoryRequest].
  ///
  /// All parameters are optional and can be null.
  ViewRewardHistoryRequest({this.websiteId, this.storeId, this.customerToken, this.pageNumber});

  /// Creates a [ViewRewardHistoryRequest] instance from a JSON map.
  factory ViewRewardHistoryRequest.fromJson(Map<String, dynamic> json) => _$ViewRewardHistoryRequestFromJson(json);

  /// Converts the model to a JSON map.
  Map<String, dynamic> toJson() => _$ViewRewardHistoryRequestToJson(this);
}

