import '../../../../../utils/exports.dart';

class MarketTypeDropdown extends StatelessWidget {
  const MarketTypeDropdown({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isDark = context.isDark;
    final Color cardBg = isDark ? AppColors.surfaceDark : AppColors.surfaceLight;
    final Color fieldBg = isDark ? AppColors.cardDark : AppColors.whiteSmokeShade;
    final Color borderColor = isDark ? AppColors.borderDark : AppColors.borderLight;
    final Color textColor = isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight;
    final Color subtextColor = isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight;

    final AddTradeCubit cubit = context.read<AddTradeCubit>();

    return BlocBuilder<AddTradeCubit, AddTradeState>(
      buildWhen: (AddTradeState prev, AddTradeState curr) => prev.selectedMarket != curr.selectedMarket,
      builder: (BuildContext context, AddTradeState state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            AddTradeUiHelpers.buildFieldLabel('Market Type *', textColor),
            const SizedBox(height: 6),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 14),
              decoration: BoxDecoration(
                color: fieldBg,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: borderColor),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: state.selectedMarket,
                  isExpanded: true,
                  dropdownColor: cardBg,
                  style: TextStyle(color: textColor, fontSize: 14, fontWeight: FontWeight.bold),
                  icon: Icon(Icons.keyboard_arrow_down_rounded, color: subtextColor),
                  items: <String>['CRYPTO', 'FOREX', 'COMMODITY', 'STOCK'].map((String m) {
                    return DropdownMenuItem<String>(
                      value: m,
                      child: Text(m),
                    );
                  }).toList(),
                  onChanged: (String? val) {
                    if (val != null) {
                      cubit.updateMarket(val);
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
