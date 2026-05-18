import '../../../../../utils/exports.dart';

/// A widget that handles the display of force update and under maintenance
/// screens based on the app's current state.
class ForceUpdateWidget extends BaseResponsiveView {
  /// A widget that handles the display of force update and under maintenance
  /// screens based on the app's current state.
  const ForceUpdateWidget({super.key});

  /// Builds the desktop version of the widget.
  /// Returns the same view as mobile and tablet for consistency.
  @override
  Widget buildDesktopWidget(BuildContext context) => _buildView(context);

  /// Builds the mobile version of the widget.
  /// Returns the same view as desktop and tablet for consistency.
  @override
  Widget buildMobileWidget(BuildContext context) => _buildView(context);

  /// Builds the tablet version of the widget.
  /// Returns the same view as desktop and mobile for consistency.
  @override
  Widget buildTabletWidget(BuildContext context) => _buildView(context);

  /// A helper function that constructs the widget view based on the current
  /// app state. Displays a different widget depending on the type of
  /// under maintenance (image or text).
  Widget _buildView(BuildContext context) => BlocConsumer<
          ForceUpdateUnderMaintenanceCubit, ForceUpdateUnderMaintenanceState>(
        builder:
            (BuildContext context, ForceUpdateUnderMaintenanceState state) => Visibility(
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
        ),
        listener:
            (BuildContext context, ForceUpdateUnderMaintenanceState state) {
          // Show update dialog if a force update is required or if there's
          // a redirect route provided
          if (state.updateMaintenanceType != UpdateMaintenanceType.none &&
              state.updateMaintenanceType !=
                  UpdateMaintenanceType.maintenance) {
            _showUpdateDialog(
              state.forceUpdateConfigModel,
              isMandatory:
                  state.updateMaintenanceType == UpdateMaintenanceType.force,
              context: context,
            );
          }
          if (state.updateMaintenanceType != UpdateMaintenanceType.none &&
              state.redirectRoute != null) {
            goBack(context);
            unawaited(
              context.router.pushAndPopUntil(
                state.redirectRoute!,
                predicate: (Route<dynamic> route) => false,
              ),
            );
          }
        },
        buildWhen: (ForceUpdateUnderMaintenanceState previous,
                ForceUpdateUnderMaintenanceState current) =>
            (current.status == BaseStateStatus.success) &&
            (current.underMaintenanceType != previous.underMaintenanceType),
        listenWhen: (ForceUpdateUnderMaintenanceState previous,
                ForceUpdateUnderMaintenanceState current) =>
            (current.status == BaseStateStatus.success) &&
            (current.updateMaintenanceType != previous.updateMaintenanceType),
      );

  /// Displays a dialog that informs the user about the force update.
  /// If the update is mandatory, the cancel button is hidden.
  ///
  /// [configModel] contains the force update details.
  /// [isMandatory] indicates if the update is mandatory or not.
  /// [context] is used to trigger the dialog display.
  void _showUpdateDialog(
    ForceUpdateConfigModel? configModel, {
    required bool isMandatory,
    required BuildContext context,
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
              // Initiates the opening of the Play Store or App
              // Store for the update
              await context
                  .instance<ForceUpdateUnderMaintenanceCubit>()
                  .openPlayStoreAppStore(context);
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
                          ?  AetherRoute()
                          :  AetherRoute(),
                      predicate: (Route<dynamic> route) => false,
                    );
                  },
          ),
        ),
      ),
    );
  }
}
