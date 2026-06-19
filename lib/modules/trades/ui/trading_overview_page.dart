import '../../../utils/exports.dart';

@RoutePage()
/// Trading overview page showing details of a specific trading signal.
class TradingOverviewPage extends BaseResponsiveView {
  const TradingOverviewPage({
    super.key,
    required this.signal,
  });

  final TradingSignalModel signal;

  @override
  Widget buildDesktopWidget(BuildContext context) => _build(context);

  @override
  Widget buildTabletWidget(BuildContext context) => _build(context);

  @override
  Widget buildMobileWidget(BuildContext context) => _build(context);

  Widget _build(BuildContext context) {
    return BlocProvider<TradingOverviewCubit>(
      create: (BuildContext context) => TradingOverviewCubit(
        signal: signal,
        repository: TradesRepositoryImpl(),
      ),
      child: TradingOverviewViewBody(signal: signal),
    );
  }
}

class TradingOverviewViewBody extends StatelessWidget {
  const TradingOverviewViewBody({
    super.key,
    required this.signal,
  });

  final TradingSignalModel signal;

  String _getPairName(String pair) {
    switch (pair.toUpperCase()) {
      case 'EURUSD':
        return 'Euro / US Dollar';
      case 'BTCUSD':
      case 'BTCUSDT':
        return 'Bitcoin / US Dollar';
      case 'ETHUSD':
        return 'Ethereum / US Dollar';
      case 'GBPUSD':
        return 'British Pound / US Dollar';
      case 'XAUUSD':
        return 'Gold / US Dollar';
      case 'USDJPY':
        return 'US Dollar / Japanese Yen';
      case 'SOLUSD':
        return 'Solana / US Dollar';
      default:
        return '$pair Spot';
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool isDark = context.isDark;
    final Color textColor = isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight;
    final Color subtextColor = isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight;
    final Color pageBg = isDark ? AppColors.backgroundDark : AppColors.backgroundLight;
    final Color themeGreen = isDark ? AppColors.successColor : AppColors.greenTextColor;

    // Status colors mapping
    Color statusBgColor = AppColors.infoColor;
    String statusText = signal.status.toUpperCase();

    if (signal.isActive) {
      statusBgColor = const Color(0xFF0F3A80);
    } else if (signal.isPending) {
      statusBgColor = AppColors.warningColor;
    } else if (signal.isClosed) {
      statusBgColor = signal.outcome == 'WIN' ? themeGreen : AppColors.errorColor;
      statusText = signal.outcome ?? 'CLOSED';
    } else if (signal.isCancelled) {
      statusBgColor = AppColors.neutralColor;
    }

    return BlocConsumer<TradingOverviewCubit, TradingOverviewState>(
      listener: (BuildContext context, TradingOverviewState state) {
        if (state.status == BaseStateStatus.loading) {
          unawaited(EasyLoading.show(status: 'Loading...'));
        } else {
          unawaited(EasyLoading.dismiss());
        }

        if (state.status == BaseStateStatus.success && state.msg != null && state.msg!.isNotEmpty) {
          context.scaffoldMessenger.showSnackBar(
            SnackBar(
              content: Text(state.msg!),
              backgroundColor: AppColors.successColor,
            ),
          );
          context.read<TradingOverviewCubit>().resetError();
        }

        if (state.status == BaseStateStatus.failure && state.msg != null && state.msg!.isNotEmpty) {
          context.scaffoldMessenger.showSnackBar(
            SnackBar(
              content: Text(state.msg!),
              backgroundColor: AppColors.errorColor,
            ),
          );
          context.read<TradingOverviewCubit>().resetError();
        }
      },
      builder: (BuildContext context, TradingOverviewState state) {
        return Scaffold(
          backgroundColor: pageBg,
          bottomNavigationBar: (signal.isActive || signal.isPending)
              ? SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: Dimens.space16, vertical: Dimens.space8),
                    child: CustomGradientButtonWidget(
                      title: 'Take Trade',
                      onTap: () {
                        if (signal.publicId.isNotEmpty) {
                          unawaited(context.read<TradingOverviewCubit>().takeTrade(signal.publicId));
                        } else {
                          context.scaffoldMessenger.showSnackBar(
                            const SnackBar(
                              content: Text('Cannot take trade: invalid ID'),
                            ),
                          );
                        }
                      },
                      borderRadius: Dimens.radius12,
                      height: 50,
                    ),
                  ),
                )
              : null,
          body: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                // Custom App Bar Header matching requested screenshot
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: Dimens.space16,
                    vertical: Dimens.space12,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      GestureDetector(
                        onTap: () => context.router.back(),
                        child: Icon(
                          Icons.arrow_back_ios_new_rounded,
                          color: textColor,
                          size: Dimens.size20,
                        ),
                      ),
                      CustomTextLabelWidget(
                        label: 'Trading Overview',
                        style: TextStyle(
                          color: textColor,
                          fontSize: Dimens.fontSize18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: Dimens.space12,
                          vertical: Dimens.space6,
                        ),
                        decoration: BoxDecoration(
                          color: statusBgColor,
                          borderRadius: BorderRadius.circular(Dimens.radius4),
                        ),
                        child: CustomTextLabelWidget(
                          label: statusText,
                          style: const TextStyle(
                            color: AppColors.whiteColor,
                            fontSize: Dimens.fontSize10,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                // Pair details section
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: Dimens.space24,
                    vertical: Dimens.space16,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      CustomTextLabelWidget(
                        label: signal.pair,
                        style: TextStyle(
                          color: textColor,
                          fontSize: Dimens.fontSize28,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: Dimens.space4),
                      CustomTextLabelWidget(
                        label: _getPairName(signal.pair),
                        style: TextStyle(
                          color: subtextColor,
                          fontSize: Dimens.fontSize14,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),

                // Scrollable Content
                Expanded(
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    padding: const EdgeInsets.symmetric(horizontal: Dimens.space16),
                    child: Column(
                      children: <Widget>[
                        // Card 1: Trade Info
                        _buildCard(
                          title: 'Trade Info',
                          isDark: isDark,
                          children: <Widget>[
                            _buildCardRow(
                              label: 'Type',
                              value: signal.type,
                              isDark: isDark,
                            ),
                            const SizedBox(height: Dimens.space12),
                            _buildCardRow(
                              label: 'Market',
                              value: signal.category,
                              isDark: isDark,
                            ),
                            const SizedBox(height: Dimens.space12),
                            _buildCardRow(
                              label: 'Created',
                              value: '08 Jun 2026, 12:52 PM',
                              isDark: isDark,
                            ),
                            const SizedBox(height: Dimens.space12),
                            _buildCardRow(
                              label: 'Platform',
                              value: '—',
                              isDark: isDark,
                            ),
                          ],
                        ),
                        const SizedBox(height: Dimens.space16),

                        // Card 2: Trade Levels
                        _buildCard(
                          title: 'Trade Levels',
                          isDark: isDark,
                          children: <Widget>[
                            _buildCardRow(
                              label: 'Entry 1',
                              value: signal.entryPrice.toString(),
                              isDark: isDark,
                            ),
                            const SizedBox(height: Dimens.space12),
                            _buildCardRow(
                              label: 'Entry 2',
                              value: '—',
                              isDark: isDark,
                            ),
                            const SizedBox(height: Dimens.space12),
                            _buildCardRow(
                              label: 'Stop Loss',
                              value: signal.stopLoss.toString(),
                              valueColor: AppColors.errorColor,
                              isDark: isDark,
                            ),
                            const SizedBox(height: Dimens.space16),
                            Row(
                              children: <Widget>[
                                _buildTPBox(
                                  label: 'TP1',
                                  value: signal.takeProfit.toString(),
                                  hasValue: true,
                                  isDark: isDark,
                                  themeGreen: themeGreen,
                                ),
                                const SizedBox(width: Dimens.space10),
                                _buildTPBox(
                                  label: 'TP2',
                                  value: '—',
                                  hasValue: false,
                                  isDark: isDark,
                                  themeGreen: themeGreen,
                                ),
                                const SizedBox(width: Dimens.space10),
                                _buildTPBox(
                                  label: 'TP3',
                                  value: '—',
                                  hasValue: false,
                                  isDark: isDark,
                                  themeGreen: themeGreen,
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: Dimens.space16),

                        // Card 3: Performance
                        _buildCard(
                          title: 'Performance',
                          isDark: isDark,
                          children: <Widget>[
                            _buildCardRow(
                              label: 'Risk Reward',
                              value: signal.rr,
                              isDark: isDark,
                            ),
                          ],
                        ),
                        const SizedBox(height: Dimens.space16),

                        // Card 4: Trade Progress
                        _buildTradeProgressCard(context, state, isDark),
                        const SizedBox(height: Dimens.space16),

                        // Card 5: Trade Analysis
                        _buildTradeAnalysisCard(context, isDark),
                        const SizedBox(height: Dimens.space24),
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

  Widget _buildTradeProgressCard(BuildContext context, TradingOverviewState state, bool isDark) {
    final Color cardBg = isDark ? AppColors.cardDark : AppColors.cardLight;
    final Color borderCol = isDark ? AppColors.borderDark : AppColors.borderLight.withValues(alpha: 0.5);
    final Color textColor = isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight;
    final Color themeGreen = isDark ? AppColors.successColor : AppColors.greenTextColor;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(Dimens.space16),
      decoration: BoxDecoration(
        color: cardBg,
        borderRadius: BorderRadius.circular(Dimens.radius12),
        border: Border.all(color: borderCol),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              CustomTextLabelWidget(
                label: 'Trade Progress',
                style: TextStyle(
                  color: textColor,
                  fontSize: Dimens.fontSize16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: Dimens.space12, vertical: Dimens.space8),
                decoration: BoxDecoration(
                  color: isDark ? const Color(0xFF0C1935) : const Color(0xFFE3F2FD),
                  borderRadius: BorderRadius.circular(Dimens.radius8),
                  border: Border.all(color: isDark ? Colors.white10 : AppColors.borderLight),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        CustomTextLabelWidget(
                          label: 'LIVE PRICE',
                          style: TextStyle(
                            color: isDark ? Colors.white70 : AppColors.textSecondaryLight,
                            fontSize: 7,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(width: Dimens.space6),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 1),
                          decoration: BoxDecoration(
                            color: isDark ? Colors.white12 : Colors.black12,
                            borderRadius: BorderRadius.circular(3),
                          ),
                          child: CustomTextLabelWidget(
                            label: 'Twelve Data',
                            style: TextStyle(
                              color: isDark ? Colors.white54 : AppColors.textSecondaryLight,
                              fontSize: 6,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    CustomTextLabelWidget(
                      label: signal.pair.contains('BTC') ? state.livePrice.toStringAsFixed(2) : state.livePrice.toStringAsFixed(5),
                      style: TextStyle(
                        color: isDark ? Colors.white : AppColors.textPrimaryLight,
                        fontSize: Dimens.fontSize14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: Dimens.space20),
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
          const SizedBox(height: Dimens.space20),
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
                alignment: Alignment(2 * state.progress - 1, 0),
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
        ],
      ),
    );
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

  String _getChartImageUrl(String url) {
    if (url.contains('tradingview.com/x/')) {
      final List<String> parts = url.split('tradingview.com/x/');
      if (parts.length > 1) {
        final String code = parts[1].replaceAll('/', '');
        return 'https://s3.tradingview.com/x/$code.png';
      }
    }
    return url;
  }

  Widget _buildTradeAnalysisCard(BuildContext context, bool isDark) {
    final Color cardBg = isDark ? AppColors.cardDark : AppColors.cardLight;
    final Color borderCol = isDark ? AppColors.borderDark : AppColors.borderLight.withValues(alpha: 0.5);
    final Color textColor = isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight;

    const String chartLink = 'https://www.tradingview.com/x/kMmfTev8/';

    final String imageUrl = _getChartImageUrl(chartLink);

    DebugLog.instance.i("image image:-$imageUrl");

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(Dimens.space16),
      decoration: BoxDecoration(
        color: cardBg,
        borderRadius: BorderRadius.circular(Dimens.radius12),
        border: Border.all(color: borderCol),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          CustomTextLabelWidget(
            label: 'Trade Analysis',
            style: TextStyle(
              color: textColor,
              fontSize: Dimens.fontSize16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: Dimens.space16),
          GestureDetector(
            onTap: () => _launchUrl(chartLink),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(Dimens.radius8),
              child: CommonImageWidget(
                imagePath: imageUrl,
                height: 180,
                width: double.infinity,
                radius: Dimens.radius8,
              ),
            ),
          ),
          const SizedBox(height: Dimens.space12),
          GestureDetector(
            onTap: () => _launchUrl(chartLink),
            child: const CustomTextLabelWidget(
              label: chartLink,
              style: TextStyle(
                color: AppColors.primaryPurple,
                decoration: TextDecoration.underline,
                fontSize: Dimens.fontSize12,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.start,
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _launchUrl(String urlString) async {
    final Uri url = Uri.parse(urlString);
    try {
      if (await canLaunchUrl(url)) {
        await launchUrl(url, mode: LaunchMode.externalApplication);
      }
    } on Object catch (_) {
      // Fail silently
    }
  }

  Widget _buildCard({
    required String title,
    required bool isDark,
    required List<Widget> children,
  }) {
    final Color cardBg = isDark ? AppColors.cardDark : AppColors.cardLight;
    final Color borderCol = isDark ? AppColors.borderDark : AppColors.borderLight.withValues(alpha: 0.5);
    final Color textColor = isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(Dimens.space16),
      decoration: BoxDecoration(
        color: cardBg,
        borderRadius: BorderRadius.circular(Dimens.radius12),
        border: Border.all(color: borderCol),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          CustomTextLabelWidget(
            label: title,
            style: TextStyle(
              color: textColor,
              fontSize: Dimens.fontSize16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: Dimens.space16),
          ...children,
        ],
      ),
    );
  }

  Widget _buildCardRow({
    required String label,
    required String value,
    Color? valueColor,
    required bool isDark,
  }) {
    final Color textColor = isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight;
    final Color subtextColor = isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        CustomTextLabelWidget(
          label: label,
          style: TextStyle(
            color: subtextColor,
            fontSize: Dimens.fontSize14,
            fontWeight: FontWeight.w400,
          ),
        ),
        CustomTextLabelWidget(
          label: value,
          style: TextStyle(
            color: valueColor ?? textColor,
            fontSize: Dimens.fontSize14,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget _buildTPBox({
    required String label,
    required String value,
    required bool hasValue,
    required bool isDark,
    required Color themeGreen,
  }) {
    final Color bg = hasValue
        ? themeGreen.withValues(alpha: isDark ? 0.15 : 0.08)
        : (isDark ? AppColors.surfaceDark : AppColors.backgroundLight);
    final Color border = hasValue
        ? themeGreen.withValues(alpha: isDark ? 0.3 : 0.2)
        : (isDark ? AppColors.borderDark : AppColors.borderLight);
    final Color textColor = hasValue ? themeGreen : (isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight);
    final Color labelColor = hasValue ? themeGreen : (isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight);

    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: Dimens.space12),
        decoration: BoxDecoration(
          color: bg,
          borderRadius: BorderRadius.circular(Dimens.radius8),
          border: Border.all(color: border),
        ),
        child: Column(
          children: <Widget>[
            CustomTextLabelWidget(
              label: label,
              style: TextStyle(
                color: labelColor,
                fontSize: Dimens.fontSize10,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: Dimens.space6),
            CustomTextLabelWidget(
              label: value,
              style: TextStyle(
                color: textColor,
                fontSize: Dimens.fontSize14,
                fontWeight: FontWeight.w800,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
