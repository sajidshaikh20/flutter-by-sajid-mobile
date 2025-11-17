import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../utils/exports.dart';
import '../../../../app/providers/providers.dart';
import 'signup_state_helper.dart';

/// Widget that displays terms and conditions agreement checkbox.
class AgreementWidget extends ConsumerWidget {
  /// Creates an agreement widget.
  const AgreementWidget({super.key, this.device = ScreenType.mobile});

  /// The screen type for responsive design.
  final ScreenType device;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final SignupState initialState = SignupStateHelper.createInitialState();
    final SignupState state = ref.watch(signupNotifierProvider(initialState));
    final SignupNotifier notifier = ref.read(signupNotifierProvider(initialState).notifier);
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
        CustomCheckbox(
          isChecked: state.isAgreed,
          onChanged: (bool value) {
            notifier.toggleAgreement(value);
          },
        ),
        Dimens.size8.widthBox,
        Expanded(
          child: Consumer(
            builder: (BuildContext context, WidgetRef ref, Widget? child) {
              final SignupState currentState = ref.watch(signupNotifierProvider(initialState));
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
                      DebugLog.instance.e("AgreementWidget");
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
