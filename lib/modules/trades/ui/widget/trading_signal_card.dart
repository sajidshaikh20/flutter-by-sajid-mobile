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

          // Mid Section 1: Entry, SL, TP (or TP 1, TP 2, TP 3 on separate line if multiple)
          if (signal.takeProfitTwo != null || signal.takeProfitThree != null) ...<Widget>[
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
                    subValue: signal.slPips != null ? '${signal.slPips!.toStringAsFixed(2)} Pips' : null,
                    valueColor: AppColors.errorColor,
                    isDark: isDark,
                    alignment: CrossAxisAlignment.center,
                  ),
                ),
                const Expanded(child: SizedBox.shrink()),
              ],
            ),
            const SizedBox(height: Dimens.space12),
            Row(
              children: <Widget>[
                Expanded(
                  child: _ValueColumn(
                    label: 'TP 1',
                    value: (signal.takeProfitOne != null)
                        ? signal.takeProfitOne.toString()
                        : signal.takeProfit.toString(),
                    subValue: signal.tpPips != null ? '${signal.tpPips!.toStringAsFixed(2)} Pips' : null,
                    valueColor: themeGreen,
                    isDark: isDark,
                  ),
                ),
                Expanded(
                  child: _ValueColumn(
                    label: 'TP 2',
                    value: signal.takeProfitTwo.toString(),
                    valueColor: themeGreen,
                    isDark: isDark,
                    alignment: CrossAxisAlignment.center,
                  ),
                ),
                if (signal.takeProfitThree != null)
                  Expanded(
                    child: _ValueColumn(
                      label: 'TP 3',
                      value: signal.takeProfitThree.toString(),
                      valueColor: themeGreen,
                      isDark: isDark,
                      alignment: CrossAxisAlignment.end,
                    ),
                  )
                else
                  const Expanded(child: SizedBox.shrink()),
              ],
            ),
          ] else ...<Widget>[
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
                    subValue: signal.slPips != null ? '${signal.slPips!.toStringAsFixed(2)} Pips' : null,
                    valueColor: AppColors.errorColor,
                    isDark: isDark,
                    alignment: CrossAxisAlignment.center,
                  ),
                ),
                Expanded(
                  child: _ValueColumn(
                    label: 'Take Profit',
                    value: signal.takeProfit.toString(),
                    subValue: signal.tpPips != null ? '${signal.tpPips!.toStringAsFixed(2)} Pips' : null,
                    valueColor: themeGreen,
                    isDark: isDark,
                    alignment: CrossAxisAlignment.end,
                  ),
                ),
              ],
            ),
          ],
          if (signal.riskAmount != null || signal.lotSize != null) ...<Widget>[
            const SizedBox(height: Dimens.space12),
            Row(
              children: <Widget>[
                if (signal.riskAmount != null)
                  Expanded(
                    child: _ValueColumn(
                      label: 'Risk Amount',
                      value: '\$${signal.riskAmount!.toStringAsFixed(signal.riskAmount! % 1 == 0 ? 0 : 2)}',
                      valueColor: textColor,
                      isDark: isDark,
                    ),
                  )
                else
                  const Expanded(child: SizedBox.shrink()),
                if (signal.lotSize != null)
                  Expanded(
                    child: _ValueColumn(
                      label: 'Lot Size',
                      value: signal.lotSize!.toString(),
                      valueColor: textColor,
                      isDark: isDark,
                      alignment: CrossAxisAlignment.center,
                    ),
                  )
                else
                  const Expanded(child: SizedBox.shrink()),
                const Expanded(child: SizedBox.shrink()),
              ],
            ),
          ],
          const SizedBox(height: Dimens.space16),

          // Mid Section 2 (Conditional)
          if (signal.isActive) ...<Widget>[
            // Active price details
            Row(
              children: <Widget>[
                // Posted by block
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Icon(
                            Icons.person_outline_rounded,
                            color: subtextColor,
                            size: Dimens.size14,
                          ),
                          const SizedBox(width: Dimens.space4),
                          CustomTextLabelWidget(
                            label: 'Posted by',
                            style: TextStyle(
                              color: subtextColor,
                              fontSize: Dimens.fontSize10,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: Dimens.space4),
                      CustomTextLabelWidget(
                        label: signal.traderName.isNotNullOrEmpty
                            ? signal.traderName!
                            : '--',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          color: textColor,
                          fontWeight: FontWeight.w800,
                          fontSize: Dimens.fontSize14,
                        ),
                      ),
                    ],
                  ),
                ),
                // PIPS block
                Expanded(
                  child: _shouldHidePips(signal.pips, signal.resultInPips)
                      ? const SizedBox()
                      : Column(
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
          ] else if (signal.isClosed) ...<Widget>[
            // Closed Details Rows (Result, RR, Outcome)
            Row(
              children: <Widget>[
                // Result
                Expanded(
                  child: _shouldHidePips(signal.pips, signal.resultInPips)
                      ? const SizedBox()
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            CustomTextLabelWidget(
                              label: 'Result',
                              style: TextStyle(
                                color: subtextColor,
                                fontSize: Dimens.fontSize10,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const SizedBox(height: Dimens.space4),
                            CustomTextLabelWidget(
                              label: signal.resultInPips != null
                                  ? '${signal.resultInPips! >= 0 ? '+' : ''}${signal.resultInPips!.toStringAsFixed(2)} PIPS'
                                  : signal.pips,
                              style: TextStyle(
                                color: signal.outcome == 'WIN' ? themeGreen : AppColors.errorColor,
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
                        label: signal.outcome ?? 'LOSS',
                        style: TextStyle(
                          color: signal.outcome == 'WIN' ? themeGreen : AppColors.errorColor,
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
            const SizedBox(height: Dimens.space12),
            // Posted by row
            Row(
              children: <Widget>[
                Icon(
                  Icons.person_outline_rounded,
                  color: subtextColor,
                  size: Dimens.size14,
                ),
                const SizedBox(width: Dimens.space4),
                CustomTextLabelWidget(
                  label: 'Posted by: ',
                  style: TextStyle(
                    color: subtextColor,
                    fontSize: Dimens.fontSize10,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                CustomTextLabelWidget(
                  label: signal.traderName.isNotNullOrEmpty ? signal.traderName! : '--',
                  style: TextStyle(
                    color: textColor,
                    fontSize: Dimens.fontSize10,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ] else ...<Widget>[
            // Closed/Cancelled Details Row
            Row(
              children: <Widget>[
                // Posted by block
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Icon(
                            Icons.person_outline_rounded,
                            color: subtextColor,
                            size: Dimens.size14,
                          ),
                          const SizedBox(width: Dimens.space4),
                          CustomTextLabelWidget(
                            label: 'Posted by',
                            style: TextStyle(
                              color: subtextColor,
                              fontSize: Dimens.fontSize10,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: Dimens.space4),
                      CustomTextLabelWidget(
                        label: signal.traderName.isNotNullOrEmpty
                            ? signal.traderName!
                            : '--',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          color: textColor,
                          fontWeight: FontWeight.w800,
                          fontSize: Dimens.fontSize14,
                        ),
                      ),
                    ],
                  ),
                ),
                // PIPS
                Expanded(
                  child: _shouldHidePips(signal.pips, signal.resultInPips)
                      ? const SizedBox()
                      : Column(
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
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      CustomTextLabelWidget(
                        label: 'RR',
                        style: TextStyle(
                          color: subtextColor,
                          fontSize: Dimens.fontSize10,
                          fontWeight: FontWeight.w500,
                        ),
                        textAlign: TextAlign.end,
                      ),
                      const SizedBox(height: Dimens.space4),
                      CustomTextLabelWidget(
                        label: signal.rr,
                        style: TextStyle(
                          color: textColor,
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
                    label: ((signal.isClosed || signal.isCancelled) && signal.createdAt != null)
                        ? 'Created: ${DateFormat('dd MMM yyyy').format(DateTime.parse(signal.createdAt!).toLocal())}'
                        : signal.timeLabel,
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
                      onTap: signal.isTaken
                          ? null
                          : () {
                              if (signal.publicId.isNotEmpty) {
                                unawaited(context.read<TradesCubit>().takeTrade(signal.publicId));
                              } else {
                                context.scaffoldMessenger.showSnackBar(
                                  const SnackBar(
                                    content: Text('Cannot take trade: invalid ID'),
                                  ),
                                );
                              }
                            },
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: Dimens.space12, vertical: Dimens.space6),
                        decoration: BoxDecoration(
                          gradient: signal.isTaken ? null : AppColors.primaryButtonGradient,
                          color: signal.isTaken ? (isDark ? AppColors.borderDark : AppColors.borderLight) : null,
                          borderRadius: BorderRadius.circular(Dimens.radius8),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            CustomTextLabelWidget(
                              label: signal.isTaken ? 'Taken' : 'Take Trade',
                              style: TextStyle(
                                color: signal.isTaken ? subtextColor : AppColors.whiteColor,
                                fontWeight: FontWeight.w800,
                                fontSize: Dimens.fontSize10,
                              ),
                            ),
                            if (!signal.isTaken) ...<Widget>[
                              const SizedBox(width: Dimens.space4),
                              const Icon(
                                Icons.trending_up_rounded,
                                color: AppColors.whiteColor,
                                size: Dimens.size12,
                              ),
                            ] else ...<Widget>[
                              const SizedBox(width: Dimens.space4),
                              Icon(
                                Icons.check_circle_rounded,
                                color: themeGreen,
                                size: Dimens.size12,
                              ),
                            ],
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: Dimens.space8),
                  ],
                  GestureDetector(
                    onTap: () async {
                      await context.router.push(TradingOverviewRoute(signal: signal));
                      if (context.mounted) {
                        if (showTakeTrade) {
                          unawaited(context.read<TradesCubit>().loadTrades());
                        } else {
                          unawaited(context.read<MyTradesCubit>().loadMyTrades(isRefresh: true));
                        }
                      }
                    },
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

}

class _ValueColumn extends StatelessWidget {
  const _ValueColumn({
    required this.label,
    required this.value,
    this.subValue,
    required this.valueColor,
    required this.isDark,
    this.alignment = CrossAxisAlignment.start,
  });

  final String label;
  final String value;
  final String? subValue;
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
        if (subValue != null && subValue!.isNotEmpty) ...<Widget>[
          const SizedBox(height: Dimens.space2),
          CustomTextLabelWidget(
            label: subValue!,
            style: TextStyle(
              color: subtextColor,
              fontWeight: FontWeight.w500,
              fontSize: Dimens.fontSize9,
            ),
          ),
        ],
      ],
    );
  }
}

bool _shouldHidePips(String pips, double? resultInPips) {
  if (resultInPips != null) {
    return resultInPips == 0.0;
  }
  final String clean = pips.replaceAll(RegExp(r'[^0-9.]'), '').trim();
  if (clean.isEmpty) return true;
  final double? val = double.tryParse(clean);
  return val == 0.0;
}



