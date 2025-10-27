import '../../../../utils/exports.dart';

/// Widget that displays terms and conditions agreement checkbox.
class AgreementWidget extends StatelessWidget {
  /// Creates an agreement widget.
  const AgreementWidget({super.key, this.device = ScreenType.mobile});

  /// The screen type for responsive design.
  final ScreenType device;

  @override
  Widget build(BuildContext context) {
    double termsConditionFontSize = Dimens.fontSize14;
    switch (device) {
      case ScreenType.tablet:
        termsConditionFontSize = Dimens.fontSize18;

      default:
        break;
    }
    final TextStyle? textStyle = context.textTheme.bodySmall?.copyWith(
      color: MainConfig.appColors.textBlackColor,
      fontSize: termsConditionFontSize,
      fontWeight: FontWeight.w600,
    );
    final TextStyle? hyperLinkTextStyle = context.textTheme.bodySmall?.copyWith(
      color: MainConfig.appColors.mainColor,
      fontSize: termsConditionFontSize,
      fontWeight: FontWeight.w600,
    );
    return Row(
      children: <Widget>[
        BlocBuilder<SignupCubit, SignupState>(
          buildWhen: (SignupState previous, SignupState current) {
            // Only rebuild when checkbox state changes
            return previous.isChecked != current.isChecked;
          },
          builder: (BuildContext context, SignupState state) {
            return CustomCheckbox(
              isChecked: state.isChecked,
              onChanged: (bool value) {
                context.read<SignupCubit>().toggleCheckbox(value: value);
              },
            );
          },
        ),
        Dimens.size8.widthBox,
        Expanded(
          child: BlocBuilder<SignupCubit, SignupState>(
            buildWhen: (SignupState previous, SignupState current) {
              // Only rebuild when checkbox state changes (affects text styling)
              return previous.isChecked != current.isChecked;
            },
            builder: (BuildContext context, SignupState state) {
              return RichText(
                maxLines: Dimens.maxLines03,
                text: TextSpan(children: <TextSpan>[
                  TextSpan(
                      text: context.appString.iAgreeToTheKey, style: textStyle),
                  TextSpan(
                    text: context.appString.termsAndConditionsSmallKey,
                    style: hyperLinkTextStyle,
                    recognizer: TapGestureRecognizer()
                      ..onTap = () async {
                      await context.router.push(
                          ViewCmsRoute(title:
                          context.appString.termsAndConditionKey,
                              url: AppConstant.term_conditions));
                      },
                  ),
                ]),
              );
            },
          ),
        ),
      ],
    );
  }
}
