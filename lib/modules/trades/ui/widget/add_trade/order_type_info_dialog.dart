import '../../../../../utils/exports.dart';

class OrderTypeInfoDialog extends StatelessWidget {
  final String selectedTradeType;

  const OrderTypeInfoDialog({
    super.key,
    required this.selectedTradeType,
  });

  static Future<void> show(
    BuildContext context, {
    required String selectedTradeType,
  }) async {
    final bool isDark = context.isDark;
    final Color cardBg = isDark ? AppColors.surfaceDark : Colors.white;

    return showDialog<void>(
      context: context,
      builder: (BuildContext ctx) => AlertDialog(
        backgroundColor: cardBg,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        content: OrderTypeInfoDialog(
          selectedTradeType: selectedTradeType,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final bool isDark = context.isDark;
    final Color textColor = isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight;
    final Color subtextColor = isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight;

    final String title = AppConstant.tradeTypeLabels[selectedTradeType] ?? 'Trade Type';
    String description = '';

    switch (selectedTradeType) {
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

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
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
        const SizedBox(height: 12),
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
        const SizedBox(height: 14),
        Align(
          alignment: Alignment.centerRight,
          child: TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Got it', style: TextStyle(fontWeight: FontWeight.bold)),
          ),
        ),
      ],
    );
  }
}
