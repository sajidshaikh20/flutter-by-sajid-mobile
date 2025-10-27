import 'package:json_annotation/json_annotation.dart'; 

part 'view_reward_history_response.g.dart'; 

@JsonSerializable(ignoreUnannotated: false)
/// Model class for view reward history response data.
class ViewRewardHistoryResponse {
  /// Indicates whether the request was successful.
  @JsonKey(name: 'success')
  final bool? success;

  /// Response message.
  @JsonKey(name: 'message')
  final String? message;

  /// Total count of reward history items.
  @JsonKey(name: 'totalCount')
  final int? totalCount;

  /// Customer's total reward points.
  @JsonKey(name: 'customerPoints')
  final int? customerPoints;

  /// Entity tag for caching.
  @JsonKey(name: 'eTag')
  final String? eTag;

  /// Creates a new instance of [ViewRewardHistoryResponse].
  ///
  /// All parameters are optional and can be null.
  ViewRewardHistoryResponse({this.success, this.message, this.totalCount, this.customerPoints, this.eTag});

  /// Creates a [ViewRewardHistoryResponse] instance from a JSON map.
  factory ViewRewardHistoryResponse.fromJson(Map<String, dynamic> json) => _$ViewRewardHistoryResponseFromJson(json);

  /// Converts the model to a JSON map.
  Map<String, dynamic> toJson() => _$ViewRewardHistoryResponseToJson(this);
}

