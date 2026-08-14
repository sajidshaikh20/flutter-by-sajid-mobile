import '../../../../utils/exports.dart';

Future<void> showCloseTradeModal(
  BuildContext context,
  TradingSignalModel signal, {
  double? initialLivePrice,
}) {
  return showDialog<void>(
    context: context,
    barrierDismissible: true,
    barrierColor: Colors.black.withValues(alpha: 0.75),
    builder: (BuildContext dialogContext) => CloseTradeModal(
      signal: signal,
      initialLivePrice: initialLivePrice,
      parentContext: context,
    ),
  );
}

class CloseTradeModal extends StatefulWidget {
  const CloseTradeModal({
    super.key,
    required this.signal,
    required this.parentContext,
    this.initialLivePrice,
  });

  final TradingSignalModel signal;
  final BuildContext parentContext;
  final double? initialLivePrice;

  @override
  State<CloseTradeModal> createState() => _CloseTradeModalState();
}

class _CloseTradeModalState extends State<CloseTradeModal> {
  double? _livePrice;
  bool _isLoading = false;
  StreamSubscription<Map<String, dynamic>>? _priceSubscription;

  @override
  void initState() {
    super.initState();
    // 1. Check initial price passed or in signal
    if (widget.initialLivePrice != null && widget.initialLivePrice! > 0) {
      _livePrice = widget.initialLivePrice;
    } else if (widget.signal.livePrice != null && widget.signal.livePrice! > 0) {
      _livePrice = widget.signal.livePrice;
    }

    // 2. Try reading live price from parent TradingOverviewCubit if available
    try {
      final TradingOverviewCubit cubit = widget.parentContext.read<TradingOverviewCubit>();
      if (cubit.state.livePrice > 0) {
        _livePrice ??= cubit.state.livePrice;
      }
    } on Object catch (_) {}

    // 3. Register symbol and listen to live price stream from WebSocket
    unawaited(MainConfig.chatSocketConnection.registerSymbol(widget.signal.pair));
    _priceSubscription = MainConfig.chatSocketConnection.priceStream.listen((Map<String, dynamic> data) {
      final String? symbol = data['symbol'] as String?;
      final double? price = double.tryParse(data['price']?.toString() ?? '');
      if (symbol != null && price != null && price > 0) {
        if (_isSymbolMatch(symbol, widget.signal.pair)) {
          if (mounted) {
            setState(() {
              _livePrice = price;
            });
          }
        }
      }
    });

    // 4. Fetch latest price via REST API fallback if live price is still null/0
    unawaited(_fetchFallbackPrice());
  }

  Future<void> _fetchFallbackPrice() async {
    try {
      final ResponseHandler<BaseResponse<List<CurrencyPairResponse>>> response =
          await TradesRepositoryImpl().getCurrencyPairs(market: widget.signal.category);
      if (response.isSuccess()) {
        final List<CurrencyPairResponse> pairs =
            response.getSuccessInstance()?.response.data ?? <CurrencyPairResponse>[];
        for (final CurrencyPairResponse pair in pairs) {
          if (_isSymbolMatch(pair.symbol, widget.signal.pair) && pair.currentPrice > 0) {
            if (mounted && (_livePrice == null || _livePrice == 0)) {
              setState(() {
                _livePrice = pair.currentPrice;
              });
            }
            break;
          }
        }
      }
    } on Object catch (_) {}
  }

  bool _isSymbolMatch(String wsSymbol, String pairSymbol) {
    if (wsSymbol.isEmpty || pairSymbol.isEmpty) return false;
    final String s1 = wsSymbol.replaceAll(RegExp(r'[^A-Z0-9]'), '').toUpperCase();
    final String s2 = pairSymbol.replaceAll(RegExp(r'[^A-Z0-9]'), '').toUpperCase();
    if (s1 == s2 || s1.startsWith(s2) || s2.startsWith(s1) || s1.contains(s2) || s2.contains(s1)) return true;
    final String baseS1 = s1.replaceAll('USDT', 'USD');
    final String baseS2 = s2.replaceAll('USDT', 'USD');
    return baseS1.startsWith(baseS2) || baseS2.startsWith(baseS1);
  }

  @override
  void dispose() {
    unawaited(_priceSubscription?.cancel());
    super.dispose();
  }

  bool get _isCloseEnabled => _livePrice != null && _livePrice! > 0;

  String _formatPrice(double price) {
    if (price % 1 == 0) {
      return price.toInt().toString();
    }
    if (price > 1000) {
      return price.toStringAsFixed(2);
    }
    return price.toStringAsFixed(4);
  }

