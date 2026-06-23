import '../../../../utils/exports.dart';

/// Search bar used on Trades and My Trades tabs.
class TradesSearchBarWidget extends StatelessWidget {
  const TradesSearchBarWidget({
    super.key,
    required this.searchQuery,
    required this.onChanged,
    required this.onClear,
  });

  final String searchQuery;
  final ValueChanged<String> onChanged;
  final VoidCallback onClear;

  @override
  Widget build(BuildContext context) {
    final bool isDark = context.isDark;
    final Color textColor = isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight;
    final Color subtextColor = isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight;

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: Dimens.space16,
        vertical: Dimens.space8,
      ),
      child: Container(
        height: 46,
        decoration: BoxDecoration(
          color: isDark ? AppColors.cardDark : AppColors.cardLight,
          borderRadius: BorderRadius.circular(Dimens.radius12),
          border: Border.all(
            color: isDark
                ? AppColors.borderDark
                : AppColors.borderLight.withValues(alpha: 0.5),
          ),
        ),
        padding: const EdgeInsets.symmetric(horizontal: Dimens.space12),
        child: Row(
          children: <Widget>[
            Icon(Icons.search_rounded, color: subtextColor, size: Dimens.size20),
            const SizedBox(width: Dimens.space10),
            Expanded(
              child: TextField(
                style: TextStyle(
                  color: textColor,
                  fontSize: Dimens.fontSize13,
                  fontWeight: FontWeight.w500,
                ),
                decoration: InputDecoration(
                  hintText: 'Search pair (e.g. BTCU)',
                  hintStyle: TextStyle(
                    color: subtextColor,
                    fontSize: Dimens.fontSize13,
                    fontWeight: FontWeight.w400,
                  ),
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  errorBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,
                  isDense: true,
                  contentPadding: EdgeInsets.zero,
                ),
                onChanged: onChanged,
              ),
            ),
            if (searchQuery.isNotEmpty) ...<Widget>[
              const SizedBox(width: Dimens.space10),
              GestureDetector(
                onTap: onClear,
                child: Icon(Icons.clear_rounded, color: subtextColor, size: Dimens.size18),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
