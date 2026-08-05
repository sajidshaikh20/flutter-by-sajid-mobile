// This class holds static utility and UI helper functions for trade creation.
// ignore_for_file: avoid_classes_with_only_static_members
import '../../../../../utils/exports.dart';

class AddTradeUiHelpers {
  static String getPriceSource(String market) {
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

  static String getRrLabel(double rr) {
    if (rr < 1.0) return 'BAD';
    if (rr < 1.5) return 'RISKY';
    if (rr < 2.0) return 'AVERAGE';
    if (rr < 3.0) return 'GOOD';
    return 'EXCELLENT';
  }

  static Color getRrColor(double rr) {
    if (rr < 1.0) return AppColors.errorColor;
    if (rr < 1.5) return Colors.orange;
    if (rr < 2.0) return Colors.amber;
    if (rr < 3.0) return Colors.lightGreen;
    return AppColors.successColor;
  }

  static Widget buildFieldLabel(String text, Color color) {
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

  static InputDecoration inputDecoration(
    Color fill,
    Color border,
    Color subtextColor, {
    required String hintText,
  }) {
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

class AddTradeModeToggle extends StatelessWidget {
  final bool isPips;
  final ValueChanged<bool> onToggle;
  final Color borderColor;
  final Color textColor;

  const AddTradeModeToggle({
    super.key,
    required this.isPips,
    required this.onToggle,
    required this.borderColor,
    required this.textColor,
  });

  @override
  Widget build(BuildContext context) {
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
}
