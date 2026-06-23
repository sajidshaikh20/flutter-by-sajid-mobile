import '../../../../utils/exports.dart';
import '../../model/home_dummy_data.dart';

class HomeRecentTradesTable extends StatelessWidget {
  const HomeRecentTradesTable({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isDark = context.isDark;
    final List<HomeRecentTradeModel> trades = HomeMockData.recentTrades;

    return ListenableBuilder(
      listenable: UserProfileService.instance(),
      builder: (BuildContext context, Widget? child) {
        final bool isSubscribed = UserProfileService.instance().isSubscriptionActive;

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
                        label: 'Unlock recent trade activity and signals.',
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
                          final HomeRecentTradeModel trade = trades[index];
                          return Row(
                            children: <Widget>[
                              Expanded(
                                flex: 3,
                                child: CustomTextLabelWidget(
                                  label: trade.pair,
                                  style: TextStyle(
                                    color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight,
                                    fontWeight: FontWeight.w500,
                                    fontSize: Dimens.fontSize13,
                                  ),
                                  textAlign: TextAlign.start,
                                ),
                              ),
                              Expanded(
                                flex: 4,
                                child: CustomTextLabelWidget(
                                  label: trade.type,
                                  style: TextStyle(
                                    color: trade.isBuy ? (isDark ? AppColors.successColor : AppColors.greenTextColor) : AppColors.errorColor,
                                    fontWeight: FontWeight.w500,
                                    fontSize: Dimens.fontSize12,
                                  ),
                                  textAlign: TextAlign.start,
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
                                      color: (isDark ? AppColors.successColor : AppColors.greenTextColor).withValues(alpha: isDark ? 0.15 : 0.1),
                                      borderRadius: BorderRadius.circular(Dimens.radius4),
                                    ),
                                    child: CustomTextLabelWidget(
                                      label: 'CLOSED',
                                      style: TextStyle(
                                        color: isDark ? AppColors.successColor : AppColors.greenTextColor,
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
                                  label: (trade.isPositivePnL ? '+' : '') + trade.pnl.toString(),
                                  style: TextStyle(
                                    color: trade.isPositivePnL ? (isDark ? AppColors.successColor : AppColors.greenTextColor) : AppColors.errorColor,
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
  }

  TextStyle _headerStyle(bool isDark) {
    return TextStyle(
      color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight,
      fontWeight: FontWeight.w400,
      fontSize: Dimens.fontSize11,
    );
  }
}
