import '../../../../../utils/exports.dart';

class TradeTypeDropdown extends StatelessWidget {
  const TradeTypeDropdown({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isDark = context.isDark;
    final Color cardBg = isDark ? const Color(0xFF181C24) : AppColors.surfaceLight;
    final Color fieldBg = isDark ? const Color(0xFF202530) : AppColors.whiteSmokeShade;
    final Color borderColor = isDark ? const Color(0xFF2C3240) : AppColors.borderLight;
    final Color textColor = isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight;
    final Color subtextColor = isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight;

    final AddTradeCubit cubit = context.read<AddTradeCubit>();

    return BlocBuilder<AddTradeCubit, AddTradeState>(
      buildWhen: (AddTradeState prev, AddTradeState curr) =>
          prev.selectedTradeType != curr.selectedTradeType,
      builder: (BuildContext context, AddTradeState state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                AddTradeUiHelpers.buildFieldLabel('Trade Type *', textColor),
                const SizedBox(width: 4),
                InkWell(
                  onTap: () => unawaited(OrderTypeInfoDialog.show(
                    context,
                    selectedTradeType: state.selectedTradeType,
                  )),
                  child: const Icon(Icons.info_outline_rounded, size: 16, color: AppColors.primaryPurple),
                ),
              ],
            ),
            const SizedBox(height: 6),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                color: fieldBg,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: borderColor),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: state.selectedTradeType,
                  isExpanded: true,
                  dropdownColor: cardBg,
                  style: TextStyle(color: textColor, fontSize: 13, fontWeight: FontWeight.bold),
                  icon: Icon(Icons.keyboard_arrow_down_rounded, color: subtextColor, size: 20),
                  items: AppConstant.tradeTypeLabels.entries.map((MapEntry<String, String> entry) {
                    return DropdownMenuItem<String>(
                      value: entry.key,
                      child: Text(entry.value),
                    );
                  }).toList(),
                  onChanged: (String? val) {
                    if (val != null) {
                      cubit.updateTradeType(val);
                    }
                  },
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
