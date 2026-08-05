import '../../../../../utils/exports.dart';

class RiskRewardRatioCard extends StatelessWidget {
  const RiskRewardRatioCard({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isDark = context.isDark;
    final Color textColor = isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight;

    final AddTradeCubit cubit = context.read<AddTradeCubit>();

    return BlocBuilder<AddTradeCubit, AddTradeState>(
      builder: (BuildContext context, AddTradeState state) {
        final Map<String, dynamic>? rrCalculation = cubit.calculateTradeRR();
        final bool isRrValid = rrCalculation != null && rrCalculation['valid'] == true;
        final double rrVal = isRrValid ? (rrCalculation['rr'] as double) : 0.0;
        final String rrLabel = isRrValid ? AddTradeUiHelpers.getRrLabel(rrVal) : 'AUTO CALCULATED';
        final Color rrColor = isRrValid ? AddTradeUiHelpers.getRrColor(rrVal) : AppColors.successColor;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            AddTradeUiHelpers.buildFieldLabel('Risk Reward Ratio TP1', textColor),
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
          ],
        );
      },
    );
  }
}
