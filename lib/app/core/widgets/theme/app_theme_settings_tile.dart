import '../../../../utils/exports.dart';

/// Single settings entry: tap opens [ThemeSelectionBottomSheet].
class AppThemeSettingsTile extends StatelessWidget {
  const AppThemeSettingsTile({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    final Color accent =
        isDark ? AppColors.primaryPurple : AppColors.secondaryPurple;

    return BlocBuilder<ThemeCubit, ThemeMode>(
      builder: (BuildContext context, ThemeMode themeMode) {
        String currentModeLabel = 'System Auto';
        IconData currentModeIcon = Icons.brightness_auto_rounded;

        if (themeMode == ThemeMode.light) {
          currentModeLabel = 'Light Mode';
          currentModeIcon = Icons.light_mode_rounded;
        } else if (themeMode == ThemeMode.dark) {
          currentModeLabel = 'Dark Mode';
          currentModeIcon = Icons.dark_mode_rounded;
        }

        return SettingsListTileWidget(
          icon: currentModeIcon,
          title: 'App Theme',
          subtitle: currentModeLabel,
          trailing: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: Dimens.space10,
              vertical: Dimens.space4,
            ),
            decoration: BoxDecoration(
              color: isDark
                  ? Colors.white.withValues(alpha: 0.05)
                  : Colors.black.withValues(alpha: 0.04),
              borderRadius: BorderRadius.circular(Dimens.radius12),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                CustomTextLabelWidget(
                  label: 'Update',
                  style: TextStyle(
                    color: accent,
                    fontSize: Dimens.fontSize12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(width: Dimens.space4),
                Icon(
                  Icons.keyboard_arrow_right_rounded,
                  color: accent,
                  size: Dimens.size14,
                ),
              ],
            ),
          ),
          onTap: () => ThemeSelectionBottomSheet.show(context),
        );
      },
    );
  }
}
