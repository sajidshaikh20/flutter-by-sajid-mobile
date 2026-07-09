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

class TradingOverviewViewBody extends StatefulWidget {
  const TradingOverviewViewBody({
    super.key,
    required this.signal,
  });

  final TradingSignalModel signal;

  @override
  State<TradingOverviewViewBody> createState() => _TradingOverviewViewBodyState();
}

class _TradingOverviewViewBodyState extends State<TradingOverviewViewBody> {

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

  String _formatCreatedDate(String? dateStr) {
    if (dateStr == null || dateStr.isEmpty) return '—';
    try {
      final DateTime parsed = DateTime.parse(dateStr);
      return DateFormat('dd MMM yyyy, hh:mm a').format(parsed.toLocal());
    } on Object catch (_) {
      return dateStr;
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool isDark = context.isDark;
    final Color textColor = isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight;
    final Color subtextColor = isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight;
    final Color pageBg = isDark ? AppColors.backgroundDark : AppColors.backgroundLight;
    final Color themeGreen = isDark ? AppColors.successColor : AppColors.greenTextColor;
    return BlocConsumer<TradingOverviewCubit, TradingOverviewState>(
      listener: (BuildContext context, TradingOverviewState state) {
        // The API client automatically manages the EasyLoading loader for API actions
        // like taking a trade (via showLoader: true). Manual management here is redundant
        // and conflicts with the client, causing infinite loading states.

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
        final TradingSignalModel currentSignal = state.signal;

        // Status colors mapping
        Color statusBgColor = AppColors.infoColor.withAlpha(2);
        String statusText = currentSignal.status.toUpperCase();

        if (currentSignal.isActive) {
          statusBgColor = const Color(0xFF0F3A80);
        } else if (currentSignal.isPending) {
          statusBgColor = AppColors.warningColor;
        } else if (currentSignal.isClosed) {
          statusBgColor = currentSignal.outcome == 'WIN' ? themeGreen : AppColors.errorColor;
          statusText = currentSignal.outcome ?? 'CLOSED';
        } else if (currentSignal.isCancelled) {
          statusBgColor = AppColors.neutralColor;
        }

        final double entryPrice = currentSignal.entryPrice;
        final double currentPrice = state.livePrice;
        final double priceDiff = currentPrice - entryPrice;
        final double percentDiff = entryPrice != 0 ? (priceDiff / entryPrice * 100) : 0.0;
        final String diffSign = priceDiff >= 0 ? '+' : '';
        final String formattedChange = '$diffSign${priceDiff.toStringAsFixed(currentSignal.pair.contains('BTC') ? 2 : 4)} ($diffSign${percentDiff.toStringAsFixed(2)}%)';
        final bool isUp = priceDiff >= 0;

        return Scaffold(
          backgroundColor: pageBg,
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
                        label: 'Signal Details',
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
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      // Left logo + name
                      Expanded(
                        child: Row(
                          children: <Widget>[
                            _buildAssetIcon(currentSignal.pair),
                            const SizedBox(width: Dimens.space12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Row(
                                    children: <Widget>[
                                      Flexible(
                                        child: CustomTextLabelWidget(
                                          label: currentSignal.pair,
                                          style: TextStyle(
                                            color: textColor,
                                            fontSize: Dimens.fontSize20,
                                            fontWeight: FontWeight.bold,
                                          ),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                      const SizedBox(width: 6),
                                      Container(
                                        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                                        decoration: BoxDecoration(
                                          color: Colors.orange.withValues(alpha: 0.1),
                                          borderRadius: BorderRadius.circular(4),
                                          border: Border.all(color: Colors.orange.withValues(alpha: 0.3)),
                                        ),
                                        child: CustomTextLabelWidget(
                                          label: currentSignal.category,
                                          style: const TextStyle(
                                            color: Colors.orange,
                                            fontSize: 7,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 2),
                                  CustomTextLabelWidget(
                                    label: _getPairName(currentSignal.pair),
                                    style: TextStyle(
                                      color: subtextColor,
                                      fontSize: Dimens.fontSize12,
                                      fontWeight: FontWeight.w400,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 12),
                      // Right live price
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
                          CustomTextLabelWidget(
                            label: '\$${currentPrice.toStringAsFixed(currentSignal.pair.contains('BTC') ? 2 : 5)}',
                            style: TextStyle(
                              color: textColor,
                              fontSize: Dimens.fontSize20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 2),
                          CustomTextLabelWidget(
                            label: formattedChange,
                            style: TextStyle(
                              color: isUp ? themeGreen : AppColors.errorColor,
                              fontSize: Dimens.fontSize11,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
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
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        // Live Price Progress Timeline
                        _buildSignalTimeline(currentSignal, state.livePrice, state.progress, isDark, themeGreen),
                        const SizedBox(height: Dimens.space16),

                        // Section Heading
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0, bottom: 8.0),
                          child: CustomTextLabelWidget(
                            label: 'Trade Statistics',
                            style: TextStyle(
                              color: textColor,
                              fontSize: Dimens.fontSize18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(height: Dimens.space8),

                        // Card 1: Strategy, Estimated Risk, Live Return, Type
                        _buildStatsCardOne(currentSignal, state.livePrice, isDark, themeGreen),
                        const SizedBox(height: Dimens.space16),

                        // Card 2: Trade Levels (Entry 1, Entry 2, Stop Loss, TPs)
                        _buildTradeLevelsCard(currentSignal, isDark, themeGreen),
                        const SizedBox(height: Dimens.space16),

                        // Card 3: List card (Entry Date & Time, Status, Entry Zone, etc.)
                        _buildStatsCardThree(currentSignal, state.livePrice, isDark, themeGreen),
                        const SizedBox(height: Dimens.space16),

                        // Card 4: Trade Analysis (Web Chart View if present)
                        _buildTradeAnalysisCard(context, state, isDark),
                        const SizedBox(height: Dimens.space24),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          bottomNavigationBar: (!currentSignal.isClosed && !currentSignal.isCancelled)
              ? Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: Dimens.space16,
                    vertical: Dimens.space12,
                  ),
                  decoration: BoxDecoration(
                    color: pageBg,
                    border: Border(
                      top: BorderSide(
                        color: isDark ? AppColors.borderDark : AppColors.borderLight.withValues(alpha: 0.5),
                      ),
                    ),
                  ),
                  child: SafeArea(
                    child: GestureDetector(
                      onTap: state.isTaken
                          ? null
                          : () {
                              if (currentSignal.publicId.isNotEmpty) {
                                unawaited(context.read<TradingOverviewCubit>().takeTrade(currentSignal.publicId));
                              }
                            },
                      child: Container(
                        width: double.infinity,
                        height: 48,
                        decoration: BoxDecoration(
                          gradient: state.isTaken ? null : AppColors.primaryButtonGradient,
                          color: state.isTaken ? (isDark ? AppColors.borderDark : AppColors.borderLight) : null,
                          borderRadius: BorderRadius.circular(Dimens.radius12),
                        ),
                        alignment: Alignment.center,
                        child: CustomTextLabelWidget(
                          label: state.isTaken ? 'Taken' : 'Trade Now',
                          style: TextStyle(
                            color: state.isTaken ? subtextColor : AppColors.whiteColor,
                            fontWeight: FontWeight.w800,
                            fontSize: Dimens.fontSize14,
                          ),
                        ),
                      ),
                    ),
                  ),
                )
              : null,
        );
      },
    );
  }

  Widget _buildTradeAnalysisCard(BuildContext context, TradingOverviewState state, bool isDark) {
    final Color cardBg = isDark ? AppColors.cardDark : AppColors.cardLight;
    final Color borderCol = isDark ? AppColors.borderDark : AppColors.borderLight.withValues(alpha: 0.5);
    final Color textColor = isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight;

    final String chartLink = (state.signal.tradingViewUrl != null && state.signal.tradingViewUrl!.isNotEmpty)
        ? state.signal.tradingViewUrl!
        : '';

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
          if (chartLink.isNotEmpty)
            ClipRRect(
              borderRadius: BorderRadius.circular(Dimens.radius8),
              child: SizedBox(
                height: 250,
                width: double.infinity,
                child: CustomWebView(url: chartLink),
              ),
            )
          else
            const SizedBox.shrink(),
          if (chartLink.isNotEmpty) ...<Widget>[
            const SizedBox(height: Dimens.space12),
            GestureDetector(
              onTap: () => _launchUrl(context, chartLink),
              child: CustomTextLabelWidget(
                label: chartLink,
                style: const TextStyle(
                  color: AppColors.primaryPurple,
                  decoration: TextDecoration.underline,
                  fontSize: Dimens.fontSize12,
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.start,
              ),
            ),
          ],
        ],
      ),
    );
  }

  Future<void> _launchUrl(BuildContext context, String urlString) async {
    if (urlString.isEmpty) return;
    try {
      await Navigator.push(
        context,
        MaterialPageRoute<dynamic>(
          builder: (BuildContext context) => InAppWebViewPage(
            title: 'TradingView Chart',
            url: urlString,
          ),
        ),
      );
    } on Object catch (_) {
      final Uri url = Uri.parse(urlString);
      try {
        if (await canLaunchUrl(url)) {
          await launchUrl(url, mode: LaunchMode.externalApplication);
        }
      } on Object catch (_) {
        // Fail silently
      }
    }
  }



  Widget _buildAssetIcon(String pair) {
    if (pair.contains('BTC')) {
      return Container(
        width: Dimens.size36,
        height: Dimens.size36,
        decoration: const BoxDecoration(
          color: Color(0xFFFFF3E0),
          shape: BoxShape.circle,
        ),
        child: const Icon(Icons.currency_bitcoin, color: Colors.orange, size: Dimens.size20),
      );
    } else if (pair.contains('EUR')) {
      return Container(
        width: Dimens.size36,
        height: Dimens.size36,
        decoration: const BoxDecoration(
          color: Color(0xFFE3F2FD),
          shape: BoxShape.circle,
        ),
        child: const Icon(Icons.euro_symbol_rounded, color: Colors.blue, size: Dimens.size20),
      );
    } else if (pair.contains('ETH')) {
      return Container(
        width: Dimens.size36,
        height: Dimens.size36,
        decoration: const BoxDecoration(
          color: Color(0xFFE8EAF6),
          shape: BoxShape.circle,
        ),
        child: const Icon(Icons.token_outlined, color: Colors.indigo, size: Dimens.size20),
      );
    } else if (pair.contains('XAU') || pair.contains('GOLD')) {
      return Container(
        width: Dimens.size36,
        height: Dimens.size36,
        decoration: const BoxDecoration(
          color: Color(0xFFFFFDE7),
          shape: BoxShape.circle,
        ),
        child: const Icon(Icons.monetization_on_rounded, color: Colors.amber, size: Dimens.size20),
      );
    } else {
      return Container(
        width: Dimens.size36,
        height: Dimens.size36,
        decoration: const BoxDecoration(
          color: Color(0xFFEDE7F6),
          shape: BoxShape.circle,
        ),
        child: const Icon(Icons.monetization_on_outlined, color: Colors.purple, size: Dimens.size20),
      );
    }
  }

  Widget _buildSignalTimeline(TradingSignalModel signal, double livePrice, double progress, bool isDark, Color themeGreen) {
    final Color textColor = isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight;
    final Color subtextColor = isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight;

    // Format created date time for under Entry
    String entryTimeStr = '—';
    if (signal.createdAt != null && signal.createdAt!.isNotEmpty) {
      try {
        final DateTime parsed = DateTime.parse(signal.createdAt!);
        entryTimeStr = DateFormat('dd MMM\nhh:mm a').format(parsed.toLocal());
      } on Object catch (_) {
        entryTimeStr = signal.timeLabel;
      }
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Dimens.space12, vertical: Dimens.space16),
      child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          final double totalWidth = constraints.maxWidth;
          final double dotPos = progress * totalWidth;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              // Live Badge positioned dynamically
              SizedBox(
                height: 24,
                child: Stack(
                  clipBehavior: Clip.none,
                  children: <Widget>[
                    Positioned(
                      left: (dotPos - 18).clamp(0.0, totalWidth - 36),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(
                          color: AppColors.errorColor,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: const CustomTextLabelWidget(
                          label: 'Live',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 7,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 4),
              // Timeline line with SL, Entry, Target nodes
              Stack(
                alignment: Alignment.center,
                clipBehavior: Clip.none,
                children: <Widget>[
                  // Horizontal tracks: Red (SL to Entry), Green (Entry to Target)
                  Row(
                    children: <Widget>[
                      // SL to Entry
                      Expanded(
                        child: Container(
                          height: 3,
                          decoration: const BoxDecoration(
                            color: AppColors.errorColor,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(1.5),
                              bottomLeft: Radius.circular(1.5),
                            ),
                          ),
                        ),
                      ),
                      // Entry to Target
                      Expanded(
                        child: Container(
                          height: 3,
                          decoration: BoxDecoration(
                            color: themeGreen,
                            borderRadius: const BorderRadius.only(
                              topRight: Radius.circular(1.5),
                              bottomRight: Radius.circular(1.5),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  // SL Node (leftmost)
                  Positioned(
                    left: 0,
                    child: Container(
                      width: 8,
                      height: 8,
                      decoration: BoxDecoration(
                        color: textColor.withValues(alpha: 0.8),
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                  // Entry Node (middle)
                  Positioned(
                    left: totalWidth / 2 - 4,
                    child: Container(
                      width: 8,
                      height: 8,
                      decoration: BoxDecoration(
                        color: textColor.withValues(alpha: 0.8),
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                  // Target Node (rightmost)
                  Positioned(
                    right: 0,
                    child: Container(
                      width: 8,
                      height: 8,
                      decoration: BoxDecoration(
                        color: textColor.withValues(alpha: 0.8),
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                  // Live Position Indicator Ring
                  Positioned(
                    left: dotPos - 6,
                    child: Container(
                      width: 12,
                      height: 12,
                      decoration: BoxDecoration(
                        color: AppColors.errorColor.withValues(alpha: 0.2),
                        shape: BoxShape.circle,
                      ),
                      alignment: Alignment.center,
                      child: Container(
                        width: 6,
                        height: 6,
                        decoration: const BoxDecoration(
                          color: AppColors.errorColor,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              // Labels
              Stack(
                clipBehavior: Clip.none,
                children: <Widget>[
                  SizedBox(
                    height: 36,
                    width: totalWidth,
                  ),
                  // SL label
                  Positioned(
                    left: 0,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        CustomTextLabelWidget(
                          label: 'SL',
                          style: TextStyle(
                            color: subtextColor,
                            fontSize: 9,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          '\$${signal.stopLoss}',
                          style: TextStyle(
                            color: textColor,
                            fontSize: 9,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Entry label (Centered)
                  Positioned(
                    left: totalWidth / 2 - 35,
                    width: 70,
                    child: Column(
                      children: <Widget>[
                        CustomTextLabelWidget(
                          label: 'Entry',
                          style: TextStyle(
                            color: subtextColor,
                            fontSize: 9,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          '\$${signal.entryPrice}',
                          style: TextStyle(
                            color: textColor,
                            fontSize: 9,
                            fontWeight: FontWeight.w500,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 1),
                        Text(
                          entryTimeStr,
                          style: TextStyle(
                            color: subtextColor,
                            fontSize: 7,
                            fontWeight: FontWeight.w400,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                  // Target/TP label
                  Positioned(
                    right: 0,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        CustomTextLabelWidget(
                          label: 'Target',
                          style: TextStyle(
                            color: subtextColor,
                            fontSize: 9,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          '\$${signal.takeProfit}',
                          style: TextStyle(
                            color: textColor,
                            fontSize: 9,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildPlainCard({
    required bool isDark,
    required List<Widget> children,
  }) {
    final Color cardBg = isDark ? AppColors.cardDark : AppColors.cardLight;
    final Color borderCol = isDark ? AppColors.borderDark : AppColors.borderLight.withValues(alpha: 0.5);

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
        children: children,
      ),
    );
  }

  Widget _buildStatsCardOne(TradingSignalModel signal, double livePrice, bool isDark, Color themeGreen) {
    final Color subtextColor = isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight;
    
    // Live Return calculation
    final double entryPrice = signal.entryPrice;
    final double current = livePrice;
    final bool isBuy = signal.isBuy;
    final double pipsDiff;
    if (signal.isClosed) {
      if (signal.resultInPips != null) {
        pipsDiff = signal.resultInPips!;
      } else if (signal.outcome?.toUpperCase() == 'LOSS') {
        pipsDiff = -(signal.slPips ?? 0.0);
      } else if (signal.outcome?.toUpperCase() == 'WIN') {
        pipsDiff = signal.tpPips ?? 0.0;
      } else {
        pipsDiff = (current - entryPrice) * (isBuy ? 10000 : -10000);
      }
    } else {
      pipsDiff = signal.resultInPips ?? (current - entryPrice) * (isBuy ? 10000 : -10000);
    }
    final String pipsStr = '${pipsDiff >= 0 ? '+' : ''}${pipsDiff.toStringAsFixed(2)} PIPS';
    final Color returnColor = pipsDiff >= 0 ? themeGreen : AppColors.errorColor;

    final bool hasResultInPips = signal.resultInPips != null;

    return _buildPlainCard(
      isDark: isDark,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            // Strategy
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                CustomTextLabelWidget(
                  label: 'Strategy',
                  style: TextStyle(
                    color: subtextColor,
                    fontSize: Dimens.fontSize10,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 4),
                CustomTextLabelWidget(
                  label: signal.type, // e.g. BUY MARKET
                  style: TextStyle(
                    color: themeGreen,
                    fontSize: Dimens.fontSize14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            // Estimated Risk
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                CustomTextLabelWidget(
                  label: 'Estimated Risk',
                  style: TextStyle(
                    color: subtextColor,
                    fontSize: Dimens.fontSize10,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 4),
                CustomTextLabelWidget(
                  label: signal.riskAmount != null
                      ? '-\$${signal.riskAmount!.toStringAsFixed(0)}'
                      : '—',
                  style: const TextStyle(
                    color: AppColors.errorColor,
                    fontSize: Dimens.fontSize14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ],
        ),
        if (hasResultInPips || signal.isClosed) ...<Widget>[
          const SizedBox(height: Dimens.space12),
          Divider(
            height: 1,
            thickness: 1,
            color: isDark ? AppColors.dividerDark : AppColors.dividerLight,
          ),
          const SizedBox(height: Dimens.space12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              // Live Return
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  CustomTextLabelWidget(
                    label: signal.isClosed ? 'Final Return' : 'Live Return',
                    style: TextStyle(
                      color: subtextColor,
                      fontSize: Dimens.fontSize10,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 4),
                  CustomTextLabelWidget(
                    label: pipsStr,
                    style: TextStyle(
                      color: returnColor,
                      fontSize: Dimens.fontSize14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              // Type column removed
              const SizedBox.shrink(),
            ],
          ),
        ],
      ],
    );
  }

  Widget _buildTradeLevelsCard(TradingSignalModel signal, bool isDark, Color themeGreen) {
    final Color textColor = isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight;
    final Color subtextColor = isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight;

    final String entry1 = signal.entryPrice.toString();
    final String entry2 = signal.entryPriceTwo != null ? signal.entryPriceTwo.toString() : '—';
    final String stopLoss = signal.slPips != null
        ? '${signal.stopLoss} (${signal.slPips!.toStringAsFixed(2)} Pips)'
        : signal.stopLoss.toString();

    return _buildPlainCard(
      isDark: isDark,
      children: <Widget>[
        CustomTextLabelWidget(
          label: 'Trade Levels',
          style: TextStyle(
            color: textColor,
            fontSize: Dimens.fontSize16,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: Dimens.space12),
        _buildLevelRow(
          label: 'Entry 1',
          value: entry1,
          textColor: textColor,
          subtextColor: subtextColor,
          isDark: isDark,
        ),
        _buildLevelRow(
          label: 'Entry 2',
          value: entry2,
          textColor: textColor,
          subtextColor: subtextColor,
          isDark: isDark,
        ),
        _buildLevelRow(
          label: 'Stop Loss',
          value: stopLoss,
          textColor: AppColors.errorColor,
          subtextColor: subtextColor,
          isDark: isDark,
          showDivider: false,
        ),
        const SizedBox(height: Dimens.space16),
        Row(
          children: <Widget>[
            if (signal.takeProfitOne != null)
              Expanded(
                child: _buildTpBox(
                  label: 'TP1',
                  value: signal.takeProfitOne.toString(),
                  subValue: signal.tpPips != null ? '${signal.tpPips!.toStringAsFixed(2)} Pips' : null,
                  themeGreen: themeGreen,
                  isDark: isDark,
                ),
              ),
            if (signal.takeProfitTwo != null) ...<Widget>[
              const SizedBox(width: Dimens.space8),
              Expanded(
                child: _buildTpBox(
                  label: 'TP2',
                  value: signal.takeProfitTwo.toString(),
                  themeGreen: themeGreen,
                  isDark: isDark,
                ),
              ),
            ],
            if (signal.takeProfitThree != null) ...<Widget>[
              const SizedBox(width: Dimens.space8),
              Expanded(
                child: _buildTpBox(
                  label: 'TP3',
                  value: signal.takeProfitThree.toString(),
                  themeGreen: themeGreen,
                  isDark: isDark,
                ),
              ),
            ],
            if (signal.takeProfitOne == null && signal.takeProfitTwo == null && signal.takeProfitThree == null)
              Expanded(
                child: _buildTpBox(
                  label: 'TP',
                  value: signal.takeProfit.toString(),
                  subValue: signal.tpPips != null ? '${signal.tpPips!.toStringAsFixed(2)} Pips' : null,
                  themeGreen: themeGreen,
                  isDark: isDark,
                ),
              ),
          ],
        ),
      ],
    );
  }

  Widget _buildLevelRow({
    required String label,
    required String value,
    required Color textColor,
    required Color subtextColor,
    required bool isDark,
    bool showDivider = true,
  }) {
    final Color dividerCol = isDark ? AppColors.dividerDark : AppColors.dividerLight;
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(vertical: Dimens.space10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              CustomTextLabelWidget(
                label: label,
                style: TextStyle(
                  color: subtextColor,
                  fontSize: Dimens.fontSize12,
                  fontWeight: FontWeight.w500,
                ),
              ),
              CustomTextLabelWidget(
                label: value,
                style: TextStyle(
                  color: textColor,
                  fontSize: Dimens.fontSize12,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
        if (showDivider)
          Divider(
            height: 1,
            thickness: 0.5,
            color: dividerCol,
          ),
      ],
    );
  }

  Widget _buildTpBox({
    required String label,
    required String value,
    String? subValue,
    required Color themeGreen,
    required bool isDark,
  }) {
    final Color boxBg = themeGreen.withValues(alpha: isDark ? 0.08 : 0.04);
    final Color borderCol = themeGreen.withValues(alpha: isDark ? 0.25 : 0.15);
    final Color textColor = isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight;
    final Color subtextColor = isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight;

    return Container(
      padding: const EdgeInsets.symmetric(vertical: Dimens.space12, horizontal: Dimens.space8),
      decoration: BoxDecoration(
        color: boxBg,
        borderRadius: BorderRadius.circular(Dimens.radius8),
        border: Border.all(color: borderCol),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          CustomTextLabelWidget(
            label: label,
            style: TextStyle(
              color: themeGreen,
              fontSize: Dimens.fontSize10,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 6),
          CustomTextLabelWidget(
            label: value,
            style: TextStyle(
              color: textColor,
              fontSize: Dimens.fontSize12,
              fontWeight: FontWeight.w600,
            ),
          ),
          if (subValue != null && subValue.isNotEmpty) ...<Widget>[
            const SizedBox(height: 4),
            CustomTextLabelWidget(
              label: subValue,
              style: TextStyle(
                color: subtextColor,
                fontSize: Dimens.fontSize9,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildStatsCardThree(TradingSignalModel signal, double livePrice, bool isDark, Color themeGreen) {
    final Color textColor = isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight;
    final Color subtextColor = isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight;

    // Status String and Color
    final String statusText;
    final Color statusColor;

    if (signal.isClosed) {
      statusText = signal.outcome == 'WIN' ? 'WIN' : 'LOSS';
      statusColor = signal.outcome == 'WIN' ? themeGreen : AppColors.errorColor;
    } else if (signal.isCancelled) {
      statusText = 'Cancelled';
      statusColor = AppColors.neutralColor;
    } else if (signal.isPending) {
      statusText = 'Pending';
      statusColor = AppColors.warningColor;
    } else {
      // Active: In Profit or In Loss
      final bool isBuy = signal.isBuy;
      final bool inProfit = isBuy ? (livePrice >= signal.entryPrice) : (livePrice <= signal.entryPrice);
      statusText = inProfit ? 'In Profit' : 'In Loss';
      statusColor = inProfit ? themeGreen : AppColors.errorColor;
    }

    final String entryZoneStr = signal.entryPriceTwo != null
        ? '\$${signal.entryPrice} - \$${signal.entryPriceTwo}'
        : '\$${signal.entryPrice}';

    return _buildPlainCard(
      isDark: isDark,
      children: <Widget>[
        _buildListRow(
          label: 'Entry Date & Time',
          value: _formatCreatedDate(signal.createdAt),
          textColor: textColor,
          subtextColor: subtextColor,
          isDark: isDark,
        ),
        _buildListRow(
          label: 'Status',
          value: statusText,
          valueColor: statusColor,
          textColor: textColor,
          subtextColor: subtextColor,
          isDark: isDark,
        ),
        _buildListRow(
          label: 'Entry Zone',
          value: entryZoneStr,
          textColor: textColor,
          subtextColor: subtextColor,
          isDark: isDark,
        ),
        _buildListRow(
          label: 'Lot Size',
          value: signal.lotSize?.toString() ?? '—',
          textColor: textColor,
          subtextColor: subtextColor,
          isDark: isDark,
        ),
        _buildListRow(
          label: 'Trade Direction',
          value: signal.isBuy ? 'Long' : 'Short',
          textColor: textColor,
          subtextColor: subtextColor,
          isDark: isDark,
        ),
        _buildListRow(
          label: 'Trade Segment',
          value: signal.category,
          textColor: textColor,
          subtextColor: subtextColor,
          isDark: isDark,
        ),
        _buildListRow(
          label: 'Signal Category',
          value: 'Swing',
          textColor: textColor,
          subtextColor: subtextColor,
          isDark: isDark,
          showDivider: false,
        ),
      ],
    );
  }

  Widget _buildListRow({
    required String label,
    required String value,
    Color? valueColor,
    required Color textColor,
    required Color subtextColor,
    required bool isDark,
    bool showDivider = true,
  }) {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(vertical: Dimens.space12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              CustomTextLabelWidget(
                label: label,
                style: TextStyle(
                  color: subtextColor,
                  fontSize: Dimens.fontSize12,
                  fontWeight: FontWeight.w500,
                ),
              ),
              CustomTextLabelWidget(
                label: value,
                style: TextStyle(
                  color: valueColor ?? textColor,
                  fontSize: Dimens.fontSize12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        if (showDivider)
          Divider(
            height: 1,
            thickness: 1,
            color: isDark ? AppColors.dividerDark : AppColors.dividerLight,
          ),
      ],
    );
  }
}
