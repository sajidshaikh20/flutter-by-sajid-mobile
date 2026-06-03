import '../../../../utils/exports.dart';

/// Placeholder body for dashboard tabs until feature UI is implemented.
class DashboardTabPlaceholder extends StatelessWidget {
  const DashboardTabPlaceholder({
    super.key,
    required this.title,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    final bool isDark = context.isDark;
    final Color backgroundColor = isDark
        ? AppColors.backgroundDark
        : AppColors.backgroundLight;
    final Color titleColor = isDark
        ? AppColors.textPrimaryDark
        : AppColors.textPrimaryLight;
    final Color subtitleColor = isDark
        ? AppColors.textSecondaryDark
        : AppColors.textSecondaryLight;

    return Scaffold(
      backgroundColor: backgroundColor,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(Dimens.size24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Icon(
                Icons.construction_outlined,
                size: Dimens.size48,
                color: AppColors.primaryPurple.withValues(alpha: 0.6),
              ),
              Dimens.size16.heightBox,
              CustomTextLabelWidget(
                label: title,
                style: context.textTheme.titleLarge?.copyWith(
                  color: titleColor,
                  fontWeight: FontWeight.w700,
                  fontSize: Dimens.fontSize22,
                ),
                textAlign: TextAlign.center,
              ),
              Dimens.size8.heightBox,
              CustomTextLabelWidget(
                label: context.appString.comingSoonKey,
                style: context.textTheme.bodyMedium?.copyWith(
                  color: subtitleColor,
                  fontSize: Dimens.fontSize14,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
