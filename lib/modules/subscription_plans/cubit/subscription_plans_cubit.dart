import '../../../utils/exports.dart';

class SubscriptionPlansCubit extends BaseCubit<SubscriptionPlansState> {
  SubscriptionPlansCubit() : super(SubscriptionPlansState.initial()) {
    _loadInitialData();
  }

  void _loadInitialData() {
    emit(state.copyWith(
      plans: _getMockPlans(),
      selectedPlanId: 'plan_elite',
      status: BaseStateStatus.success,
    ));
  }

  void toggleYearly({required bool isYearly}) {
    emit(state.copyWith(isYearly: isYearly));
  }

  void selectPlan(String planId) {
    emit(state.copyWith(selectedPlanId: planId));
  }

  List<SubscriptionPlanModel> _getMockPlans() {
    return const <SubscriptionPlanModel>[
      SubscriptionPlanModel(
        id: 'plan_crypto',
        name: 'Crypto Plan',
        monthlyPrice: 200,
        yearlyPrice: 2000,
        features: <String>[
          '2-4 High quality strategies per day',
          '75-80% accuracy',
          '1:2 Risk reward ratio',
          'Whatsapp notification support',
          'Weekly crypto insights',
          'Live price access for every trades',
          'AI Suites',
          '10+ trading strategies',
        ],
      ),
      SubscriptionPlanModel(
        id: 'plan_forex',
        name: 'Forex Plan',
        monthlyPrice: 200,
        yearlyPrice: 2000,
        features: <String>[
          '2-4 High quality strategies per day',
          '30-40 Pips target range',
          '75-80% accuracy',
          '1:2 Risk reward ratio',
          'Whatsapp notification support',
          'Weekly forex insights',
          'Live price access for every trades',
          'AI Suites',
          '10+ trading strategies',
        ],
      ),
      SubscriptionPlanModel(
        id: 'plan_elite',
        name: 'Elite Plan (Forex + Crypto)',
        monthlyPrice: 300,
        yearlyPrice: 3000,
        isPopular: true,
        features: <String>[
          '4-6 High quality strategies per day',
          '30-40 Pips target range',
          '75-80% accuracy',
          '1:2 Risk reward ratio',
          'Whatsapp notification support',
          'Weekly forex insights',
          '20+ trading strategies',
          'Live price access for every trade',
          'Advance analytical tool',
          'Risk Management Tools',
          'Live price access for every trades',
          'AI Suites',
          '24×7 research support',
        ],
      ),
    ];
  }

  @override
  SubscriptionPlansState getResetErrorState() => state.copyWith(msg: '');

  @override
  SubscriptionPlansState getResetRedirectionState() => state.copyWith();
}
