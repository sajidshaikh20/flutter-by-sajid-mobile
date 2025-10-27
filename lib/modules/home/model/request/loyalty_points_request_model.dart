import 'package:freezed_annotation/freezed_annotation.dart';

part 'loyalty_points_request_model.freezed.dart';
part 'loyalty_points_request_model.g.dart';

/// Request model for the Loyalty Points API call.
@freezed
class LoyaltyPointsRequestModel with _$LoyaltyPointsRequestModel {
  /// Constructor for creating a [LoyaltyPointsRequestModel].
  const factory LoyaltyPointsRequestModel({
    required String customerToken,
    required String platform,
    required String version,
    int? languageId,
  }) = _LoyaltyPointsRequestModel;

  /// Factory constructor for creating an instance from JSON.
  factory LoyaltyPointsRequestModel.fromJson(Map<String, dynamic> json) =>
      _$LoyaltyPointsRequestModelFromJson(json);
}
