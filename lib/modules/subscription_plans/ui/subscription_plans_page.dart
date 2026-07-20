import '../../../utils/exports.dart';

@RoutePage()
class SubscriptionPlansPage extends BaseResponsiveView {
  const SubscriptionPlansPage({super.key});

  @override
  Widget buildDesktopWidget(BuildContext context) => _build(context);

  @override
  Widget buildTabletWidget(BuildContext context) => _build(context);

  @override
  Widget buildMobileWidget(BuildContext context) => _build(context);

  Widget _build(BuildContext context) {
    return BlocProvider<SubscriptionPlansCubit>(
      create: (BuildContext context) => SubscriptionPlansCubit(
        repository: PlansRepositoryImpl(),
      ),
      child: const SubscriptionPlansViewBody(),
    );
  }
}

class SubscriptionPlansViewBody extends StatefulWidget {
  const SubscriptionPlansViewBody({super.key});

  @override
  State<SubscriptionPlansViewBody> createState() => _SubscriptionPlansViewBodyState();
}

class _SubscriptionPlansViewBodyState extends State<SubscriptionPlansViewBody> {
  @override
  Widget build(BuildContext context) {
    final bool isDark = context.isDark;
    final Color pageBg = isDark ? AppColors.backgroundDark : AppColors.backgroundLight;
    final Color textColor = isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight;
    final Color subtextColor = isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight;
    final Color cardBorder = isDark ? AppColors.borderDark : AppColors.borderLight;
    final Color bottomBarBg = isDark ? AppColors.surfaceDark : Colors.white;
    final Color dividerColor = isDark ? AppColors.dividerDark : AppColors.dividerLight;

    return BlocConsumer<SubscriptionPlansCubit, SubscriptionPlansState>(
      listener: (BuildContext context, SubscriptionPlansState state) {

        if (state.status == BaseStateStatus.success && state.msg != null && state.msg!.isNotEmpty) {
          if (state.msg!.startsWith('PAYMENT_REDIRECT:')) {
            final String url = state.msg!.substring('PAYMENT_REDIRECT:'.length);
            final StackRouter router = context.router;
            context.read<SubscriptionPlansCubit>().resetError();
            unawaited(Future<void>(() async {
              final dynamic result = await router.push(PaymentWebViewRoute(paymentUrl: url));
              if (result != null && result != 'Goback') {
                await UserProfileService.instance().updateUserProfile(
                  paymentStatus: 'SUCCESS',
                  subscriptionStatus: 'ACTIVE',
                  isActive: true,
                );
                if (mounted) {
                  showCustomDialog(
                    'Your payment was completed successfully! Enjoy your premium access.',
                    title: 'Success',
                    okBtnTitle: 'Awesome',
                    isDialogHideOnClick: true,
                    onOkClicked: () {
                      router.back();
                    },
                  );
                }
              }
            }));
          } else {
            showCustomDialog(
              state.msg!,
              title: 'Success',
              okBtnTitle: 'Awesome',
              isDialogHideOnClick: true,
              onOkClicked: () {
                context.router.back();
              },
            );
          }
        }

        if (state.status == BaseStateStatus.failure && state.msg != null && state.msg!.isNotEmpty) {
          context.scaffoldMessenger.showSnackBar(
            SnackBar(
              content: Text(state.msg!),
              backgroundColor: AppColors.errorColor,
            ),
          );
          context.read<SubscriptionPlansCubit>().resetError();
        }
      },
      builder: (BuildContext context, SubscriptionPlansState state) {
        if (state.plans.isEmpty) {
          return Scaffold(
            backgroundColor: pageBg,
            body: SafeArea(
              child: Column(
                children: <Widget>[
                  _buildHeader(context, isDark, textColor, cardBorder),
                ],
              ),
            ),
          );
        }
        // Find visible plans and currently selected plan
        final List<SubscriptionPlanModel> displayPlans = state.visiblePlans;
        final SubscriptionPlanModel selectedPlan = displayPlans.firstWhere(
          (SubscriptionPlanModel p) => p.id == state.selectedPlanId,
          orElse: () => displayPlans.first,
        );

        final int currentPrice = selectedPlan.price;
        final String currentPeriod = selectedPlan.billingCycle.toUpperCase() == 'YEARLY' ? 'year' : 'month';

        return Scaffold(
          backgroundColor: pageBg,
          body: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                // Header (Back button + Title)
                _buildHeader(context, isDark, textColor, cardBorder),

                // Scrollable Body
                Expanded(
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: Dimens.space16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          const SizedBox(height: Dimens.space8),

                          // Monthly vs Yearly Timeframe Switcher
                          Center(
                            child: _buildTimeframeToggle(context, isDark, state),
                          ),

                          const SizedBox(height: Dimens.space24),

                          // Subtitle Selection Header
                          CustomTextLabelWidget(
                            label: 'Choose plan type',
                            style: TextStyle(
                              fontSize: Dimens.fontSize14,
                              fontWeight: FontWeight.bold,
                              color: textColor,
                            ),
                          ),
                          const SizedBox(height: Dimens.space4),
                          CustomTextLabelWidget(
                            label: 'Select the product plan you want to access',
                            style: TextStyle(
                              fontSize: Dimens.fontSize12,
                              color: subtextColor,
                            ),
                          ),
                          const SizedBox(height: Dimens.space12),

                          // 1. Compact Radio Plan Selection Cards (ek ke niche ek)
                          Column(
                            children: displayPlans.map((SubscriptionPlanModel plan) {
                              final bool isSelected = plan.id == state.selectedPlanId;
                              return Padding(
                                padding: const EdgeInsets.only(bottom: Dimens.space12),
                                child: _buildPlanRadioCard(context, isDark, textColor, subtextColor, cardBorder, plan, isSelected),
                              );
                            }).toList(),
                          ),

                          const SizedBox(height: Dimens.space16),

                          // 2. What's Included details card for the selected plan
                          if (selectedPlan.features.isNotEmpty) ...<Widget>[
                            _buildDetailsCard(isDark, textColor, subtextColor, cardBorder, selectedPlan),
                            const SizedBox(height: Dimens.space24),
                          ],
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // 3. Sticky Bottom Checkout Bar
          bottomNavigationBar: Container(
            padding: const EdgeInsets.symmetric(horizontal: Dimens.space20, vertical: Dimens.space16),
            decoration: BoxDecoration(
              color: bottomBarBg,
              border: Border(
                top: BorderSide(color: dividerColor, width: 0.5),
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                // Price information row
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        CustomTextLabelWidget(
                          label: 'Total Payable Today',
                          style: TextStyle(
                            fontSize: Dimens.fontSize11,
                            color: subtextColor,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 2),
                        CustomTextLabelWidget(
                          label: '\$${NumberFormat('#,##0').format(currentPrice)}',
                          style: TextStyle(
                            fontSize: Dimens.fontSize24,
                            fontWeight: FontWeight.w900,
                            color: textColor,
                          ),
                        ),
                      ],
                    ),
                    CustomTextLabelWidget(
                      label: 'Billed per $currentPeriod',
                      style: TextStyle(
                        fontSize: Dimens.fontSize11,
                        color: subtextColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: Dimens.space16),

                // Premium Gradient Continue Button
                GestureDetector(
                  onTap: () {
                    _handleChoosePlan(context, selectedPlan.name);
                  },
                  child: Container(
                    height: 52,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: AppColors.primaryGradient,
                      ),
                      borderRadius: BorderRadius.circular(Dimens.radius12),
                      boxShadow: <BoxShadow>[
                        BoxShadow(
                          color: AppColors.primaryPurple.withValues(alpha: isDark ? 0.3 : 0.15),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        CustomTextLabelWidget(
                          label: 'Continue',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: Dimens.fontSize15,
                          ),
                        ),
                        SizedBox(width: Dimens.space8),
                        Icon(
                          Icons.arrow_forward_rounded,
                          color: Colors.white,
                          size: Dimens.size18,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildHeader(BuildContext context, bool isDark, Color textColor, Color borderCol) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: Dimens.space16,
        vertical: Dimens.space12,
      ),
      child: Row(
        children: <Widget>[
          GestureDetector(
            onTap: () => context.router.maybePop(),
            child: Container(
              padding: const EdgeInsets.all(Dimens.space8),
              decoration: BoxDecoration(
                color: isDark ? AppColors.surfaceDark : Colors.white,
                shape: BoxShape.circle,
                border: Border.all(color: borderCol),
              ),
              child: Icon(
                Icons.arrow_back_ios_new_rounded,
                color: textColor,
                size: Dimens.size16,
              ),
            ),
          ),
          const SizedBox(width: Dimens.space16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                CustomTextLabelWidget(
                  label: 'Choose the plan',
                  style: TextStyle(
                    fontSize: Dimens.fontSize14,
                    fontWeight: FontWeight.w900,
                    color: textColor,
                    height: 1.1,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTimeframeToggle(
    BuildContext context,
    bool isDark,
    SubscriptionPlansState state,
  ) {
    final Color toggleBg = isDark ? AppColors.surfaceDark : Colors.grey.shade200;

    return Container(
      width: 260,
      height: 48,
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: toggleBg,
        borderRadius: BorderRadius.circular(Dimens.radius12),
      ),
      child: Row(
        children: <Widget>[
          // Monthly option
          Expanded(
            child: GestureDetector(
              onTap: () => context.read<SubscriptionPlansCubit>().toggleYearly(isYearly: false),
              child: Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: !state.isYearly ? AppColors.primaryPurple : Colors.transparent,
                  borderRadius: BorderRadius.circular(Dimens.radius8),
                ),
                child: CustomTextLabelWidget(
                  label: '1 Month',
                  style: TextStyle(
                    color: !state.isYearly ? Colors.white : (isDark ? Colors.white70 : Colors.black87),
                    fontWeight: FontWeight.bold,
                    fontSize: Dimens.fontSize13,
                  ),
                ),
              ),
            ),
          ),

          // Yearly option
          Expanded(
            child: GestureDetector(
              onTap: () => context.read<SubscriptionPlansCubit>().toggleYearly(isYearly: true),
              child: Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: state.isYearly ? AppColors.primaryPurple : Colors.transparent,
                  borderRadius: BorderRadius.circular(Dimens.radius8),
                ),
                child: CustomTextLabelWidget(
                  label: '12 Months',
                  style: TextStyle(
                    color: state.isYearly ? Colors.white : (isDark ? Colors.white70 : Colors.black87),
                    fontWeight: FontWeight.bold,
                    fontSize: Dimens.fontSize13,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPlanRadioCard(
    BuildContext context,
    bool isDark,
    Color textColor,
    Color subtextColor,
    Color borderCol,
    SubscriptionPlanModel plan,
    bool isSelected,
  ) {
    final int price = plan.price;
    final String periodLabel = plan.billingCycle.toUpperCase() == 'YEARLY' ? 'yr' : 'mo';

    final String subtitle = plan.description;

    final Color cardBg = isSelected
        ? (isDark ? const Color(0xFF1F183C) : const Color(0xFFFAF7FF))
        : (isDark ? AppColors.surfaceDark : Colors.white);

    final Color cardBorderColor = isSelected ? AppColors.primaryPurple : borderCol;
    final double cardBorderWidth = isSelected ? 1.8 : 0.8;

    return GestureDetector(
      onTap: () => context.read<SubscriptionPlansCubit>().selectPlan(plan.id),
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: cardBg,
          borderRadius: BorderRadius.circular(Dimens.radius16),
          border: Border.all(color: cardBorderColor, width: cardBorderWidth),
        ),
        child: Padding(
          padding: const EdgeInsets.all(Dimens.space16),
          child: Row(
            children: <Widget>[
              // Radio Selector Circle
              Container(
                width: 22,
                height: 22,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: isSelected ? AppColors.primaryPurple : subtextColor.withValues(alpha: 0.5),
                    width: 2.0,
                  ),
                ),
                alignment: Alignment.center,
                child: isSelected
                    ? Container(
                        width: 11,
                        height: 11,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.primaryPurple,
                        ),
                      )
                    : null,
              ),
              const SizedBox(width: Dimens.space16),

              // Middle details
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Flexible(
                          child: CustomTextLabelWidget(
                            label: plan.name,
                            style: TextStyle(
                              fontSize: Dimens.fontSize14,
                              fontWeight: FontWeight.bold,
                              color: textColor,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        if (plan.isPopular) ...<Widget>[
                          const SizedBox(width: Dimens.space6),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(colors: AppColors.primaryGradient),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: const CustomTextLabelWidget(
                              label: 'POPULAR',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 8,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                          ),
                        ],
                      ],
                    ),
                    const SizedBox(height: 2),
                    CustomTextLabelWidget(
                      label: subtitle,
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        fontSize: 10,
                        color: subtextColor,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: Dimens.space8),

              // Right price
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  CustomTextLabelWidget(
                    label: '\$${NumberFormat('#,##0').format(price)}',
                    style: TextStyle(
                      fontSize: Dimens.fontSize16,
                      fontWeight: FontWeight.w900,
                      color: textColor,
                    ),
                  ),
                  CustomTextLabelWidget(
                    label: '/$periodLabel',
                    style: TextStyle(
                      fontSize: 9,
                      color: subtextColor,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDetailsCard(
    bool isDark,
    Color textColor,
    Color subtextColor,
    Color borderCol,
    SubscriptionPlanModel selectedPlan,
  ) {
    // Custom container themed to stand out
    final Color detailsBg = isDark ? const Color(0xFF131828) : const Color(0xFFF3F6FF);
    final Color detailsBorder = isDark ? AppColors.primaryPurple.withValues(alpha: 0.3) : AppColors.primaryPurple.withValues(alpha: 0.15);

    return DecoratedBox(
      decoration: BoxDecoration(
        color: detailsBg,
        borderRadius: BorderRadius.circular(Dimens.radius16),
        border: Border.all(color: detailsBorder),
      ),
      child: Padding(
        padding: const EdgeInsets.all(Dimens.space16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // Headers
            const Row(
              children: <Widget>[
                Icon(
                  Icons.stars_rounded,
                  color: AppColors.primaryPurple,
                  size: Dimens.size22,
                ),
                SizedBox(width: Dimens.space8),
                CustomTextLabelWidget(
                  label: "What's Included?",
                  style: TextStyle(
                    fontSize: Dimens.fontSize14,
                    fontWeight: FontWeight.w900,
                    color: AppColors.primaryPurple,
                  ),
                ),
              ],
            ),
            const SizedBox(height: Dimens.space12),

            // Bullet checklist items
            ...selectedPlan.features.map((String feature) {
              return Padding(
                padding: const EdgeInsets.only(bottom: Dimens.space8),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const Icon(
                      Icons.check_rounded,
                      color: AppColors.primaryPurple,
                      size: Dimens.size16,
                    ),
                    const SizedBox(width: Dimens.space10),
                    Expanded(
                      child: CustomTextLabelWidget(
                        label: feature,
                        style: TextStyle(
                          color: textColor.withValues(alpha: 0.85),
                          fontSize: Dimens.fontSize12,
                          height: 1.3,
                        ),
                        textAlign: TextAlign.start,
                      ),
                    ),
                  ],
                ),
              );
            }),
          ],
        ),
      ),
    );
  }

  void _handleChoosePlan(BuildContext context, String planName) {
    unawaited(context.read<SubscriptionPlansCubit>().createSubscription(context));
  }
}
