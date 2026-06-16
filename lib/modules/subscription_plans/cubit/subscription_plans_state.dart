import '../../../utils/exports.dart';

class SubscriptionPlansState extends BaseState {
  const SubscriptionPlansState({
    this.isYearly = false,
    this.plans = const <SubscriptionPlanModel>[],
    this.selectedPlanId,
    super.status = BaseStateStatus.initial,
    super.msg = '',
    super.redirectRoute,
  });

  final bool isYearly;
  final List<SubscriptionPlanModel> plans;
  final String? selectedPlanId;

  factory SubscriptionPlansState.initial() => const SubscriptionPlansState();

  SubscriptionPlansState copyWith({
    BaseStateStatus? status,
    String? msg,
    PageRouteInfo? redirectRoute,
    bool? isYearly,
    List<SubscriptionPlanModel>? plans,
    String? selectedPlanId,
  }) =>
      SubscriptionPlansState(
        status: status ?? this.status,
        msg: msg ?? this.msg,
        redirectRoute: redirectRoute ?? this.redirectRoute,
        isYearly: isYearly ?? this.isYearly,
        plans: plans ?? this.plans,
        selectedPlanId: selectedPlanId ?? this.selectedPlanId,
      );

  @override
  List<Object?> get props => <Object?>[
        status,
        msg,
        redirectRoute,
        isYearly,
        plans,
        selectedPlanId,
      ];
}
