import '../../../../utils/exports.dart';

class HomeLiveTradesCard extends StatelessWidget {
  const HomeLiveTradesCard({super.key});

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
            final List<TradingSignalModel> liveTrades = state.liveTrades;

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
                        label: 'Live Trades',
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
                    Container(
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
                          const Icon(
                            Icons.lock_outline_rounded,
                            color: AppColors.primaryPurple,
                            size: Dimens.size28,
                          ),
                          const SizedBox(height: Dimens.space10),
                          const CustomTextLabelWidget(
                            label: 'Subscription Required',
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: Dimens.fontSize14,
                            ),
                          ),
                          const SizedBox(height: Dimens.space4),
                          CustomTextLabelWidget(
                            label: 'Unlock live active trades and entry alerts.',
                            style: TextStyle(
                              color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight,
                              fontSize: Dimens.fontSize11,
                              height: 1.3,
                            ),
                          ),
                          const SizedBox(height: Dimens.space12),
                          GestureDetector(
                            onTap: () => context.router.push(const SubscriptionPlansRoute()),
                            child: const CustomTextLabelWidget(
                              label: 'Get Premium Access',
                              style: TextStyle(
                                color: AppColors.primaryPurple,
                                fontWeight: FontWeight.w500,
                                fontSize: Dimens.fontSize12,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  else if (liveTrades.isEmpty)
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
                        label: 'No active live trades',
                        style: TextStyle(
                          color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight,
                          fontSize: Dimens.fontSize13,
                        ),
                      ),
                    )
                  else
                    ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      padding: EdgeInsets.zero,
                      itemCount: liveTrades.length,
                      separatorBuilder: (BuildContext context, int index) => const SizedBox(height: Dimens.space12),
                      itemBuilder: (BuildContext context, int index) {
                        final TradingSignalModel trade = liveTrades[index];
                        final bool isBuy = trade.type.toUpperCase().contains('BUY');
                        final double currentPrice = trade.livePrice ?? trade.entryPrice;
                        final String priceStr = trade.pair.contains('BTC') 
                            ? currentPrice.toStringAsFixed(2) 
                            : currentPrice.toStringAsFixed(4);
                        final String entryStr = trade.pair.contains('BTC') 
                            ? trade.entryPrice.toStringAsFixed(2) 
                            : trade.entryPrice.toStringAsFixed(4);
                        final String slStr = trade.pair.contains('BTC') 
                            ? trade.stopLoss.toStringAsFixed(2) 
                            : trade.stopLoss.toStringAsFixed(4);
                        final String tpStr = trade.pair.contains('BTC') 
                            ? trade.takeProfit.toStringAsFixed(2) 
                            : trade.takeProfit.toStringAsFixed(4);

                        return Container(
                          decoration: BoxDecoration(
                            color: isDark ? AppColors.cardDark : AppColors.cardLight,
                            borderRadius: BorderRadius.circular(Dimens.radius12),
                            border: Border.all(
                              color: isDark ? AppColors.borderDark : AppColors.borderLight.withValues(alpha: 0.5),
                            ),
                          ),
                          padding: const EdgeInsets.all(Dimens.space16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              // Top Row: Pair, Status, Price
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  // Left Column: Asset Info, Type
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Row(
                                          children: <Widget>[
                                            Container(
                                              width: Dimens.size32,
                                              height: Dimens.size32,
                                              decoration: BoxDecoration(
                                                color: Colors.orange.withValues(alpha: isDark ? 0.15 : 0.1),
                                                shape: BoxShape.circle,
                                              ),
                                              child: const Icon(
                                                Icons.currency_bitcoin,
                                                color: Colors.orange,
                                                size: Dimens.size18,
                                              ),
                                            ),
                                            const SizedBox(width: Dimens.space8),
                                            CustomTextLabelWidget(
                                              label: trade.pair,
                                              style: TextStyle(
                                                color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight,
                                                fontWeight: FontWeight.w600,
                                                fontSize: Dimens.fontSize14,
                                              ),
                                            ),
                                            const SizedBox(width: Dimens.space8),
                                            Container(
                                              padding: const EdgeInsets.symmetric(
                                                horizontal: Dimens.space6,
                                                vertical: Dimens.space2,
                                              ),
                                              decoration: BoxDecoration(
                                                color: themeGreen.withValues(alpha: isDark ? 0.15 : 0.1),
                                                borderRadius: BorderRadius.circular(Dimens.radius4),
                                              ),
                                              child: CustomTextLabelWidget(
                                                label: trade.status,
                                                style: TextStyle(
                                                  color: themeGreen,
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: Dimens.fontSize9,
                                                ),
                                              ),
                                            ),
                                            const SizedBox(width: Dimens.space6),
                                            CustomTextLabelWidget(
                                              label: '• ${trade.category}',
                                              style: TextStyle(
                                                color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight,
                                                fontSize: Dimens.fontSize10,
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: Dimens.space6),
                                        Padding(
                                          padding: const EdgeInsets.only(left: Dimens.space40),
                                          child: CustomTextLabelWidget(
                                            label: trade.type,
                                            style: TextStyle(
                                              color: isBuy ? themeGreen : AppColors.errorColor,
                                              fontWeight: FontWeight.w500,
                                              fontSize: Dimens.fontSize11,
                                            ),
                                            textAlign: TextAlign.start,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  // Right Column: Live Price
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: <Widget>[
                                      Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: <Widget>[
                                          Container(
                                            width: Dimens.size6,
                                            height: Dimens.size6,
                                            decoration: BoxDecoration(
                                              color: themeGreen,
                                              shape: BoxShape.circle,
                                            ),
                                          ),
                                          const SizedBox(width: Dimens.space4),
                                          CustomTextLabelWidget(
                                            label: 'Live Price',
                                            style: TextStyle(
                                              color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight,
                                              fontSize: Dimens.fontSize10,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: Dimens.space4),
                                      CustomTextLabelWidget(
                                        label: priceStr,
                                        style: TextStyle(
                                          color: themeGreen,
                                          fontWeight: FontWeight.w600,
                                          fontSize: Dimens.fontSize18,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              const SizedBox(height: Dimens.space12),
                              Divider(
                                height: 1,
                                thickness: 1,
                                color: isDark ? AppColors.dividerDark : AppColors.dividerLight,
                              ),
                              const SizedBox(height: Dimens.space12),
                              // Bottom Row: Entry, SL, TP
                              Row(
                                children: <Widget>[
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: <Widget>[
                                        CustomTextLabelWidget(
                                          label: 'Entry',
                                          style: _labelStyle(isDark),
                                          textAlign: TextAlign.start,
                                        ),
                                        const SizedBox(height: Dimens.space4),
                                        CustomTextLabelWidget(
                                          label: entryStr,
                                          style: _valueStyle(isDark, null),
                                          textAlign: TextAlign.start,
                                        ),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    child: Column(
                                      children: <Widget>[
                                        CustomTextLabelWidget(
                                          label: 'SL',
                                          style: _labelStyle(isDark),
                                        ),
                                        const SizedBox(height: Dimens.space4),
                                        CustomTextLabelWidget(
                                          label: slStr,
                                          style: _valueStyle(isDark, AppColors.errorColor),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.end,
                                      children: <Widget>[
                                        CustomTextLabelWidget(
                                          label: 'TP',
                                          style: _labelStyle(isDark),
                                          textAlign: TextAlign.end,
                                        ),
                                        const SizedBox(height: Dimens.space4),
                                        CustomTextLabelWidget(
                                          label: tpStr,
                                          style: _valueStyle(isDark, themeGreen),
                                          textAlign: TextAlign.end,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              if (trade.riskAmount != null || trade.lotSize != null) ...<Widget>[
                                const SizedBox(height: Dimens.space12),
                                Row(
                                  children: <Widget>[
                                    if (trade.riskAmount != null)
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: <Widget>[
                                            CustomTextLabelWidget(
                                              label: 'Risk Amount',
                                              style: _labelStyle(isDark),
                                              textAlign: TextAlign.start,
                                            ),
                                            const SizedBox(height: Dimens.space4),
                                            CustomTextLabelWidget(
                                              label: '\$${trade.riskAmount!.toStringAsFixed(trade.riskAmount! % 1 == 0 ? 0 : 2)}',
                                              style: _valueStyle(isDark, null),
                                              textAlign: TextAlign.start,
                                            ),
                                          ],
                                        ),
                                      )
                                    else
                                      const Expanded(child: SizedBox.shrink()),
                                    if (trade.lotSize != null)
                                      Expanded(
                                        child: Column(
                                          children: <Widget>[
                                            CustomTextLabelWidget(
                                              label: 'Lot Size',
                                              style: _labelStyle(isDark),
                                            ),
                                            const SizedBox(height: Dimens.space4),
                                            CustomTextLabelWidget(
                                              label: trade.lotSize!.toString(),
                                              style: _valueStyle(isDark, null),
                                            ),
                                          ],
                                        ),
                                      )
                                    else
                                      const Expanded(child: SizedBox.shrink()),
                                    const Expanded(child: SizedBox.shrink()),
                                  ],
                                ),
                              ],
                            ],
                          ),
                        );
                      },
                    ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  TextStyle _labelStyle(bool isDark) {
    return TextStyle(
      color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight,
      fontSize: Dimens.fontSize10,
      fontWeight: FontWeight.w400,
    );
  }

  TextStyle _valueStyle(bool isDark, Color? customColor) {
    return TextStyle(
      color: customColor ?? (isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight),
      fontSize: Dimens.fontSize13,
      fontWeight: FontWeight.w500,
    );
  }
}