  Future<void> _submitCloseTrade() async {
    if (!_isCloseEnabled || _isLoading) return;
    setState(() => _isLoading = true);

    try {
      final TradingOverviewCubit cubit = widget.parentContext.read<TradingOverviewCubit>();
      await cubit.closeTrade(
        exitPrice: _livePrice,
      );
    } on Object catch (_) {
      final ResponseHandler<BaseResponse<dynamic>> response = await TradesRepositoryImpl().closeTrade(
        tradePublicId: widget.signal.publicId,
        exitPrice: _livePrice,
      );

      if (!mounted) return;

      if (response.isSuccess()) {
        displaySnackBar('Trade closed successfully!', context);
      } else {
        final String err = response.getFailureInstance()?.error?.errorMessage ?? 'Failed to close trade.';
        displaySnackBar(err, context);
      }
    }

    if (!mounted) return;
    setState(() => _isLoading = false);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final bool isDark = context.isDark;
    final Color textColor = isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight;
    final Color subtitleColor = isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight;
    final Color themeGreen = isDark ? AppColors.successColor : AppColors.greenTextColor;
    final Color dialogBg = isDark ? const Color(0xFF0F172A) : AppColors.surfaceLight;

    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
      child: Container(
        width: double.infinity,
        constraints: const BoxConstraints(maxWidth: 400),
        decoration: BoxDecoration(
          color: dialogBg,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isDark ? Colors.white.withValues(alpha: 0.1) : AppColors.borderLight,
            width: 1,
          ),
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.4),
              blurRadius: 24,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        padding: const EdgeInsets.all(Dimens.space20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            // Title
            CustomTextLabelWidget(
              label: 'Close Trade',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: textColor,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: Dimens.space6),

            // Subtitle
            CustomTextLabelWidget(
              label: 'Are you sure you want to close this trade?',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: subtitleColor,
                fontSize: Dimens.fontSize13,
              ),
            ),
            const SizedBox(height: Dimens.space20),

            // Live Market Price Box
            Container(
              padding: const EdgeInsets.all(Dimens.space16),
              decoration: BoxDecoration(
                color: isDark ? const Color(0xFF0A131D) : const Color(0xFFF8FAFC),
                borderRadius: BorderRadius.circular(Dimens.radius12),
                border: Border.all(
                  color: isDark ? const Color(0xFF0D4B44) : AppColors.borderLight,
                  width: 1,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  CustomTextLabelWidget(
                    label: 'LIVE MARKET PRICE',
                    style: TextStyle(
                      color: subtitleColor,
                      fontSize: 10,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.8,
                    ),
                  ),
                  const SizedBox(height: Dimens.space8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        widget.signal.pair,
                        style: TextStyle(
                          color: textColor,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      if (_livePrice != null && _livePrice! > 0)
                        Text(
                          _formatPrice(_livePrice!),
                          style: TextStyle(
                            color: themeGreen,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        )
                      else
                        Row(
                          children: <Widget>[
                            SizedBox(
                              width: 14,
                              height: 14,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                color: themeGreen,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Text(
                              '--',
                              style: TextStyle(
                                color: themeGreen,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: Dimens.space20),

            const CustomTextLabelWidget(
              label: 'This action cannot be undone.',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: AppColors.errorColor,
                fontSize: Dimens.fontSize12,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: Dimens.space20),

            // Action Buttons
            Row(
              children: <Widget>[
                Expanded(
                  child: GestureDetector(
                    onTap: _isLoading ? null : () => Navigator.of(context).pop(),
                    child: Container(
                      height: 46,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: isDark ? const Color(0xFF1E293B) : const Color(0xFFE2E8F0),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        'Cancel',
                        style: TextStyle(
                          color: isDark ? Colors.white : Colors.black87,
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: Dimens.space12),
                Expanded(
                  child: GestureDetector(
                    onTap: (_isCloseEnabled && !_isLoading) ? _submitCloseTrade : null,
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      height: 46,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: _isCloseEnabled
                            ? themeGreen
                            : themeGreen.withValues(alpha: 0.4),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: _isLoading
                          ? const SizedBox(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(
                                color: Colors.white,
                                strokeWidth: 2,
                              ),
                            )
                          : Text(
                              'Close Trade',
                              style: TextStyle(
                                color: Colors.white.withValues(alpha: _isCloseEnabled ? 1.0 : 0.6),
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                            ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

