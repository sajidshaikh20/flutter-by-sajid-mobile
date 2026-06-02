import '../../../../utils/exports.dart';

@RoutePage()
/// Sign up step 1 – basic information.
class SignUpBasicInfoPage extends StatelessWidget {
  /// Creates [SignUpBasicInfoPage].
  const SignUpBasicInfoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SignUpStepPlaceholder(
      title: context.appString.signUpBasicInfoKey,
      subtitle: context.appString.signUpBasicInfoSubtitleKey,
    );
  }
}
