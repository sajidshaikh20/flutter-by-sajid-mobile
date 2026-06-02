import '../../../../utils/exports.dart';

@RoutePage()
/// Sign up step 2 – verification.
class SignUpVerificationPage extends StatelessWidget {
  /// Creates [SignUpVerificationPage].
  const SignUpVerificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SignUpStepPlaceholder(
      title: context.appString.signUpVerificationKey,
      subtitle: context.appString.signUpVerificationSubtitleKey,
    );
  }
}
