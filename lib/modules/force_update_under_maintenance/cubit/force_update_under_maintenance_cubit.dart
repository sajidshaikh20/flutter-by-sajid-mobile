import '../../../utils/exports.dart';

/// A Cubit for managing the state of force update and under maintenance
/// information in the application.
class ForceUpdateUnderMaintenanceCubit
    extends Cubit<ForceUpdateUnderMaintenanceState> {

  /// The constructor for ForceUpdateUnderMaintenanceCubit.
  ///
  /// Initializes the state with default values for status,
  /// underMaintenanceType,
  /// and updateMaintenanceType.
  ForceUpdateUnderMaintenanceCubit()
      : super(
          const ForceUpdateUnderMaintenanceState(
            status: BaseStateStatus.initial,
            underMaintenanceType: UnderMaintenanceType.none,
            updateMaintenanceType: UpdateMaintenanceType.none,
          ),
        ) {
    FirebaseRemoteConfig.instance.onConfigUpdated.listen(
      (RemoteConfigUpdate event) async {
        try {
          await FirebaseRemoteConfig.instance.activate();
          await checkAppUpdate(syncNavigation: true);
        } on Object catch (e) {
          debugPrint('Error applying remote config update: $e');
        }
      },
    );
  }
  /// Static method to get the instance of ForceUpdateUnderMaintenanceCubit from
  /// the service locator (e.g., GetIt).
  static ForceUpdateUnderMaintenanceCubit instance() =>
      getIt<ForceUpdateUnderMaintenanceCubit>();

  ///get remote config details
  Future<ForceUpdateConfigModel?> readRemoteConfig() async {
    FirebaseRemoteConfig remoteConfig = FirebaseRemoteConfig.instance;
    try {
      await remoteConfig.setConfigSettings(
        RemoteConfigSettings(
          fetchTimeout: const Duration(seconds: 3),
          minimumFetchInterval: const Duration(hours: 1),
        ),
      );
      await remoteConfig.fetchAndActivate();
      if (remoteConfig.getString(AppConstant.updateApp).isNotEmpty) {
        return ForceUpdateConfigModel.fromJson(
          jsonDecode(remoteConfig.getString(AppConstant.updateApp)),
        );
      }
    } on Object catch (e) {
      debugPrint('Error fetching remote config: $e');
    }
    return null;
  }

  /// Fetches remote config, updates state, and returns the required action.
  ///
  /// When [syncNavigation] is true, navigates to/from the maintenance route
  /// based on the result (used after remote-config changes or app resume).
  Future<UpdateMaintenanceType> checkAppUpdate({
    bool syncNavigation = false,
  }) async {
    final ForceUpdateConfigModel? config = await readRemoteConfig();
    final UpdateMaintenanceType type = getUpdateOrMaintenanceType(config);
    _emitForUpdateType(type, config);
    if (syncNavigation) {
      syncNavigationWithUpdateType(type);
    }
    return type;
  }

  /// Aligns the navigation stack with [type] when the router is mounted.
  void syncNavigationWithUpdateType(UpdateMaintenanceType type) {
    if (!getIt.isRegistered<AppRouter>()) {
      return;
    }
    final AppRouter router = getIt<AppRouter>();
    if (router.navigatorKey.currentContext == null) {
      return;
    }

    final bool onMaintenance = _isOnMaintenanceRoute(router);

    if (type == UpdateMaintenanceType.none) {
      if (onMaintenance) {
        unawaited(router.replacePath(AppPaths.splash));
      }
      return;
    }

    if (!onMaintenance) {
      unawaited(router.pushPath(AppPaths.maintenance));
    }
  }

  bool _isOnMaintenanceRoute(AppRouter router) {
    final String path = router.currentPath;
    return path == AppPaths.maintenance || path.endsWith(AppPaths.maintenance);
  }

  void _emitForUpdateType(
    UpdateMaintenanceType type,
    ForceUpdateConfigModel? config,
  ) {
    switch (type) {
      case UpdateMaintenanceType.none:
        emit(
          state.copyWith(
            updateMaintenanceType: UpdateMaintenanceType.none,
            underMaintenanceType: UnderMaintenanceType.none,
            isAlertDialogVisible: false,
            status: BaseStateStatus.success,
          ),
        );
      case UpdateMaintenanceType.force:
        emit(
          state.copyWith(
            updateMaintenanceType: UpdateMaintenanceType.force,
            underMaintenanceType: UnderMaintenanceType.none,
            forceUpdateConfigModel: config,
            isAlertDialogVisible: false,
            status: BaseStateStatus.success,
          ),
        );
      case UpdateMaintenanceType.optional:
        emit(
          state.copyWith(
            updateMaintenanceType: UpdateMaintenanceType.optional,
            underMaintenanceType: UnderMaintenanceType.none,
            forceUpdateConfigModel: config,
            isAlertDialogVisible: false,
            status: BaseStateStatus.success,
          ),
        );
      case UpdateMaintenanceType.maintenance:
        emit(
          state.copyWith(
            forceUpdateConfigModel: config,
            updateMaintenanceType: UpdateMaintenanceType.maintenance,
            underMaintenanceType: _underMaintenanceType(config),
            isAlertDialogVisible: false,
            status: BaseStateStatus.success,
          ),
        );
    }
  }

  /// Determines the type of update or maintenance required based on the current
  /// app version and the configuration settings.
  UpdateMaintenanceType getUpdateOrMaintenanceType(
      ForceUpdateConfigModel? config,
      ) {
    // Get the details for the minimum and maximum Android version allowed.
    String? androidMinVersion = config?.forceUpdate?.androidMinVersion;
    String? androidMaxVersion = config?.forceUpdate?.androidMaxVersion;

    // Get the details for the minimum and maximum iOS version allowed.
    String? iosMaxVersion = config?.forceUpdate?.iosMaxVersion;
    String? iosMinVersion = config?.forceUpdate?.iosMinVersion;

    // Get the current app version from the package info.
    String currentAppVersion = getIt<MainConfig>().packageInfo.version;

    // Check if maintenance mode is enabled in the configuration.
    if (config?.underMaintenance?.isMaintainanceModeEnable ?? false) {
      return UpdateMaintenanceType.maintenance;
    }

    // Check for updates if not in web platform.
    if (!kIsWeb) {
      if (Platform.isAndroid) {
        return _androidUpdateType(
          currentAppVersion: currentAppVersion,
          minVersion: androidMinVersion,
          maxVersion: androidMaxVersion,
        );
      } else if (Platform.isIOS) {
        return _iosUpdateType(
          currentAppVersion: currentAppVersion,
          minVersion: iosMinVersion,
          maxVersion: iosMaxVersion,
        );
      }
    }
    // If the platform is web, no update is required.
    return UpdateMaintenanceType.none;
  }


  UpdateMaintenanceType _androidUpdateType({
    required String currentAppVersion,
    required String? minVersion,
    required String? maxVersion,
  }) {
    if (minVersion == null || minVersion.isEmpty) {
      return UpdateMaintenanceType.none;
    }
    if (compareAppVersions(currentAppVersion, minVersion) < 0) {
      return UpdateMaintenanceType.force;
    }
    if (maxVersion != null &&
        maxVersion.isNotEmpty &&
        compareAppVersions(currentAppVersion, minVersion) >= 0 &&
        compareAppVersions(currentAppVersion, maxVersion) < 0) {
      return UpdateMaintenanceType.optional;
    }
    return UpdateMaintenanceType.none;
  }

  UpdateMaintenanceType _iosUpdateType({
    required String currentAppVersion,
    required String? minVersion,
    required String? maxVersion,
  }) {
    if (minVersion == null || minVersion.isEmpty) {
      return UpdateMaintenanceType.none;
    }
    if (compareAppVersions(currentAppVersion, minVersion) < 0) {
      return UpdateMaintenanceType.force;
    }
    if (maxVersion != null &&
        maxVersion.isNotEmpty &&
        compareAppVersions(currentAppVersion, minVersion) >= 0 &&
        compareAppVersions(currentAppVersion, maxVersion) < 0) {
      return UpdateMaintenanceType.optional;
    }
    return UpdateMaintenanceType.none;
  }

  ///check if under maintenance image
  static UnderMaintenanceType _underMaintenanceType(
    ForceUpdateConfigModel? config,
  ) {
    if ((config?.underMaintenance?.maintainancePriority ?? 0) ==
        UnderMaintenanceType.image.type) {
      return UnderMaintenanceType.image;
    } else {
      return UnderMaintenanceType.text;
    }
  }

  /// Opens the platform store in an external browser/app.
  Future<void> openPlayStoreAppStore(BuildContext context) async {
    Uri parseUrl;
    try {
      if (Platform.isAndroid) {
        parseUrl = Uri.parse('${AppConstant.playStoreURL}${AppConstant.appId}');
      } else if (Platform.isIOS) {
        parseUrl =
            Uri.parse('${AppConstant.appstoreURL}${AppConstant.appStoreId}');
      } else {
        throw PlatformException(
          code:  AppConstant.platformNotSupportedCode,
          message: AppConstant.platformNotSupportedMessage
          ,
        );
      }

      if (await canLaunchUrl(parseUrl)) {
        await launchUrl(parseUrl, mode: LaunchMode.externalApplication);
      } else {
        throw Exception('Could not launch $parseUrl');
      }
    } on Exception catch (e) {
      debugPrint('Error launching store: $e');
    }
  }
}
