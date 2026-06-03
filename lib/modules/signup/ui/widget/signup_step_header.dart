import '../../../../utils/exports.dart';

/// Title and subtitle header for sign up step forms.
class SignUpStepHeader extends StatelessWidget {
  /// Creates [SignUpStepHeader].
  const SignUpStepHeader({
    super.key,
    required this.title,
    required this.subtitle,
  });

  /// Step heading.
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

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        CustomTextLabelWidget(
          label: title,
          style: context.textTheme.titleLarge?.copyWith(
            height: Dimens.lineHeight28.toLineHeight(Dimens.fontSize24),
            fontWeight: FontWeight.w800,
            fontSize: Dimens.fontSize24,
            color: titleColor,
          ),
        ),
        Dimens.size8.heightBox,
        CustomTextLabelWidget(
          label: subtitle,
          style: context.textTheme.bodyMedium?.copyWith(
            color: subtitleColor,
            fontSize: Dimens.fontSize14,
            height: Dimens.lineHeight20.toLineHeight(Dimens.fontSize14),
          ),
        ),
      ],
    );
  }
}
