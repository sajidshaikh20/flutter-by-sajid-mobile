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
        );
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
          fetchTimeout: const Duration(seconds: Dimens.duration10),
          minimumFetchInterval: const Duration(seconds: Dimens.duration10),
        ),
      );
      await remoteConfig.fetchAndActivate();
      if (remoteConfig.getString(AppConstant.updateApp).isNotEmpty) {
        return ForceUpdateConfigModel.fromJson(
          jsonDecode(remoteConfig.getString(AppConstant.updateApp)),
        );
      }
    } on Exception catch (e) {
      debugPrint('Error fetching remote config: $e');
    }
    remoteConfig.onConfigUpdated.listen((RemoteConfigUpdate event) async {
      await checkAppUpdate();
    });
    return null;
  }

  ///check update or maintenance
  Future<void> checkAppUpdate() async {
    // showLoader(value: true);
    ForceUpdateConfigModel? config = await readRemoteConfig();
    UpdateMaintenanceType type = getUpdateOrMaintenanceType(config);

    //showLoader(value: false);
    switch (type) {
      case UpdateMaintenanceType.none:
        {
          bool isCountryAndLanguageSelected = SharedPref.instance.getBool(
            PrefsKey.isCountryAndLanguageSelectedKey,
           defValue: false,
          );

          emit(
            state.copyWith(
              updateMaintenanceType: UpdateMaintenanceType.none,
              underMaintenanceType: UnderMaintenanceType.none,
              redirectRoute: isCountryAndLanguageSelected
                  ?  AetherRoute()
                  :  AetherRoute(),
              status: BaseStateStatus.success,
            ),
          );
          // redirectToLogin(MainConfig.context);
        }
      case UpdateMaintenanceType.force:
        {
          emit(
            state.copyWith(
              updateMaintenanceType: UpdateMaintenanceType.force,
              underMaintenanceType: UnderMaintenanceType.none,
              forceUpdateConfigModel: config,
              status: BaseStateStatus.success,
            ),
          );
        }
      case UpdateMaintenanceType.optional:
        {
          emit(
            state.copyWith(
              updateMaintenanceType: UpdateMaintenanceType.optional,
              underMaintenanceType: UnderMaintenanceType.none,
              forceUpdateConfigModel: config,
              status: BaseStateStatus.success,
            ),
          );
        }
      case UpdateMaintenanceType.maintenance:
        emit(
          state.copyWith(
            forceUpdateConfigModel: config,
            updateMaintenanceType: UpdateMaintenanceType.maintenance,
            underMaintenanceType: _underMaintenanceType(config),
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
      // If maintenance mode is enabled, return maintenance type.
      return UpdateMaintenanceType.maintenance;
    }

    // Check for updates if not in web platform.
    if (!kIsWeb) {
      if (Platform.isAndroid) {
        // For Android, check the version details.
        if (androidMinVersion != null) {
          // If the current app version is less than the minimum Android
          // version,
          // force update is required.
          if (currentAppVersion.compareTo(androidMinVersion) < 0) {
            return UpdateMaintenanceType.force;
          } else if (androidMaxVersion != null &&
              currentAppVersion.compareTo(androidMinVersion) >= 0 &&
              currentAppVersion.compareTo(androidMaxVersion) < 0) {
            // If the current app version is between the min and max version,
            // optional update is required.
            return UpdateMaintenanceType.optional;
          }
        }
        // If none of the above conditions are met, no update is needed.
        return UpdateMaintenanceType.none;
      } else if (Platform.isIOS) {
        // For iOS, check the version details.
        if (iosMinVersion != null) {
          // If the current app version is less than the minimum iOS version,
          // force update is required.
          if (currentAppVersion.compareTo(iosMinVersion) < 0) {
            return UpdateMaintenanceType.force;
          } else if (iosMaxVersion != null &&
              currentAppVersion.compareTo(iosMinVersion) >= 0 &&
              currentAppVersion.compareTo(iosMaxVersion) < 0) {
            // If the current app version is between the min and max version,
            // optional update is required.
            return UpdateMaintenanceType.optional;
          }
        }
        // If none of the above conditions are met, no update is needed.
        return UpdateMaintenanceType.none;
      }
    }
    // If the platform is web, no update is required.
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

  /// open play store or app store
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
        await launchUrl(parseUrl);
        if (context.mounted) {
          goBack(context);
        }
      } else {
        throw Exception('Could not launch $parseUrl');
      }
    } on Exception catch (e) {
      debugPrint('Error launching store: $e');
    }
  }
}
