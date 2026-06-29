import '../../../../utils/exports.dart';

class HomeOverviewGrid extends StatelessWidget {
  const HomeOverviewGrid({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isDark = context.isDark;
    final Color cardBg = isDark ? AppColors.cardDark : AppColors.cardLight;
    final Color themeGreen = isDark ? AppColors.successColor : AppColors.greenTextColor;

    return BlocBuilder<HomeCubit, HomeState>(
      builder: (BuildContext context, HomeState state) {
        final bool isProfitabilityPositive = state.profitability >= 0;
        final Color profitabilityColor = isProfitabilityPositive ? themeGreen : AppColors.errorColor;

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: Dimens.space16),
          child: Row(
            children: <Widget>[
              Expanded(
                child: _StatCard(
                  title: 'Total Trades',
                  value: state.totalTrades.toString(),
                  icon: Icons.analytics_outlined,
                  iconColor: AppColors.primaryPurple,
                  backgroundColor: cardBg,
                  isDark: isDark,
                ),
              ),
              const SizedBox(width: Dimens.space8),
              Expanded(
                child: _StatCard(
                  title: 'Winning Trades',
                  value: state.winningTrades.toString(),
                  icon: Icons.emoji_events_outlined,
                  iconColor: AppColors.infoColor,
                  backgroundColor: cardBg,
                  isDark: isDark,
                ),
              ),
              const SizedBox(width: Dimens.space8),
              Expanded(
                child: _StatCard(
                  title: 'Profitability',
                  value: '${isProfitabilityPositive ? '+' : ''}${state.profitability.toStringAsFixed(0)}%',
                  valueColor: profitabilityColor,
                  icon: Icons.account_balance_wallet_outlined,
                  iconColor: profitabilityColor,
                  backgroundColor: cardBg,
                  isDark: isDark,
                ),
              ),
              const SizedBox(width: Dimens.space8),
              Expanded(
                child: _StatCard(
                  title: 'Win Rate',
                  value: '${state.winRate.toStringAsFixed(0)}%',
                  icon: Icons.percent_rounded,
                  iconColor: AppColors.accentPink,
                  backgroundColor: cardBg,
                  isDark: isDark,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _StatCard extends StatelessWidget {
  const _StatCard({
    required this.title,
    required this.value,
    required this.icon,
    required this.iconColor,
    required this.backgroundColor,
    required this.isDark,
    this.valueColor,
  });

  final String title;
  final String value;
  final IconData icon;
  final Color iconColor;
  final Color backgroundColor;
  final Color? valueColor;
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    final Color titleColor = isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight;
    final Color valColor = valueColor ?? (isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight);
    
    const double cardHeight = 100.0;

    return Container(
      height: cardHeight,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(Dimens.radius12),
        border: Border.all(
          color: isDark ? AppColors.borderDark : AppColors.borderLight.withValues(alpha: 0.5),
        ),
      ),
      padding: const EdgeInsets.all(Dimens.space8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            padding: const EdgeInsets.all(Dimens.space4),
            decoration: BoxDecoration(
              color: iconColor.withValues(alpha: isDark ? 0.15 : 0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              color: iconColor,
              size: Dimens.size16,
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              CustomTextLabelWidget(
                label: value,
                style: TextStyle(
                  color: valColor,
                  fontWeight: FontWeight.w600,
                  fontSize: Dimens.fontSize14,
                  height: 1.1,
                ),
                textAlign: TextAlign.start,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: Dimens.space2),
              CustomTextLabelWidget(
                label: title,
                style: TextStyle(
                  color: titleColor,
                  fontSize: Dimens.fontSize9,
                  fontWeight: FontWeight.w400,
                  height: 1.1,
                ),
                textAlign: TextAlign.start,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
