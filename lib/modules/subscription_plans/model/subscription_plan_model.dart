import '../../../utils/exports.dart';

class SubscriptionPlanModel extends Equatable {
  const SubscriptionPlanModel({
    required this.id,
    required this.name,
    required this.monthlyPrice,
    required this.yearlyPrice,
    required this.features,
    required this.description,
    this.isPopular = false,
  });

  final String id;
  final String name;
  final int monthlyPrice;
  final int yearlyPrice;
  final List<String> features;
  final String description;
  final bool isPopular;

  @override
  List<Object?> get props => <Object?>[
        id,
        name,
        monthlyPrice,
        yearlyPrice,
        features,
        description,
        isPopular,
      ];
}
