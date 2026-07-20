import '../../../utils/exports.dart';

class SubscriptionPlanModel extends Equatable {
  const SubscriptionPlanModel({
    required this.id,
    required this.planId,
    required this.name,
    required this.planCode,
    required this.category,
    required this.billingCycle,
    required this.price,
    required this.currencyCode,
    required this.features,
    required this.description,
    this.isPopular = false,
  });

  final String id;
  final int planId;
  final String name;
  final String planCode;
  final String category;
  final String billingCycle;
  final int price;
  final String currencyCode;
  final List<String> features;
  final String description;
  final bool isPopular;

  @override
  List<Object?> get props => <Object?>[
        id,
        planId,
        name,
        planCode,
        category,
        billingCycle,
        price,
        currencyCode,
        features,
        description,
        isPopular,
      ];
}
