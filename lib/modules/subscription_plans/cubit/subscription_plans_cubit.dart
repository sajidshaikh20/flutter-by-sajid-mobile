import '../../../utils/exports.dart';

class SubscriptionPlansCubit extends BaseCubit<SubscriptionPlansState> {
  final PlansRepository repository;

  SubscriptionPlansCubit({required this.repository}) : super(SubscriptionPlansState.initial()) {
    unawaited(loadPlans());
  }

  Future<void> loadPlans() async {
    emit(state.copyWith(status: BaseStateStatus.loading));
    final ResponseHandler<BaseResponse<List<PlanResponse>>> response = await repository.getPlans();
    if (response.isSuccess()) {
      final BaseResponse<List<PlanResponse>>? baseResponse = response.getSuccessInstance()?.response;
      final List<PlanResponse> apiPlans = baseResponse?.data ?? <PlanResponse>[];
      
      final List<SubscriptionPlanModel> mappedPlans = _mapApiPlansToUiModels(apiPlans);
      
      // Determine default selected plan
      String? defaultSelectedId;
      if (mappedPlans.isNotEmpty) {
        final SubscriptionPlanModel? elitePlan = mappedPlans.firstWhereOrNull((SubscriptionPlanModel p) => p.id == 'plan_elite');
        defaultSelectedId = elitePlan?.id ?? mappedPlans.first.id;
      }

      emit(state.copyWith(
        rawPlans: apiPlans,
        plans: mappedPlans,
        selectedPlanId: defaultSelectedId,
        status: BaseStateStatus.success,
      ));
    } else {
      final OnFailureResponse<BaseResponse<List<PlanResponse>>>? failure = response.getFailureInstance();
      emit(state.copyWith(
        status: BaseStateStatus.failure,
        msg: failure?.error?.errorMessage ?? 'Failed to load subscription plans.',
      ));
    }
  }

  List<SubscriptionPlanModel> _mapApiPlansToUiModels(List<PlanResponse> apiPlans) {
    final Map<String, List<PlanResponse>> grouped = <String, List<PlanResponse>>{};
    for (final PlanResponse plan in apiPlans) {
      final String cat = plan.category.toUpperCase();
      grouped.putIfAbsent(cat, () => <PlanResponse>[]).add(plan);
    }

    final List<SubscriptionPlanModel> uiPlans = <SubscriptionPlanModel>[];

    grouped.forEach((String category, List<PlanResponse> plans) {
      final PlanResponse? monthlyPlan = plans.firstWhereOrNull((PlanResponse p) => p.billingCycle.toUpperCase() == 'MONTHLY');
      final PlanResponse? yearlyPlan = plans.firstWhereOrNull((PlanResponse p) => p.billingCycle.toUpperCase() == 'YEARLY');

      if (monthlyPlan == null && yearlyPlan == null) return;

      final PlanResponse activePlan = monthlyPlan ?? yearlyPlan!;
      final String id = _getPlanUiId(category, activePlan.planCode);
      final String name = _getPlanDisplayName(category);

      final int monthlyPrice = monthlyPlan?.prices.firstOrNull?.price.toInt() ?? 
          ((yearlyPlan?.prices.firstOrNull?.price ?? 0) / 12).toInt();
      final int yearlyPrice = yearlyPlan?.prices.firstOrNull?.price.toInt() ?? 
          (monthlyPrice * 10);

      final List<String> features = _getFeaturesForCategory(category);
      final String description = _getDescriptionForCategory(category);

      uiPlans.add(SubscriptionPlanModel(
        id: id,
        name: name,
        monthlyPrice: monthlyPrice,
        yearlyPrice: yearlyPrice,
        features: features,
        description: description,
        isPopular: category.contains('ELITE') || activePlan.planCode.toLowerCase().contains('elite'),
      ));
    });

    return uiPlans;
  }

  List<String> _getFeaturesForCategory(String category) {
    if (category.contains('CRYPTO')) {
      return const <String>[
        '2-4 High quality strategies per day',
        '75-80% accuracy',
        '1:2 Risk reward ratio',
        'Whatsapp notification support',
        'Weekly crypto insights',
        'Live price access for every trades',
        'AI Suites',
        '10+ trading strategies',
      ];
    } else if (category.contains('FOREX')) {
      return const <String>[
        '2-4 High quality strategies per day',
        '30-40 Pips target range',
        '75-80% accuracy',
        '1:2 Risk reward ratio',
        'Whatsapp notification support',
        'Weekly forex insights',
        'Live price access for every trades',
        'AI Suites',
        '10+ trading strategies',
      ];
    } else {
      return const <String>[
        '4-6 High quality strategies per day',
        '30-40 Pips target range',
        '75-80% accuracy',
        '1:2 Risk reward ratio',
        'Whatsapp notification support',
        'Weekly forex insights',
        '20+ trading strategies',
        'Live price access for every trade',
        'Advance analytical tool',
        'Risk Managment Tools',
        'Live price access for every trades',
        'AI Suites',
        '24×7 research support',
      ];
    }
  }

