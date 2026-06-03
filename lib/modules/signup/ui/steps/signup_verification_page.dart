import '../../../../utils/exports.dart';

@RoutePage()
/// Sign up step 2 – email and phone verification.
class SignUpVerificationPage extends StatelessWidget {
  /// Creates [SignUpVerificationPage].
  const SignUpVerificationPage({
    super.key,
    this.email,
  });

  /// Email from basic info (AutoRoute).
  final String? email;

  @override
  Widget build(BuildContext context) {
    return SignUpVerificationForm(
      email: email ?? '',
    );
  }
}
