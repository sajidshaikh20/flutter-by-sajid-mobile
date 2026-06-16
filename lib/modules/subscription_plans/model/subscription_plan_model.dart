import '../../../utils/exports.dart';

class SubscriptionPlanModel extends Equatable {
  const SubscriptionPlanModel({
    required this.id,
    required this.name,
    required this.monthlyPrice,
    required this.yearlyPrice,
    required this.features,
    this.isPopular = false,
  });

  final String id;
  final String name;
  final int monthlyPrice;
  final int yearlyPrice;
  final List<String> features;
  final bool isPopular;

  @override
  List<Object?> get props => <Object?>[
        id,
        name,
        monthlyPrice,
        yearlyPrice,
        features,
        isPopular,
      ];
}
