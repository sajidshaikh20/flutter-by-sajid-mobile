import '../../../../../utils/exports.dart';

class TradeNotesField extends StatelessWidget {
  const TradeNotesField({super.key});

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
            AddTradeUiHelpers.buildFieldLabel('Trade Notes', textColor),
            const SizedBox(height: 6),
            TextFormField(
              controller: state.commentController,
              maxLines: 3,
              style: TextStyle(color: textColor, fontSize: 13),
              decoration: AddTradeUiHelpers.inputDecoration(
                fieldBg,
                borderColor,
                subtextColor,
                hintText: 'Enter setup analysis, key levels, or strategy notes...',
              ),
            ),
          ],
        );
      },
    );
  }
}
