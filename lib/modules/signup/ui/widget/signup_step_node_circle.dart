import 'package:flutter/material.dart';

import '../../../../app/core/theme/app_colors.dart';
import '../../../../app/core/theme/dimens.dart';

/// Gradient used for active / completed sign up step nodes and lines.
const List<Color> signUpStepGradient = <Color>[
  Color(0xFF8B40FF),
  Color(0xFFFF4DB8),
];

/// Visual state of a sign up step node.
enum SignUpStepNodeState {
  /// Current step.
  current,

  /// Step already passed.
  completed,

  /// Step not yet reached.
  inactive,
}

/// Resolves [SignUpStepNodeState] from indices.
SignUpStepNodeState signUpStepNodeState({
  required int index,
  required int currentStep,
}) {
  if (index < currentStep) {
    return SignUpStepNodeState.completed;
  }
  if (index == currentStep) {
    return SignUpStepNodeState.current;
  }
  return SignUpStepNodeState.inactive;
}

/// Circular step indicator matching sign up design (gradient ring + number/check).
class SignUpStepNodeCircle extends StatelessWidget {
  /// Creates [SignUpStepNodeCircle].
  const SignUpStepNodeCircle({
    super.key,
    required this.stepNumber,
    required this.state,
    required this.isDark,
    this.size = Dimens.size40,
  });

  /// 1-based step number shown inside the circle.
  final int stepNumber;

  /// Active, completed, or inactive styling.
  final SignUpStepNodeState state;

  /// Whether dark theme is active.
  final bool isDark;

  /// Diameter of the circle.
  final double size;

  static const double _borderWidth = 2;

  @override
  Widget build(BuildContext context) {
    final Color fillColor = isDark
        ? AppColors.backgroundDark
        : AppColors.backgroundLight;
    final Color inactiveBorder = isDark
        ? const Color(0xFF4A4560)
        : AppColors.borderLight;
    final Color inactiveText = isDark
        ? const Color(0xFF6B657F)
        : AppColors.textSecondaryLight;

    final bool useGradient = state != SignUpStepNodeState.inactive;

    if (useGradient) {
      return SizedBox(
        width: size,
        height: size,
        child: DecoratedBox(
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(
              colors: signUpStepGradient,
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(_borderWidth),
            child: DecoratedBox(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: fillColor,
              ),
              child: Center(
                child: state == SignUpStepNodeState.completed
                    ? const Icon(
                        Icons.check,
                        size: Dimens.size18,
                        color: AppColors.whiteColor,
                      )
                    : Text(
                        '$stepNumber',
                        style: const TextStyle(
                          fontSize: Dimens.fontSize14,
                          fontWeight: FontWeight.w600,
                          color: AppColors.blackColor,
                          height: 1,
                        ),
                      ),
              ),
            ),
          ),
        ),
      );
    }

    return SizedBox(
      width: size,
      height: size,
      child: DecoratedBox(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: fillColor,
          border: Border.all(color: inactiveBorder, width: _borderWidth),
        ),
        child: Center(
          child: Text(
            '$stepNumber',
            style: TextStyle(
              fontSize: Dimens.fontSize14,
              fontWeight: FontWeight.w500,
              color: inactiveText,
              height: 1,
            ),
          ),
        ),
      ),
    );
  }
}
