import '../../../utils/exports.dart';

/// Widget that displays password requirements for reset password form.
class PasswordRequirements extends StatelessWidget {
  /// Creates a password requirements widget.
  const PasswordRequirements({super.key});

  @override
  Widget build(BuildContext context) {
    final TextStyle? textStyle = context.textTheme.headlineMedium?.copyWith(
      fontWeight: FontWeight.w400,
      fontSize: Dimens.size10,
      height: Dimens.lineHeight10.toLineHeight(Dimens.fontSize10),
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        CustomTextLabelWidget(
          label: context.appString.minimumSixMaxFifteenKey,
          style: textStyle,
        ),
        const SizedBox(height: Dimens.size12),
        CustomTextLabelWidget(
          label: context.appString.mustIncludeLeastKey,
          style: textStyle?.copyWith(
            fontWeight: FontWeight.w500,
            fontSize: Dimens.size12, // Optional: Adjust font size if needed.
          ),
        ),
        const SizedBox(height: Dimens.size8),
        Padding(
          padding: const EdgeInsets.only(left: Dimens.space16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              CustomTextLabelWidget(
                label: context.appString.oneNumberKey,
                style: textStyle,
              ),
              const SizedBox(height: Dimens.size6),
              CustomTextLabelWidget(
                label: context.appString.upperCaseLetterKey,
                style: textStyle,
              ),
              const SizedBox(height: Dimens.size6),
              CustomTextLabelWidget(
                label: context.appString.lowerCaseLetterKey,
                style: textStyle,
              ),
              const SizedBox(height: Dimens.size6),
              CustomTextLabelWidget(
                label: context.appString.specialCaseLetterKey,
                style: textStyle,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
