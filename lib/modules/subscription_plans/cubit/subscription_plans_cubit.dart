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

      String? defaultSelectedId;
      if (mappedPlans.isNotEmpty) {
        final List<SubscriptionPlanModel> monthlyPlans = mappedPlans
            .where((SubscriptionPlanModel p) => p.billingCycle.toUpperCase() == 'MONTHLY')
            .toList();
        final SubscriptionPlanModel defaultPlan = monthlyPlans.firstWhereOrNull((SubscriptionPlanModel p) => p.isPopular) ??
            (monthlyPlans.isNotEmpty ? monthlyPlans.first : mappedPlans.first);
        defaultSelectedId = defaultPlan.id;
      }

      emit(state.copyWith(
        rawPlans: apiPlans,
        plans: mappedPlans,
        selectedPlanId: defaultSelectedId,
        isYearly: false,
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
    return apiPlans.map((PlanResponse plan) {
      final int price = plan.prices.firstOrNull?.price.toInt() ?? 0;
      final String currency = plan.prices.firstOrNull?.currencyCode ?? 'USD';
      final List<String> features = _getFeaturesForCategory(plan.category);
      final String description = (plan.description.isNotEmpty && plan.description != 'sample_description')
          ? plan.description
          : _getDescriptionForCategory(plan.category, plan.planName);

      final bool isPopular = plan.category.toUpperCase().contains('ELITE') ||
          plan.planCode.toUpperCase().contains('ELT') ||
          plan.planName.toUpperCase().contains('ELITE');

      return SubscriptionPlanModel(
        id: plan.id.toString(),
        planId: plan.id,
        name: plan.planName,
        planCode: plan.planCode,
        category: plan.category,
        billingCycle: plan.billingCycle,
        price: price,
        currencyCode: currency,
        features: features,
        description: description,
        isPopular: isPopular,
      );
    }).toList();
  }

  List<String> _getFeaturesForCategory(String category) {
    final String upperCat = category.toUpperCase();
    if (upperCat.contains('CRYPTO')) {
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
    } else if (upperCat.contains('FOREX')) {
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

  String _getDescriptionForCategory(String category, String planName) {
    final String combined = '$category $planName'.toUpperCase();
    if (combined.contains('TEST')) {
      return 'Test plan for trial access & testing';
    } else if (combined.contains('CRYPTO')) {
      return 'Best for crypto scalping & altcoin traders';
    } else if (combined.contains('FOREX')) {
      return 'Perfect for standard currency pairs trading';
    } else {
      return 'Combined high quality Forex + Crypto strategies';
    }
  }

  void toggleYearly({required bool isYearly}) {
    final String targetCycle = isYearly ? 'YEARLY' : 'MONTHLY';
    final List<SubscriptionPlanModel> targetPlans = state.plans
        .where((SubscriptionPlanModel p) => p.billingCycle.toUpperCase() == targetCycle)
        .toList();

    SubscriptionPlanModel? selected;
    if (state.selectedPlanId != null) {
      final SubscriptionPlanModel? currentSelected = state.plans.firstWhereOrNull((SubscriptionPlanModel p) => p.id == state.selectedPlanId);
      if (currentSelected != null) {
        selected = targetPlans.firstWhereOrNull((SubscriptionPlanModel p) => p.category.toUpperCase() == currentSelected.category.toUpperCase());
      }
    }
    selected ??= targetPlans.firstWhereOrNull((SubscriptionPlanModel p) => p.isPopular) ??
        (targetPlans.isNotEmpty ? targetPlans.first : null);

    emit(state.copyWith(
      isYearly: isYearly,
      selectedPlanId: selected?.id ?? state.selectedPlanId,
    ));
  }

  void selectPlan(String planId) {
    emit(state.copyWith(selectedPlanId: planId));
  }

  Future<void> createSubscription(BuildContext context) async {
    final String? selectedId = state.selectedPlanId;
    if (selectedId == null) return;

    final SubscriptionPlanModel? selectedUiPlan = state.plans.firstWhereOrNull((SubscriptionPlanModel p) => p.id == selectedId);
    final PlanResponse? resolvedPlan = state.rawPlans.firstWhereOrNull(
      (PlanResponse p) => p.id.toString() == selectedId || (selectedUiPlan != null && p.id == selectedUiPlan.planId),
    );

    if (resolvedPlan == null) {
      emit(state.copyWith(
        status: BaseStateStatus.failure,
        msg: 'The selected plan is not available.',
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
        planId: resolvedPlan.id,
      ),
    );

    if (response.isSuccess()) {
      final BaseResponse<dynamic>? baseResponse = response.getSuccessInstance()?.response;
      final dynamic data = baseResponse?.data;
      String? checkoutUrl;
      if (data is Map<String, dynamic>) {
        checkoutUrl = data['checkoutUrl']?.toString();
      }

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
        msg: checkoutUrl != null && checkoutUrl.isNotEmpty
            ? 'PAYMENT_REDIRECT:$checkoutUrl'
            : 'Subscription created successfully. Payment verification is pending.',
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
