import '../../../utils/exports.dart';

@RoutePage()
class AddTradePage extends StatefulWidget {
  const AddTradePage({super.key});

  @override
  State<AddTradePage> createState() => _AddTradePageState();
}

class _AddTradePageState extends State<AddTradePage> {
  final TradesRepositoryImpl _repository = TradesRepositoryImpl();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // Market & Currency Pair State
  String _selectedMarket = 'FOREX';
  List<CurrencyPairResponse> _currencyPairs = <CurrencyPairResponse>[];
  CurrencyPairResponse? _selectedPair;
  bool _isLoadingPairs = false;

  // Order Direction: 'BUY' or 'SELL'
  String _orderDirection = 'BUY';
  // Order Execution Type: 0: Market, 1: Limit, 2: Stop, 3: Stop-limit
  int _orderTypeIndex = 0;
  final List<String> _orderTypes = const <String>[
    'Market',
    'Limit',
    'Stop',
    'Stop-limit'
  ];

  String get _executionType {
    switch (_orderTypeIndex) {
      case 1:
        return 'LIMIT';
      case 2:
        return 'STOP';
      case 3:
        return 'STOP_LIMIT';
      default:
        return 'MARKET';
    }
  }

  String get _selectedOrderType => '${_orderDirection}_$_executionType';

  // Lots & Quantity
  double _lots = 1.5;
  bool _marketRange = false;
  final TextEditingController _marketRangePipsController =
      TextEditingController(text: '10');

  // SL & TP Toggles
  bool _stopLossOn = true;
  bool _takeProfitOn = true;
  bool _trailingStop = false;
  bool _breakEven = false;

  // SL & TP Inputs
  final TextEditingController _slPipsController =
      TextEditingController(text: '99');
  final TextEditingController _tp1PipsController =
      TextEditingController(text: '150');
  final TextEditingController _tp2PipsController = TextEditingController();
  final TextEditingController _tp3PipsController = TextEditingController();

  bool _showTp2 = false;
  bool _showTp3 = false;

  // Comment & TradingView URL
  final TextEditingController _tradingViewUrlController = TextEditingController();
  final TextEditingController _commentController = TextEditingController();

  bool _isSubmitting = false;

  @override
  void initState() {
    super.initState();
    unawaited(_loadPairs());
    _slPipsController.addListener(_onCalculationsChanged);
    _tp1PipsController.addListener(_onCalculationsChanged);
    _commentController.addListener(_onCalculationsChanged);
  }

  @override
  void dispose() {
    _marketRangePipsController.dispose();
    _slPipsController.dispose();
    _tp1PipsController.dispose();
    _tp2PipsController.dispose();
    _tp3PipsController.dispose();
    _tradingViewUrlController.dispose();
    _commentController.dispose();
    super.dispose();
  }

  void _onCalculationsChanged() {
    setState(() {});
  }

  Future<void> _loadPairs() async {
    setState(() {
      _isLoadingPairs = true;
      _currencyPairs = <CurrencyPairResponse>[];
      _selectedPair = null;
    });

    try {
      // 1. Attempt with uppercase market name
      ResponseHandler<BaseResponse<List<CurrencyPairResponse>>> response =
          await _repository.getCurrencyPairs(market: _selectedMarket);
      List<CurrencyPairResponse>? pairs =
          response.getSuccessInstance()?.response.data;

      // 2. Fallback with lowercase market name
      if (pairs == null || pairs.isEmpty) {
        response = await _repository.getCurrencyPairs(
          market: _selectedMarket.toLowerCase(),
        );
        pairs = response.getSuccessInstance()?.response.data;
      }

      // 3. Fallback without market filter (get all pairs)
      if (pairs == null || pairs.isEmpty) {
        response = await _repository.getCurrencyPairs(market: '');
        pairs = response.getSuccessInstance()?.response.data;
      }

      if (pairs != null && pairs.isNotEmpty) {
        setState(() {
          _currencyPairs = pairs!;
          _selectedPair = _currencyPairs.first;
        });
      }
    } on Object catch (e) {
      debugPrint('Failed to load currency pairs: $e');
    } finally {
      if (mounted) {
        setState(() {
          _isLoadingPairs = false;
        });
      }
    }
  }

  double _getPipSize() {
    if (_selectedPair != null &&
        _selectedPair!.pipValue != null &&
        _selectedPair!.pipValue! > 0) {
      return _selectedPair!.pipValue!;
    }
    return 0.0001;
  }

  int _getPricePrecision() {
    final double pipSize = _getPipSize();
    final List<String> parts = pipSize.toString().split('.');
    if (parts.length > 1) {
      return parts[1].length;
    }
    return 4;
  }

  double _priceToPips(double price, double reference) {
    final double pipSize = _getPipSize();
    if (pipSize == 0) return 0.0;
    return double.parse(
      ((price - reference).abs() / pipSize).toStringAsFixed(2),
    );
  }

  double _pipsToPrice(double pips, double reference, bool isAbove) {
    final double pipSize = _getPipSize();
    final double diff = pips * pipSize;
    final double value = isAbove ? (reference + diff) : (reference - diff);
    return double.parse(value.toStringAsFixed(_getPricePrecision()));
  }

