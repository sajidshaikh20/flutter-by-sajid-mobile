import '../../../../utils/exports.dart';

/// Bottom sheet to pick [ThemeMode] (system / light / dark).
class ThemeSelectionBottomSheet {
  ThemeSelectionBottomSheet._();

  /// Opens the theme picker for the current [ThemeCubit] state.
  static Future<void> show(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;

    return showModalBottomSheet<void>(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (BuildContext sheetContext) {
        return BlocBuilder<ThemeCubit, ThemeMode>(
          builder: (BuildContext context, ThemeMode selectedMode) {
            return DecoratedBox(
              decoration: BoxDecoration(
                color: isDark ? AppColors.surfaceDark : AppColors.surfaceLight,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(28),
                  topRight: Radius.circular(28),
                ),
                border: Border.all(
                  color: isDark
                      ? Colors.white.withValues(alpha: 0.05)
                      : Colors.black.withValues(alpha: 0.05),
                ),
              ),
              child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(Dimens.space24),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Center(
                        child: Container(
                          width: Dimens.size48,
                          height: Dimens.size4,
                          decoration: BoxDecoration(
                            color: isDark ? Colors.white24 : Colors.black26,
                            borderRadius: BorderRadius.circular(2),
                          ),
                        ),
                      ),
                      const SizedBox(height: Dimens.space24),
                      CustomTextLabelWidget(
                        label: 'Choose App Theme',
                        style: TextStyle(
                          color: isDark
                              ? AppColors.textPrimaryDark
                              : AppColors.textPrimaryLight,
                          fontSize: Dimens.fontSize18,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      const SizedBox(height: Dimens.space6),
                      CustomTextLabelWidget(
                        label:
                            'Select manual layout color mode or keep automatic device sync.',
                        style: TextStyle(
                          color: isDark
                              ? AppColors.textSecondaryDark
                              : AppColors.textSecondaryLight,
                          fontSize: Dimens.fontSize13,
                        ),
                      ),
                      const SizedBox(height: Dimens.space20),
                      _ThemeOptionTile(
                        sheetContext: sheetContext,
                        mode: ThemeMode.system,
                        title: 'System Automatic',
                        subtitle:
                            'Synchronizes styling based on device OS theme settings',
                        icon: Icons.brightness_auto_rounded,
                        isSelected: selectedMode == ThemeMode.system,
                      ),
                      _ThemeOptionDivider(isDark: isDark),
                      _ThemeOptionTile(
                        sheetContext: sheetContext,
                        mode: ThemeMode.light,
                        title: 'Light Theme',
                        subtitle:
                            'Clean white workspace matching bright environments',
                        icon: Icons.light_mode_rounded,
                        isSelected: selectedMode == ThemeMode.light,
                      ),
                      _ThemeOptionDivider(isDark: isDark),
                      _ThemeOptionTile(
                        sheetContext: sheetContext,
                        mode: ThemeMode.dark,
                        title: 'Dark Theme',
                        subtitle: 'Visually optimized neon trading environment',
                        icon: Icons.dark_mode_rounded,
                        isSelected: selectedMode == ThemeMode.dark,
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}

class _ThemeOptionDivider extends StatelessWidget {
  const _ThemeOptionDivider({required this.isDark});

  final bool isDark;

  @override
  Widget build(BuildContext context) {
    return Divider(
      height: 1,
      thickness: 1,
      color: isDark ? AppColors.dividerDark : AppColors.dividerLight,
    );
  }
}

class _ThemeOptionTile extends StatelessWidget {
  const _ThemeOptionTile({
    required this.sheetContext,
    required this.mode,
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.isSelected,
  });

  final BuildContext sheetContext;
  final ThemeMode mode;
  final String title;
  final String subtitle;
  final IconData icon;
  final bool isSelected;

  Color _accentColor(bool isDark) =>
      isDark ? AppColors.primaryPurple : AppColors.secondaryPurple;

  @override
  Widget build(BuildContext context) {
    final bool isDark = Theme.of(sheetContext).brightness == Brightness.dark;
    final Color accent = _accentColor(isDark);

    return InkWell(
      onTap: () async {
        await sheetContext.read<ThemeCubit>().selectThemeMode(mode);
        if (sheetContext.mounted) {
          Navigator.pop(sheetContext);
        }
      },
      borderRadius: BorderRadius.circular(Dimens.radius16),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: Dimens.space12,
          vertical: Dimens.space14,
        ),
        child: Row(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.all(Dimens.space10),
              decoration: BoxDecoration(
                color: isSelected
                    ? accent.withValues(alpha: 0.12)
                    : (isDark ? AppColors.backgroundDark : AppColors.cardLight),
                borderRadius: BorderRadius.circular(Dimens.radius12),
              ),
              child: Icon(
                icon,
                color: isSelected
                    ? accent
                    : (isDark
                        ? AppColors.textSecondaryDark
                        : AppColors.textSecondaryLight),
                size: Dimens.size22,
              ),
            ),
            const SizedBox(width: Dimens.space16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  CustomTextLabelWidget(
                    label: title,
                    style: TextStyle(
                      color: isSelected
                          ? accent
                          : (isDark
                              ? AppColors.textPrimaryDark
                              : AppColors.textPrimaryLight),
                      fontSize: Dimens.fontSize15,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.start,
                  ),
                  const SizedBox(height: Dimens.space2),
                  CustomTextLabelWidget(
                    label: subtitle,
                    style: TextStyle(
                      color: isDark
                          ? AppColors.textSecondaryDark
                          : AppColors.textSecondaryLight,
                      fontSize: 11.5,
                    ),
                    textAlign: TextAlign.start,
                  ),
                ],
              ),
            ),
            if (isSelected)
              Icon(
                Icons.check_circle_rounded,
                color: accent,
                size: Dimens.size20,
              ),
          ],
        ),
      ),
    );
  }
}
