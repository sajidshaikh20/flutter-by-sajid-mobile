import '../../../../utils/exports.dart';

class TradesFilterBar extends StatelessWidget {
  const TradesFilterBar({
    super.key,
    required this.selectedFilters,
    required this.onFilterChanged,
  });

  final Set<SignalFilter> selectedFilters;
  final ValueChanged<SignalFilter> onFilterChanged;

  @override
  Widget build(BuildContext context) {
    final bool isDark = context.isDark;

    return SizedBox(
      height: 48,
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: Dimens.space16),
        children: <Widget>[
          _FilterPill(
            label: 'All',
            filter: SignalFilter.all,
            isSelected: selectedFilters.contains(SignalFilter.all),
            onTap: () => onFilterChanged(SignalFilter.all),
            isDark: isDark,
          ),
          const SizedBox(width: Dimens.space8),
          _FilterPill(
            label: 'Active',
            filter: SignalFilter.active,
            isSelected: selectedFilters.contains(SignalFilter.active),
            dotColor: isDark ? AppColors.successColor : AppColors.greenTextColor,
            onTap: () => onFilterChanged(SignalFilter.active),
            isDark: isDark,
          ),
          const SizedBox(width: Dimens.space8),
          _FilterPill(
            label: 'Pending',
            filter: SignalFilter.pending,
            isSelected: selectedFilters.contains(SignalFilter.pending),
            dotColor: AppColors.warningColor,
            onTap: () => onFilterChanged(SignalFilter.pending),
            isDark: isDark,
          ),
          const SizedBox(width: Dimens.space8),
          _FilterPill(
            label: 'Closed',
            filter: SignalFilter.closed,
            isSelected: selectedFilters.contains(SignalFilter.closed),
            dotColor: AppColors.neutralColor,
            onTap: () => onFilterChanged(SignalFilter.closed),
            isDark: isDark,
          ),
          const SizedBox(width: Dimens.space8),
          _FilterPill(
            label: 'Cancelled',
            filter: SignalFilter.cancelled,
            isSelected: selectedFilters.contains(SignalFilter.cancelled),
            dotColor: AppColors.errorColor,
            onTap: () => onFilterChanged(SignalFilter.cancelled),
            isDark: isDark,
          ),
        ],
      ),
    );
  }
}

class _FilterPill extends StatelessWidget {
  const _FilterPill({
    required this.label,
    required this.filter,
    required this.isSelected,
    required this.onTap,
    required this.isDark,
    this.dotColor,
  });

  final String label;
  final SignalFilter filter;
  final bool isSelected;
  final VoidCallback onTap;
  final bool isDark;
  final Color? dotColor;

  @override
  Widget build(BuildContext context) {
    final Color textColor = isSelected
        ? AppColors.whiteColor
        : (isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight);

    final BoxDecoration decoration = isSelected
        ? BoxDecoration(
            gradient: AppColors.primaryButtonGradient,
            borderRadius: BorderRadius.circular(Dimens.radius20),
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: AppColors.primaryPurple.withValues(alpha: 0.3),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          )
        : BoxDecoration(
            color: isDark ? AppColors.cardDark : AppColors.cardLight,
            borderRadius: BorderRadius.circular(Dimens.radius20),
            border: Border.all(
              color: isDark ? AppColors.borderDark : AppColors.borderLight.withValues(alpha: 0.5),
            ),
          );

    return GestureDetector(
      onTap: onTap,
      child: Center(
        child: Container(
          decoration: decoration,
          padding: const EdgeInsets.symmetric(
            horizontal: Dimens.space16,
            vertical: Dimens.space8,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              CustomTextLabelWidget(
                label: label,
                style: TextStyle(
                  color: textColor,
                  fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                  fontSize: Dimens.fontSize12,
                ),
              ),
              if (dotColor != null) ...<Widget>[
                const SizedBox(width: Dimens.space6),
                Container(
                  width: Dimens.size6,
                  height: Dimens.size6,
                  decoration: BoxDecoration(
                    color: dotColor,
                    shape: BoxShape.circle,
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
