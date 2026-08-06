import '../../../../../utils/exports.dart';

class TakeProfit1Field extends StatelessWidget {
  const TakeProfit1Field({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isDark = context.isDark;

    final Color fieldBg = isDark
        ? AppColors.cardDark
        : AppColors.whiteSmokeShade;

    final Color borderColor = isDark
        ? AppColors.borderDark
        : AppColors.borderLight;

    final Color textColor = isDark
        ? AppColors.textPrimaryDark
        : AppColors.textPrimaryLight;

    final Color subtextColor = isDark
        ? AppColors.textSecondaryDark
        : AppColors.textSecondaryLight;

    final AddTradeCubit cubit = context.read<AddTradeCubit>();

    return BlocBuilder<AddTradeCubit, AddTradeState>(
      builder: (BuildContext context, AddTradeState state) {
        final double entryPrice = cubit.getCalculatedEntry();

        final double? tp1Price = cubit.getEffectiveTP1(entryPrice);

        final double tp1Pips = tp1Price != null
            ? cubit.priceToPips(tp1Price, entryPrice)
            : 0.0;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child: AddTradeUiHelpers.buildFieldLabel(
                    'Take Profit 1 *',
                    textColor,
                  ),
                ),

                const SizedBox(width: 8),

                AddTradeModeToggle(
                  isPips: state.isTp1InPips,
                  onToggle: (bool val) {
                    cubit.toggleTp1InPips();
                  },
                  borderColor: borderColor,
                  textColor: textColor,
                ),
              ],
            ),

            const SizedBox(height: 6),

            TextFormField(
              controller: state.tp1Controller,
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
              style: TextStyle(
                color: textColor,
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
              decoration: AddTradeUiHelpers.inputDecoration(
                fieldBg,
                borderColor,
                subtextColor,
                hintText: state.isTp1InPips
                    ? 'Pips (e.g. 100)'
                    : 'Price',
              ),
              validator: (String? val) {
                if (val == null || val.trim().isEmpty) {
                  return 'Required';
                }

                if (double.tryParse(val.trim()) == null) {
                  return 'Invalid';
                }

                return null;
              },
            ),

            const SizedBox(height: 4),

            Text(
              state.isTp1InPips
                  ? '≈ ${state.tp1Controller.text.isNotEmpty ? state.tp1Controller.text : '--'} Pips'
                  : '≈ ${tp1Pips > 0 ? tp1Pips.toStringAsFixed(1) : '--'} Pips',
              style: TextStyle(
                color: subtextColor,
                fontSize: 11,
              ),
            ),
          ],
        );
      },
    );
  }
}

class TakeProfit2And3Fields extends StatelessWidget {
  const TakeProfit2And3Fields({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isDark = context.isDark;

    final Color fieldBg = isDark
        ? AppColors.cardDark
        : AppColors.whiteSmokeShade;

    final Color borderColor = isDark
        ? AppColors.borderDark
        : AppColors.borderLight;

    final Color textColor = isDark
        ? AppColors.textPrimaryDark
        : AppColors.textPrimaryLight;

    final Color subtextColor = isDark
        ? AppColors.textSecondaryDark
        : AppColors.textSecondaryLight;

    return BlocBuilder<AddTradeCubit, AddTradeState>(
      builder: (BuildContext context, AddTradeState state) {
        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // --------------------------------------------------------
            // TAKE PROFIT 2
            // --------------------------------------------------------
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  AddTradeUiHelpers.buildFieldLabel(
                    'Take Profit 2',
                    textColor,
                  ),

                  const SizedBox(height: 6),

                  TextFormField(
                    controller: state.tp2Controller,
                    keyboardType: const TextInputType.numberWithOptions(
                      decimal: true,
                    ),
                    style: TextStyle(
                      color: textColor,
                      fontSize: 14,
                    ),
                    decoration: AddTradeUiHelpers.inputDecoration(
                      fieldBg,
                      borderColor,
                      subtextColor,
                      hintText: 'Optional',
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(width: 16),

            // --------------------------------------------------------
            // TAKE PROFIT 3
            // --------------------------------------------------------
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  AddTradeUiHelpers.buildFieldLabel(
                    'Take Profit 3',
                    textColor,
                  ),

                  const SizedBox(height: 6),

                  TextFormField(
                    controller: state.tp3Controller,
                    keyboardType: const TextInputType.numberWithOptions(
                      decimal: true,
                    ),
                    style: TextStyle(
                      color: textColor,
                      fontSize: 14,
                    ),
                    decoration: AddTradeUiHelpers.inputDecoration(
                      fieldBg,
                      borderColor,
                      subtextColor,
                      hintText: 'Optional',
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