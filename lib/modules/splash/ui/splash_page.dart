import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../utils/exports.dart';
import '../../../app/providers/providers.dart';
import '../state/splash_state.dart';

@RoutePage()
/// Page that displays the splash screen with initialization logic.
class SplashPage extends ConsumerStatefulWidget {
  /// Creates a splash page.
  const SplashPage({super.key});

  @override
  ConsumerState<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends ConsumerState<SplashPage> {
  @override
  void initState() {
    super.initState();
  }

  Future<void> _handleNavigation(SplashState state) async {
    await ref.read(localeNotifierProvider.notifier).changeLanguageOnInit(
      state.languageCode,
      state.languageAlignment,
    );

    if (mounted) {
      await context.router.replaceNamed(state.redirectPath);
    }
  }

  @override
  Widget build(BuildContext context) {
    // Listen to splash state changes
    // ref.listen must be called during the build phase, not in initState
    ref.listen<SplashState>(splashNotifierProvider, (SplashState? previous, SplashState next) {
      if (next.redirectPath.isNotEmpty && mounted) {
        unawaited(_handleNavigation(next));
      }
    });
    
    return const SplashViewWidget();
  }
}
