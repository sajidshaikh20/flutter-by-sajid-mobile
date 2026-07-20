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
  String _selectedMarket = 'COMMODITY';
  List<CurrencyPairResponse> _currencyPairs = <CurrencyPairResponse>[];
  CurrencyPairResponse? _selectedPair;
  bool _isLoadingPairs = false;

  // Socket Live Price Stream
  StreamSubscription<Map<String, dynamic>>? _priceSubscription;
  String? _registeredSymbol;
  double? _liveSocketPrice;

  // Trade Type Options
  String _selectedTradeType = 'BUY';
  final List<String> _tradeTypes = const <String>[
    'BUY',
    'SELL',
    'BUY LIMIT',
    'SELL LIMIT',
    'BUY STOP',
    'SELL STOP',
  ];

  // Price vs Pips Toggles for SL & TP1
  bool _isSlInPips = false;
  bool _isTp1InPips = false;

  // Controllers
  final TextEditingController _entryController = TextEditingController();
  final TextEditingController _slController = TextEditingController();
  final TextEditingController _tp1Controller = TextEditingController();
  final TextEditingController _tp2Controller = TextEditingController();
  final TextEditingController _tp3Controller = TextEditingController();
  final TextEditingController _tradingViewUrlController = TextEditingController();
  final TextEditingController _commentController = TextEditingController();

  bool _isSubmitting = false;

  @override
  void initState() {
    super.initState();
    unawaited(_loadPairs());
    _subscribeLivePrice();

    _entryController.addListener(_onCalculationsChanged);
    _slController.addListener(_onCalculationsChanged);
    _tp1Controller.addListener(_onCalculationsChanged);
    _tp2Controller.addListener(_onCalculationsChanged);
    _tp3Controller.addListener(_onCalculationsChanged);
  }

  @override
  void dispose() {
    unawaited(_priceSubscription?.cancel());
    if (_registeredSymbol != null) {
      unawaited(MainConfig.chatSocketConnection.unregisterSymbol(_registeredSymbol!));
    }
    _entryController.dispose();
    _slController.dispose();
    _tp1Controller.dispose();
    _tp2Controller.dispose();
    _tp3Controller.dispose();
    _tradingViewUrlController.dispose();
    _commentController.dispose();
    super.dispose();
  }

  void _onCalculationsChanged() {
    setState(() {});
  }

  void _subscribeLivePrice() {
    unawaited(_priceSubscription?.cancel());
    _priceSubscription = MainConfig.chatSocketConnection.priceStream.listen((Map<String, dynamic> data) {
      final String? symbol = data['symbol'] as String?;
      final double? price = double.tryParse(data['price']?.toString() ?? '');
      if (symbol != null && price != null && price > 0) {
        final String normSymbol = symbol.replaceAll('/', '').toUpperCase();
        final String normSelected = (_selectedPair?.symbol ?? '').replaceAll('/', '').toUpperCase();
        if (normSymbol == normSelected) {
          if (mounted) {
            setState(() {
              _liveSocketPrice = price;
              if (_selectedPair != null) {
                _selectedPair = CurrencyPairResponse(
                  id: _selectedPair!.id,
                  symbol: _selectedPair!.symbol,
                  baseCurrency: _selectedPair!.baseCurrency,
                  quoteCurrency: _selectedPair!.quoteCurrency,
                  market: _selectedPair!.market,
                  currentPrice: price,
                  pipValue: _selectedPair!.pipValue,
                );
              }
              if (_entryController.text.isEmpty) {
                _entryController.text = price.toStringAsFixed(_getPricePrecision());
              }
            });
          }
        }
      }
    });
  }

  void _updateSocketRegistration(String? newSymbol) {
    if (_registeredSymbol != null && _registeredSymbol != newSymbol) {
      unawaited(MainConfig.chatSocketConnection.unregisterSymbol(_registeredSymbol!));
      _registeredSymbol = null;
    }
    if (newSymbol != null && newSymbol.isNotEmpty) {
      _registeredSymbol = newSymbol;
      unawaited(MainConfig.chatSocketConnection.registerSymbol(newSymbol));
    }
  }

  Future<void> _loadPairs() async {
    setState(() {
      _isLoadingPairs = true;
      _currencyPairs = <CurrencyPairResponse>[];
      _selectedPair = null;
      _liveSocketPrice = null;
    });

    try {
      ResponseHandler<BaseResponse<List<CurrencyPairResponse>>> response =
          await _repository.getCurrencyPairs(market: _selectedMarket);
      List<CurrencyPairResponse>? pairs =
          response.getSuccessInstance()?.response.data;

      if (pairs == null || pairs.isEmpty) {
        response = await _repository.getCurrencyPairs(
          market: _selectedMarket.toLowerCase(),
        );
        pairs = response.getSuccessInstance()?.response.data;
      }

      if (pairs == null || pairs.isEmpty) {
        response = await _repository.getCurrencyPairs(market: '');
        pairs = response.getSuccessInstance()?.response.data;
      }

      if (pairs != null && pairs.isNotEmpty) {
        setState(() {
          _currencyPairs = pairs!;
          _selectedPair = _currencyPairs.first;
          if (_selectedPair!.currentPrice > 0) {
            _liveSocketPrice = _selectedPair!.currentPrice;
          }
          _entryController.text = _getLivePrice().toStringAsFixed(_getPricePrecision());
        });
        _updateSocketRegistration(_selectedPair!.symbol);
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

  double _getLivePrice() {
    if (_liveSocketPrice != null && _liveSocketPrice! > 0) {
      return _liveSocketPrice!;
    }
    if (_selectedPair != null && _selectedPair!.currentPrice > 0) {
      return _selectedPair!.currentPrice;
    }
    return 2200.0;
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

  double _getCalculatedEntry() {
    final double? val = double.tryParse(_entryController.text);
    if (val != null && val > 0) return val;
    return _getLivePrice();
  }

  double? _getEffectiveSL(double entry) {
    if (_slController.text.trim().isEmpty) return null;
    final double? inputVal = double.tryParse(_slController.text.trim());
    if (inputVal == null) return null;

    final bool isBuy = _selectedTradeType.contains('BUY');
    if (_isSlInPips) {
      return _pipsToPrice(inputVal, entry, !isBuy);
    } else {
      return inputVal;
    }
  }

  double? _getEffectiveTP1(double entry) {
    if (_tp1Controller.text.trim().isEmpty) return null;
    final double? inputVal = double.tryParse(_tp1Controller.text.trim());
    if (inputVal == null) return null;

    final bool isBuy = _selectedTradeType.contains('BUY');
    if (_isTp1InPips) {
      return _pipsToPrice(inputVal, entry, isBuy);
    } else {
      return inputVal;
    }
  }

  Map<String, dynamic>? _calculateTradeRR() {
    final double entry = _getCalculatedEntry();
    final double? sl = _getEffectiveSL(entry);
    final double? tp = _getEffectiveTP1(entry);

    if (sl == null || tp == null) return null;

    final bool isBuy = _selectedTradeType.contains('BUY');

    if (isBuy) {
      if (sl >= entry) {
        return <String, dynamic>{
          'valid': false,
          'reason': 'Stop Loss must be below Entry price',
          'rr': 0.0,
        };
      }
      if (tp <= entry) {
        return <String, dynamic>{
          'valid': false,
          'reason': 'Take Profit must be above Entry price',
          'rr': 0.0,
        };
      }
    } else {
      if (sl <= entry) {
        return <String, dynamic>{
          'valid': false,
          'reason': 'Stop Loss must be above Entry price',
          'rr': 0.0,
        };
      }
      if (tp >= entry) {
        return <String, dynamic>{
          'valid': false,
          'reason': 'Take Profit must be below Entry price',
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
                'Invalid Risk-Reward calculations. Please enter valid SL and TP.',
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
      final double sl = _getEffectiveSL(entry)!;
      final double tp1 = _getEffectiveTP1(entry)!;

      final double slPips = _priceToPips(sl, entry);
      final double tp1Pips = _priceToPips(tp1, entry);

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

      if (_tp2Controller.text.trim().isNotEmpty) {
        final double? tp2 = double.tryParse(_tp2Controller.text.trim());
        if (tp2 != null) {
          levels.add(<String, dynamic>{
            'levelType': 'TAKE_PROFIT',
            'takeProfit': tp2,
            'level': 2,
            'tpPips': _priceToPips(tp2, entry),
          });
        }
      }

      if (_tp3Controller.text.trim().isNotEmpty) {
        final double? tp3 = double.tryParse(_tp3Controller.text.trim());
        if (tp3 != null) {
          levels.add(<String, dynamic>{
            'levelType': 'TAKE_PROFIT',
            'takeProfit': tp3,
            'level': 3,
            'tpPips': _priceToPips(tp3, entry),
          });
        }
      }

      final Map<String, dynamic> payload = <String, dynamic>{
        'market': _selectedMarket,
        'marketType': _selectedTradeType,
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
              content: Text('Trade signal created successfully!'),
              backgroundColor: AppColors.successColor,
            ),
          );
          unawaited(context.router.maybePop());
        }
      } else {
        if (mounted) {
          final String errMsg =
              response.getFailureInstance()?.error?.errorMessage ??
                  'Failed to create trade signal';
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
                      children: <String>['COMMODITY', 'FOREX', 'CRYPTO', 'STOCK']
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
                      hintText: 'Search EURUSD, BTCUSD, ALUMINIUM...',
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
                                separatorBuilder: (BuildContext context, int index) =>
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
                                      'Live Price: ${pair.currentPrice > 0 ? pair.currentPrice : "--"}',
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
                                        if (pair.currentPrice > 0) {
                                          _liveSocketPrice = pair.currentPrice;
                                        } else {
                                          _liveSocketPrice = null;
                                        }
                                        _entryController.text = _getLivePrice().toStringAsFixed(_getPricePrecision());
                                      });
                                      _updateSocketRegistration(pair.symbol);
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

  void _showOrderTypeInfo() {
    final bool isDark = context.isDark;
    unawaited(showDialog<void>(
      context: context,
      builder: (BuildContext ctx) => AlertDialog(
        backgroundColor: isDark ? AppColors.surfaceDark : Colors.white,
        title: const Text('Trade Types', style: TextStyle(fontWeight: FontWeight.bold)),
        content: const Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('• BUY / SELL: Immediate market execution at current live price.', style: TextStyle(fontSize: 13)),
            SizedBox(height: 6),
            Text('• BUY LIMIT: Buy order placed below current price.', style: TextStyle(fontSize: 13)),
            SizedBox(height: 6),
            Text('• SELL LIMIT: Sell order placed above current price.', style: TextStyle(fontSize: 13)),
            SizedBox(height: 6),
            Text('• BUY STOP: Buy order placed above current price.', style: TextStyle(fontSize: 13)),
            SizedBox(height: 6),
            Text('• SELL STOP: Sell order placed below current price.', style: TextStyle(fontSize: 13)),
          ],
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Got it'),
          ),
        ],
      ),
    ));
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

    final Map<String, dynamic>? rrCalculation = _calculateTradeRR();
    final double entryPrice = _getCalculatedEntry();
    final double? slPrice = _getEffectiveSL(entryPrice);
    final double? tp1Price = _getEffectiveTP1(entryPrice);

    final double slPips = slPrice != null ? _priceToPips(slPrice, entryPrice) : 0.0;
    final double tp1Pips = tp1Price != null ? _priceToPips(tp1Price, entryPrice) : 0.0;

    final String livePriceStr = _getLivePrice() > 0
        ? _getLivePrice().toStringAsFixed(_getPricePrecision())
        : '--';

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
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                // Subtitle
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
                      value: _selectedMarket,
                      isExpanded: true,
                      dropdownColor: cardBg,
                      style: TextStyle(color: textColor, fontSize: 14, fontWeight: FontWeight.bold),
                      icon: Icon(Icons.keyboard_arrow_down_rounded, color: subtextColor),
                      items: <String>['COMMODITY', 'FOREX', 'CRYPTO', 'STOCK'].map((String m) {
                        return DropdownMenuItem<String>(
                          value: m,
                          child: Text(m),
                        );
                      }).toList(),
                      onChanged: (String? val) {
                        if (val != null && val != _selectedMarket) {
                          setState(() {
                            _selectedMarket = val;
                          });
                          unawaited(_loadPairs());
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
                  onTap: _openPairSelectionSheet,
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
                          _selectedPair?.symbol ?? 'Select Currency Pair',
                          style: TextStyle(
                            color: textColor,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Spacer(),
                        if (_isLoadingPairs)
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
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: isDark ? const Color(0xFF092019) : const Color(0xFFE8F8F1),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: AppColors.successColor.withOpacity(0.4)),
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
                            child: const Text(
                              'Source: Twelve Data',
                              style: TextStyle(
                                color: Colors.orangeAccent,
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
                            _selectedPair?.symbol ?? 'SYMB',
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
                const SizedBox(height: 20),

                // 4. Trade Type & Entry 1
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    // Trade Type
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              _buildFieldLabel('Trade Type *', textColor),
                              const SizedBox(width: 4),
                              GestureDetector(
                                onTap: _showOrderTypeInfo,
                                child: Icon(Icons.info_outline_rounded, size: 16, color: subtextColor),
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
                                value: _selectedTradeType,
                                isExpanded: true,
                                dropdownColor: cardBg,
                                style: TextStyle(color: textColor, fontSize: 13, fontWeight: FontWeight.bold),
                                icon: Icon(Icons.keyboard_arrow_down_rounded, color: subtextColor, size: 20),
                                items: _tradeTypes.map((String t) {
                                  return DropdownMenuItem<String>(
                                    value: t,
                                    child: Text(t),
                                  );
                                }).toList(),
                                onChanged: (String? val) {
                                  if (val != null) {
                                    setState(() {
                                      _selectedTradeType = val;
                                    });
                                  }
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 12),
                    // Entry 1
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          _buildFieldLabel('Entry 1 *', textColor),
                          const SizedBox(height: 6),
                          TextFormField(
                            controller: _entryController,
                            keyboardType: const TextInputType.numberWithOptions(decimal: true),
                            style: TextStyle(color: textColor, fontSize: 14, fontWeight: FontWeight.bold),
                            decoration: _inputDecoration(fieldBg, borderColor, hintText: '2200'),
                            validator: (String? val) {
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
                    // Stop Loss
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              _buildFieldLabel('Stop Loss *', textColor),
                              _buildModeToggle(
                                isPips: _isSlInPips,
                                onToggle: (bool val) => setState(() => _isSlInPips = val),
                                borderColor: borderColor,
                                textColor: textColor,
                              ),
                            ],
                          ),
                          const SizedBox(height: 6),
                          TextFormField(
                            controller: _slController,
                            keyboardType: const TextInputType.numberWithOptions(decimal: true),
                            style: TextStyle(color: textColor, fontSize: 14, fontWeight: FontWeight.bold),
                            decoration: _inputDecoration(fieldBg, borderColor, hintText: _isSlInPips ? 'Pips (e.g. 50)' : 'Price'),
                            validator: (String? val) {
                              if (val == null || val.trim().isEmpty) return 'Required';
                              if (double.tryParse(val.trim()) == null) return 'Invalid';
                              return null;
                            },
                          ),
                          const SizedBox(height: 4),
                          Text(
                            '≈ ${slPips > 0 ? slPips.toStringAsFixed(1) : '--'} Pips',
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
                              _buildFieldLabel('Take Profit 1 *', textColor),
                              _buildModeToggle(
                                isPips: _isTp1InPips,
                                onToggle: (bool val) => setState(() => _isTp1InPips = val),
                                borderColor: borderColor,
                                textColor: textColor,
                              ),
                            ],
                          ),
                          const SizedBox(height: 6),
                          TextFormField(
                            controller: _tp1Controller,
                            keyboardType: const TextInputType.numberWithOptions(decimal: true),
                            style: TextStyle(color: textColor, fontSize: 14, fontWeight: FontWeight.bold),
                            decoration: _inputDecoration(fieldBg, borderColor, hintText: _isTp1InPips ? 'Pips (e.g. 100)' : 'Price'),
                            validator: (String? val) {
                              if (val == null || val.trim().isEmpty) return 'Required';
                              if (double.tryParse(val.trim()) == null) return 'Invalid';
                              return null;
                            },
                          ),
                          const SizedBox(height: 4),
                          Text(
                            '≈ ${tp1Pips > 0 ? tp1Pips.toStringAsFixed(1) : '--'} Pips',
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
                            controller: _tp2Controller,
                            keyboardType: const TextInputType.numberWithOptions(decimal: true),
                            style: TextStyle(color: textColor, fontSize: 14),
                            decoration: _inputDecoration(fieldBg, borderColor, hintText: 'Optional'),
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
                            controller: _tp3Controller,
                            keyboardType: const TextInputType.numberWithOptions(decimal: true),
                            style: TextStyle(color: textColor, fontSize: 14),
                            decoration: _inputDecoration(fieldBg, borderColor, hintText: 'Optional'),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 18),

                // 7. Risk Reward Ratio TP1 Card
                _buildFieldLabel('Risk Reward Ratio TP1', textColor),
                const SizedBox(height: 6),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                  decoration: BoxDecoration(
                    color: isDark ? const Color(0xFF0F1E24) : const Color(0xFFF0FDF8),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: AppColors.successColor.withOpacity(0.3)),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: isDark ? Colors.black26 : Colors.black12,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          'AUTO CALCULATED',
                          style: TextStyle(
                            color: subtextColor,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 0.5,
                          ),
                        ),
                      ),
                      Text(
                        (rrCalculation != null && rrCalculation['valid'] == true)
                            ? '1 : ${(rrCalculation['rr'] as double).toStringAsFixed(2)}'
                            : '--',
                        style: const TextStyle(
                          color: AppColors.successColor,
                          fontSize: 16,
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
                  controller: _tradingViewUrlController,
                  keyboardType: TextInputType.url,
                  style: TextStyle(color: textColor, fontSize: 13),
                  decoration: _inputDecoration(
                    fieldBg,
                    borderColor,
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
                  controller: _commentController,
                  maxLines: 3,
                  style: TextStyle(color: textColor, fontSize: 13),
                  decoration: _inputDecoration(
                    fieldBg,
                    borderColor,
                    hintText: 'Enter setup analysis, key levels, or strategy notes...',
                  ),
                ),
                const SizedBox(height: 28),

                // 10. Create Trade Submit Button
                SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: ElevatedButton(
                    onPressed: _isSubmitting ? null : _submitTrade,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryPurple,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 2,
                    ),
                    child: _isSubmitting
                        ? const SizedBox(
                            width: 22,
                            height: 22,
                            child: CircularProgressIndicator(
                              color: Colors.white,
                              strokeWidth: 2.5,
                            ),
                          )
                        : const Text(
                            'Create Trade Signal',
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
  }

  Widget _buildFieldLabel(String text, Color color) {
    return Text(
      text,
      style: TextStyle(
        color: color,
        fontSize: 13,
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
      height: 26,
      decoration: BoxDecoration(
        color: borderColor.withOpacity(0.5),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          GestureDetector(
            onTap: () => onToggle(false),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
              decoration: BoxDecoration(
                color: !isPips ? AppColors.primaryPurple : Colors.transparent,
                borderRadius: BorderRadius.circular(6),
              ),
              child: Text(
                'Price',
                style: TextStyle(
                  color: !isPips ? Colors.white : textColor,
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: () => onToggle(true),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
              decoration: BoxDecoration(
                color: isPips ? AppColors.primaryPurple : Colors.transparent,
                borderRadius: BorderRadius.circular(6),
              ),
              child: Text(
                'Pips',
                style: TextStyle(
                  color: isPips ? Colors.white : textColor,
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  InputDecoration _inputDecoration(Color fill, Color border, {required String hintText}) {
    return InputDecoration(
      hintText: hintText,
      hintStyle: TextStyle(color: border, fontSize: 13),
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
}
