import '../../../utils/exports.dart';

@RoutePage()
class AddTradePage extends BaseResponsiveView {
  const AddTradePage({super.key});

  @override
  Widget buildDesktopWidget(BuildContext context) => _build(context);

  @override
  Widget buildTabletWidget(BuildContext context) => _build(context);

  @override
  Widget buildMobileWidget(BuildContext context) => _build(context);

  Widget _build(BuildContext context) {
    return BlocProvider<AddTradeCubit>(
      create: (BuildContext context) => AddTradeCubit(
        repository: TradesRepositoryImpl(),
        initialState: AddTradeState.initial(
          formKey: GlobalKey<FormState>(),
          entryController: TextEditingController(),
          slController: TextEditingController(),
          tp1Controller: TextEditingController(),
          tp2Controller: TextEditingController(),
          tp3Controller: TextEditingController(),
          tradingViewUrlController: TextEditingController(),
          commentController: TextEditingController(),
          pairSearchController: TextEditingController(),
        ),
      ),
      child: const AddTradeForm(),
    );
  }
}

class AddTradeForm extends StatelessWidget {
  const AddTradeForm({super.key});

  void _openPairSelectionSheet(BuildContext context, AddTradeCubit cubit, AddTradeState state) {
    cubit.updatePairSearchQuery('');
    state.pairSearchController.clear();

    final bool isDark = context.isDark;
    final Color sheetBg = isDark ? AppColors.surfaceDark : AppColors.surfaceLight;
    final Color textColor = isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight;
    final Color subtextColor = isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight;

    unawaited(showModalBottomSheet<void>(
      context: context,
      backgroundColor: sheetBg,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (BuildContext ctx) {
        return BlocProvider<AddTradeCubit>.value(
          value: cubit,
          child: BlocBuilder<AddTradeCubit, AddTradeState>(
            builder: (BuildContext context, AddTradeState state) {
              final List<CurrencyPairResponse> filtered = state.currencyPairs.where((CurrencyPairResponse p) {
                final String cleanQuery = state.pairSearchQuery.trim().toLowerCase();
                if (cleanQuery.isEmpty) return true;
                return p.symbol.toLowerCase().contains(cleanQuery) ||
                       p.baseCurrency.toLowerCase().contains(cleanQuery) ||
                       p.quoteCurrency.toLowerCase().contains(cleanQuery);
              }).toList();

              final double keyboardHeight = MediaQuery.of(context).viewInsets.bottom;
              final double screenHeight = MediaQuery.of(context).size.height;
              final double maxHeight = keyboardHeight > 0 
                  ? (screenHeight - keyboardHeight) 
                  : (screenHeight * 0.75);

              return Padding(
                padding: EdgeInsets.only(bottom: keyboardHeight),
                child: Container(
                  height: maxHeight > 0 ? maxHeight : 100.0,
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Center(
                        child: Container(
                          width: 38,
                          height: 4,
                          margin: const EdgeInsets.only(bottom: 12),
                          decoration: BoxDecoration(
                            color: isDark ? const Color(0xFF2C3240) : Colors.black12,
                            borderRadius: BorderRadius.circular(2),
                          ),
                        ),
                      ),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            'Select Currency Pair',
                            style: TextStyle(
                              color: textColor,
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          IconButton(
                            icon: Icon(Icons.close_rounded, color: subtextColor, size: 20),
                            padding: EdgeInsets.zero,
                            constraints: const BoxConstraints(),
                            onPressed: () => Navigator.pop(ctx),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),

                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: <String>['CRYPTO', 'FOREX', 'COMMODITY', 'STOCK']
                              .map((String m) {
                            final bool isSelected = state.selectedMarket == m;
                            return Padding(
                              padding: const EdgeInsets.only(right: 8),
                              child: InkWell(
                                borderRadius: BorderRadius.circular(20),
                                onTap: () {
                                  cubit.updateMarket(m);
                                },
                                child: AnimatedContainer(
                                  duration: const Duration(milliseconds: 200),
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 16,
                                    vertical: 7,
                                  ),
                                  decoration: BoxDecoration(
                                    color: isSelected
                                        ? AppColors.primaryPurple
                                        : (isDark
                                            ? const Color(0xFF1E2430)
                                            : AppColors.whiteSmokeShade),
                                    borderRadius: BorderRadius.circular(20),
                                    border: Border.all(
                                      color: isSelected
                                          ? AppColors.primaryPurple
                                          : (isDark ? const Color(0xFF2C3240) : Colors.transparent),
                                    ),
                                  ),
                                  child: Text(
                                    m,
                                    style: TextStyle(
                                      color: isSelected ? Colors.white : textColor,
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ),

                      const SizedBox(height: 12),

                      DecoratedBox(
                        decoration: BoxDecoration(
                          color: isDark ? const Color(0xFF1E2430) : const Color(0xFFF2F4F7),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: state.pairSearchQuery.isNotEmpty
                                ? AppColors.primaryPurple
                                : (isDark ? const Color(0xFF2C3240) : Colors.transparent),
                            width: 1.2,
                          ),
                        ),
                        child: TextField(
                          controller: state.pairSearchController,
                          onChanged: cubit.updatePairSearchQuery,
                          style: TextStyle(color: textColor, fontSize: 13, fontWeight: FontWeight.w600),
                          decoration: InputDecoration(
                            hintText: 'Search BTCUSD, EURUSD, XAUUSD...',
                            hintStyle: TextStyle(
                              color: subtextColor.withValues(alpha: 0.65),
                              fontSize: 12,
                            ),
                            prefixIcon: Icon(
                              Icons.search_rounded,
                              size: 20,
                              color: state.pairSearchQuery.isNotEmpty ? AppColors.primaryPurple : subtextColor,
                            ),
                            suffixIcon: state.pairSearchQuery.isNotEmpty
                                ? GestureDetector(
                                    onTap: () {
                                      state.pairSearchController.clear();
                                      cubit.updatePairSearchQuery('');
                                    },
                                    child: Icon(Icons.cancel_rounded, size: 18, color: subtextColor),
                                  )
                                : null,
                            filled: false,
                            contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                            border: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            focusedBorder: InputBorder.none,
                          ),
                        ),
                      ),

                      const SizedBox(height: 10),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            state.pairSearchQuery.trim().isNotEmpty
                                ? 'Found ${filtered.length} results'
                                : '${filtered.length} pairs available',
                            style: TextStyle(
                              color: state.pairSearchQuery.trim().isNotEmpty ? AppColors.primaryPurple : subtextColor,
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            state.selectedMarket,
                            style: TextStyle(color: subtextColor.withValues(alpha: 0.6), fontSize: 10, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),

                      const SizedBox(height: 6),

                      Expanded(
                        child: state.isLoadingPairs
                            ? const Center(child: CircularProgressIndicator())
                            : filtered.isEmpty
                                ? Center(
                                    child: Padding(
                                      padding: const EdgeInsets.all(24.0),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: <Widget>[
                                          Icon(
                                            Icons.search_off_rounded,
                                            size: 44,
                                            color: subtextColor.withValues(alpha: 0.4),
                                          ),
                                          const SizedBox(height: 10),
                                          Text(
                                            'No pairs found for "${state.pairSearchQuery}"',
                                            style: TextStyle(
                                              color: textColor,
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          const SizedBox(height: 4),
                                          Text(
                                            'Try searching for another pair symbol or select a different market tab.',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              color: subtextColor,
                                              fontSize: 12,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  )
                                : ListView.builder(
                                    itemCount: filtered.length,
                                    padding: const EdgeInsets.only(top: 4, bottom: 12),
                                    itemBuilder: (BuildContext context, int index) {
                                      final CurrencyPairResponse pair = filtered[index];
                                      final bool isSelected = state.selectedPair?.id == pair.id;
                                      return Container(
                                        margin: const EdgeInsets.only(bottom: 6),
                                        decoration: BoxDecoration(
                                          color: isSelected
                                              ? AppColors.primaryPurple.withValues(alpha: 0.12)
                                              : (isDark ? AppColors.cardDark : AppColors.whiteSmokeShade),
                                          borderRadius: BorderRadius.circular(10),
                                          border: Border.all(
                                            color: isSelected
                                                ? AppColors.primaryPurple
                                                : (isDark ? const Color(0xFF2C3240) : Colors.transparent),
                                            width: isSelected ? 1.5 : 1.0,
                                          ),
                                        ),
                                        child: ListTile(
                                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                                          title: Text(
                                            pair.symbol,
                                            style: TextStyle(
                                              color: isSelected ? AppColors.primaryPurple : textColor,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 14,
                                            ),
                                          ),
                                          trailing: isSelected
                                              ? const Icon(
                                                  Icons.check_circle_rounded,
                                                  color: AppColors.primaryPurple,
                                                  size: 20,
                                                )
                                              : Icon(
                                                  Icons.chevron_right_rounded,
                                                  color: subtextColor.withValues(alpha: 0.5),
                                                  size: 20,
                                                ),
                                          onTap: () {
                                            cubit.updateSelectedPair(pair);
                                            Navigator.pop(ctx);
                                          },
                                        ),
                                      );
                                    },
                                  ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        );
      },
    ));
  }

  void _showOrderTypeInfo(BuildContext context, AddTradeCubit cubit, AddTradeState state) {
    final bool isDark = context.isDark;
    final Color textColor = isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight;
    final Color subtextColor = isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight;
    final Color cardBg = isDark ? AppColors.surfaceDark : Colors.white;

    final String title = cubit.tradeTypeLabels[state.selectedTradeType] ?? 'Trade Type';
    String description = '';

    switch (state.selectedTradeType) {
      case 'BUY_MARKET':
        description = 'Buy Market order is immediately matched to the best available market price.';
      case 'SELL_MARKET':
        description = 'Sell Market order is immediately matched to the best available market price.';
      case 'BUY_LIMIT':
        description = 'A Buy Limit order is an order to buy at a specific price or better (below current market price).';
      case 'SELL_LIMIT':
        description = 'A Sell Limit order is an order to sell at a specific price or better (above current market price).';
      case 'BUY_STOP':
        description = 'Buy Stop order executes when price moves above the trigger level.';
      case 'SELL_STOP':
        description = 'Sell Stop order executes when price moves below the trigger level.';
    }

    unawaited(showDialog<void>(
      context: context,
      builder: (BuildContext ctx) => AlertDialog(
        backgroundColor: cardBg,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Row(
          children: <Widget>[
            const Icon(Icons.info_outline_rounded, color: AppColors.primaryPurple, size: 22),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                title,
                style: TextStyle(color: textColor, fontWeight: FontWeight.bold, fontSize: 16),
              ),
            ),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              description,
              style: TextStyle(color: subtextColor, fontSize: 13, height: 1.4),
            ),
            const SizedBox(height: 14),
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: isDark ? AppColors.cardDark : AppColors.whiteSmokeShade,
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text('• BUY / SELL MARKET: Instant execution.', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600)),
                  SizedBox(height: 4),
                  Text('• BUY LIMIT: Placed below live price.', style: TextStyle(fontSize: 11)),
                  SizedBox(height: 4),
                  Text('• SELL LIMIT: Placed above live price.', style: TextStyle(fontSize: 11)),
                  SizedBox(height: 4),
                  Text('• BUY STOP: Placed above live price.', style: TextStyle(fontSize: 11)),
                  SizedBox(height: 4),
                  Text('• SELL STOP: Placed below live price.', style: TextStyle(fontSize: 11)),
                ],
              ),
            ),
          ],
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Got it', style: TextStyle(fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    ));
  }

  String _getPriceSource(String market) {
    switch (market.toUpperCase()) {
      case 'CRYPTO':
        return 'Source: Binance';
      case 'FOREX':
      case 'COMMODITY':
      case 'STOCK':
        return 'Source: Twelve Data';
      default:
        return 'Source: Live Market Feed';
    }
  }

  String _getRrLabel(double rr) {
    if (rr < 1.0) return 'BAD';
    if (rr < 1.5) return 'RISKY';
    if (rr < 2.0) return 'AVERAGE';
    if (rr < 3.0) return 'GOOD';
    return 'EXCELLENT';
  }

  Color _getRrColor(double rr) {
    if (rr < 1.0) return AppColors.errorColor;
    if (rr < 1.5) return Colors.orange;
    if (rr < 2.0) return Colors.amber;
    if (rr < 3.0) return Colors.lightGreen;
    return AppColors.successColor;
  }

  Widget _buildFieldLabel(String text, Color color) {
    return Text(
      text,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
        color: color,
        fontSize: 12,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _buildModeToggle({
    required bool isPips,
    required ValueChanged<bool> onToggle,
    required Color borderColor,
    required Color textColor,
  }) {
    return Container(
      height: 24,
      decoration: BoxDecoration(
        color: borderColor.withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          GestureDetector(
            onTap: () => onToggle(false),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
              decoration: BoxDecoration(
                color: !isPips ? AppColors.primaryPurple : Colors.transparent,
                borderRadius: BorderRadius.circular(6),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(
                    'Price',
                    style: TextStyle(
                      color: !isPips ? Colors.white : textColor,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  if (!isPips) ...<Widget>[
                    const SizedBox(width: 2),
                    const Icon(Icons.swap_horiz_rounded, size: 11, color: Colors.white),
                  ],
                ],
              ),
            ),
          ),
          GestureDetector(
            onTap: () => onToggle(true),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
              decoration: BoxDecoration(
                color: isPips ? AppColors.primaryPurple : Colors.transparent,
                borderRadius: BorderRadius.circular(6),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(
                    'Pips',
                    style: TextStyle(
                      color: isPips ? Colors.white : textColor,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  if (isPips) ...<Widget>[
                    const SizedBox(width: 2),
                    const Icon(Icons.swap_horiz_rounded, size: 11, color: Colors.white),
                  ],
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  InputDecoration _inputDecoration(Color fill, Color border, Color subtextColor, {required String hintText}) {
    return InputDecoration(
      hintText: hintText,
      hintStyle: TextStyle(color: subtextColor.withValues(alpha: 0.65), fontSize: 13),
      filled: true,
      fillColor: fill,
      contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(color: border),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(color: border),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: AppColors.primaryPurple),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final bool isDark = context.isDark;
    final Color pageBg = isDark ? const Color(0xFF0F1218) : AppColors.backgroundLight;
    final Color cardBg = isDark ? const Color(0xFF181C24) : AppColors.surfaceLight;
    final Color fieldBg = isDark ? const Color(0xFF202530) : AppColors.whiteSmokeShade;
    final Color borderColor = isDark ? const Color(0xFF2C3240) : AppColors.borderLight;
    final Color textColor = isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight;
    final Color subtextColor = isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight;

    return BlocConsumer<AddTradeCubit, AddTradeState>(
      listener: (BuildContext context, AddTradeState state) {
        if (state.msg != null && state.msg!.isNotEmpty) {
          if (state.status == BaseStateStatus.success) {
            context.scaffoldMessenger.showSnackBar(
              SnackBar(
                content: Text(state.msg!),
                backgroundColor: AppColors.successColor,
              ),
            );
            unawaited(context.router.maybePop());
          } else if (state.status == BaseStateStatus.failure) {
            context.scaffoldMessenger.showSnackBar(
              SnackBar(
                content: Text(state.msg!),
                backgroundColor: AppColors.errorColor,
              ),
            );
          }
          context.read<AddTradeCubit>().resetError();
        }
      },
      builder: (BuildContext context, AddTradeState state) {
        final AddTradeCubit cubit = context.read<AddTradeCubit>();

        final Map<String, dynamic>? rrCalculation = cubit.calculateTradeRR();
        final double entryPrice = cubit.getCalculatedEntry();
        final double? slPrice = cubit.getEffectiveSL(entryPrice);
        final double? tp1Price = cubit.getEffectiveTP1(entryPrice);

        final double slPips = slPrice != null ? cubit.priceToPips(slPrice, entryPrice) : 0.0;
        final double tp1Pips = tp1Price != null ? cubit.priceToPips(tp1Price, entryPrice) : 0.0;

        final String livePriceStr = cubit.getLivePrice() > 0
            ? cubit.getLivePrice().toStringAsFixed(cubit.getPricePrecision())
            : '--';

        final bool isRrValid = rrCalculation != null && rrCalculation['valid'] == true;
        final double rrVal = isRrValid ? (rrCalculation['rr'] as double) : 0.0;
        final String rrLabel = isRrValid ? _getRrLabel(rrVal) : 'AUTO CALCULATED';
        final Color rrColor = isRrValid ? _getRrColor(rrVal) : AppColors.successColor;
        final String validationMsg = (rrCalculation != null && rrCalculation['valid'] == false)
            ? (rrCalculation['reason'] as String? ?? '')
            : '';

        return Scaffold(
          backgroundColor: pageBg,
          appBar: AppBar(
            backgroundColor: pageBg,
            elevation: 0,
            leading: IconButton(
              icon: Icon(Icons.arrow_back_ios_new_rounded, color: textColor, size: 18),
              onPressed: () => context.router.maybePop(),
            ),
            title: Text(
              'Add New Trade',
              style: TextStyle(
                color: textColor,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          body: SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Form(
                key: state.formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Create a premium signal with smart entries, SL, TP and auto RR insights.',
                      style: TextStyle(
                        color: subtextColor,
                        fontSize: 13,
                      ),
                    ),
                    const SizedBox(height: 20),

                    // 1. Market Type Dropdown
                    _buildFieldLabel('Market Type *', textColor),
                    const SizedBox(height: 6),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 14),
                      decoration: BoxDecoration(
                        color: fieldBg,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: borderColor),
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          value: state.selectedMarket,
                          isExpanded: true,
                          dropdownColor: cardBg,
                          style: TextStyle(color: textColor, fontSize: 14, fontWeight: FontWeight.bold),
                          icon: Icon(Icons.keyboard_arrow_down_rounded, color: subtextColor),
                          items: <String>['CRYPTO', 'FOREX', 'COMMODITY', 'STOCK'].map((String m) {
                            return DropdownMenuItem<String>(
                              value: m,
                              child: Text(m),
                            );
                          }).toList(),
                          onChanged: (String? val) {
                            if (val != null) {
                              cubit.updateMarket(val);
                            }
                          },
                        ),
                      ),
                    ),
                    const SizedBox(height: 18),

                    // 2. Currency Pair Selector
                    _buildFieldLabel('Currency Pair', textColor),
                    const SizedBox(height: 6),
                    InkWell(
                      onTap: () => _openPairSelectionSheet(context, cubit, state),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
                        decoration: BoxDecoration(
                          color: fieldBg,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: borderColor),
                        ),
                        child: Row(
                          children: <Widget>[
                            Text(
                              state.selectedPair?.symbol ?? 'Select Currency Pair',
                              style: TextStyle(
                                color: textColor,
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const Spacer(),
                            if (state.isLoadingPairs)
                              const SizedBox(
                                width: 16,
                                height: 16,
                                child: CircularProgressIndicator(strokeWidth: 2),
                              )
                            else
                              Icon(Icons.keyboard_arrow_down_rounded, color: subtextColor),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 18),

                    // 3. Live Market Price Card
                    if (state.selectedPair != null) ...<Widget>[
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: isDark ? const Color(0xFF092019) : const Color(0xFFE8F8F1),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: AppColors.successColor.withValues(alpha: 0.4)),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    Container(
                                      width: 8,
                                      height: 8,
                                      decoration: const BoxDecoration(
                                        color: AppColors.successColor,
                                        shape: BoxShape.circle,
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    const Text(
                                      'LIVE MARKET PRICE',
                                      style: TextStyle(
                                        color: AppColors.successColor,
                                        fontSize: 11,
                                        fontWeight: FontWeight.bold,
                                        letterSpacing: 0.5,
                                      ),
                                    ),
                                  ],
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                  decoration: BoxDecoration(
                                    color: isDark ? Colors.black38 : Colors.black12,
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  child: Text(
                                    _getPriceSource(state.selectedMarket),
                                    style: const TextStyle(
                                      color: AppColors.errorColor,
                                      fontSize: 10,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 12),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(
                                  state.selectedPair?.symbol ?? 'SYMB',
                                  style: TextStyle(
                                    color: textColor,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  livePriceStr,
                                  style: const TextStyle(
                                    color: AppColors.successColor,
                                    fontSize: 22,
                                    fontWeight: FontWeight.w900,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 18),
                    ],

                    // 4. Trade Type & Entry 1
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  _buildFieldLabel('Trade Type *', textColor),
                                  const SizedBox(width: 4),
                                  InkWell(
                                    onTap: () => _showOrderTypeInfo(context, cubit, state),
                                    child: const Icon(Icons.info_outline_rounded, size: 16, color: AppColors.primaryPurple),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 6),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 10),
                                decoration: BoxDecoration(
                                  color: fieldBg,
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(color: borderColor),
                                ),
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButton<String>(
                                    value: state.selectedTradeType,
                                    isExpanded: true,
                                    dropdownColor: cardBg,
                                    style: TextStyle(color: textColor, fontSize: 13, fontWeight: FontWeight.bold),
                                    icon: Icon(Icons.keyboard_arrow_down_rounded, color: subtextColor, size: 20),
                                    items: cubit.tradeTypeLabels.entries.map((MapEntry<String, String> entry) {
                                      return DropdownMenuItem<String>(
                                        value: entry.key,
                                        child: Text(entry.value),
                                      );
                                    }).toList(),
                                    onChanged: (String? val) {
                                      if (val != null) {
                                        cubit.updateTradeType(val);
                                      }
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 12),

                        // Entry 1 Input
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              _buildFieldLabel('Entry 1 *', textColor),
                              const SizedBox(height: 6),
                              TextFormField(
                                controller: state.entryController,
                                readOnly: state.isMarketOrder,
                                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                                style: TextStyle(
                                  color: state.isMarketOrder ? subtextColor : textColor,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                                decoration: _inputDecoration(
                                  state.isMarketOrder ? borderColor.withValues(alpha: 0.2) : fieldBg,
                                  borderColor,
                                  subtextColor,
                                  hintText: livePriceStr,
                                ),
                                validator: (String? val) {
                                  if (state.isMarketOrder) return null;
                                  if (val == null || val.trim().isEmpty) return 'Required';
                                  if (double.tryParse(val.trim()) == null) return 'Invalid price';
                                  return null;
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 18),

                    // 5. Stop Loss & Take Profit 1
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Expanded(child: _buildFieldLabel('Stop Loss *', textColor)),
                                  const SizedBox(width: 4),
                                  _buildModeToggle(
                                    isPips: state.isSlInPips,
                                    onToggle: (bool val) => cubit.toggleSlInPips(),
                                    borderColor: borderColor,
                                    textColor: textColor,
                                  ),
                                ],
                              ),
                              const SizedBox(height: 6),
                              TextFormField(
                                controller: state.slController,
                                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                                style: TextStyle(color: textColor, fontSize: 14, fontWeight: FontWeight.bold),
                                decoration: _inputDecoration(fieldBg, borderColor, subtextColor, hintText: state.isSlInPips ? 'Pips (e.g. 50)' : 'Price'),
                                validator: (String? val) {
                                  if (val == null || val.trim().isEmpty) return 'Required';
                                  if (double.tryParse(val.trim()) == null) return 'Invalid';
                                  return null;
                                },
                              ),
                              const SizedBox(height: 4),
                              Text(
                                state.isSlInPips
                                    ? '≈ ${state.slController.text.isNotEmpty ? state.slController.text : '--'} Pips'
                                    : '≈ ${slPips > 0 ? slPips.toStringAsFixed(1) : '--'} Pips',
                                style: TextStyle(color: subtextColor, fontSize: 11),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 12),

                        // Take Profit 1
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Expanded(child: _buildFieldLabel('Take Profit 1 *', textColor)),
                                  const SizedBox(width: 4),
                                  _buildModeToggle(
                                    isPips: state.isTp1InPips,
                                    onToggle: (bool val) => cubit.toggleTp1InPips(),
                                    borderColor: borderColor,
                                    textColor: textColor,
                                  ),
                                ],
                              ),
                              const SizedBox(height: 6),
                              TextFormField(
                                controller: state.tp1Controller,
                                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                                style: TextStyle(color: textColor, fontSize: 14, fontWeight: FontWeight.bold),
                                decoration: _inputDecoration(fieldBg, borderColor, subtextColor, hintText: state.isTp1InPips ? 'Pips (e.g. 100)' : 'Price'),
                                validator: (String? val) {
                                  if (val == null || val.trim().isEmpty) return 'Required';
                                  if (double.tryParse(val.trim()) == null) return 'Invalid';
                                  return null;
                                },
                              ),
                              const SizedBox(height: 4),
                              Text(
                                state.isTp1InPips
                                    ? '≈ ${state.tp1Controller.text.isNotEmpty ? state.tp1Controller.text : '--'} Pips'
                                    : '≈ ${tp1Pips > 0 ? tp1Pips.toStringAsFixed(1) : '--'} Pips',
                                style: TextStyle(color: subtextColor, fontSize: 11),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),

                    // 6. Take Profit 2 & Take Profit 3 (Optional)
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              _buildFieldLabel('Take Profit 2', textColor),
                              const SizedBox(height: 6),
                              TextFormField(
                                controller: state.tp2Controller,
                                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                                style: TextStyle(color: textColor, fontSize: 14),
                                decoration: _inputDecoration(fieldBg, borderColor, subtextColor, hintText: 'Optional'),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              _buildFieldLabel('Take Profit 3', textColor),
                              const SizedBox(height: 6),
                              TextFormField(
                                controller: state.tp3Controller,
                                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                                style: TextStyle(color: textColor, fontSize: 14),
                                decoration: _inputDecoration(fieldBg, borderColor, subtextColor, hintText: 'Optional'),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 18),

                    // Validation Warning Box
                    if (validationMsg.isNotEmpty) ...<Widget>[
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                        decoration: BoxDecoration(
                          color: AppColors.errorColor.withValues(alpha: 0.12),
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: AppColors.errorColor.withValues(alpha: 0.4)),
                        ),
                        child: Row(
                          children: <Widget>[
                            const Icon(Icons.warning_amber_rounded, color: AppColors.errorColor, size: 18),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                validationMsg,
                                style: const TextStyle(
                                  color: AppColors.errorColor,
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 18),
                    ],

                    // 7. Risk Reward Ratio TP1 Card
                    _buildFieldLabel('Risk Reward Ratio TP1', textColor),
                    const SizedBox(height: 6),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                      decoration: BoxDecoration(
                        color: isDark ? const Color(0xFF0F1E24) : const Color(0xFFF0FDF8),
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: rrColor.withValues(alpha: 0.4)),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: rrColor.withValues(alpha: 0.15),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Text(
                              rrLabel,
                              style: TextStyle(
                                color: rrColor,
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 0.5,
                              ),
                            ),
                          ),
                          Text(
                            isRrValid ? '1 : ${rrVal.toStringAsFixed(2)}' : '--',
                            style: TextStyle(
                              color: rrColor,
                              fontSize: 18,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 18),

                    // 8. TradingView Chart URL
                    _buildFieldLabel('TradingView Chart URL *', textColor),
                    const SizedBox(height: 6),
                    TextFormField(
                      controller: state.tradingViewUrlController,
                      keyboardType: TextInputType.url,
                      style: TextStyle(color: textColor, fontSize: 13),
                      decoration: _inputDecoration(
                        fieldBg,
                        borderColor,
                        subtextColor,
                        hintText: 'https://www.tradingview.com/...',
                      ),
                      validator: (String? val) {
                        if (val == null || val.trim().isEmpty) return 'Please provide a TradingView chart URL';
                        if (!val.startsWith('http')) return 'Enter a valid URL starting with http:// or https://';
                        return null;
                      },
                    ),
                    const SizedBox(height: 18),

                    // 9. Trade Notes
                    _buildFieldLabel('Trade Notes', textColor),
                    const SizedBox(height: 6),
                    TextFormField(
                      controller: state.commentController,
                      maxLines: 3,
                      style: TextStyle(color: textColor, fontSize: 13),
                      decoration: _inputDecoration(
                        fieldBg,
                        borderColor,
                        subtextColor,
                        hintText: 'Enter setup analysis, key levels, or strategy notes...',
                      ),
                    ),
                    const SizedBox(height: 28),

                    // 10. Publish Trade Submit Button
                    SizedBox(
                      width: double.infinity,
                      height: 52,
                      child: ElevatedButton(
                        onPressed: state.isSubmitting ? null : cubit.submitTrade,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primaryPurple,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          elevation: 2,
                        ),
                        child: state.isSubmitting
                            ? const SizedBox(
                                width: 22,
                                height: 22,
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                  strokeWidth: 2.5,
                                ),
                              )
                            : const Text(
                                'Publish Trade',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                      ),
                    ),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
