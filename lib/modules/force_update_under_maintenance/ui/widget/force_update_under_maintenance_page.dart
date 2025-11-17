import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../../utils/exports.dart';
import '../../../../../app/providers/providers.dart';

/// A page that checks for app updates and displays force update or
/// under maintenance views based on the current status.
///
/// This page is responsible for triggering an app update check when
/// mounted and displaying the `ForceUpdateWidget` to show the appropriate
/// view based on the update or maintenance state.
@RoutePage()
class ForceUpdateUnderMaintenancePage extends ConsumerWidget {
  /// A page that checks for app updates and displays force update or
  /// under maintenance views based on the current status.
  const ForceUpdateUnderMaintenancePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Initiates a microtask to check for app updates
    // asynchronously when the page is mounted.
    // This prevents blocking the main thread and ensures the update check
    // happens in the background.
    scheduleMicrotask(
      () async {
        if (context.mounted) {
          // Calls the notifier to check if an app update is available.
          await ref.read(forceUpdateNotifierProvider.notifier).checkAppUpdate();
        }
      },
    );

    // Returns the ForceUpdateWidget that handles the rendering of
    // either the force update screen or under maintenance screen.
    return const ForceUpdateWidget();
  }
}
