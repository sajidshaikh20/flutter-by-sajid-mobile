import '../../../../utils/exports.dart';

/// A button widget used for signing up.
///
/// This widget can adapt its styling based on the screen type (mobile, tablet, or web).
class SignUpButtonWidget extends StatelessWidget {
  /// Creates a [SignUpButtonWidget].
  ///
  /// [device] determines the screen type for responsive styling. Defaults to `ScreenType.mobile`.
  const SignUpButtonWidget({super.key, this.device = ScreenType.mobile});

  /// The type of screen for which the widget is being built.
  final ScreenType device;

  @override
  Widget build(BuildContext context) {
    final SignupCubit signupCubit = context.instance<SignupCubit>();

    return CustomGradientButtonWidget(
      device: device,
      title: context.appString.signUpKey,
      onTap: () async {
        // Call the cubit's validateInput method which handles validation and API call
        await signupCubit.validateInput(
          context.appString.pleaseEnterTheFullNameKey,
          context.appString.pleaseEnterMobileNumberKey,
          context.appString.pleaseEnterTheEmailKey,
          context.appString.selectNationalityKey,
           context.appString.dateOfBirthKey,
          context.appString.selectGenderKey,
          context.appString.pleaseEnterThePasswordKey,
          context.appString.onlyNumbersAllowedKey,
         context.appString.enterValidMobileNumberKey,
          context.appString.pleaseEnterValidEmailKey,
          context.appString.pleaseEnterValidPasswordKey,
           context.appString.youMustAcceptTermsKey,
        );
      },
    );
  }


}
