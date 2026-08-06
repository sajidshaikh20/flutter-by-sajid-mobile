import '../../../../../utils/exports.dart';

class EntryPriceField extends StatelessWidget {
  const EntryPriceField({super.key});

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
          prev.selectedTradeType != curr.selectedTradeType ||
          prev.liveSocketPrice != curr.liveSocketPrice ||
          prev.selectedPair != curr.selectedPair,
      builder: (BuildContext context, AddTradeState state) {
        final String livePriceStr = cubit.getLivePrice() > 0
            ? cubit.getLivePrice().toStringAsFixed(cubit.getPricePrecision())
            : '--';

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            AddTradeUiHelpers.buildFieldLabel('Entry 1 *', textColor),
            const SizedBox(height: 6),
            TextFormField(
              controller: state.entryController,
              readOnly: state.isMarketOrder,
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              style: TextStyle(
                color: state.isMarketOrder ? subtextColor : textColor,
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
              decoration: AddTradeUiHelpers.inputDecoration(
                state.isMarketOrder ? borderColor.withValues(alpha: 0.2) : fieldBg,
                borderColor,
                subtextColor,
                hintText: livePriceStr,
              ),
              validator: (String? val) {
                if (state.isMarketOrder) return null;
                if (val == null || val.trim().isEmpty) return 'Required';
                if (double.tryParse(val.trim()) == null) return 'Invalid price';
                return null;
              },
            ),
          ],
        );
      },
    );
  }
}
