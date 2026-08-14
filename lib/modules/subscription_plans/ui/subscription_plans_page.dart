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
        if (state.status == BaseStateStatus.loading) {
          unawaited(EasyLoading.show(status: 'Loading...'));
        } else {
          unawaited(EasyLoading.dismiss());
        }

        if (state.status == BaseStateStatus.success && state.msg != null && state.msg!.isNotEmpty) {
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
        // Find currently selected plan
        final SubscriptionPlanModel selectedPlan = state.plans.firstWhere(
          (SubscriptionPlanModel p) => p.id == state.selectedPlanId,
          orElse: () => state.plans.first,
        );

        final int currentPrice = state.isYearly ? selectedPlan.yearlyPrice : selectedPlan.monthlyPrice;
        final String currentPeriod = state.isYearly ? 'year' : 'month';

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
                    controller: _scrollController,
                    physics: const BouncingScrollPhysics(),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: Dimens.space16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          const SizedBox(height: Dimens.space8),

                          // Membership & Billing Header & 2 Summary Cards (Only shown if subscription is active)
                          ListenableBuilder(
                            listenable: UserProfileService.instance(),
                            builder: (BuildContext context, Widget? child) {
                              final bool isSubActive = UserProfileService.instance().isSubscriptionActive;
                              if (!isSubActive) {
                                return const SizedBox.shrink();
                              }

                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  CustomTextLabelWidget(
                                    label: 'Membership & Billing',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: textColor,
                                    ),
                                  ),
                                  const SizedBox(height: 2),
                                  CustomTextLabelWidget(
                                    label: 'Manage your subscription, billing and premium features.',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: subtextColor,
                                    ),
                                  ),
                                  const SizedBox(height: Dimens.space12),

                                  // Responsive 2 Membership Cards
                                  LayoutBuilder(
                                    builder: (BuildContext context, BoxConstraints constraints) {
                                      final bool isWide = constraints.maxWidth > 700;
                                      if (isWide) {
                                        return Row(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Expanded(child: _buildCurrentPlanCard(context, isDark, textColor, subtextColor, cardBorder)),
                                            const SizedBox(width: Dimens.space16),
                                            Expanded(child: _buildAccountSummaryCard(context, isDark, textColor, subtextColor, cardBorder)),
                                          ],
                                        );
                                      } else {
                                        return Column(
                                          children: <Widget>[
                                            _buildCurrentPlanCard(context, isDark, textColor, subtextColor, cardBorder),
                                            const SizedBox(height: Dimens.space16),
                                            _buildAccountSummaryCard(context, isDark, textColor, subtextColor, cardBorder),
                                          ],
                                        );
                                      }
                                    },
                                  ),

                                  const SizedBox(height: Dimens.space28),

                                  // Upgrade Membership Section Header
                                  KeyedSubtree(
                                    key: _upgradeSectionKey,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: <Widget>[
                                        CustomTextLabelWidget(
                                          label: 'Upgrade Membership',
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                            color: textColor,
                                          ),
                                        ),
                                        const SizedBox(height: Dimens.space4),
                                        CustomTextLabelWidget(
                                          label: 'Upgrade or renew your subscription.',
                                          style: TextStyle(
                                            fontSize: Dimens.fontSize12,
                                            color: subtextColor,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: Dimens.space16),
                                ],
                              );
                            },
                          ),

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
                            children: state.plans.map((SubscriptionPlanModel plan) {
                              final bool isSelected = plan.id == state.selectedPlanId;
                              return Padding(
                                padding: const EdgeInsets.only(bottom: Dimens.space12),
                                child: _buildPlanRadioCard(context, isDark, textColor, subtextColor, cardBorder, plan, isSelected, state.isYearly),
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
                  onTap: () => unawaited(context.read<SubscriptionPlansCubit>().purchaseWithRevenueCat(context)),
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
                const SizedBox(height: Dimens.space12),

                // Restore Purchases & Manage Subscriptions
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    TextButton(
                      onPressed: () async {
                        unawaited(EasyLoading.show(status: 'Restoring...'));
                        final bool restored = await getIt<RevenueCatService>().restorePurchases();
                        unawaited(EasyLoading.dismiss());
                        if (restored) {
                          if (context.mounted) {
                            context.scaffoldMessenger.showSnackBar(
                              const SnackBar(
                                content: Text('Purchases restored successfully!'),
                                backgroundColor: Colors.green,
                              ),
                            );
                            context.router.back();
                          }
                        } else {
                          if (context.mounted) {
                            context.scaffoldMessenger.showSnackBar(
                              const SnackBar(
                                content: Text('No active subscriptions found to restore.'),
                                backgroundColor: AppColors.errorColor,
                              ),
                            );
                          }
                        }
                      },
                      child: CustomTextLabelWidget(
                        label: 'Restore Purchases',
                        style: TextStyle(
                          fontSize: Dimens.fontSize12,
                          color: subtextColor,
                          fontWeight: FontWeight.w600,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: () => unawaited(getIt<RevenueCatService>().presentCustomerCenter()),
                      child: CustomTextLabelWidget(
                        label: 'Manage Subscriptions',
                        style: TextStyle(
                          fontSize: Dimens.fontSize12,
                          color: subtextColor,
                          fontWeight: FontWeight.w600,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ],
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
            onTap: () => context.router.back(),
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
    bool isYearly,
  ) {
    final int price = isYearly ? plan.yearlyPrice : plan.monthlyPrice;
    final String periodLabel = isYearly ? 'yr' : 'mo';

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

  final ScrollController _scrollController = ScrollController();
  final GlobalKey _upgradeSectionKey = GlobalKey();

  void _scrollToUpgradeSection() {
    if (_upgradeSectionKey.currentContext != null) {
      unawaited(Scrollable.ensureVisible(
        _upgradeSectionKey.currentContext!,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      ));
    } else if (_scrollController.hasClients) {
      unawaited(_scrollController.animateTo(
        350.0,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      ));
    }
  }

  String _formatDateString(String? rawDate) {
    if (rawDate == null || rawDate.trim().isEmpty) return '--';
    try {
      final DateTime parsed = DateTime.parse(rawDate.trim());
      return DateFormat('dd MMM yyyy').format(parsed);
    } on Object catch (_) {
      if (rawDate.trim().length >= 10) {
        try {
          final DateTime parsed = DateTime.parse(rawDate.trim().substring(0, 10));
          return DateFormat('dd MMM yyyy').format(parsed);
        } on Object catch (_) {}
      }
      return rawDate;
    }
  }

  String _capitalize(String? text) {
    if (text == null || text.trim().isEmpty) return '--';
    final String trimmed = text.trim();
    return trimmed[0].toUpperCase() + trimmed.substring(1).toLowerCase();
  }

  Widget _buildCurrentPlanCard(
    BuildContext context,
    bool isDark,
    Color textColor,
    Color subtextColor,
    Color cardBorder,
  ) {
    final UserProfileService userProfile = UserProfileService.instance();
    final bool isActive = userProfile.isSubscriptionActive;
    final String category = isActive
        ? (userProfile.category.isNotEmpty
            ? userProfile.category
            : (userProfile.planName.isNotEmpty ? userProfile.planName : 'No Active Plan'))
        : 'No Active Plan';
    final String billingCycle = isActive && userProfile.billingCycle.isNotEmpty
        ? userProfile.billingCycle.toUpperCase()
        : '--';
    final double amount = userProfile.amount ?? 0;
    final String endDateStr = isActive ? _formatDateString(userProfile.endDate) : 'No active plan';

    final Color cardBg = isDark ? const Color(0xFF0F172A) : Colors.white;

    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: cardBg,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isDark ? Colors.white.withValues(alpha: 0.08) : cardBorder,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          // Header Title
          Text(
            'Current Plan',
            style: TextStyle(
              color: textColor,
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),

          // Plan Name Category & Active Badge Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                category,
                style: TextStyle(
                  color: textColor,
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                ),
              ),

              // Active / Expired Badge
              Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  const SizedBox(width: 5),
                  Text(
                    isActive ? 'Active' : 'Expired',
                    style: TextStyle(
                      color: isActive ? const Color(0xFF34D399) : AppColors.errorColor,
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 0.3,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 12),

          // Amount / Billing Cycle
          Text(
            isActive ? '${amount % 1 == 0 ? amount.toInt() : amount} / ${_capitalize(billingCycle)}' : '--',
            style: const TextStyle(
              color: Color(0xFF60A5FA),
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            isActive ? 'Valid till $endDateStr' : 'No active subscription',
            style: TextStyle(
              color: subtextColor,
              fontSize: 11,
            ),
          ),
          const SizedBox(height: 14),

          // Upgrade Plan Button
          CustomButtonWidget(
            title: isActive ? 'Upgrade Plan' : 'Select Plan',
            height: 38,
            borderRadius: 8,
            titleTextStyle: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 12,
            ),
            onTap: _scrollToUpgradeSection,
          ),
        ],
      ),
    );
  }

  Widget _buildAccountSummaryCard(
    BuildContext context,
    bool isDark,
    Color textColor,
    Color subtextColor,
    Color cardBorder,
  ) {
    final UserProfileService userProfile = UserProfileService.instance();
    final bool isActive = userProfile.isSubscriptionActive;

    final String category = isActive
        ? (userProfile.category.isNotEmpty
            ? userProfile.category
            : (userProfile.planName.isNotEmpty ? userProfile.planName : 'None'))
        : 'None';
    final String paymentStatus = isActive
        ? (userProfile.paymentStatus.isNotEmpty ? _capitalize(userProfile.paymentStatus) : 'Completed')
        : 'Inactive';
    final String subscriptionStatus = isActive
        ? (userProfile.subscriptionStatus.isNotEmpty ? _capitalize(userProfile.subscriptionStatus) : 'Active')
        : 'Expired';
    final String startDateStr = isActive ? _formatDateString(userProfile.startDate) : '--';
    final String endDateStr = isActive ? _formatDateString(userProfile.endDate) : '--';
    final String durationDays = isActive && userProfile.durationDays > 0 ? '${userProfile.durationDays} Days' : '--';
    final String billingCycle = isActive && userProfile.billingCycle.isNotEmpty
        ? userProfile.billingCycle.toUpperCase()
        : '--';

    final Color cardBg = isDark ? const Color(0xFF0F172A) : Colors.white;

    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: cardBg,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isDark ? Colors.white.withValues(alpha: 0.08) : cardBorder,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          // Header Title
          Text(
            'Account Summary',
            style: TextStyle(
              color: textColor,
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),

          _buildSummaryRow('Subscription', category, textColor, subtextColor),
          _buildSummaryRow('Payment Status', paymentStatus, textColor, subtextColor),
          _buildSummaryRow('Subscription Status', subscriptionStatus, textColor, subtextColor),
          _buildSummaryRow('Start Date', startDateStr, textColor, subtextColor),
          _buildSummaryRow('Renewal Date', endDateStr, textColor, subtextColor),
          _buildSummaryRow('Duration', durationDays, textColor, subtextColor),
          _buildSummaryRow('Billing Cycle', billingCycle, textColor, subtextColor),
          _buildSummaryRow(
            'Active',
            isActive ? 'Yes' : 'No',
            isActive ? const Color(0xFF10B981) : AppColors.errorColor,
            subtextColor,
            isValueColorCustom: true,
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryRow(
    String label,
    String value,
    Color valueColor,
    Color labelColor, {
    bool isValueColorCustom = false,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3.5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            label,
            style: TextStyle(color: labelColor, fontSize: 12),
          ),
          Text(
            value,
            style: TextStyle(
              color: isValueColorCustom ? valueColor : valueColor,
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