  String _getDescriptionForCategory(String category) {
    if (category.contains('CRYPTO')) {
      return 'Best for crypto scalping & altcoin traders';
    } else if (category.contains('FOREX')) {
      return 'Perfect for standard currency pairs trading';
    } else {
      return 'Combined high quality Forex + Crypto strategies';
    }
  }

  String _getPlanDisplayName(String category) {
    if (category.contains('ELITE')) {
      return 'Elite Plan (Forex + Crypto)';
    } else if (category.contains('CRYPTO')) {
      return 'Crypto Plan';
    } else {
      return 'Forex Plan';
    }
  }

  String _getPlanUiId(String category, String planCode) {
    if (category.contains('ELITE') || planCode.toLowerCase().contains('elite')) {
      return 'plan_elite';
    } else if (category.contains('CRYPTO')) {
      return 'plan_crypto';
    } else {
      return 'plan_forex';
    }
  }

  void toggleYearly({required bool isYearly}) {
    emit(state.copyWith(isYearly: isYearly));
  }

  void selectPlan(String planId) {
    emit(state.copyWith(selectedPlanId: planId));
  }

  Future<void> createSubscription(BuildContext context) async {
    final String? selectedId = state.selectedPlanId;
    if (selectedId == null) return;

    String resolvedCategory = 'ELITE';
    if (selectedId == 'plan_crypto') resolvedCategory = 'CRYPTO';
    if (selectedId == 'plan_forex') resolvedCategory = 'FOREX';

    final String targetCycle = state.isYearly ? 'YEARLY' : 'MONTHLY';
    PlanResponse? resolvedPlan = state.rawPlans.firstWhereOrNull(
      (PlanResponse p) => p.category.toUpperCase() == resolvedCategory && p.billingCycle.toUpperCase() == targetCycle,
    );

    resolvedPlan ??= state.rawPlans.firstWhereOrNull(
      (PlanResponse p) => p.category.toUpperCase() == resolvedCategory,
    );

    if (resolvedPlan == null) {
      emit(state.copyWith(
        status: BaseStateStatus.failure,
        msg: 'The selected plan is not available for $targetCycle billing.',
      ));
      return;
    }

    final String? userPublicId = UserProfileService.instance().customerId;
    if (userPublicId == null || userPublicId.isEmpty) {
      emit(state.copyWith(
        status: BaseStateStatus.failure,
        msg: 'User identity not found. Please log in again.',
      ));
      return;
    }

    emit(state.copyWith(status: BaseStateStatus.loading));

    final ResponseHandler<BaseResponse<dynamic>> response = await repository.createSubscription(
      CreateSubscriptionRequest(
        userPublicId: userPublicId,
        planPublicId: resolvedPlan.publicId,
      ),
    );

    if (response.isSuccess()) {
      await UserProfileService.instance().updateUserProfile(
        subscriptionPublicId: 'PENDING',
        planName: resolvedPlan.planName,
        planCode: resolvedPlan.planCode,
        category: resolvedPlan.category,
        billingCycle: resolvedPlan.billingCycle,
        amount: resolvedPlan.prices.firstOrNull?.price,
        currencyCode: resolvedPlan.prices.firstOrNull?.currencyCode ?? 'USD',
        paymentStatus: 'PENDING',
        subscriptionStatus: 'PENDING',
        isActive: false,
      );

      emit(state.copyWith(
        status: BaseStateStatus.success,
        msg: 'Subscription created successfully. Payment verification is pending.',
      ));
    } else {
      final OnFailureResponse<BaseResponse<dynamic>>? failure = response.getFailureInstance();
      emit(state.copyWith(
        status: BaseStateStatus.failure,
        msg: failure?.error?.errorMessage ?? 'Failed to create subscription.',
      ));
    }
  }

  @override
  SubscriptionPlansState getResetErrorState() => state.copyWith(msg: '');

  @override
  SubscriptionPlansState getResetRedirectionState() => state.copyWith();
}
