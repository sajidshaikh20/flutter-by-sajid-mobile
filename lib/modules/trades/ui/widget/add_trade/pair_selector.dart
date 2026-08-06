import '../../../../../utils/exports.dart';

class PairSelector extends StatelessWidget {
  const PairSelector({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isDark = context.isDark;
    final Color fieldBg = isDark ? AppColors.cardDark : AppColors.whiteSmokeShade;
    final Color borderColor = isDark ? AppColors.borderDark : AppColors.borderLight;
    final Color textColor = isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight;
    final Color subtextColor = isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight;

    final AddTradeCubit cubit = context.read<AddTradeCubit>();

    return BlocBuilder<AddTradeCubit, AddTradeState>(
      buildWhen: (AddTradeState prev, AddTradeState curr) =>
          prev.selectedPair != curr.selectedPair ||
          prev.isLoadingPairs != curr.isLoadingPairs,
      builder: (BuildContext context, AddTradeState state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            AddTradeUiHelpers.buildFieldLabel('Currency Pair', textColor),
            const SizedBox(height: 6),
            InkWell(
              onTap: () => unawaited(PairSelectionSheet.show(context, cubit, state)),
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
          ],
        );
      },
    );
  }
}
