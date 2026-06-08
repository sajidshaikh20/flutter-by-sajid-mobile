import '../../../../utils/exports.dart';
import '../../model/home_dummy_data.dart';

class HomeLiveTradesCard extends StatelessWidget {
  const HomeLiveTradesCard({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isDark = context.isDark;
    final List<HomeLiveTradeModel> liveTrades = HomeMockData.liveTrades;

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
                  fontWeight: FontWeight.w800,
                  fontSize: Dimens.fontSize16,
                ),
              ),
              GestureDetector(
                onTap: () {
                 // AutoTabsRouter.of(context).setActiveIndex(2);
                  displaySnackBar("Under development", context);
                },
                child: const CustomTextLabelWidget(
                  label: 'View All',
                  style: TextStyle(
                    color: AppColors.primaryPurple,
                    fontWeight: FontWeight.w600,
                    fontSize: Dimens.fontSize12,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: Dimens.space12),
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: EdgeInsets.zero,
            itemCount: liveTrades.length,
            separatorBuilder: (BuildContext context, int index) => const SizedBox(height: Dimens.space12),
            itemBuilder: (BuildContext context, int index) {
              final HomeLiveTradeModel trade = liveTrades[index];
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
                                      fontWeight: FontWeight.w800,
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
                                      color: (isDark ? AppColors.successColor : AppColors.greenTextColor).withValues(alpha: isDark ? 0.15 : 0.1),
                                      borderRadius: BorderRadius.circular(Dimens.radius4),
                                    ),
                                    child: CustomTextLabelWidget(
                                      label: trade.status,
                                      style: TextStyle(
                                        color: isDark ? AppColors.successColor : AppColors.greenTextColor,
                                        fontWeight: FontWeight.w800,
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
                                      fontWeight: FontWeight.w500,
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
                                    color: trade.isBuy ? (isDark ? AppColors.successColor : AppColors.greenTextColor) : AppColors.errorColor,
                                    fontWeight: FontWeight.w700,
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
                                    color: isDark ? AppColors.successColor : AppColors.greenTextColor,
                                    shape: BoxShape.circle,
                                  ),
                                ),
                                const SizedBox(width: Dimens.space4),
                                CustomTextLabelWidget(
                                  label: 'Live Price',
                                  style: TextStyle(
                                    color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight,
                                    fontSize: Dimens.fontSize10,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: Dimens.space4),
                            CustomTextLabelWidget(
                              label: trade.livePrice.toStringAsFixed(2),
                              style: TextStyle(
                                color: isDark ? AppColors.successColor : AppColors.greenTextColor,
                                fontWeight: FontWeight.w800,
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
                                label: trade.entry.toStringAsFixed(2),
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
                                label: trade.sl.toStringAsFixed(0),
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
                                label: trade.tp.toStringAsFixed(0),
                                style: _valueStyle(isDark, isDark ? AppColors.successColor : AppColors.greenTextColor),
                                textAlign: TextAlign.end,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  TextStyle _labelStyle(bool isDark) {
    return TextStyle(
      color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight,
      fontSize: Dimens.fontSize10,
      fontWeight: FontWeight.w500,
    );
  }

  TextStyle _valueStyle(bool isDark, Color? customColor) {
    return TextStyle(
      color: customColor ?? (isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight),
      fontSize: Dimens.fontSize13,
      fontWeight: FontWeight.w700,
    );
  }
}
