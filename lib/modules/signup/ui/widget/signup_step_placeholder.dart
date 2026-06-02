import '../../../../utils/exports.dart';

/// Placeholder content for a sign up step (until forms are implemented).
class SignUpStepPlaceholder extends StatelessWidget {
  /// Creates [SignUpStepPlaceholder].
  const SignUpStepPlaceholder({
    super.key,
    required this.title,
    required this.subtitle,
  });

  /// Step title.
  final String title;

  /// Step description.
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    final bool isDark = context.isDark;
    final Color titleColor = isDark
        ? AppColors.textPrimaryDark
        : AppColors.textPrimaryLight;
    final Color subtitleColor = isDark
        ? AppColors.textSecondaryDark
        : AppColors.textSecondaryLight;

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: Dimens.size16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          CustomTextLabelWidget(
            label: title,
            style: context.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w700,
              fontSize: Dimens.fontSize18,
              color: titleColor,
            ),
          ),
          Dimens.size8.heightBox,
          CustomTextLabelWidget(
            label: subtitle,
            style: context.textTheme.bodyMedium?.copyWith(
              fontSize: Dimens.fontSize14,
              color: subtitleColor,
              height: Dimens.lineHeight20.toLineHeight(Dimens.fontSize14),
            ),
          ),
        ],
      ),
    );
  }
}
