import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../utils/exports.dart';
import '../../../app/providers/providers.dart';

@RoutePage()
/// Page that displays the sign up form for new user registration.
class SignUpPage extends ConsumerWidget {
  /// Creates a sign up page.
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        ScreenType device = ScreenType.mobile;
        if (constraints.maxWidth >= AppConstant.webPixelWidth) {
          device = ScreenType.desktop;
        } else if (constraints.maxWidth >= AppConstant.mobilePixelWidth) {
          device = ScreenType.tablet;
        }
        return SignUpForm(device: device);
      },
    );
  }
}
