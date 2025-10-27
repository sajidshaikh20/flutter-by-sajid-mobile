/// Represents the response after applying a coupon.
///
/// Contains the active reward ID and a list of default rewards associated with the coupon.
class ApplyCouponResponseModel {
  /// The currently active reward ID, if any.
  final int? activeId;

  /// The list of default rewards associated with the coupon.
  final List<DefaultRewardIds> defaultRewardIds;

  /// Creates an [ApplyCouponResponseModel].
  ///
  /// [defaultRewardIds] defaults to an empty list if not provided.
  ApplyCouponResponseModel({
    this.activeId,
    this.defaultRewardIds = const <DefaultRewardIds>[],
  });

  /// Creates an [ApplyCouponResponseModel] from a JSON map.
  factory ApplyCouponResponseModel.fromJson(Map<String, dynamic> json) {
    return ApplyCouponResponseModel(
      activeId: json['active_id'] as int?,
      defaultRewardIds: (json['default_reward_ids'] as List<dynamic>?)
          ?.map((dynamic e) =>
          DefaultRewardIds.fromJson(e as Map<String, dynamic>))
          .toList() ??
          <DefaultRewardIds>[],
    );
  }
}

/// Represents a default reward with its ID and description.
class DefaultRewardIds {
  /// The unique ID of the reward.
  final int? id;

  /// The description of the reward.
  final String? description;

  /// Creates a [DefaultRewardIds] instance.
  DefaultRewardIds({
    this.id,
    this.description,
  });

  /// Creates a [DefaultRewardIds] from a JSON map.
  factory DefaultRewardIds.fromJson(Map<String, dynamic> json) {
    return DefaultRewardIds(
      id: json['id'] as int?,
      description: json['description'] as String?,
    );
  }
}
