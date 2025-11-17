import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../utils/exports.dart';
import '../../../app/providers/providers.dart';

@RoutePage()
/// Page that displays language selection options.
class LanguageSelectionPage extends ConsumerWidget {
  /// Creates a language selection page.
  const LanguageSelectionPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Listen to state changes
    ref.listen<LanguageSelectionState>(
      languageSelectionNotifierProvider,
      (LanguageSelectionState? previous, LanguageSelectionState next) async {
        if (next.status == BaseStateStatus.success) {
          await ref.read(localeNotifierProvider.notifier).changeLanguage(next.languageCode, next.languageAlignment);
          if (context.mounted) {
            await context.router.replace(next.redirectRoute!);
          }
        }
      },
    );

    return const LanguageSelectionWidget();
  }
}
