/// Model class for membership tier information.
class MembershipTierModelTier {
  /// The path to the tier icon image.
  final String iconPath;

  /// The title of the membership tier.
  final String title;

  /// The description of the membership tier.
  final String description;

  /// The maximum points for this tier.
  final String maxPoints;

  /// The points earned per KD spent.
  final String pointsPerKD;

  /// The point value display text.
  final String point;

  /// The count of points.
  final String pointCount;

  /// The points display text.
  final String points;

  /// Creates an instance of [MembershipTierModelTier].
  MembershipTierModelTier({
    required this.iconPath,
    required this.title,
    required this.description,
    required this.maxPoints,
    required this.pointsPerKD,
    required this.point,
    required this.pointCount,
    required this.points,
  });
}
