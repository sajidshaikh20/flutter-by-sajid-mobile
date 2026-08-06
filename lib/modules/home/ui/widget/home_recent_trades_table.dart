import '../../../../utils/exports.dart';

class HomeRecentTradesTable extends StatelessWidget {
  const HomeRecentTradesTable({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isDark = context.isDark;
    final Color themeGreen = isDark ? AppColors.successColor : AppColors.greenTextColor;

    return ListenableBuilder(
      listenable: UserProfileService.instance(),
      builder: (BuildContext context, Widget? child) {
        final bool isSubscribed = UserProfileService.instance().isSubscriptionActive;

        return BlocBuilder<HomeCubit, HomeState>(
          builder: (BuildContext context, HomeState state) {
            final List<TradingSignalModel> trades = state.recentTrades;

            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: Dimens.space16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      CustomTextLabelWidget(
                        label: 'Recent Trades',
                        style: TextStyle(
                          color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight,
                          fontWeight: FontWeight.w600,
                          fontSize: Dimens.fontSize16,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          AutoTabsRouter.of(context).setActiveIndex(2);
                        },
                        child: const CustomTextLabelWidget(
                          label: 'View All',
                          style: TextStyle(
                            color: AppColors.primaryPurple,
                            fontWeight: FontWeight.w500,
                            fontSize: Dimens.fontSize12,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: Dimens.space12),
                  if (!isSubscribed)
                    Builder(
                      builder: (BuildContext context) {
                        final bool isPending = UserProfileService.instance().isPaymentPending;
                        return Container(
                          height: 160,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: isDark ? AppColors.cardDark : AppColors.cardLight,
                            borderRadius: BorderRadius.circular(Dimens.radius12),
                            border: Border.all(
                              color: isDark ? AppColors.borderDark : AppColors.borderLight.withValues(alpha: 0.5),
                            ),
                          ),
                          alignment: Alignment.center,
                          padding: const EdgeInsets.symmetric(horizontal: Dimens.space20),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Icon(
                                isPending ? Icons.pending_actions_rounded : Icons.lock_outline_rounded,
                                color: isPending ? Colors.orangeAccent : AppColors.primaryPurple,
                                size: Dimens.size28,
                              ),
                              const SizedBox(height: Dimens.space10),
                              CustomTextLabelWidget(
                                label: isPending ? 'Your Payment is Pending' : 'Subscription Required',
                                style: const TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: Dimens.fontSize14,
                                ),
                              ),
                              const SizedBox(height: Dimens.space4),
                              CustomTextLabelWidget(
                                label: isPending
                                    ? 'Your subscription payment is pending verification. Complete payment to activate your plan.'
                                    : 'Unlock recent trade activity and signals.',
                                style: TextStyle(
                                  color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight,
                                  fontSize: Dimens.fontSize11,
                                  height: 1.3,
                                ),
                              ),
                              const SizedBox(height: Dimens.space12),
                              GestureDetector(
                                onTap: () => context.router.push(const SubscriptionPlansRoute()),
                                child: CustomTextLabelWidget(
                                  label: isPending ? 'Complete Payment' : 'Get Premium Access',
                                  style: const TextStyle(
                                    color: AppColors.primaryPurple,
                                    fontWeight: FontWeight.w500,
                                    fontSize: Dimens.fontSize12,
                                    decoration: TextDecoration.underline,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    )
                  else if (trades.isEmpty)
                    Container(
                      height: 120,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: isDark ? AppColors.cardDark : AppColors.cardLight,
                        borderRadius: BorderRadius.circular(Dimens.radius12),
                        border: Border.all(
                          color: isDark ? AppColors.borderDark : AppColors.borderLight.withValues(alpha: 0.5),
                        ),
                      ),
                      alignment: Alignment.center,
                      child: CustomTextLabelWidget(
                        label: 'No recent trades',
                        style: TextStyle(
                          color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight,
                          fontSize: Dimens.fontSize13,
                        ),
                      ),
                    )
                  else
                    Container(
                      decoration: BoxDecoration(
                        color: isDark ? AppColors.cardDark : AppColors.cardLight,
                        borderRadius: BorderRadius.circular(Dimens.radius12),
                        border: Border.all(
                          color: isDark ? AppColors.borderDark : AppColors.borderLight.withValues(alpha: 0.5),
                        ),
                      ),
                      padding: const EdgeInsets.all(Dimens.space12),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          // Table Header Row
                          Row(
                            children: <Widget>[
                              Expanded(
                                flex: 3,
                                child: CustomTextLabelWidget(
                                  label: 'Pair',
                                  style: _headerStyle(isDark),
                                  textAlign: TextAlign.start,
                                ),
                              ),
                              Expanded(
                                flex: 4,
                                child: CustomTextLabelWidget(
                                  label: 'Type',
                                  style: _headerStyle(isDark),
                                  textAlign: TextAlign.start,
                                ),
                              ),
                              Expanded(
                                flex: 3,
                                child: CustomTextLabelWidget(
                                  label: 'Status',
                                  style: _headerStyle(isDark),
                                ),
                              ),
                              Expanded(
                                flex: 3,
                                child: CustomTextLabelWidget(
                                  label: 'PnL',
                                  style: _headerStyle(isDark),
                                  textAlign: TextAlign.end,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: Dimens.space8),
                          Divider(
                            height: 1,
                            thickness: 1,
                            color: isDark ? AppColors.dividerDark : AppColors.dividerLight,
                          ),
                          const SizedBox(height: Dimens.space8),
                          // Table Rows
                          ListView.separated(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: trades.length,
                            separatorBuilder: (BuildContext context, int index) => const SizedBox(height: Dimens.space10),
                            itemBuilder: (BuildContext context, int index) {
                              final TradingSignalModel trade = trades[index];
                              final bool isBuy = trade.type.toUpperCase().contains('BUY');
                              final bool isWin = trade.outcome?.toUpperCase() == 'WIN';
                              final bool isLoss = trade.outcome?.toUpperCase() == 'LOSS';
                              final Color pnlColor = isWin 
                                  ? themeGreen 
                                  : (isLoss ? AppColors.errorColor : (isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight));

                              Color statusBgColor = AppColors.infoColor.withValues(alpha: isDark ? 0.15 : 0.1);
                              Color statusTextColor = AppColors.infoColor;

                              if (trade.status == 'CLOSED') {
                                statusBgColor = (isWin ? themeGreen : AppColors.errorColor).withValues(alpha: isDark ? 0.15 : 0.1);
                                statusTextColor = isWin ? themeGreen : AppColors.errorColor;
                              }

                              return Row(
                                children: <Widget>[
                                  Expanded(
                                    flex: 3,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: <Widget>[
                                        CustomTextLabelWidget(
                                          label: trade.pair,
                                          style: TextStyle(
                                            color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight,
                                            fontWeight: FontWeight.w500,
                                            fontSize: Dimens.fontSize12,
                                          ),
                                          textAlign: TextAlign.start,
                                        ),
                                        if (trade.lotSize != null) ...<Widget>[
                                          const SizedBox(height: 2),
                                          CustomTextLabelWidget(
                                            label: 'Lot: ${trade.lotSize}',
                                            style: TextStyle(
                                              color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight,
                                              fontSize: Dimens.fontSize10,
                                            ),
                                            textAlign: TextAlign.start,
                                          ),
                                        ],
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    flex: 4,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: <Widget>[
                                        CustomTextLabelWidget(
                                          label: trade.type,
                                          style: TextStyle(
                                            color: isBuy ? themeGreen : AppColors.errorColor,
                                            fontWeight: FontWeight.w500,
                                            fontSize: Dimens.fontSize12,
                                          ),
                                          textAlign: TextAlign.start,
                                        ),
                                        if (trade.riskAmount != null) ...<Widget>[
                                          const SizedBox(height: 2),
                                          CustomTextLabelWidget(
                                            label: 'Risk: \$${trade.riskAmount!.toStringAsFixed(trade.riskAmount! % 1 == 0 ? 0 : 2)}',
                                            style: TextStyle(
                                              color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight,
                                              fontSize: Dimens.fontSize10,
                                            ),
                                            textAlign: TextAlign.start,
                                          ),
                                        ],
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    flex: 3,
                                    child: Center(
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: Dimens.space6,
                                          vertical: Dimens.space2,
                                        ),
                                        decoration: BoxDecoration(
                                          color: statusBgColor,
                                          borderRadius: BorderRadius.circular(Dimens.radius4),
                                        ),
                                        child: CustomTextLabelWidget(
                                          label: trade.status,
                                          style: TextStyle(
                                            color: statusTextColor,
                                            fontWeight: FontWeight.w600,
                                            fontSize: Dimens.fontSize10,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 3,
                                    child: CustomTextLabelWidget(
                                      label: trade.pips,
                                      style: TextStyle(
                                        color: pnlColor,
                                        fontWeight: FontWeight.w500,
                                        fontSize: Dimens.fontSize13,
                                      ),
                                      textAlign: TextAlign.end,
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  TextStyle _headerStyle(bool isDark) {
    return TextStyle(
      color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight,
      fontWeight: FontWeight.w400,
      fontSize: Dimens.fontSize11,
    );
  }
}
