import '../../../../utils/exports.dart';

class TradesSummaryCards extends StatelessWidget {
  const TradesSummaryCards({
    super.key,
    this.activeCount = '3',
    this.pendingCount = '2',
    this.closedCount = '18',
    this.lossesCount = '5',
  });

  final String activeCount;
  final String pendingCount;
  final String closedCount;
  final String lossesCount;

  @override
  Widget build(BuildContext context) {
    final bool isDark = context.isDark;
    final Color cardBg = isDark ? AppColors.cardDark : AppColors.cardLight;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Dimens.space16),
      child: Row(
        children: <Widget>[
          // Active Card
          Expanded(
            child: _SummaryCard(
              count: activeCount,
              label: 'Active',
              icon: Icons.multiline_chart_rounded,
              color: isDark ? AppColors.successColor : AppColors.greenTextColor,
              backgroundColor: cardBg,
              isDark: isDark,
            ),
          ),
          const SizedBox(width: Dimens.space8),
          // Pending Card
          Expanded(
            child: _SummaryCard(
              count: pendingCount,
              label: 'Pending',
              icon: Icons.schedule_rounded,
              color: AppColors.infoColor,
              backgroundColor: cardBg,
              isDark: isDark,
            ),
          ),
          const SizedBox(width: Dimens.space8),
          // Closed Card
          Expanded(
            child: _SummaryCard(
              count: closedCount,
              label: 'Closed',
              icon: Icons.check_circle_outline_rounded,
              color: AppColors.primaryPurple,
              backgroundColor: cardBg,
              isDark: isDark,
            ),
          ),
          const SizedBox(width: Dimens.space8),
          // Losses Card
          Expanded(
            child: _SummaryCard(
              count: lossesCount,
              label: 'Losses',
              icon: Icons.trending_down_rounded,
              color: AppColors.errorColor,
              backgroundColor: cardBg,
              isDark: isDark,
            ),
          ),
        ],
      ),
    );
  }
}

class _SummaryCard extends StatelessWidget {
  const _SummaryCard({
    required this.count,
    required this.label,
    required this.icon,
    required this.color,
    required this.backgroundColor,
    required this.isDark,
  });

  final String count;
  final String label;
  final IconData icon;
  final Color color;
  final Color backgroundColor;
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    final Color labelColor = isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight;
    final Color countColor = isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight;

    return Container(
      padding: const EdgeInsets.all(Dimens.space8),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(Dimens.radius12),
        border: Border.all(
          color: isDark ? AppColors.borderDark : AppColors.borderLight.withValues(alpha: 0.5),
        ),
      ),
      child: Row(
        children: <Widget>[
          // Icon
          Container(
            padding: const EdgeInsets.all(Dimens.space6),
            decoration: BoxDecoration(
              color: color.withValues(alpha: isDark ? 0.15 : 0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              color: color,
              size: Dimens.size16,
            ),
          ),
          const SizedBox(width: Dimens.space8),
          // Numbers & Labels
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                CustomTextLabelWidget(
                  label: count,
                  style: TextStyle(
                    color: countColor,
                    fontWeight: FontWeight.w800,
                    fontSize: Dimens.fontSize14,
                    height: 1.1,
                  ),
                  textAlign: TextAlign.start,
                ),
                const SizedBox(height: Dimens.space2),
                CustomTextLabelWidget(
                  label: label,
                  style: TextStyle(
                    color: labelColor,
                    fontSize: Dimens.fontSize9,
                    fontWeight: FontWeight.w500,
                    height: 1.1,
                  ),
                  textAlign: TextAlign.start,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
