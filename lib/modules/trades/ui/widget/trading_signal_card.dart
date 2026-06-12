import '../../../../utils/exports.dart';

class TradingSignalCard extends StatelessWidget {
  const TradingSignalCard({
    super.key,
    required this.signal,
    this.showTakeTrade = true,
  });

  final TradingSignalModel signal;
  final bool showTakeTrade;

  @override
  Widget build(BuildContext context) {
    final bool isDark = context.isDark;
    final Color cardBg = isDark ? AppColors.cardDark : AppColors.cardLight;
    final Color textColor = isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight;
    final Color subtextColor = isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight;
    final Color borderColor = isDark ? AppColors.borderDark : AppColors.borderLight.withValues(alpha: 0.5);

    // Green color selection
    final Color themeGreen = isDark ? AppColors.successColor : AppColors.greenTextColor;

    // Status colors
    Widget statusBadge = const SizedBox.shrink();

    if (signal.isActive) {
      statusBadge = Container(
        padding: const EdgeInsets.symmetric(horizontal: Dimens.space8, vertical: Dimens.space2),
        decoration: BoxDecoration(
          color: themeGreen.withValues(alpha: isDark ? 0.15 : 0.1),
          borderRadius: BorderRadius.circular(Dimens.radius4),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            CustomTextLabelWidget(
              label: 'ACTIVE',
              style: TextStyle(
                color: themeGreen,
                fontWeight: FontWeight.w800,
                fontSize: Dimens.fontSize9,
              ),
            ),
            const SizedBox(width: Dimens.space4),
            Container(
              width: 5,
              height: 5,
              decoration: BoxDecoration(
                color: themeGreen,
                shape: BoxShape.circle,
              ),
            ),
          ],
        ),
      );
    } else if (signal.isPending) {
      statusBadge = Container(
        padding: const EdgeInsets.symmetric(horizontal: Dimens.space8, vertical: Dimens.space2),
        decoration: BoxDecoration(
          color: AppColors.warningColor.withValues(alpha: isDark ? 0.15 : 0.1),
          borderRadius: BorderRadius.circular(Dimens.radius4),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const CustomTextLabelWidget(
              label: 'PENDING',
              style: TextStyle(
                color: AppColors.warningColor,
                fontWeight: FontWeight.w800,
                fontSize: Dimens.fontSize9,
              ),
            ),
            const SizedBox(width: Dimens.space4),
            Container(
              width: 5,
              height: 5,
              decoration: const BoxDecoration(
                color: AppColors.warningColor,
                shape: BoxShape.circle,
              ),
            ),
          ],
        ),
      );
    } else if (signal.isClosed) {
      final bool isWin = signal.outcome == 'WIN';
      statusBadge = Container(
        padding: const EdgeInsets.symmetric(horizontal: Dimens.space8, vertical: Dimens.space2),
        decoration: BoxDecoration(
          color: (isWin ? themeGreen : AppColors.errorColor).withValues(alpha: isDark ? 0.15 : 0.1),
          borderRadius: BorderRadius.circular(Dimens.radius4),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            CustomTextLabelWidget(
              label: 'CLOSED',
              style: TextStyle(
                color: isWin ? themeGreen : AppColors.errorColor,
                fontWeight: FontWeight.w800,
                fontSize: Dimens.fontSize9,
              ),
            ),
            const SizedBox(width: Dimens.space4),
            Icon(
              isWin ? Icons.check_circle_rounded : Icons.cancel_rounded,
              color: isWin ? themeGreen : AppColors.errorColor,
              size: Dimens.size10,
            ),
          ],
        ),
      );
    } else if (signal.isCancelled) {
      statusBadge = Container(
        padding: const EdgeInsets.symmetric(horizontal: Dimens.space8, vertical: Dimens.space2),
        decoration: BoxDecoration(
          color: AppColors.neutralColor.withValues(alpha: isDark ? 0.15 : 0.1),
          borderRadius: BorderRadius.circular(Dimens.radius4),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const CustomTextLabelWidget(
              label: 'CANCELLED',
              style: TextStyle(
                color: AppColors.neutralColor,
                fontWeight: FontWeight.w800,
                fontSize: Dimens.fontSize9,
              ),
            ),
            const SizedBox(width: Dimens.space4),
            Container(
              width: 5,
              height: 5,
              decoration: const BoxDecoration(
                color: AppColors.neutralColor,
                shape: BoxShape.circle,
              ),
            ),
          ],
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
          // Header: Logo, Title, Status, Sparkline
          Row(
            children: <Widget>[
              _buildAssetIcon(signal.pair),
              const SizedBox(width: Dimens.space10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        CustomTextLabelWidget(
                          label: signal.pair,
                          style: TextStyle(
                            color: textColor,
                            fontWeight: FontWeight.w800,
                            fontSize: Dimens.fontSize15,
                          ),
                        ),
                        const SizedBox(width: Dimens.space8),
                        statusBadge,
                      ],
                    ),
                    const SizedBox(height: Dimens.space4),
                    CustomTextLabelWidget(
                      label: '${signal.type} • ${signal.category}',
                      style: TextStyle(
                        color: subtextColor,
                        fontWeight: FontWeight.w500,
                        fontSize: Dimens.fontSize10,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: Dimens.space10),
            ],
          ),
          const SizedBox(height: Dimens.space16),
          Divider(
            height: 1,
            thickness: 1,
            color: isDark ? AppColors.dividerDark : AppColors.dividerLight,
          ),
          const SizedBox(height: Dimens.space16),

          // Mid Section 1: Entry, SL, TP
          Row(
            children: <Widget>[
              Expanded(
                child: _ValueColumn(
                  label: 'Entry Price',
                  value: signal.entryPrice.toString(),
                  valueColor: textColor,
                  isDark: isDark,
                ),
              ),
              Expanded(
                child: _ValueColumn(
                  label: 'Stop Loss',
                  value: signal.stopLoss.toString(),
                  valueColor: AppColors.errorColor,
                  isDark: isDark,
                  alignment: CrossAxisAlignment.center,
                ),
              ),
              Expanded(
                child: _ValueColumn(
                  label: 'Take Profit',
                  value: signal.takeProfit.toString(),
                  valueColor: themeGreen,
                  isDark: isDark,
                  alignment: CrossAxisAlignment.end,
                ),
              ),
            ],
          ),
          const SizedBox(height: Dimens.space16),

          // Mid Section 2 (Conditional)
          if (signal.isActive) ...<Widget>[
            // Active price details
            Row(
              children: <Widget>[
                // Live price block
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Icon(
                            (signal.isLivePriceUp ?? true)
                                ? Icons.arrow_upward_rounded
                                : Icons.arrow_downward_rounded,
                            color: (signal.isLivePriceUp ?? true) ? themeGreen : AppColors.errorColor,
                            size: Dimens.size12,
                          ),
                          const SizedBox(width: Dimens.space4),
                          CustomTextLabelWidget(
                            label: 'Live Price',
                            style: TextStyle(
                              color: subtextColor,
                              fontSize: Dimens.fontSize10,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          CustomTextLabelWidget(
                            label: signal.livePrice?.toString() ?? '',
                            style: TextStyle(
                              color: (signal.isLivePriceUp ?? true) ? themeGreen : AppColors.errorColor,
                              fontWeight: FontWeight.w800,
                              fontSize: Dimens.fontSize14,
                            ),
                          ),
                          CustomTextLabelWidget(
                            label: signal.livePriceChange ?? '',
                            style: TextStyle(
                              color: (signal.isLivePriceUp ?? true) ? themeGreen : AppColors.errorColor,
                              fontWeight: FontWeight.w600,
                              fontSize: Dimens.fontSize9,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                // PIPS block
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      CustomTextLabelWidget(
                        label: signal.pips,
                        style: TextStyle(
                          color: (signal.pips.startsWith('+')) ? themeGreen : AppColors.errorColor,
                          fontWeight: FontWeight.w800,
                          fontSize: Dimens.fontSize14,
                        ),
                      ),
                      const SizedBox(height: Dimens.space4),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: Dimens.space6, vertical: Dimens.space2),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: ((signal.pips.startsWith('+')) ? themeGreen : AppColors.errorColor).withValues(alpha: 0.5),
                          ),
                          borderRadius: BorderRadius.circular(Dimens.radius4),
                        ),
                        child: CustomTextLabelWidget(
                          label: 'PIPS',
                          style: TextStyle(
                            color: (signal.pips.startsWith('+')) ? themeGreen : AppColors.errorColor,
                            fontWeight: FontWeight.w800,
                            fontSize: Dimens.fontSize8,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                // Risk-Reward block
                Expanded(
                  child: _ValueColumn(
                    label: 'RR',
                    value: signal.rr,
                    valueColor: textColor,
                    isDark: isDark,
                    alignment: CrossAxisAlignment.end,
                  ),
                ),
              ],
            ),
            const SizedBox(height: Dimens.space12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                _buildLevelPill(
                  label: 'SL',
                  value: signal.stopLoss.toString(),
                  color: AppColors.errorColor,
                  isDark: isDark,
                ),
                _buildLevelPill(
                  label: 'ENTRY',
                  value: signal.entryPrice.toString(),
                  color: AppColors.warningColor,
                  isDark: isDark,
                ),
                _buildLevelPill(
                  label: 'TP',
                  value: signal.takeProfit.toString(),
                  color: themeGreen,
                  isDark: isDark,
                ),
              ],
            ),
            const SizedBox(height: Dimens.space12),
            Stack(
              alignment: Alignment.centerLeft,
              children: <Widget>[
                Container(
                  height: 6,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(3),
                    gradient: LinearGradient(
                      colors: <Color>[
                        AppColors.errorColor.withValues(alpha: 0.7),
                        AppColors.warningColor.withValues(alpha: 0.7),
                        themeGreen.withValues(alpha: 0.7),
                      ],
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment(2 * (signal.progress ?? 0.0) - 1, 0),
                  child: Container(
                    width: 14,
                    height: 14,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.grey.shade400, width: 1.5),
                      boxShadow: const <BoxShadow>[
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 3,
                          offset: Offset(0, 1),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: Dimens.space12),
          ] else ...<Widget>[
            // Closed/Cancelled Details Row
            Row(
              children: <Widget>[
                // PIPS
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      CustomTextLabelWidget(
                        label: 'PIPS',
                        style: TextStyle(
                          color: subtextColor,
                          fontSize: Dimens.fontSize10,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: Dimens.space4),
                      CustomTextLabelWidget(
                        label: signal.pips,
                        style: TextStyle(
                          color: (signal.pips.startsWith('+'))
                              ? themeGreen
                              : (signal.pips.startsWith('-') ? AppColors.errorColor : textColor),
                          fontWeight: FontWeight.w800,
                          fontSize: Dimens.fontSize14,
                        ),
                      ),
                    ],
                  ),
                ),
                // RR
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      CustomTextLabelWidget(
                        label: 'RR',
                        style: TextStyle(
                          color: subtextColor,
                          fontSize: Dimens.fontSize10,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: Dimens.space4),
                      CustomTextLabelWidget(
                        label: signal.rr,
                        style: TextStyle(
                          color: textColor,
                          fontWeight: FontWeight.w800,
                          fontSize: Dimens.fontSize14,
                        ),
                      ),
                    ],
                  ),
                ),
                // Outcome
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      CustomTextLabelWidget(
                        label: 'Outcome',
                        style: TextStyle(
                          color: subtextColor,
                          fontSize: Dimens.fontSize10,
                          fontWeight: FontWeight.w500,
                        ),
                        textAlign: TextAlign.end,
                      ),
                      const SizedBox(height: Dimens.space4),
                      CustomTextLabelWidget(
                        label: signal.outcome ?? (signal.isCancelled ? 'CANCELLED' : 'PENDING'),
                        style: TextStyle(
                          color: signal.outcome == 'WIN'
                              ? themeGreen
                              : (signal.outcome == 'LOSS' ? AppColors.errorColor : subtextColor),
                          fontWeight: FontWeight.w800,
                          fontSize: Dimens.fontSize14,
                        ),
                        textAlign: TextAlign.end,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],

          const SizedBox(height: Dimens.space12),
          Divider(
            height: 1,
            thickness: 1,
            color: isDark ? AppColors.dividerDark : AppColors.dividerLight,
          ),
          const SizedBox(height: Dimens.space12),

          // Footer: Time label & View Details button
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              // Time label
              Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Icon(
                    signal.isClosed || signal.isCancelled
                        ? Icons.calendar_today_rounded
                        : Icons.watch_later_outlined,
                    color: subtextColor,
                    size: Dimens.size14,
                  ),
                  const SizedBox(width: Dimens.space6),
                  CustomTextLabelWidget(
                    label: signal.timeLabel,
                    style: TextStyle(
                      color: subtextColor,
                      fontWeight: FontWeight.w500,
                      fontSize: Dimens.fontSize10,
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  if (showTakeTrade && (signal.isActive || signal.isPending)) ...<Widget>[
                    GestureDetector(
                      onTap: () {
                        context.scaffoldMessenger.showSnackBar(
                          SnackBar(
                            content: Text('Taking trade for ${signal.pair}...'),
                            duration: const Duration(seconds: 2),
                          ),
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: Dimens.space12, vertical: Dimens.space6),
                        decoration: BoxDecoration(
                          gradient: AppColors.primaryButtonGradient,
                          borderRadius: BorderRadius.circular(Dimens.radius8),
                        ),
                        child: const Row(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            CustomTextLabelWidget(
                              label: 'Take Trade',
                              style: TextStyle(
                                color: AppColors.whiteColor,
                                fontWeight: FontWeight.w800,
                                fontSize: Dimens.fontSize10,
                              ),
                            ),
                            SizedBox(width: Dimens.space4),
                            Icon(
                              Icons.trending_up_rounded,
                              color: AppColors.whiteColor,
                              size: Dimens.size12,
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: Dimens.space8),
                  ],
                  GestureDetector(
                    onTap: () => context.router.push(TradingOverviewRoute(signal: signal)),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: Dimens.space12, vertical: Dimens.space6),
                      decoration: BoxDecoration(
                        color: AppColors.primaryPurple.withValues(alpha: isDark ? 0.15 : 0.08),
                        borderRadius: BorderRadius.circular(Dimens.radius8),
                      ),
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          CustomTextLabelWidget(
                            label: 'View Details',
                            style: TextStyle(
                              color: AppColors.primaryPurple,
                              fontWeight: FontWeight.w700,
                              fontSize: Dimens.fontSize10,
                            ),
                      ),
                          SizedBox(width: Dimens.space4),
                          Icon(
                            Icons.arrow_forward_ios_rounded,
                            color: AppColors.primaryPurple,
                            size: Dimens.size8,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAssetIcon(String pair) {
    if (pair.contains('BTC')) {
      return Container(
        width: Dimens.size32,
        height: Dimens.size32,
        decoration: const BoxDecoration(
          color: Color(0xFFFFF3E0),
          shape: BoxShape.circle,
        ),
        child: const Icon(Icons.currency_bitcoin, color: Colors.orange, size: Dimens.size18),
      );
    } else if (pair.contains('EUR')) {
      return Container(
        width: Dimens.size32,
        height: Dimens.size32,
        decoration: const BoxDecoration(
          color: Color(0xFFE3F2FD),
          shape: BoxShape.circle,
        ),
        child: const Icon(Icons.euro_symbol_rounded, color: Colors.blue, size: Dimens.size18),
      );
    } else if (pair.contains('ETH')) {
      return Container(
        width: Dimens.size32,
        height: Dimens.size32,
        decoration: const BoxDecoration(
          color: Color(0xFFE8EAF6),
          shape: BoxShape.circle,
        ),
        child: const Icon(Icons.token_outlined, color: Colors.indigo, size: Dimens.size18),
      );
    } else if (pair.contains('XAU') || pair.contains('GOLD')) {
      return Container(
        width: Dimens.size32,
        height: Dimens.size32,
        decoration: const BoxDecoration(
          color: Color(0xFFFFFDE7),
          shape: BoxShape.circle,
        ),
        child: const Icon(Icons.monetization_on_rounded, color: Colors.amber, size: Dimens.size18),
      );
    } else {
      return Container(
        width: Dimens.size32,
        height: Dimens.size32,
        decoration: const BoxDecoration(
          color: Color(0xFFEDE7F6),
          shape: BoxShape.circle,
        ),
        child: const Icon(Icons.monetization_on_outlined, color: Colors.purple, size: Dimens.size18),
      );
    }
  }

  Widget _buildLevelPill({
    required String label,
    required String value,
    required Color color,
    required bool isDark,
  }) {
    final Color bg = color.withValues(alpha: isDark ? 0.15 : 0.08);
    final Color border = color.withValues(alpha: isDark ? 0.3 : 0.2);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: Dimens.space12, vertical: Dimens.space6),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(Dimens.radius6),
        border: Border.all(color: border),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          CustomTextLabelWidget(
            label: label,
            style: TextStyle(
              color: color,
              fontSize: Dimens.fontSize9,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 2),
          CustomTextLabelWidget(
            label: value,
            style: TextStyle(
              color: color,
              fontSize: Dimens.fontSize11,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

class _ValueColumn extends StatelessWidget {
  const _ValueColumn({
    required this.label,
    required this.value,
    required this.valueColor,
    required this.isDark,
    this.alignment = CrossAxisAlignment.start,
  });

  final String label;
  final String value;
  final Color valueColor;
  final bool isDark;
  final CrossAxisAlignment alignment;

  @override
  Widget build(BuildContext context) {
    final Color subtextColor = isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight;

    return Column(
      crossAxisAlignment: alignment,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        CustomTextLabelWidget(
          label: label,
          style: TextStyle(
            color: subtextColor,
            fontSize: Dimens.fontSize10,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: Dimens.space4),
        CustomTextLabelWidget(
          label: value,
          style: TextStyle(
            color: valueColor,
            fontWeight: FontWeight.w800,
            fontSize: Dimens.fontSize13,
          ),
        ),
      ],
    );
  }
}



