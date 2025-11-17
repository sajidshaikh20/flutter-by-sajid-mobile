import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../utils/exports.dart';
import '../../../../app/providers/providers.dart';
import 'signup_state_helper.dart';

/// A button widget used for signing up.
///
/// This widget can adapt its styling based on the screen type (mobile, tablet, or web).
class SignUpButtonWidget extends ConsumerWidget {
  /// Creates a [SignUpButtonWidget].
  ///
  /// [device] determines the screen type for responsive styling. Defaults to `ScreenType.mobile`.
  const SignUpButtonWidget({super.key, this.device = ScreenType.mobile});

  /// The type of screen for which the widget is being built.
  final ScreenType device;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final SignupState initialState = SignupStateHelper.createInitialState();
    final SignupNotifier signupNotifier = ref.read(signupNotifierProvider(initialState).notifier);

    return CustomGradientButtonWidget(
      device: device,
      title: context.appString.signUpKey,
      onTap: () async {
        // Call the notifier's validateInput method which handles validation and API call
        await signupNotifier.validateInput(
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
