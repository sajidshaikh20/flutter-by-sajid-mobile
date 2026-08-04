import '../../../../utils/exports.dart';

class ClientTradeCard extends StatelessWidget {
  const ClientTradeCard({
    super.key,
    required this.signal,
  });

  final TradingSignalModel signal;

  @override
  Widget build(BuildContext context) {
    final bool isDark = context.isDark;
    final Color cardBg = isDark ? AppColors.cardDark : AppColors.cardLight;
    final Color textColor = isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight;
    final Color subtextColor = isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight;
    final Color borderColor = isDark ? AppColors.borderDark : AppColors.borderLight.withValues(alpha: 0.5);
    final Color themeGreen = isDark ? AppColors.successColor : AppColors.greenTextColor;

    // Status Badge
    Widget statusBadge = const SizedBox.shrink();
    if (signal.isActive) {
      statusBadge = Container(
        padding: const EdgeInsets.symmetric(horizontal: Dimens.space8, vertical: Dimens.space4),
        decoration: BoxDecoration(
          color: AppColors.primaryPurple.withValues(alpha: 0.15),
          borderRadius: BorderRadius.circular(Dimens.radius4),
        ),
        child: const CustomTextLabelWidget(
          label: 'ACTIVE',
          style: TextStyle(
            color: AppColors.primaryPurple,
            fontWeight: FontWeight.w800,
            fontSize: Dimens.fontSize10,
          ),
        ),
      );
    } else if (signal.isClosed) {
      statusBadge = Container(
        padding: const EdgeInsets.symmetric(horizontal: Dimens.space8, vertical: Dimens.space4),
        decoration: BoxDecoration(
          color: themeGreen.withValues(alpha: 0.15),
          borderRadius: BorderRadius.circular(Dimens.radius4),
        ),
        child: CustomTextLabelWidget(
          label: 'CLOSED',
          style: TextStyle(
            color: themeGreen,
            fontWeight: FontWeight.w800,
            fontSize: Dimens.fontSize10,
          ),
        ),
      );
    } else if (signal.isPending) {
      statusBadge = Container(
        padding: const EdgeInsets.symmetric(horizontal: Dimens.space8, vertical: Dimens.space4),
        decoration: BoxDecoration(
          color: AppColors.warningColor.withValues(alpha: 0.15),
          borderRadius: BorderRadius.circular(Dimens.radius4),
        ),
        child: const CustomTextLabelWidget(
          label: 'PENDING',
          style: TextStyle(
            color: AppColors.warningColor,
            fontWeight: FontWeight.w800,
            fontSize: Dimens.fontSize10,
          ),
        ),
      );
    } else if (signal.isCancelled) {
      statusBadge = Container(
        padding: const EdgeInsets.symmetric(horizontal: Dimens.space8, vertical: Dimens.space4),
        decoration: BoxDecoration(
          color: AppColors.neutralColor.withValues(alpha: 0.15),
          borderRadius: BorderRadius.circular(Dimens.radius4),
        ),
        child: const CustomTextLabelWidget(
          label: 'CANCELLED',
          style: TextStyle(
            color: AppColors.neutralColor,
            fontWeight: FontWeight.w800,
            fontSize: Dimens.fontSize10,
          ),
        ),
      );
    }

    return Container(
      decoration: BoxDecoration(
        color: cardBg,
        borderRadius: BorderRadius.circular(Dimens.radius16),
        border: Border.all(color: borderColor),
      ),
      padding: const EdgeInsets.all(Dimens.space16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          // Top Row: Chip Symbol & Status Badge
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                padding: const EdgeInsets.symmetric(horizontal: Dimens.space12, vertical: Dimens.space6),
                decoration: BoxDecoration(
                  color: isDark ? AppColors.borderDark : AppColors.borderLight,
                  borderRadius: BorderRadius.circular(Dimens.radius8),
                ),
                child: CustomTextLabelWidget(
                  label: signal.pair,
                  style: TextStyle(
                    color: textColor,
                    fontWeight: FontWeight.w800,
                    fontSize: Dimens.fontSize12,
                  ),
                ),
              ),
              statusBadge,
            ],
          ),
          const SizedBox(height: Dimens.space16),