  double _getLivePrice() {
    if (_selectedPair != null && _selectedPair!.currentPrice > 0) {
      return _selectedPair!.currentPrice;
    }
    return 1.13974;
  }

  double _getCalculatedEntry() {
    return _getLivePrice();
  }

  double? _getCalculatedSL(double entry) {
    if (!_stopLossOn) return null;
    final double? pips = double.tryParse(_slPipsController.text);
    if (pips == null) return null;
    final bool isBuy = _orderDirection == 'BUY';
    return _pipsToPrice(pips, entry, !isBuy);
  }

  double? _getCalculatedTP(String pipsText, double entry) {
    if (!_takeProfitOn) return null;
    final double? pips = double.tryParse(pipsText);
    if (pips == null || pips == 0) return null;
    final bool isBuy = _orderDirection == 'BUY';
    return _pipsToPrice(pips, entry, isBuy);
  }

  Map<String, dynamic>? _calculateTradeRR() {
    final double entry = _getCalculatedEntry();
    final double? sl = _getCalculatedSL(entry);
    final double? tp = _getCalculatedTP(_tp1PipsController.text, entry);

    if (sl == null || tp == null) return null;

    final bool isBuy = _orderDirection == 'BUY';

    if (isBuy) {
      if (sl >= entry) {
        return <String, dynamic>{
          'valid': false,
          'reason': 'Stop Loss must be below Entry',
          'rr': 0.0,
        };
      }
      if (tp <= entry) {
        return <String, dynamic>{
          'valid': false,
          'reason': 'Take Profit must be above Entry',
          'rr': 0.0,
        };
      }
    } else {
      if (sl <= entry) {
        return <String, dynamic>{
          'valid': false,
          'reason': 'Stop Loss must be above Entry',
          'rr': 0.0,
        };
      }
      if (tp >= entry) {
        return <String, dynamic>{
          'valid': false,
          'reason': 'Take Profit must be below Entry',
          'rr': 0.0,
        };
      }
    }

    final double risk = (entry - sl).abs();
    final double reward = (tp - entry).abs();

    if (risk == 0) {
      return <String, dynamic>{
        'valid': false,
        'reason': 'Risk cannot be zero',
        'rr': 0.0,
      };
    }

    final double rr = double.parse((reward / risk).toStringAsFixed(2));
    return <String, dynamic>{'valid': true, 'reason': '', 'rr': rr};
  }

  Future<void> _submitTrade() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final Map<String, dynamic>? calculation = _calculateTradeRR();
    if (calculation == null || calculation['valid'] == false) {
      context.scaffoldMessenger.showSnackBar(
        SnackBar(
          content: Text(
            (calculation?['reason'] as String?) ??
                'Invalid Risk-Reward calculations',
          ),
          backgroundColor: AppColors.errorColor,
        ),
      );
      return;
    }

    setState(() {
      _isSubmitting = true;
    });

