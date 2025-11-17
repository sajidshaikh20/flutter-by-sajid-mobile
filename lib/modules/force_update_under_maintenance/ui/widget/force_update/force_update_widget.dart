import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../../utils/exports.dart';
import '../../../../../app/providers/providers.dart';

/// A widget that handles the display of force update and under maintenance
/// screens based on the app's current state.
class ForceUpdateWidget extends ConsumerWidget {
  /// A widget that handles the display of force update and under maintenance
  /// screens based on the app's current state.
  const ForceUpdateWidget({super.key});

  /// Builds the desktop version of the widget.
  /// Returns the same view as mobile and tablet for consistency.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Listen to state changes
    ref.listen<ForceUpdateUnderMaintenanceState>(
      forceUpdateNotifierProvider,
      (ForceUpdateUnderMaintenanceState? previous, ForceUpdateUnderMaintenanceState next) {
        // Show update dialog if a force update is required
        if (next.updateMaintenanceType != UpdateMaintenanceType.none &&
            next.updateMaintenanceType != UpdateMaintenanceType.maintenance) {
          _showUpdateDialog(
            next.forceUpdateConfigModel,
            isMandatory: next.updateMaintenanceType == UpdateMaintenanceType.force,
            context: context,
            ref: ref,
          );
        }
        if (next.updateMaintenanceType != UpdateMaintenanceType.none &&
            next.redirectRoute != null && context.mounted) {
          goBack(context);
          unawaited(
            context.router.pushAndPopUntil(
              next.redirectRoute!,
              predicate: (Route<dynamic> route) => false,
            ),
          );
        }
      },
    );

    final ForceUpdateUnderMaintenanceState state = ref.watch(forceUpdateNotifierProvider);
    
    return Visibility(
      replacement: Container(color: MainConfig.appColors.transparent),
      visible: state.underMaintenanceType != UnderMaintenanceType.none,
      child: Center(
        child: state.underMaintenanceType == UnderMaintenanceType.image
            ? UnderMaintenanceImageWidget(
                config: state.forceUpdateConfigModel,
              )
            : UnderMaintenanceTextWidget(
                config: state.forceUpdateConfigModel,
              ),
      ),
    );
  }

  /// Displays a dialog that informs the user about the force update.
  /// If the update is mandatory, the cancel button is hidden.
  ///
  /// [configModel] contains the force update details.
  /// [isMandatory] indicates if the update is mandatory or not.
  /// [context] is used to trigger the dialog display.
  /// [ref] is used to access Riverpod providers.
  void _showUpdateDialog(
    ForceUpdateConfigModel? configModel, {
    required bool isMandatory,
    required BuildContext context,
    required WidgetRef ref,
  }) {
    unawaited(
      showDialog(
        context: MainConfig.context,
        barrierDismissible: false,
        useRootNavigator: false,
        builder: (BuildContext ctx) => PopScope(
          canPop: false,
          child: DialogUtils(
            isDialogHideOnClick: false,
            message: configModel?.forceUpdate?.forceUpdateMsg ?? '',
            title: configModel?.forceUpdate?.forceUpdateTitle ?? '',
            okBtnTitle: AppConstant.update,
            cancelBtnTitle: isMandatory
                ? null
                : context.appString.cancelKey,
            onOkClicked: () async {
              // Initiates the opening of the Play Store or App Store for the update
              final ProviderContainer container = ProviderScope.containerOf(ctx);
              final ForceUpdateNotifier notifier = container.read(forceUpdateNotifierProvider.notifier);
              await notifier.openPlayStoreAppStore(ctx);
            },
            onCancelClicked: isMandatory
                ? null
                : () async {
                    goBack(ctx);
                    bool isCountryAndLanguageSelected = SharedPref.instance.getBool(
                      PrefsKey.isCountryAndLanguageSelectedKey,
                      defValue: false,
                    );
                    // Redirects based on country and language selection
                    await ctx.router.pushAndPopUntil(
                      isCountryAndLanguageSelected
                          ? const DashboardRoute()
                          : const LanguageSelectionRoute(),
                      predicate: (Route<dynamic> route) => false,
                    );
                  },
          ),
        ),
      ),
    );
  }
}
