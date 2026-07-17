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

  // Form Fields State
  String _selectedMarket = 'FOREX';
  List<CurrencyPairResponse> _currencyPairs = <CurrencyPairResponse>[];
  CurrencyPairResponse? _selectedPair;
  bool _isLoadingPairs = false;

  String _selectedOrderType = 'BUY_MARKET';
  
  // Entry Mode: 'PRICE' or 'PIPS'
  String _entryMode = 'PRICE';
  String _slMode = 'PRICE';
  String _tp1Mode = 'PRICE';
  String _tp2Mode = 'PRICE';
  String _tp3Mode = 'PRICE';

  final TextEditingController _entryController = TextEditingController();
  final TextEditingController _slController = TextEditingController();
  final TextEditingController _tp1Controller = TextEditingController();
  final TextEditingController _tp2Controller = TextEditingController();
  final TextEditingController _tp3Controller = TextEditingController();
  final TextEditingController _tradingViewUrlController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();

  bool _isSubmitting = false;

  @override
  void initState() {
    super.initState();
    unawaited(_loadPairs());
    _entryController.addListener(_onCalculationsChanged);
    _slController.addListener(_onCalculationsChanged);
    _tp1Controller.addListener(_onCalculationsChanged);
  }

  @override
  void dispose() {
    _entryController.dispose();
    _slController.dispose();
    _tp1Controller.dispose();
    _tp2Controller.dispose();
    _tp3Controller.dispose();
    _tradingViewUrlController.dispose();
    _noteController.dispose();
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
      final ResponseHandler<BaseResponse<List<CurrencyPairResponse>>> response =
          await _repository.getCurrencyPairs(market: _selectedMarket);
      if (response.isSuccess() && response.getSuccessInstance()?.response.data != null) {
        setState(() {
          _currencyPairs = response.getSuccessInstance()!.response.data!;
          if (_currencyPairs.isNotEmpty) {
            _selectedPair = _currencyPairs.first;
            _updateEntryForMarketOrder();
          }
        });
      }
    } on Object catch (e) {
      debugPrint('Failed to load currency pairs: $e');
    } finally {
      setState(() {
        _isLoadingPairs = false;
      });
    }
  }

  void _updateEntryForMarketOrder() {
    if (_selectedOrderType.contains('MARKET') && _selectedPair != null) {
      _entryController.text = _selectedPair!.currentPrice.toString();
    }
  }

  double _getPipSize() {
    if (_selectedPair != null && _selectedPair!.pipValue != null && _selectedPair!.pipValue! > 0) {
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
    return double.parse(((price - reference).abs() / pipSize).toStringAsFixed(2));
  }

  double _pipsToPrice(double pips, double reference, bool isAbove) {
    final double pipSize = _getPipSize();
    final double diff = pips * pipSize;
    final double value = isAbove ? (reference + diff) : (reference - diff);
    return double.parse(value.toStringAsFixed(_getPricePrecision()));
  }

  // Calculate actual numeric values based on modes
  double? _getCalculatedEntry() {
    final double? entry = double.tryParse(_entryController.text);
    if (entry == null) return null;
    
    if (_selectedOrderType.contains('MARKET')) {
      return _selectedPair?.currentPrice;
    }

    if (_entryMode == 'PIPS') {
      final double? live = _selectedPair?.currentPrice;
      if (live == null) return null;
      final bool isAbove = _selectedOrderType == 'BUY_LIMIT' || _selectedOrderType == 'SELL_STOP';
      return _pipsToPrice(entry, live, isAbove);
    }
    return entry;
  }

  double? _getCalculatedSL(double entry) {
    final double? sl = double.tryParse(_slController.text);
    if (sl == null) return null;

    if (_slMode == 'PIPS') {
      final bool isBuy = _selectedOrderType.startsWith('BUY');
      return _pipsToPrice(sl, entry, !isBuy);
    }
    return sl;
  }

  double? _getCalculatedTP(String text, String mode, double entry) {
    final double? tp = double.tryParse(text);
    if (tp == null || tp == 0) return null;

    if (mode == 'PIPS') {
      final bool isBuy = _selectedOrderType.startsWith('BUY');
      return _pipsToPrice(tp, entry, isBuy);
    }
    return tp;
  }

  Map<String, dynamic>? _calculateTradeRR() {
    final double? entry = _getCalculatedEntry();
    if (entry == null) return null;

    final double? sl = _getCalculatedSL(entry);
    final double? tp = _getCalculatedTP(_tp1Controller.text, _tp1Mode, entry);

    if (sl == null || tp == null) return null;

    final bool isBuy = _selectedOrderType.startsWith('BUY');

    if (isBuy) {
      if (sl >= entry) {
        return <String, dynamic>{'valid': false, 'reason': 'SL must be below entry', 'rr': 0.0};
      }
      if (tp <= entry) {
        return <String, dynamic>{'valid': false, 'reason': 'TP must be above entry', 'rr': 0.0};
      }
    } else {
      if (sl <= entry) {
        return <String, dynamic>{'valid': false, 'reason': 'SL must be above entry', 'rr': 0.0};
      }
      if (tp >= entry) {
        return <String, dynamic>{'valid': false, 'reason': 'TP must be below entry', 'rr': 0.0};
      }
    }

    final double risk = (entry - sl).abs();
    final double reward = (tp - entry).abs();

    if (risk == 0) {
      return <String, dynamic>{'valid': false, 'reason': 'Risk cannot be zero', 'rr': 0.0};
    }

    final double rr = double.parse((reward / risk).toStringAsFixed(2));
    return <String, dynamic>{'valid': true, 'reason': '', 'rr': rr};
  }

  String _getRrLabel(double rr) {
    if (rr < 1) return 'Bad';
    if (rr < 1.5) return 'Risky';
    if (rr < 2.0) return 'Average';
    if (rr < 3.0) return 'Good';
    return 'Excellent';
  }

  Color _getRrColor(double rr) {
    if (rr < 1) return Colors.red;
    if (rr < 1.5) return Colors.orange;
    if (rr < 2.0) return Colors.amber;
    if (rr < 3.0) return Colors.blue;
    return Colors.green;
  }

  Future<void> _submitTrade() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final Map<String, dynamic>? calculation = _calculateTradeRR();
    if (calculation == null || calculation['valid'] == false) {
      context.scaffoldMessenger.showSnackBar(
        SnackBar(
          content: Text((calculation?['reason'] as String?) ?? 'Invalid Risk-Reward calculations'),
          backgroundColor: AppColors.errorColor,
        ),
      );
      return;
    }

    setState(() {
      _isSubmitting = true;
    });

    try {
      final double entry = _getCalculatedEntry()!;
      final double sl = _getCalculatedSL(entry)!;
      final double tp1 = _getCalculatedTP(_tp1Controller.text, _tp1Mode, entry)!;

      final double livePrice = _selectedPair?.currentPrice ?? entry;
      final double entryPips = _priceToPips(entry, livePrice);
      final double slPips = _priceToPips(sl, entry);
      final double tp1Pips = _priceToPips(tp1, entry);

      final List<Map<String, dynamic>> levels = <Map<String, dynamic>>[
        <String, dynamic>{
          'levelType': 'ENTRY',
          'entryPoint': entry,
          'stopLoss': sl,
          'takeProfit': tp1,
          'level': 0,
          'entryPips': entryPips,
          'slPips': slPips,
          'tpPips': tp1Pips,
        }
      ];

      final double? tp2 = _getCalculatedTP(_tp2Controller.text, _tp2Mode, entry);
      if (tp2 != null) {
        levels.add(<String, dynamic>{
          'levelType': 'TAKE_PROFIT',
          'takeProfit': tp2,
          'level': 2,
          'tpPips': _priceToPips(tp2, entry),
        });
      }

      final double? tp3 = _getCalculatedTP(_tp3Controller.text, _tp3Mode, entry);
      if (tp3 != null) {
        levels.add(<String, dynamic>{
          'levelType': 'TAKE_PROFIT',
          'takeProfit': tp3,
          'level': 3,
          'tpPips': _priceToPips(tp3, entry),
        });
      }

      final Map<String, dynamic> payload = <String, dynamic>{
        'market': _selectedMarket,
        'marketType': _selectedOrderType,
        'currencyPairSymbol': _selectedPair?.symbol ?? '',
        'currencyPairId': _selectedPair?.id ?? 0,
        'riskRewardRatio': calculation['rr'].toString(),
        'tradingViewUrl': _tradingViewUrlController.text,
        'note': _noteController.text,
        'slPips': slPips,
        'tpPips': tp1Pips,
        'levels': levels,
      };

      final ResponseHandler<BaseResponse<dynamic>> response = await _repository.createTrade(payload);
      if (response.isSuccess()) {
        if (mounted) {
          context.scaffoldMessenger.showSnackBar(
            const SnackBar(
              content: Text('Trade signal created successfully!'),
              backgroundColor: Colors.green,
            ),
          );
          unawaited(context.router.maybePop());
        }
      } else {
        if (mounted) {
          final String errMsg = response.getFailureInstance()?.error?.errorMessage ?? 'Failed to create trade';
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

  @override
  Widget build(BuildContext context) {
    final bool isDark = context.isDark;
    final Color pageBg = isDark ? AppColors.backgroundDark : AppColors.backgroundLight;
    final Color cardBg = isDark ? AppColors.surfaceDark : AppColors.surfaceLight;
    final Color textColor = isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight;

    final Map<String, dynamic>? calculation = _calculateTradeRR();
    final bool isRRValid = calculation != null && calculation['valid'] == true;
    final double rrValue = isRRValid ? (calculation['rr'] as double) : 0.0;

    return Scaffold(
      backgroundColor: pageBg,
      appBar: AppBar(
        title: const Text('Add Trade Signal'),
        backgroundColor: cardBg,
        elevation: 0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(Dimens.space16),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                // Markets Selector
                Card(
                  color: cardBg,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(Dimens.radius12)),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: Dimens.space16, vertical: Dimens.space8),
                    child: DropdownButtonFormField<String>(
                      initialValue: _selectedMarket,
                      decoration: const InputDecoration(
                        labelText: 'Select Market',
                        border: InputBorder.none,
                      ),
                      dropdownColor: cardBg,
                      items: <String>['FOREX', 'CRYPTO', 'COMMODITY', 'STOCK'].map((String market) {
                        return DropdownMenuItem<String>(
                          value: market,
                          child: Text(market, style: TextStyle(color: textColor)),
                        );
                      }).toList(),
                      onChanged: (String? val) {
                        if (val != null) {
                          setState(() {
                            _selectedMarket = val;
                            unawaited(_loadPairs());
                          });
                        }
                      },
                    ),
                  ),
                ),
                const SizedBox(height: Dimens.space16),

                // Currency Pairs Selector
                Card(
                  color: cardBg,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(Dimens.radius12)),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: Dimens.space16, vertical: Dimens.space8),
                    child: _isLoadingPairs
                        ? const Center(child: Padding(padding: EdgeInsets.all(8.0), child: CircularProgressIndicator()))
                        : DropdownButtonFormField<CurrencyPairResponse>(
                            initialValue: _selectedPair,
                            decoration: const InputDecoration(
                              labelText: 'Select Currency Pair',
                              border: InputBorder.none,
                            ),
                            dropdownColor: cardBg,
                            items: _currencyPairs.map((CurrencyPairResponse pair) {
                              return DropdownMenuItem<CurrencyPairResponse>(
                                value: pair,
                                child: Text('${pair.symbol} (${pair.currentPrice})', style: TextStyle(color: textColor)),
                              );
                            }).toList(),
                            onChanged: (CurrencyPairResponse? val) {
                              if (val != null) {
                                setState(() {
                                  _selectedPair = val;
                                  _updateEntryForMarketOrder();
                                });
                              }
                            },
                            validator: (CurrencyPairResponse? val) => val == null ? 'Please select a currency pair' : null,
                          ),
                  ),
                ),
                const SizedBox(height: Dimens.space16),

                // Order Type Selector
                Card(
                  color: cardBg,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(Dimens.radius12)),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: Dimens.space16, vertical: Dimens.space8),
                    child: DropdownButtonFormField<String>(
                      initialValue: _selectedOrderType,
                      decoration: const InputDecoration(
                        labelText: 'Order Type',
                        border: InputBorder.none,
                      ),
                      dropdownColor: cardBg,
                      items: <String>[
                        'BUY_MARKET',
                        'SELL_MARKET',
                        'BUY_LIMIT',
                        'SELL_LIMIT',
                        'BUY_STOP',
                        'SELL_STOP'
                      ].map((String type) {
                        return DropdownMenuItem<String>(
                          value: type,
                          child: Text(type.replaceAll('_', ' '), style: TextStyle(color: textColor)),
                        );
                      }).toList(),
                      onChanged: (String? val) {
                        if (val != null) {
                          setState(() {
                            _selectedOrderType = val;
                            _updateEntryForMarketOrder();
                          });
                        }
                      },
                    ),
                  ),
                ),
                const SizedBox(height: Dimens.space24),

                // Live calculations banner
                if (calculation != null)
                  Container(
                    margin: const EdgeInsets.only(bottom: Dimens.space16),
                    padding: const EdgeInsets.all(Dimens.space12),
                    decoration: BoxDecoration(
                      color: calculation['valid'] == true
                          ? _getRrColor(rrValue).withValues(alpha: 0.1)
                          : Colors.red.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(Dimens.radius8),
                      border: Border.all(
                        color: calculation['valid'] == true ? _getRrColor(rrValue) : Colors.red,
                      ),

                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Expanded(
                          child: Text(
                            calculation['valid'] == true
                                ? 'R:R Ratio: ${rrValue.toStringAsFixed(2)} (${_getRrLabel(rrValue)})'
                                : 'Error: ${calculation['reason']}',
                            style: TextStyle(
                              color: calculation['valid'] == true ? _getRrColor(rrValue) : Colors.red,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                // Form Inputs Card
                Card(
                  color: cardBg,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(Dimens.radius12)),
                  child: Padding(
                    padding: const EdgeInsets.all(Dimens.space16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        // Entry Price Input
                        _buildInputField(
                          labelText: 'Entry Price',
                          controller: _entryController,
                          mode: _entryMode,
                          onModeChanged: _selectedOrderType.contains('MARKET')
                              ? null
                              : (String mode) => setState(() => _entryMode = mode),
                          enabled: !_selectedOrderType.contains('MARKET'),
                          validator: (String? val) {
                            if (val == null || val.isEmpty) return 'Required';
                            if (double.tryParse(val) == null) return 'Must be a number';
                            return null;
                          },
                        ),
                        const SizedBox(height: Dimens.space16),

                        // Stop Loss Input
                        _buildInputField(
                          labelText: 'Stop Loss',
                          controller: _slController,
                          mode: _slMode,
                          onModeChanged: (String mode) => setState(() => _slMode = mode),
                          validator: (String? val) {
                            if (val == null || val.isEmpty) return 'Required';
                            if (double.tryParse(val) == null) return 'Must be a number';
                            return null;
                          },
                        ),
                        const SizedBox(height: Dimens.space16),

                        // Take Profit 1 Input
                        _buildInputField(
                          labelText: 'Take Profit 1',
                          controller: _tp1Controller,
                          mode: _tp1Mode,
                          onModeChanged: (String mode) => setState(() => _tp1Mode = mode),
                          validator: (String? val) {
                            if (val == null || val.isEmpty) return 'Required';
                            if (double.tryParse(val) == null) return 'Must be a number';
                            return null;
                          },
                        ),
                        const SizedBox(height: Dimens.space16),

                        // Take Profit 2 Input (Optional)
                        _buildInputField(
                          labelText: 'Take Profit 2 (Optional)',
                          controller: _tp2Controller,
                          mode: _tp2Mode,
                          onModeChanged: (String mode) => setState(() => _tp2Mode = mode),
                        ),
                        const SizedBox(height: Dimens.space16),

                        // Take Profit 3 Input (Optional)
                        _buildInputField(
                          labelText: 'Take Profit 3 (Optional)',
                          controller: _tp3Controller,
                          mode: _tp3Mode,
                          onModeChanged: (String mode) => setState(() => _tp3Mode = mode),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: Dimens.space16),

                // TradingView URL and Note Inputs
                Card(
                  color: cardBg,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(Dimens.radius12)),
                  child: Padding(
                    padding: const EdgeInsets.all(Dimens.space16),
                    child: Column(
                      children: <Widget>[
                        TextFormField(
                          controller: _tradingViewUrlController,
                          style: TextStyle(color: textColor),
                          decoration: const InputDecoration(
                            labelText: 'TradingView URL',
                            hintText: 'https://tradingview.com/...',
                            border: OutlineInputBorder(),
                          ),
                          validator: (String? val) {
                            if (val == null || val.isEmpty) return 'Required';
                            if (!val.contains('tradingview.com')) {
                              return 'Must be a valid TradingView link';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: Dimens.space16),
                        TextFormField(
                          controller: _noteController,
                          maxLines: 3,
                          style: TextStyle(color: textColor),
                          decoration: const InputDecoration(
                            labelText: 'Analysis / Notes',
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: Dimens.space24),

                // Submit Button
                SizedBox(
                  width: double.infinity,
                  height: Dimens.size50,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryPurple,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(Dimens.radius12)),
                    ),
                    onPressed: _isSubmitting ? null : () => unawaited(_submitTrade()),
                    child: _isSubmitting
                        ? const CircularProgressIndicator(color: Colors.white)
                        : const Text(
                            'Submit Trade Signal',
                            style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInputField({
    required String labelText,
    required TextEditingController controller,
    required String mode,
    ValueChanged<String>? onModeChanged,
    bool enabled = true,
    FormFieldValidator<String>? validator,
  }) {
    final bool isDark = context.isDark;
    final Color textColor = isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Expanded(
          child: TextFormField(
            controller: controller,
            enabled: enabled,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            style: TextStyle(color: textColor),
            decoration: InputDecoration(
              labelText: labelText,
              border: const OutlineInputBorder(),
              contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            ),
            validator: validator,
          ),
        ),
        if (onModeChanged != null) ...<Widget>[
          const SizedBox(width: Dimens.space8),

          Container(
            height: 48,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade400),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Row(
              children: <Widget>[
                _buildModeTab('PRICE', mode == 'PRICE', onModeChanged),
                _buildModeTab('PIPS', mode == 'PIPS', onModeChanged),
              ],
            ),
          ),
        ]
      ],
    );
  }

  Widget _buildModeTab(String label, bool isSelected, ValueChanged<String> onTap) {
    return GestureDetector(
      onTap: () => onTap(label),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        alignment: Alignment.center,
        color: isSelected ? AppColors.primaryPurple : Colors.transparent,
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.grey,
            fontWeight: FontWeight.bold,
            fontSize: 12,
          ),
        ),
      ),
    );
  }
}
