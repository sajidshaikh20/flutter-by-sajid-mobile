import '../../../../../utils/exports.dart';

class ValidationWarningBox extends StatelessWidget {
  const ValidationWarningBox({super.key});

  @override
  Widget build(BuildContext context) {
    final AddTradeCubit cubit = context.read<AddTradeCubit>();

    return BlocBuilder<AddTradeCubit, AddTradeState>(
      builder: (BuildContext context, AddTradeState state) {
        final Map<String, dynamic>? rrCalculation = cubit.calculateTradeRR();
        final String validationMsg = (rrCalculation != null && rrCalculation['valid'] == false)
            ? (rrCalculation['reason'] as String? ?? '')
            : '';

        if (validationMsg.isEmpty) {
          return const SizedBox.shrink();
        }

        return Column(
          children: <Widget>[
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
        );
      },
    );
  }
}
