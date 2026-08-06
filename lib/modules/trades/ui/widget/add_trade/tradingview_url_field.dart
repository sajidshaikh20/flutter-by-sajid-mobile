import '../../../../../utils/exports.dart';

class TradingViewUrlField extends StatelessWidget {
  const TradingViewUrlField({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isDark = context.isDark;
    final Color fieldBg = isDark ? AppColors.cardDark : AppColors.whiteSmokeShade;
    final Color borderColor = isDark ? AppColors.borderDark : AppColors.borderLight;
    final Color textColor = isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight;
    final Color subtextColor = isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight;

    return BlocBuilder<AddTradeCubit, AddTradeState>(
      buildWhen: (AddTradeState prev, AddTradeState curr) => false,
      builder: (BuildContext context, AddTradeState state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            AddTradeUiHelpers.buildFieldLabel('TradingView Chart URL *', textColor),
            const SizedBox(height: 6),
            TextFormField(
              controller: state.tradingViewUrlController,
              keyboardType: TextInputType.url,
              style: TextStyle(color: textColor, fontSize: 13),
              decoration: AddTradeUiHelpers.inputDecoration(
                fieldBg,
                borderColor,
                subtextColor,
                hintText: 'https://www.tradingview.com/...',
              ),
              validator: (String? val) {
                if (val == null || val.trim().isEmpty) return 'Please provide a TradingView chart URL';
                if (!val.startsWith('http')) return 'Enter a valid URL starting with http:// or https://';
                return null;
              },
            ),
          ],
        );
      },
    );
  }
}
