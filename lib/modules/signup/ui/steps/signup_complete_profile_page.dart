import '../../../../utils/exports.dart';

@RoutePage()
/// Sign up step 3 – complete profile.
class SignUpCompleteProfilePage extends StatelessWidget {
  /// Creates [SignUpCompleteProfilePage].
  const SignUpCompleteProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SignUpStepPlaceholder(
      title: context.appString.signUpCompleteProfileKey,
      subtitle: context.appString.signUpCompleteProfileSubtitleKey,
    );
  }
}