    try {
      final double entry = _getCalculatedEntry();
      final double sl = _getCalculatedSL(entry)!;
      final double tp1 = _getCalculatedTP(_tp1PipsController.text, entry)!;

      final double slPips = double.tryParse(_slPipsController.text) ?? 30.0;
      final double tp1Pips = double.tryParse(_tp1PipsController.text) ?? 60.0;

      final List<Map<String, dynamic>> levels = <Map<String, dynamic>>[
        <String, dynamic>{
          'levelType': 'ENTRY',
          'entryPoint': entry,
          'stopLoss': sl,
          'takeProfit': tp1,
          'level': 0,
          'entryPips': 0,
          'slPips': slPips,
          'tpPips': tp1Pips,
        }
      ];

      if (_showTp2) {
        final double? tp2 = _getCalculatedTP(_tp2PipsController.text, entry);
        if (tp2 != null) {
          levels.add(<String, dynamic>{
            'levelType': 'TAKE_PROFIT',
            'takeProfit': tp2,
            'level': 2,
            'tpPips': double.tryParse(_tp2PipsController.text) ?? 0,
          });
        }
      }

      if (_showTp3) {
        final double? tp3 = _getCalculatedTP(_tp3PipsController.text, entry);
        if (tp3 != null) {
          levels.add(<String, dynamic>{
            'levelType': 'TAKE_PROFIT',
            'takeProfit': tp3,
            'level': 3,
            'tpPips': double.tryParse(_tp3PipsController.text) ?? 0,
          });
        }
      }

      final Map<String, dynamic> payload = <String, dynamic>{
        'market': _selectedMarket,
        'marketType': _selectedOrderType,
        'currencyPairSymbol': _selectedPair?.symbol ?? 'EURUSD',
        'currencyPairId': _selectedPair?.id ?? 0,
        'riskRewardRatio': calculation['rr'].toString(),
        'tradingViewUrl': _tradingViewUrlController.text.isNotEmpty
            ? _tradingViewUrlController.text
            : 'https://tradingview.com',
        'note': _commentController.text,
        'slPips': slPips,
        'tpPips': tp1Pips,
        'levels': levels,
      };

      final ResponseHandler<BaseResponse<dynamic>> response =
          await _repository.createTrade(payload);
      if (response.isSuccess()) {
        if (mounted) {
          context.scaffoldMessenger.showSnackBar(
            const SnackBar(
              content: Text('Order placed successfully!'),
              backgroundColor: AppColors.successColor,
            ),
          );
          unawaited(context.router.maybePop());
        }
      } else {
        if (mounted) {
          final String errMsg =
              response.getFailureInstance()?.error?.errorMessage ??
                  'Failed to place order';
          context.scaffoldMessenger.showSnackBar(
            SnackBar(
              content: Text(errMsg),
              backgroundColor: AppColors.errorColor,
            ),
          );
        }
      }
    } on Object catch (e) {
      if (mounted) {
        context.scaffoldMessenger.showSnackBar(
          SnackBar(
            content: Text('An unexpected error occurred: $e'),
            backgroundColor: AppColors.errorColor,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isSubmitting = false;
        });
      }
    }
  }

  Future<void> _openPairSelectionSheet() async {
    final bool isDark = context.isDark;
    final Color sheetBg =
        isDark ? AppColors.surfaceDark : AppColors.surfaceLight;
    final Color textColor =
        isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight;

    await showModalBottomSheet<void>(
      context: context,
      backgroundColor: sheetBg,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (BuildContext ctx) {
        String query = '';
        String selectedTabMarket = _selectedMarket;

        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setModalState) {
            final List<CurrencyPairResponse> filtered = _currencyPairs.where((CurrencyPairResponse p) {
              return p.symbol.toLowerCase().contains(query.toLowerCase());
            }).toList();

            return Container(
              height: MediaQuery.of(context).size.height * 0.70,
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        'Select Currency Pair',
                        style: TextStyle(
                          color: textColor,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.close_rounded, color: textColor, size: 20),
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                        onPressed: () => Navigator.pop(ctx),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),

                  // Market Tabs in Sheet
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: <String>['FOREX', 'CRYPTO', 'COMMODITY', 'STOCK']
                          .map((String m) {
                        final bool isSelected = selectedTabMarket == m;
                        return Padding(
                          padding: const EdgeInsets.only(right: 6),
                          child: InkWell(
                            onTap: () {
                              setModalState(() {
                                selectedTabMarket = m;
                                _selectedMarket = m;
                              });
                              setState(() {});
                              unawaited(_loadPairs());
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 6,
                              ),
                              decoration: BoxDecoration(
                                color: isSelected
                                    ? AppColors.primaryPurple
                                    : (isDark
                                        ? AppColors.cardDark
                                        : AppColors.whiteSmokeShade),
                                borderRadius: BorderRadius.circular(16),
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

                  const SizedBox(height: 10),
                  TextField(
                    onChanged: (String val) => setModalState(() => query = val),
                    style: TextStyle(color: textColor, fontSize: 13),
                    decoration: InputDecoration(
                      hintText: 'Search EURUSD, BTCUSD...',
                      hintStyle: const TextStyle(fontSize: 12),
                      prefixIcon: const Icon(Icons.search_rounded, size: 18),
                      filled: true,
                      fillColor: isDark
                          ? AppColors.cardDark
                          : AppColors.whiteSmokeShade,
                      contentPadding: const EdgeInsets.symmetric(vertical: 8),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),

                  Expanded(
                    child: _isLoadingPairs
                        ? const Center(child: CircularProgressIndicator())
                        : filtered.isEmpty
                            ? Center(
                                child: Text(
                                  'No pairs found for $selectedTabMarket',
                                  style: TextStyle(
                                    color: isDark
                                        ? AppColors.textSecondaryDark
                                        : AppColors.textSecondaryLight,
                                    fontSize: 12,
                                  ),
                                ),
                              )
                            : ListView.separated(
                                itemCount: filtered.length,
                                separatorBuilder: (_, __) =>
                                    const Divider(height: 1),
                                itemBuilder: (BuildContext context, int index) {
                                  final CurrencyPairResponse pair = filtered[index];
                                  final bool isSelected =
                                      _selectedPair?.id == pair.id;
                                  return ListTile(
                                    dense: true,
                                    title: Text(
                                      pair.symbol,
                                      style: TextStyle(
                                        color: textColor,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14,
                                      ),
                                    ),
                                    subtitle: Text(
                                      'Live Price: ${pair.currentPrice}',
                                      style: const TextStyle(
                                        color: AppColors.successColor,
                                        fontSize: 12,
                                      ),
                                    ),
                                    trailing: isSelected
                                        ? const Icon(
                                            Icons.check_circle_rounded,
                                            color: AppColors.primaryPurple,
                                            size: 18,
                                          )
                                        : null,
                                    onTap: () {
                                      setState(() {
                                        _selectedPair = pair;
                                      });
                                      Navigator.pop(ctx);
                                    },
                                  );
                                },
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

  @override
  Widget build(BuildContext context) {
    final bool isDark = context.isDark;

    // Adaptive Theme Palette matching user UI
    final Color bg = isDark ? const Color(0xFF14161C) : AppColors.backgroundLight;
    final Color topBarBg = isDark ? const Color(0xFF1C1F27) : AppColors.surfaceLight;
    final Color cardBg = isDark ? const Color(0xFF1C1F27) : AppColors.surfaceLight;
    final Color cardInnerBg = isDark ? const Color(0xFF20232C) : AppColors.whiteSmokeShade;
    final Color fieldBg = isDark ? const Color(0xFF181B22) : AppColors.surfaceLight;
    final Color borderColor = isDark ? const Color(0xFF2C303A) : AppColors.borderLight;

    final Color greenColor = const Color(0xFF25D077);
    final Color greenTextColor = const Color(0xFF2EBD70);
    final Color orangeColor = const Color(0xFFE8642C);
    final Color greyColor = const Color(0xFF9099A8);
    final Color lightGreyColor = isDark ? const Color(0xFFB8C0CC) : AppColors.textSecondaryLight;
    final Color whiteColor = isDark ? const Color(0xFFEDEFF3) : AppColors.textPrimaryLight;

    final double livePrice = _getLivePrice();
    final String livePriceStr = livePrice.toStringAsFixed(_getPricePrecision());
    final String askPriceStr = (livePrice * 1.00015).toStringAsFixed(_getPricePrecision());

    return Scaffold(
      backgroundColor: bg,
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              // TOP BAR
              _topBar(topBarBg, whiteColor, greyColor, lightGreyColor),
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(12),
                  child: _orderPanel(
                    cardBg,
                    cardInnerBg,
                    fieldBg,
                    borderColor,
                    greenColor,
                    greenTextColor,
                    orangeColor,
                    greyColor,
                    lightGreyColor,
                    whiteColor,
                    livePriceStr,
                    askPriceStr,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ---------------- TOP BAR ----------------
  Widget _topBar(
    Color topBarBg,
    Color whiteColor,
    Color greyColor,
    Color lightGreyColor,
  ) {
    final String symbol = _selectedPair?.symbol ?? 'EURUSD';

    return Container(
      color: topBarBg,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      child: Row(
        children: <Widget>[
          InkWell(
            onTap: _openPairSelectionSheet,
            child: Row(
              children: <Widget>[
                Text(
                  symbol,
                  style: TextStyle(
                    color: whiteColor,
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(width: 4),
                Icon(Icons.keyboard_arrow_down, color: greyColor),
              ],
            ),
          ),
          const Spacer(),
          _iconBtn(Icons.share_outlined, lightGreyColor),
          _iconBtn(Icons.star_border, lightGreyColor),
          _iconBtn(Icons.edit_note, lightGreyColor),
          _iconBtn(Icons.notifications_none, lightGreyColor),
        ],
      ),
    );
  }

  Widget _iconBtn(IconData icon, Color color) {
    return Padding(
      padding: const EdgeInsets.only(left: 14),
      child: Icon(icon, color: color, size: 22),
    );
  }

  // ---------------- MAIN PANEL ----------------
  Widget _orderPanel(
    Color cardBg,
    Color cardInnerBg,
    Color fieldBg,
    Color borderColor,
    Color greenColor,
    Color greenTextColor,
    Color orangeColor,
    Color greyColor,
    Color lightGreyColor,
    Color whiteColor,
    String sellPriceStr,
    String buyPriceStr,
  ) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: cardBg,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _panelHeader(whiteColor, greyColor),
          Container(
            margin: const EdgeInsets.fromLTRB(14, 0, 14, 16),
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: cardInnerBg,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                _instrumentRow(whiteColor, greenColor, greenTextColor, greyColor),
                const SizedBox(height: 14),
                _orderTypeTabs(whiteColor, greyColor, greenColor, borderColor),
                const SizedBox(height: 14),
                _sellBuyRow(orangeColor, greenColor, sellPriceStr, buyPriceStr),
                const SizedBox(height: 8),
                _spreadBar(orangeColor, greenColor),
                const SizedBox(height: 10),
                _spreadInfoRow(greyColor, sellPriceStr),
                const SizedBox(height: 18),
                _quantityRow(
                  lightGreyColor,
                  whiteColor,
                  fieldBg,
                  borderColor,
                  greyColor,
                ),
                const SizedBox(height: 8),
                _marginPipRow(greyColor),
                const SizedBox(height: 20),
                _stopLossTakeProfitRow(
                  lightGreyColor,
                  whiteColor,
                  fieldBg,
                  borderColor,
                  greyColor,
                ),
                const SizedBox(height: 18),
                _trailingStopRow(lightGreyColor, whiteColor, greyColor),
                const SizedBox(height: 14),
                _breakEvenRow(lightGreyColor, whiteColor, greyColor),
                const SizedBox(height: 18),
                _commentField(whiteColor, greyColor, fieldBg, borderColor),
                const SizedBox(height: 18),
                _placeOrderButton(greenColor),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _panelHeader(Color whiteColor, Color greyColor) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 14, 10, 14),
      child: Row(
        children: <Widget>[
          Text(
            'New order',
            style: TextStyle(
              color: whiteColor,
              fontSize: 17,
              fontWeight: FontWeight.w500,
            ),
          ),
          const Spacer(),
          Icon(Icons.keyboard_arrow_up, color: greyColor),
        ],
      ),
    );
  }

  Widget _instrumentRow(
    Color whiteColor,
    Color greenColor,
    Color greenTextColor,
    Color greyColor,
  ) {
    final String base = _selectedPair?.baseCurrency.isNotEmpty == true
        ? _selectedPair!.baseCurrency
        : 'Euro';
    final String quote = _selectedPair?.quoteCurrency.isNotEmpty == true
        ? _selectedPair!.quoteCurrency
        : 'US Dollar';

    return Row(
      children: <Widget>[
        Container(
          width: 18,
          height: 18,
          alignment: Alignment.center,
          decoration: const BoxDecoration(shape: BoxShape.circle),
          child: Icon(Icons.check, color: greenColor, size: 18),
        ),
        const SizedBox(width: 8),
        Text(
          '$base vs $quote',
          style: TextStyle(color: whiteColor, fontSize: 15),
        ),
        const Spacer(),
        Text(
          '+7.6 (+0.07%)',
          style: TextStyle(
            color: greenTextColor,
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(width: 10),
        Icon(Icons.ios_share, color: greyColor, size: 18),
      ],
    );
  }

  Widget _orderTypeTabs(
    Color whiteColor,
    Color greyColor,
    Color greenColor,
    Color borderColor,
  ) {
    return Row(
      children: List<Widget>.generate(_orderTypes.length, (int i) {
        final bool selected = i == _orderTypeIndex;
        return Expanded(
          child: GestureDetector(
            onTap: () => setState(() => _orderTypeIndex = i),
            child: Container(
              padding: const EdgeInsets.only(bottom: 10),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: selected ? greenColor : borderColor,
                    width: 2,
                  ),
                ),
              ),
              alignment: Alignment.center,
              child: Text(
                _orderTypes[i],
                style: TextStyle(
                  color: selected ? whiteColor : greyColor,
                  fontSize: 14,
                  fontWeight: selected ? FontWeight.w600 : FontWeight.w400,
                ),
              ),
            ),
          ),
        );
      }),
    );
  }

  Widget _sellBuyRow(
    Color orangeColor,
    Color greenColor,
    String sellPriceStr,
    String buyPriceStr,
  ) {
    final bool isBuy = _orderDirection == 'BUY';

    return Row(
      children: <Widget>[
        Expanded(
          child: GestureDetector(
            onTap: () => setState(() => _orderDirection = 'SELL'),
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 12),
              decoration: BoxDecoration(
                color: const Color(0xFF15171D),
                border: Border.all(
                  color: !isBuy ? orangeColor : Colors.transparent,
                  width: 1.5,
                ),
                borderRadius:
                    const BorderRadius.horizontal(left: Radius.circular(8)),
              ),
              child: Column(
                children: <Widget>[
                  Text('Sell', style: TextStyle(color: orangeColor, fontSize: 13)),
                  const SizedBox(height: 4),
                  Text(
                    sellPriceStr,
                    style: TextStyle(
                      color: orangeColor,
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(width: 2),
        Expanded(
          child: GestureDetector(
            onTap: () => setState(() => _orderDirection = 'BUY'),
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 12),
              decoration: BoxDecoration(
                color: const Color(0xFF15171D),
                border: Border.all(
                  color: isBuy ? greenColor : Colors.transparent,
                  width: 1.5,
                ),
                borderRadius:
                    const BorderRadius.horizontal(right: Radius.circular(8)),
              ),
              child: Column(
                children: <Widget>[
                  Text('Buy', style: TextStyle(color: greenColor, fontSize: 13)),
                  const SizedBox(height: 4),
                  Text(
                    buyPriceStr,
                    style: TextStyle(
                      color: greenColor,
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _spreadBar(Color orangeColor, Color greenColor) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(3),
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 1,
            child: Container(height: 4, color: orangeColor),
          ),
          Expanded(
            flex: 2,
            child: Container(height: 4, color: greenColor),
          ),
        ],
      ),
    );
  }

  Widget _spreadInfoRow(Color greyColor, String currentPriceStr) {
    final double p = double.tryParse(currentPriceStr) ?? 1.13974;
    final String highStr = (p * 1.0015).toStringAsFixed(_getPricePrecision());
    final String lowStr = (p * 0.9985).toStringAsFixed(_getPricePrecision());

    return Center(
      child: Text(
        'Spread: 0.2; High: $highStr; Low: $lowStr',
        style: TextStyle(color: greyColor, fontSize: 12.5),
      ),
    );
  }

  Widget _quantityRow(
    Color lightGreyColor,
    Color whiteColor,
    Color fieldBg,
    Color borderColor,
    Color greyColor,
  ) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text('Quantity', style: TextStyle(color: lightGreyColor, fontSize: 13)),
              const SizedBox(height: 8),
              Row(
                children: <Widget>[
                  Expanded(
                    child: _stepperField(
                      _lots.toStringAsFixed(1),
                      (double delta) {
                        setState(() {
                          _lots = (_lots + delta).clamp(0.01, 999.0);
                        });
                      },
                      fieldBg,
                      borderColor,
                      whiteColor,
                      greyColor,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text('Lots', style: TextStyle(color: lightGreyColor, fontSize: 13)),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: <Widget>[
                  _checkbox(
                    _marketRange,
                    (bool v) => setState(() => _marketRange = v),
                    whiteColor,
                    greyColor,
                  ),
                  const SizedBox(width: 8),
                  Text('Market range',
                      style: TextStyle(color: lightGreyColor, fontSize: 13)),
                  const SizedBox(width: 6),
                  _infoIcon(greyColor),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                children: <Widget>[
                  Expanded(
                    child: _stepperField(
                      _marketRangePipsController.text,
                      null,
                      fieldBg,
                      borderColor,
                      whiteColor,
                      greyColor,
                      enabled: _marketRange,
                      controller: _marketRangePipsController,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text('Pips', style: TextStyle(color: lightGreyColor, fontSize: 13)),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _marginPipRow(Color greyColor) {
    return Row(
      children: <Widget>[
        Expanded(
          child: Text(
            'Sell margin: ~1 500.00',
            style: TextStyle(color: greyColor, fontSize: 12.5),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Text(
            'Pip value: 13.16 EUR',
            style: TextStyle(color: greyColor, fontSize: 12.5),
          ),
        ),
      ],
    );
  }

  Widget _stopLossTakeProfitRow(
    Color lightGreyColor,
    Color whiteColor,
    Color fieldBg,
    Color borderColor,
    Color greyColor,
  ) {
    final double entry = _getLivePrice();
    final double? slPrice = _getCalculatedSL(entry);
    final double? tpPrice = _getCalculatedTP(_tp1PipsController.text, entry);

    final String slVal = _slPipsController.text.startsWith('-')
        ? _slPipsController.text
        : '-${_slPipsController.text}';
    final String slPriceStr = slPrice != null
        ? slPrice.toStringAsFixed(_getPricePrecision())
        : '1.14964';

    final String tpVal = _tp1PipsController.text;
    final String tpPriceStr = tpPrice != null
        ? tpPrice.toStringAsFixed(_getPricePrecision())
        : '1.12474';

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Expanded(
          child: _slTpColumn(
            title: 'Stop loss',
            checked: _stopLossOn,
            onCheck: (bool v) => setState(() => _stopLossOn = v),
            trailingIcon: Icons.arrow_forward,
            rows: <_SlTpRowData>[
              _SlTpRowData(
                symbol: '=',
                label: 'Pips',
                value: slVal,
                controller: _slPipsController,
              ),
              _SlTpRowData(
                symbol: '~',
                label: 'Price',
                value: slPriceStr,
              ),
              const _SlTpRowData(
                symbol: '~',
                label: 'Balance',
                value: '-130.29',
                suffix: '%',
              ),
              const _SlTpRowData(
                symbol: '~',
                label: 'Profit',
                value: '-1302.91',
                suffix: 'EUR',
                prefix: '~EUR',
              ),
            ],
            enabled: _stopLossOn,
            lightGreyColor: lightGreyColor,
            whiteColor: whiteColor,
            fieldBg: fieldBg,
            borderColor: borderColor,
            greyColor: greyColor,
          ),
        ),
        const SizedBox(width: 14),
        Expanded(
          child: _slTpColumn(
            title: 'Take profit',
            checked: _takeProfitOn,
            onCheck: (bool v) => setState(() => _takeProfitOn = v),
            rows: <_SlTpRowData>[
              _SlTpRowData(
                symbol: '=',
                label: 'Pips',
                value: tpVal,
                controller: _tp1PipsController,
              ),
              _SlTpRowData(
                symbol: '~',
                label: 'Price',
                value: tpPriceStr,
              ),
              const _SlTpRowData(
                symbol: '~',
                label: 'Balance',
                value: '197.41',
                suffix: '%',
              ),
              const _SlTpRowData(
                symbol: '~',
                label: 'Profit',
                value: '1974.1',
                suffix: 'EUR',
              ),
            ],
            enabled: _takeProfitOn,
            lightGreyColor: lightGreyColor,
            whiteColor: whiteColor,
            fieldBg: fieldBg,
            borderColor: borderColor,
            greyColor: greyColor,
            footerButton: '+ Add TP',
            onFooterTap: () {
              setState(() {
                if (!_showTp2) {
                  _showTp2 = true;
                } else if (!_showTp3) {
                  _showTp3 = true;
                }
              });
            },
          ),
        ),
      ],
    );
  }

  Widget _slTpColumn({
    required String title,
    required bool checked,
    required ValueChanged<bool> onCheck,
    required List<_SlTpRowData> rows,
    required bool enabled,
    required Color lightGreyColor,
    required Color whiteColor,
    required Color fieldBg,
    required Color borderColor,
    required Color greyColor,
    IconData? trailingIcon,
    String? footerButton,
    VoidCallback? onFooterTap,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            _checkbox(checked, onCheck, whiteColor, greyColor),
            const SizedBox(width: 8),
            Text(
              title,
              style: TextStyle(
                color: lightGreyColor,
                fontSize: 13,
                fontWeight: FontWeight.w500,
              ),
            ),
            if (trailingIcon != null) ...<Widget>[
              const SizedBox(width: 6),
              Container(
                padding: const EdgeInsets.all(3),
                decoration: BoxDecoration(
                  color: fieldBg,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Icon(trailingIcon, size: 12, color: greyColor),
              ),
            ],
          ],
        ),
        const SizedBox(height: 10),
        for (final _SlTpRowData r in rows) ...<Widget>[
          _slTpFieldRow(
            r,
            enabled,
            fieldBg,
            borderColor,
            whiteColor,
            greyColor,
            lightGreyColor,
          ),
          const SizedBox(height: 8),
        ],
        if (footerButton != null)
          SizedBox(
            width: double.infinity,
            child: OutlinedButton(
              onPressed: onFooterTap,
              style: OutlinedButton.styleFrom(
                backgroundColor: const Color(0xFF3A3E48),
                side: BorderSide.none,
                padding: const EdgeInsets.symmetric(vertical: 10),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6),
                ),
              ),
              child: Text(
                footerButton,
                style: TextStyle(color: whiteColor, fontSize: 13),
              ),
            ),
          ),
      ],
    );
  }

  Widget _slTpFieldRow(
    _SlTpRowData r,
    bool enabled,
    Color fieldBg,
    Color borderColor,
    Color whiteColor,
    Color greyColor,
    Color lightGreyColor,
  ) {
    final Color color = enabled ? whiteColor : greyColor;

    return Opacity(
      opacity: enabled ? 1 : 0.45,
      child: Row(
        children: <Widget>[
          Expanded(
            child: Container(
              height: 34,
              padding: const EdgeInsets.symmetric(horizontal: 8),
              decoration: BoxDecoration(
                color: fieldBg,
                borderRadius: BorderRadius.circular(6),
                border: Border.all(color: borderColor),
              ),
              child: Row(
                children: <Widget>[
                  Text(r.symbol,
                      style: TextStyle(color: greyColor, fontSize: 12)),
                  const SizedBox(width: 6),
                  Expanded(
                    child: r.controller != null
                        ? TextFormField(
                            controller: r.controller,
                            enabled: enabled,
                            keyboardType: const TextInputType.numberWithOptions(
                                decimal: true),
                            style: TextStyle(color: color, fontSize: 13),
                            decoration: const InputDecoration(
                              isDense: true,
                              contentPadding: EdgeInsets.zero,
                              border: InputBorder.none,
                            ),
                          )
                        : Text(
                            r.value,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(color: color, fontSize: 13),
                          ),
                  ),
                  if (r.suffix != null)
                    Text(r.suffix!,
                        style: TextStyle(color: greyColor, fontSize: 11)),
                  const SizedBox(width: 2),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Icon(Icons.keyboard_arrow_up,
                          size: 12, color: greyColor),
                      Icon(Icons.keyboard_arrow_down,
                          size: 12, color: greyColor),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 6),
          SizedBox(
            width: 46,
            child: Text(
              r.label,
              style: TextStyle(color: lightGreyColor, fontSize: 12),
            ),
          ),
          const SizedBox(width: 4),
          _infoIcon(greyColor),
        ],
      ),
    );
  }

  Widget _trailingStopRow(
    Color lightGreyColor,
    Color whiteColor,
    Color greyColor,
  ) {
    return Row(
      children: <Widget>[
        _checkbox(
          _trailingStop,
          (bool v) => setState(() => _trailingStop = v),
          whiteColor,
          greyColor,
        ),
        const SizedBox(width: 8),
        Text(
          'Trailing stop loss',
          style: TextStyle(color: lightGreyColor, fontSize: 13),
        ),
      ],
    );
  }

  Widget _breakEvenRow(
    Color lightGreyColor,
    Color whiteColor,
    Color greyColor,
  ) {
    return Row(
      children: <Widget>[
        _checkbox(
          _breakEven,
          (bool v) => setState(() => _breakEven = v),
          whiteColor,
          greyColor,
        ),
        const SizedBox(width: 8),
        Text(
          'Break-even',
          style: TextStyle(color: lightGreyColor, fontSize: 13),
        ),
      ],
    );
  }

  Widget _commentField(
    Color whiteColor,
    Color greyColor,
    Color fieldBg,
    Color borderColor,
  ) {
    return Column(
      children: <Widget>[
        // TradingView URL input field (Hidden backend field required)
        SizedBox(
          height: 36,
          child: TextFormField(
            controller: _tradingViewUrlController,
            style: TextStyle(color: whiteColor, fontSize: 13),
            decoration: InputDecoration(
              hintText: 'TradingView URL (e.g. https://tradingview.com/...)',
              hintStyle: TextStyle(color: greyColor, fontSize: 12),
              prefixIcon: Icon(Icons.link_rounded, size: 16, color: greyColor),
              filled: true,
              fillColor: fieldBg,
              contentPadding: const EdgeInsets.symmetric(vertical: 4),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(6),
                borderSide: BorderSide(color: borderColor),
              ),
            ),
            validator: (String? val) {
              if (val != null && val.isNotEmpty && !val.contains('tradingview.com')) {
                return 'Must be a valid TradingView link';
              }
              return null;
            },
          ),
        ),
        const SizedBox(height: 8),

        // Comment Box
        Container(
          decoration: BoxDecoration(
            color: fieldBg,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: borderColor),
          ),
          padding: const EdgeInsets.fromLTRB(12, 10, 12, 6),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              TextField(
                controller: _commentController,
                maxLength: 100,
                style: TextStyle(color: whiteColor, fontSize: 13),
                decoration: InputDecoration(
                  hintText: 'Comment',
                  hintStyle: TextStyle(color: greyColor, fontSize: 14),
                  border: InputBorder.none,
                  isDense: true,
                  counterText: '',
                ),
                onChanged: (_) => setState(() {}),
              ),
              Text(
                '${_commentController.text.length}/100',
                style: TextStyle(color: greyColor, fontSize: 11),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _placeOrderButton(Color greenColor) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: _isSubmitting ? null : () => unawaited(_submitTrade()),
        style: ElevatedButton.styleFrom(
          backgroundColor: greenColor,
          padding: const EdgeInsets.symmetric(vertical: 14),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          elevation: 0,
        ),
        child: _isSubmitting
            ? const CircularProgressIndicator(color: Colors.black)
            : const Text(
                'Place order',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                ),
              ),
      ),
    );
  }

  // ---------------- SHARED WIDGETS ----------------
  Widget _checkbox(
    bool value,
    ValueChanged<bool> onChanged,
    Color whiteColor,
    Color greyColor,
  ) {
    return GestureDetector(
      onTap: () => onChanged(!value),
      child: Container(
        width: 18,
        height: 18,
        decoration: BoxDecoration(
          color: value ? whiteColor : Colors.transparent,
          border: Border.all(
            color: value ? whiteColor : greyColor,
            width: 1.4,
          ),
          borderRadius: BorderRadius.circular(3),
        ),
        child: value
            ? const Icon(Icons.check, size: 13, color: Colors.black)
            : null,
      ),
    );
  }

  Widget _infoIcon(Color greyColor) {
    return Container(
      width: 16,
      height: 16,
      decoration: BoxDecoration(
        border: Border.all(color: greyColor, width: 1),
        borderRadius: BorderRadius.circular(4),
      ),
      alignment: Alignment.center,
      child: Text(
        'i',
        style: TextStyle(
          color: greyColor,
          fontSize: 10,
          fontStyle: FontStyle.italic,
        ),
      ),
    );
  }

  Widget _stepperField(
    String value,
    void Function(double delta)? onDelta,
    Color fieldBg,
    Color borderColor,
    Color whiteColor,
    Color greyColor, {
    bool enabled = true,
    TextEditingController? controller,
  }) {
    return Opacity(
      opacity: enabled ? 1 : 0.4,
      child: Container(
        height: 38,
        padding: const EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          color: fieldBg,
          borderRadius: BorderRadius.circular(6),
          border: Border.all(color: borderColor),
        ),
        child: Row(
          children: <Widget>[
            Expanded(
              child: controller != null
                  ? TextFormField(
                      controller: controller,
                      enabled: enabled,
                      keyboardType: const TextInputType.numberWithOptions(
                          decimal: true),
                      style: TextStyle(color: whiteColor, fontSize: 14),
                      decoration: const InputDecoration(
                        isDense: true,
                        contentPadding: EdgeInsets.zero,
                        border: InputBorder.none,
                      ),
                    )
                  : Text(
                      value,
                      style: TextStyle(color: whiteColor, fontSize: 14),
                    ),
            ),
            if (onDelta != null)
              Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  GestureDetector(
                    onTap: () => onDelta(0.1),
                    child:
                        Icon(Icons.keyboard_arrow_up, size: 14, color: greyColor),
                  ),
                  GestureDetector(
                    onTap: () => onDelta(-0.1),
                    child: Icon(Icons.keyboard_arrow_down,
                        size: 14, color: greyColor),
                  ),
                ],
              )
            else
              Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Icon(Icons.keyboard_arrow_up, size: 14, color: greyColor),
                  Icon(Icons.keyboard_arrow_down, size: 14, color: greyColor),
                ],
              ),
          ],
        ),
      ),
    );
  }
}

class _SlTpRowData {
  final String symbol;
  final String label;
  final String value;
  final String? suffix;
  final String? prefix;
  final TextEditingController? controller;

  const _SlTpRowData({
    required this.symbol,
    required this.label,
    required this.value,
    this.suffix,
    this.prefix,
    this.controller,
  });
}
