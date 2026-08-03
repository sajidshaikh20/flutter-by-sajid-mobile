import 'package:step_progress/step_progress.dart';

import '../../../../utils/exports.dart';

/// Builds themed [StepProgressThemeData] for sign up flow.
StepProgressThemeData buildSignUpStepProgressTheme(BuildContext context) {
  final bool isDark = context.isDark;
  final Color inactiveLine = isDark
      ? const Color(0xFF4A4560)
      : AppColors.borderLight;
  final Color activeLine = AppColors.primaryPurple;
  final Color inactiveLabel = isDark
      ? const Color(0xFF6B657F)
      : AppColors.textSecondaryLight;

  return StepProgressThemeData(
    defaultForegroundColor: inactiveLine,
    activeForegroundColor: activeLine,
    nodeLabelAlignment: StepLabelAlignment.top,
    stepNodeStyle: const StepNodeStyle(
      decoration: BoxDecoration(color: Colors.transparent),
      activeDecoration: BoxDecoration(color: Colors.transparent),
    ),
    stepLineStyle: StepLineStyle(
      lineThickness: Dimens.size3,
      borderRadius: const Radius.circular(Dimens.radius2),
      foregroundColor: inactiveLine,
      activeColor: signUpStepGradient.first,
    ),
    nodeLabelStyle: StepLabelStyle(
      maxWidth: 120,
      titleMaxLines: Dimens.maxLines02,
      defualtColor: inactiveLabel,
      activeColor: AppColors.primaryPurple,
      padding: const EdgeInsets.only(bottom: Dimens.size8),
      margin: const EdgeInsets.symmetric(vertical: Dimens.size2),
      titleStyle: context.textTheme.bodySmall?.copyWith(
        fontSize: Dimens.fontSize12,
        fontWeight: FontWeight.w500,
        height: 1.2,
      ),
    ),
  );
}

/// Custom label above each step — completed + current are purple; upcoming grey.
Widget? buildSignUpStepLabel(
  BuildContext context, {
  required int index,
  required int currentStep,
  required List<String> titles,
}) {
  final String? title = titles.elementAtOrNull(index);
  if (title == null) {
    return null;
  }

  final bool isCurrent = index == currentStep;
  final bool isUpcoming = index > currentStep;
  final bool isDark = context.isDark;
  final Color inactiveLabel = isDark
      ? const Color(0xFF6B657F)
      : AppColors.textSecondaryLight;

  return CustomTextLabelWidget(
    label: title,
    maxLines: Dimens.maxLines02,
    overflow: TextOverflow.ellipsis,
    style: context.textTheme.bodySmall?.copyWith(
      fontSize: Dimens.fontSize12,
      fontWeight: isCurrent ? FontWeight.w600 : FontWeight.w500,
      color: isUpcoming ? inactiveLabel : AppColors.primaryPurple,
      height: 1.2,
    ),
  );
}
