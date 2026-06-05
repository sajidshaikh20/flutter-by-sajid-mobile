import '../../../../../utils/exports.dart';

/// A widget that handles the display of force update and under maintenance
/// screens based on the app's current state.
class ForceUpdateWidget extends BaseResponsiveView {
  /// A widget that handles the display of force update and under maintenance
  /// screens based on the app's current state.
  const ForceUpdateWidget({super.key});

  @override
  Widget buildDesktopWidget(BuildContext context) => const _ForceUpdateView();

  @override
  Widget buildMobileWidget(BuildContext context) => const _ForceUpdateView();

  @override
  Widget buildTabletWidget(BuildContext context) => const _ForceUpdateView();
}

class _ForceUpdateView extends StatefulWidget {
  const _ForceUpdateView();

  @override
  State<_ForceUpdateView> createState() => _ForceUpdateViewState();
}

class _ForceUpdateViewState extends State<_ForceUpdateView> {
  bool _updateDialogShown = false;
  bool _isLeaving = false;
  UpdateMaintenanceType? _dialogUpdateType;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _handleUpdateState(
        context.read<ForceUpdateUnderMaintenanceCubit>().state,
      );
    });
  }

  bool get _isOnMaintenanceRoute {
    final String path = context.router.currentPath;
    return path == AppPaths.maintenance || path.endsWith(AppPaths.maintenance);
  }

  void _handleUpdateState(ForceUpdateUnderMaintenanceState state) {
    if (!mounted || state.status != BaseStateStatus.success) {
      return;
    }

    if (state.updateMaintenanceType == UpdateMaintenanceType.none) {
      _updateDialogShown = false;
      _dialogUpdateType = null;
      if (_isOnMaintenanceRoute) {
        unawaited(_leaveMaintenanceFlow());
      }
      return;
    }

    if (state.updateMaintenanceType == UpdateMaintenanceType.maintenance) {
      _dismissUpdateDialogIfNeeded();
      _updateDialogShown = false;
      _dialogUpdateType = null;
      return;
    }

    final bool shouldShowDialog = !_updateDialogShown ||
        _dialogUpdateType != state.updateMaintenanceType;

    if (shouldShowDialog) {
      _dismissUpdateDialogIfNeeded();
      _updateDialogShown = true;
      _dialogUpdateType = state.updateMaintenanceType;
      _showUpdateDialog(
        state.forceUpdateConfigModel,
        isMandatory:
            state.updateMaintenanceType == UpdateMaintenanceType.force,
      );
    }
  }

  void _dismissUpdateDialogIfNeeded() {
    if (_updateDialogShown && mounted) {
      final NavigatorState navigator = Navigator.of(context);
      if (navigator.canPop()) {
        navigator.pop();
      }
    }
  }

  Future<void> _leaveMaintenanceFlow() async {
    if (!mounted || _isLeaving || !_isOnMaintenanceRoute) {
      return;
    }
    _isLeaving = true;
    _dismissUpdateDialogIfNeeded();
    _updateDialogShown = false;
    _dialogUpdateType = null;
    await context.router.replacePath(AppPaths.splash);
    _isLeaving = false;
  }

  @override
  Widget build(BuildContext context) => BlocConsumer<
        ForceUpdateUnderMaintenanceCubit,
        ForceUpdateUnderMaintenanceState
      >(
        builder: (
          BuildContext context,
          ForceUpdateUnderMaintenanceState state,
        ) =>
            Visibility(
          replacement: Container(color: MainConfig.appColors.transparent),
          visible: state.updateMaintenanceType ==
              UpdateMaintenanceType.maintenance,
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
        listener: (
          BuildContext context,
          ForceUpdateUnderMaintenanceState state,
        ) =>
            _handleUpdateState(state),
        buildWhen: (
          ForceUpdateUnderMaintenanceState previous,
          ForceUpdateUnderMaintenanceState current,
        ) =>
            current.status == BaseStateStatus.success &&
            (current.updateMaintenanceType != previous.updateMaintenanceType ||
                current.underMaintenanceType != previous.underMaintenanceType),
        listenWhen: (
          ForceUpdateUnderMaintenanceState previous,
          ForceUpdateUnderMaintenanceState current,
        ) =>
            current.status == BaseStateStatus.success &&
            current.updateMaintenanceType != previous.updateMaintenanceType,
      );

  void _showUpdateDialog(
    ForceUpdateConfigModel? configModel, {
    required bool isMandatory,
  }) {
    unawaited(
      showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext dialogContext) => PopScope(
          canPop: false,
          child: DialogUtils(
            isDialogHideOnClick: false,
            message: configModel?.forceUpdate?.forceUpdateMsg ?? '',
            title: configModel?.forceUpdate?.forceUpdateTitle ?? '',
            okBtnTitle: AppConstant.update,
            cancelBtnTitle:
                isMandatory ? null : context.appString.cancelKey,
            onOkClicked: () async {
              await context
                  .read<ForceUpdateUnderMaintenanceCubit>()
                  .openPlayStoreAppStore(dialogContext);
            },
            onCancelClicked: isMandatory
                ? null
                : () async {
                    goBack(dialogContext);
                    _updateDialogShown = false;
                    await _leaveMaintenanceFlow();
                  },
          ),
        ),
      ),
    );
  }
}