          // Posted By Section
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              CustomTextLabelWidget(
                label: 'POSTED BY:',
                style: TextStyle(
                  color: subtextColor,
                  fontSize: Dimens.fontSize10,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: Dimens.space4),
              CustomTextLabelWidget(
                label: signal.traderName.isNotNullOrEmpty ? signal.traderName! : '--',
                style: TextStyle(
                  color: textColor,
                  fontWeight: FontWeight.w800,
                  fontSize: Dimens.fontSize14,
                ),
              ),
            ],
          ),
          const SizedBox(height: Dimens.space16),

          Divider(
            height: 1,
            thickness: 1,
            color: isDark ? AppColors.dividerDark : AppColors.dividerLight,
          ),
          const SizedBox(height: Dimens.space16),

          // Trade ID & Taken On Section
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              // Trade ID column
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  CustomTextLabelWidget(
                    label: 'TRADE ID',
                    style: TextStyle(
                      color: subtextColor,
                      fontSize: Dimens.fontSize10,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: Dimens.space4),
                  CustomTextLabelWidget(
                    label: signal.publicId.isNotNullOrEmpty ? signal.publicId : '--',
                    style: TextStyle(
                      color: textColor,
                      fontWeight: FontWeight.w800,
                      fontSize: Dimens.fontSize12,
                    ),
                  ),
                ],
              ),

              // Taken On column
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  CustomTextLabelWidget(
                    label: 'TAKEN ON',
                    style: TextStyle(
                      color: subtextColor,
                      fontSize: Dimens.fontSize10,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: Dimens.space4),
                  CustomTextLabelWidget(
                    label: _formatDate(signal.takenAt),
                    style: TextStyle(
                      color: textColor,
                      fontWeight: FontWeight.w800,
                      fontSize: Dimens.fontSize12,
                    ),
                    textAlign: TextAlign.end,
                  ),
                  if (signal.takenAt != null) ...<Widget>[
                    const SizedBox(height: Dimens.space2),
                    CustomTextLabelWidget(
                      label: _formatTime(signal.takenAt),
                      style: TextStyle(
                        color: subtextColor,
                        fontWeight: FontWeight.w500,
                        fontSize: Dimens.fontSize10,
                      ),
                      textAlign: TextAlign.end,
                    ),
                  ],
                ],
              ),
            ],
          ),
          const SizedBox(height: Dimens.space20),

          // View Trade Button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () async {
                await context.router.push(TradingOverviewRoute(signal: signal));
                if (context.mounted) {
                  unawaited(context.read<MyTradesCubit>().loadMyTrades(isRefresh: true));
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryPurple,
                padding: const EdgeInsets.symmetric(vertical: Dimens.space12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(Dimens.radius8),
                ),
              ),
              child: const CustomTextLabelWidget(
                label: 'View Trade',
                style: TextStyle(
                  color: AppColors.whiteColor,
                  fontWeight: FontWeight.w800,
                  fontSize: Dimens.fontSize14,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _formatDate(String? dateTimeStr) {
    if (dateTimeStr == null) return '--';
    try {
      final DateTime dateTime = DateTime.parse(dateTimeStr).toLocal();
      return DateFormat('dd MMM yyyy').format(dateTime);
    } on Object catch (_) {
      return '--';
    }
  }

  String _formatTime(String? dateTimeStr) {
    if (dateTimeStr == null) return '';
    try {
      final DateTime dateTime = DateTime.parse(dateTimeStr).toLocal();
      return DateFormat('hh:mm a').format(dateTime);
    } on Object catch (_) {
      return '';
    }
  }
}
