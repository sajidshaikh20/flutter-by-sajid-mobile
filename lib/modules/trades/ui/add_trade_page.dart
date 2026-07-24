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
  String _selectedMarket = 'CRYPTO';
  List<CurrencyPairResponse> _currencyPairs = <CurrencyPairResponse>[];
  CurrencyPairResponse? _selectedPair;
  bool _isLoadingPairs = false;

  // Socket Live Price Stream
  StreamSubscription<Map<String, dynamic>>? _priceSubscription;
  String? _registeredSymbol;
  double? _liveSocketPrice;

  // Trade Type Options (Matching Web Frontend)
  String _selectedTradeType = 'BUY_MARKET';
  final Map<String, String> _tradeTypeLabels = const <String, String>{
    'BUY_MARKET': 'Buy By Market',
    'SELL_MARKET': 'Sell By Market',
    'BUY_LIMIT': 'Buy Limit',
    'SELL_LIMIT': 'Sell Limit',
    'BUY_STOP': 'Buy Stop',
    'SELL_STOP': 'Sell Stop',
  };

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

  bool get _isMarketOrder => _selectedTradeType.contains('MARKET');

  bool _isSymbolMatch(String wsSymbol, String pairSymbol) {
    if (wsSymbol.isEmpty || pairSymbol.isEmpty) return false;
    final String s1 = wsSymbol.replaceAll(RegExp(r'[^A-Z0-9]'), '').toUpperCase();
    final String s2 = pairSymbol.replaceAll(RegExp(r'[^A-Z0-9]'), '').toUpperCase();
    if (s1 == s2) return true;
    if (s1.startsWith(s2) || s2.startsWith(s1)) return true;
    if (s1.contains(s2) || s2.contains(s1)) return true;
    final String baseS1 = s1.replaceAll('USDT', 'USD');
    final String baseS2 = s2.replaceAll('USDT', 'USD');
    return baseS1.startsWith(baseS2) || baseS2.startsWith(baseS1);
  }

  void _subscribeLivePrice() {
    unawaited(_priceSubscription?.cancel());
    _priceSubscription = MainConfig.chatSocketConnection.priceStream.listen((Map<String, dynamic> data) {
      final String? symbol = data['symbol'] as String?;
      final double? price = double.tryParse(data['price']?.toString() ?? '');
      if (symbol != null && price != null && price > 0) {
        final String pairSym = _selectedPair?.symbol ?? '';
        if (_isSymbolMatch(symbol, pairSym)) {
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
              if (_entryController.text.isEmpty || _isMarketOrder) {
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

  Future<void> _loadPairs({StateSetter? modalSetState}) async {
    setState(() {
      _isLoadingPairs = true;
      _currencyPairs = <CurrencyPairResponse>[];
      _selectedPair = null;
      _liveSocketPrice = null;
    });
    if (modalSetState != null) {
      modalSetState(() {});
    }

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
        if (modalSetState != null) {
          modalSetState(() {});
        }
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

    final bool isBuy = _selectedTradeType.startsWith('BUY');
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

    final bool isBuy = _selectedTradeType.startsWith('BUY');
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

    final bool isBuy = _selectedTradeType.startsWith('BUY');

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
    final Color subtextColor =
        isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight;

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

        final TextEditingController searchController = TextEditingController();

        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setModalState) {
            final List<CurrencyPairResponse> filtered = _currencyPairs.where((CurrencyPairResponse p) {
              final String cleanQuery = query.trim().toLowerCase();
              if (cleanQuery.isEmpty) return true;
              return p.symbol.toLowerCase().contains(cleanQuery) ||
                     p.baseCurrency.toLowerCase().contains(cleanQuery) ||
                     p.quoteCurrency.toLowerCase().contains(cleanQuery);
            }).toList();

            return Container(
              height: MediaQuery.of(context).size.height * 0.75,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  // Drag handle indicator
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

                  // Market Tabs in Sheet
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: <String>['CRYPTO', 'FOREX', 'COMMODITY', 'STOCK']
                          .map((String m) {
                        final bool isSelected = selectedTabMarket == m;
                        return Padding(
                          padding: const EdgeInsets.only(right: 8),
                          child: InkWell(
                            borderRadius: BorderRadius.circular(20),
                            onTap: () {
                              setModalState(() {
                                selectedTabMarket = m;
                                _selectedMarket = m;
                              });
                              setState(() {});
                              unawaited(_loadPairs(modalSetState: setModalState));
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

                  // Professional Search Bar Input
                  DecoratedBox(
                    decoration: BoxDecoration(
                      color: isDark ? const Color(0xFF1E2430) : const Color(0xFFF2F4F7),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: query.isNotEmpty
                            ? AppColors.primaryPurple
                            : (isDark ? const Color(0xFF2C3240) : Colors.transparent),
                        width: 1.2,
                      ),
                    ),
                    child: TextField(
                      controller: searchController,
                      onChanged: (String val) => setModalState(() => query = val),
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
                          color: query.isNotEmpty ? AppColors.primaryPurple : subtextColor,
                        ),
                        suffixIcon: query.isNotEmpty
                            ? GestureDetector(
                                onTap: () {
                                  setModalState(() {
                                    query = '';
                                    searchController.clear();
                                  });
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

                  // Results Count Bar
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        query.trim().isNotEmpty
                            ? 'Found ${filtered.length} results'
                            : '${filtered.length} pairs available',
                        style: TextStyle(
                          color: query.trim().isNotEmpty ? AppColors.primaryPurple : subtextColor,
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        selectedTabMarket,
                        style: TextStyle(color: subtextColor.withValues(alpha: 0.6), fontSize: 10, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),

                  const SizedBox(height: 6),

                  Expanded(
                    child: _isLoadingPairs
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
                                        'No pairs found for "$query"',
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
                                  final bool isSelected =
                                      _selectedPair?.id == pair.id;
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
                                    ),
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
    final Color textColor = isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight;
    final Color subtextColor = isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight;
    final Color cardBg = isDark ? AppColors.surfaceDark : Colors.white;

    final String title = _tradeTypeLabels[_selectedTradeType] ?? 'Trade Type';
    String description = '';

    switch (_selectedTradeType) {
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
            key: _formKey,
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
                      value: _selectedMarket,
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
                if (_selectedPair != null) ...<Widget>[
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
                                _getPriceSource(_selectedMarket),
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
                  const SizedBox(height: 18),
                ],

                // 4. Trade Type & Entry 1
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    // Trade Type Dropdown with (i) info icon
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              _buildFieldLabel('Trade Type *', textColor),
                              const SizedBox(width: 4),
                              InkWell(
                                onTap: _showOrderTypeInfo,
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
                                value: _selectedTradeType,
                                isExpanded: true,
                                dropdownColor: cardBg,
                                style: TextStyle(color: textColor, fontSize: 13, fontWeight: FontWeight.bold),
                                icon: Icon(Icons.keyboard_arrow_down_rounded, color: subtextColor, size: 20),
                                items: _tradeTypeLabels.entries.map((MapEntry<String, String> entry) {
                                  return DropdownMenuItem<String>(
                                    value: entry.key,
                                    child: Text(entry.value),
                                  );
                                }).toList(),
                                onChanged: (String? val) {
                                  if (val != null) {
                                    setState(() {
                                      _selectedTradeType = val;
                                      if (val.contains('MARKET')) {
                                        _entryController.text = livePriceStr;
                                      }
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

                    // Entry 1 Input
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          _buildFieldLabel('Entry 1 *', textColor),
                          const SizedBox(height: 6),
                          TextFormField(
                            controller: _entryController,
                            readOnly: _isMarketOrder,
                            keyboardType: const TextInputType.numberWithOptions(decimal: true),
                            style: TextStyle(
                              color: _isMarketOrder ? subtextColor : textColor,
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                            decoration: _inputDecoration(
                              _isMarketOrder ? borderColor.withValues(alpha: 0.2) : fieldBg,
                              borderColor,
                              subtextColor,
                              hintText: livePriceStr,
                            ),
                            validator: (String? val) {
                              if (_isMarketOrder) return null;
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
                              Expanded(child: _buildFieldLabel('Stop Loss *', textColor)),
                              const SizedBox(width: 4),
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
                            decoration: _inputDecoration(fieldBg, borderColor, subtextColor, hintText: _isSlInPips ? 'Pips (e.g. 50)' : 'Price'),
                            validator: (String? val) {
                              if (val == null || val.trim().isEmpty) return 'Required';
                              if (double.tryParse(val.trim()) == null) return 'Invalid';
                              return null;
                            },
                          ),
                          const SizedBox(height: 4),
                          Text(
                            _isSlInPips
                                ? '≈ ${_slController.text.isNotEmpty ? _slController.text : '--'} Pips'
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
                            decoration: _inputDecoration(fieldBg, borderColor, subtextColor, hintText: _isTp1InPips ? 'Pips (e.g. 100)' : 'Price'),
                            validator: (String? val) {
                              if (val == null || val.trim().isEmpty) return 'Required';
                              if (double.tryParse(val.trim()) == null) return 'Invalid';
                              return null;
                            },
                          ),
                          const SizedBox(height: 4),
                          Text(
                            _isTp1InPips
                                ? '≈ ${_tp1Controller.text.isNotEmpty ? _tp1Controller.text : '--'} Pips'
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
                            controller: _tp2Controller,
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
                            controller: _tp3Controller,
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

                // Validation Warning Box (if SL/TP invalid)
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
                  controller: _tradingViewUrlController,
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
                  controller: _commentController,
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
}
