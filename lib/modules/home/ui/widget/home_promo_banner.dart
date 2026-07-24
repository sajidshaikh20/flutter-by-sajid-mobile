import '../../../../utils/exports.dart';

class HomePromoBanner extends StatelessWidget {
  const HomePromoBanner({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isDark = context.isDark;

    return ListenableBuilder(
      listenable: UserProfileService.instance(),
      builder: (BuildContext context, Widget? child) {
        final UserProfileService profile = UserProfileService.instance();
        final bool isTrader = profile.isTrader;

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: Dimens.space16),
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: isDark ? AppColors.darkPromoBannerGradient : AppColors.lightPromoBannerGradient,
              borderRadius: BorderRadius.circular(Dimens.radius16),
              border: Border.all(
                color: isDark ? AppColors.borderDark : AppColors.borderLight,
              ),
              boxShadow: <BoxShadow>[
                if (isDark)
                  BoxShadow(
                    color: AppColors.primaryPurple.withValues(alpha: 0.15),
                    blurRadius: 16,
                    offset: const Offset(0, 4),
                  ),
              ],
            ),
            padding: const EdgeInsets.all(Dimens.space16),
            child: Row(
              children: <Widget>[
                // Left text panel
                Expanded(
                  flex: 3,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      // Tag label
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Icon(
                            isTrader ? Icons.show_chart_rounded : Icons.workspace_premium,
                            color: isDark ? AppColors.successColor : AppColors.greenTextColor,
                            size: Dimens.size14,
                          ),
                          const SizedBox(width: Dimens.space4),
                          CustomTextLabelWidget(
                            label: isTrader ? 'TRADER HUB' : 'WEKO PRO',
                            style: const TextStyle(
                              color: AppColors.primaryPurple,
                              fontWeight: FontWeight.w600,
                              fontSize: Dimens.fontSize11,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: Dimens.space10),
                      CustomTextLabelWidget(
                        label: isTrader
                            ? 'Welcome Back, ${profile.customerName.isNotEmpty ? profile.customerName : "Trader"}'
                            : 'Unlock Advanced Tools',
                        style: TextStyle(
                          color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight,
                          fontWeight: FontWeight.w600,
                          fontSize: Dimens.fontSize16,
                          height: 1.2,
                        ),
                        textAlign: TextAlign.start,
                      ),
                      const SizedBox(height: Dimens.space6),
                      CustomTextLabelWidget(
                        label: isTrader
                            ? 'Track live trades, publish signals & analyze performance.'
                            : 'Automate, Backtest & Optimize Your Strategies',
                        style: TextStyle(
                          color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight,
                          fontSize: Dimens.fontSize10,
                          fontWeight: FontWeight.w400,
                        ),
                        textAlign: TextAlign.start,
                      ),
                      const SizedBox(height: Dimens.space16),
                      // Action Button
                      Container(
                        height: Dimens.size36,
                        decoration: BoxDecoration(
                          gradient: AppColors.primaryButtonGradient,
                          borderRadius: BorderRadius.circular(Dimens.radius10),
                        ),
                        child: InkWell(
                          onTap: () async {
                            if (isTrader) {
                              await context.router.push(const AddTradeRoute());
                            } else {
                              await context.router.push(const SubscriptionPlansRoute());
                            }
                          },
                          borderRadius: BorderRadius.circular(Dimens.radius10),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: Dimens.space12),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                CustomTextLabelWidget(
                                  label: isTrader ? '+ Add New Trade' : 'Explore Pro',
                                  style: const TextStyle(
                                    color: AppColors.whiteColor,
                                    fontWeight: FontWeight.w500,
                                    fontSize: Dimens.fontSize11,
                                  ),
                                ),
                                const SizedBox(width: Dimens.space6),
                                const Icon(
                                  Icons.arrow_forward_ios_rounded,
                                  color: AppColors.whiteColor,
                                  size: Dimens.size10,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
            // Right Graphics Panel (futuristic UI look without placeholders)
            Expanded(
              flex: 2,
              child: AspectRatio(
                aspectRatio: 1,
                child: Stack(
                  alignment: Alignment.center,
                  children: <Widget>[
                    // Background glow
                    Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        boxShadow: <BoxShadow>[
                          BoxShadow(
                            color: AppColors.primaryPurple.withValues(alpha: 0.2),
                            blurRadius: 20,
                            spreadRadius: 10,
                          ),
                        ],
                      ),
                    ),
                    // Desktop Monitor graphic
                    Container(
                      width: 75,
                      height: 55,
                      decoration: BoxDecoration(
                        color: isDark ? const Color(0xFF1D143D) : AppColors.whiteColor,
                        borderRadius: BorderRadius.circular(Dimens.radius6),
                        border: Border.all(
                          color: AppColors.primaryPurple.withValues(alpha: 0.3),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          // Top Bar
                          Container(
                            height: 6,
                            color: AppColors.primaryPurple.withValues(alpha: 0.1),
                            padding: const EdgeInsets.symmetric(horizontal: 4),
                            child: Row(
                              children: <Widget>[
                                Container(width: 3, height: 3, decoration: const BoxDecoration(color: AppColors.errorColor, shape: BoxShape.circle)),
                                const SizedBox(width: 2),
                                Container(width: 3, height: 3, decoration: const BoxDecoration(color: AppColors.warningColor, shape: BoxShape.circle)),
                                const SizedBox(width: 2),
                                Container(width: 3, height: 3, decoration: BoxDecoration(color: isDark ? AppColors.successColor : AppColors.greenTextColor, shape: BoxShape.circle)),
                              ],
                            ),
                          ),
                          // Trend Chart preview lines
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Container(width: 40, height: 4, color: AppColors.primaryPurple.withValues(alpha: 0.4)),
                                  Container(width: 55, height: 4, color: (isDark ? AppColors.successColor : AppColors.greenTextColor).withValues(alpha: 0.4)),
                                  Container(width: 30, height: 4, color: AppColors.infoColor.withValues(alpha: 0.4)),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Robot standing overlay
                    Positioned(
                      right: 12,
                      bottom: 0,
                      child: Container(
                        width: 36,
                        height: 36,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: AppColors.primaryButtonGradient,
                          boxShadow: <BoxShadow>[
                            BoxShadow(
                              color: AppColors.primaryPurple.withValues(alpha: 0.35),
                              blurRadius: 8,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        alignment: Alignment.center,
                        child: const Icon(
                          Icons.smart_toy_rounded,
                          color: AppColors.whiteColor,
                          size: Dimens.size20,
                        ),
                      ),
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
}
