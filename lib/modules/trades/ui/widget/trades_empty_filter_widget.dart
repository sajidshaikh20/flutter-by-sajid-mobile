import '../../../../utils/exports.dart';

/// Placeholder shown when no trades match the current filter or search.
class TradesEmptyFilterWidget extends StatelessWidget {
  const TradesEmptyFilterWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final Color subtextColor =
        context.isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight;

    return Center(
      child: Padding(
        padding: const EdgeInsets.only(top: Dimens.space40),
        child: CustomTextLabelWidget(
          label: 'No signals available for this filter',
          style: TextStyle(
            color: subtextColor,
            fontSize: Dimens.fontSize13,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
