import '../../../../../utils/exports.dart';

class StopLossField extends StatelessWidget {
  const StopLossField({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isDark = context.isDark;
    final Color fieldBg = isDark ? const Color(0xFF202530) : AppColors.whiteSmokeShade;
    final Color borderColor = isDark ? const Color(0xFF2C3240) : AppColors.borderLight;
    final Color textColor = isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight;
    final Color subtextColor = isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight;

    final AddTradeCubit cubit = context.read<AddTradeCubit>();

    return BlocBuilder<AddTradeCubit, AddTradeState>(
      builder: (BuildContext context, AddTradeState state) {
        final double entryPrice = cubit.getCalculatedEntry();
        final double? slPrice = cubit.getEffectiveSL(entryPrice);
        final double slPips = slPrice != null ? cubit.priceToPips(slPrice, entryPrice) : 0.0;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Expanded(child: AddTradeUiHelpers.buildFieldLabel('Stop Loss *', textColor)),
                const SizedBox(width: 4),
                AddTradeModeToggle(
                  isPips: state.isSlInPips,
                  onToggle: (bool val) => cubit.toggleSlInPips(),
                  borderColor: borderColor,
                  textColor: textColor,
                ),
              ],
            ),
            const SizedBox(height: 6),
            TextFormField(
              controller: state.slController,
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              style: TextStyle(color: textColor, fontSize: 14, fontWeight: FontWeight.bold),
              decoration: AddTradeUiHelpers.inputDecoration(
                fieldBg,
                borderColor,
                subtextColor,
                hintText: state.isSlInPips ? 'Pips (e.g. 50)' : 'Price',
              ),
              validator: (String? val) {
                if (val == null || val.trim().isEmpty) return 'Required';
                if (double.tryParse(val.trim()) == null) return 'Invalid';
                return null;
              },
            ),
            const SizedBox(height: 4),
            Text(
              state.isSlInPips
                  ? '≈ ${state.slController.text.isNotEmpty ? state.slController.text : '--'} Pips'
                  : '≈ ${slPips > 0 ? slPips.toStringAsFixed(1) : '--'} Pips',
              style: TextStyle(color: subtextColor, fontSize: 11),
            ),
          ],
        );
      },
    );
  }
}
