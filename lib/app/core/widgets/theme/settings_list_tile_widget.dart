import '../../../../utils/exports.dart';

/// Reusable settings row: leading icon, title, subtitle, optional trailing.
class SettingsListTileWidget extends StatelessWidget {
  const SettingsListTileWidget({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    this.trailing,
    this.onTap,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final Widget? trailing;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    final Color iconBackground =
        isDark ? AppColors.cardDark : AppColors.cardLight;
    final Color iconColor =
        isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight;

    return Material(
      color: isDark ? AppColors.surfaceDark : AppColors.surfaceLight,
      borderRadius: BorderRadius.circular(Dimens.radius16),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(Dimens.radius16),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: Dimens.space16,
            vertical: Dimens.space14,
          ),
          child: Row(
            children: <Widget>[
              Container(
                padding: const EdgeInsets.all(Dimens.space10),
                decoration: BoxDecoration(
                  color: iconBackground,
                  borderRadius: BorderRadius.circular(Dimens.radius12),
                ),
                child: Icon(icon, color: iconColor, size: Dimens.size22),
              ),
              const SizedBox(width: Dimens.space16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    CustomTextLabelWidget(
                      label: title,
                      style: TextStyle(
                        color: isDark
                            ? AppColors.textPrimaryDark
                            : AppColors.textPrimaryLight,
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
                        fontSize: Dimens.fontSize12,
                      ),
                      textAlign: TextAlign.start,
                    ),
                  ],
                ),
              ),
              if (trailing != null) trailing!,
            ],
          ),
        ),
      ),
    );
  }
}
