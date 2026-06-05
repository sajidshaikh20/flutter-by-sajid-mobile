import '../../../../../utils/exports.dart';

/// A page that checks for app updates and displays force update or
/// under maintenance views based on the current status.
///
/// This page is responsible for triggering an app update check when
/// mounted and displaying the `ForceUpdateWidget` to show the appropriate
/// view based on the update or maintenance state.
@RoutePage()
class ForceUpdateUnderMaintenancePage extends StatelessWidget {
  /// A page that checks for app updates and displays force update or
  /// under maintenance views based on the current status.
  const ForceUpdateUnderMaintenancePage({super.key});

  @override
  Widget build(BuildContext context) {
    scheduleMicrotask(
      () async {
        if (!context.mounted) {
          return;
        }
        await context
            .read<ForceUpdateUnderMaintenanceCubit>()
            .checkAppUpdate();
      },
    );

    return Scaffold(
      backgroundColor: MainConfig.appColors.backgroundWhiteColor,
      body: const ForceUpdateWidget(),
    );
  }
}
