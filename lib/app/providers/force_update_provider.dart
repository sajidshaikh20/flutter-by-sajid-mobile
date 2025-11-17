import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../utils/exports.dart';
import '../../modules/force_update_under_maintenance/state/force_update_under_maintenance_state.dart';

/// Notifier for managing force update and maintenance state (Riverpod version).
class ForceUpdateNotifier extends StateNotifier<ForceUpdateUnderMaintenanceState> {
  /// Creates a force update notifier.
  ForceUpdateNotifier()
      : super(
          const ForceUpdateUnderMaintenanceState(
            status: BaseStateStatus.initial,
            underMaintenanceType: UnderMaintenanceType.none,
            updateMaintenanceType: UpdateMaintenanceType.none,
          ),
        );

  /// Get remote config details
  Future<ForceUpdateConfigModel?> readRemoteConfig() async {
    final FirebaseRemoteConfig remoteConfig = FirebaseRemoteConfig.instance;
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

  /// Check update or maintenance
  Future<void> checkAppUpdate() async {
    final ForceUpdateConfigModel? config = await readRemoteConfig();
    final UpdateMaintenanceType type = getUpdateOrMaintenanceType(config);

    switch (type) {
      case UpdateMaintenanceType.none:
        {
          final bool isCountryAndLanguageSelected = SharedPref.instance.getBool(
            PrefsKey.isCountryAndLanguageSelectedKey,
            defValue: false,
          );

          state = state.copyWith(
            updateMaintenanceType: UpdateMaintenanceType.none,
            underMaintenanceType: UnderMaintenanceType.none,
            redirectRoute: isCountryAndLanguageSelected
                ? const DashboardRoute()
                : const LanguageSelectionRoute(),
            status: BaseStateStatus.success,
          );
        }
      case UpdateMaintenanceType.force:
        {
          state = state.copyWith(
            updateMaintenanceType: UpdateMaintenanceType.force,
            underMaintenanceType: UnderMaintenanceType.none,
            forceUpdateConfigModel: config,
            status: BaseStateStatus.success,
          );
        }
      case UpdateMaintenanceType.optional:
        {
          state = state.copyWith(
            updateMaintenanceType: UpdateMaintenanceType.optional,
            underMaintenanceType: UnderMaintenanceType.none,
            forceUpdateConfigModel: config,
            status: BaseStateStatus.success,
          );
        }
      case UpdateMaintenanceType.maintenance:
        {
          state = state.copyWith(
            updateMaintenanceType: UpdateMaintenanceType.maintenance,
            underMaintenanceType: _underMaintenanceType(config),
            forceUpdateConfigModel: config,
            status: BaseStateStatus.success,
          );
        }
    }
  }

  /// Determines the type of update or maintenance required based on the current
  /// app version and the configuration settings.
  UpdateMaintenanceType getUpdateOrMaintenanceType(
      ForceUpdateConfigModel? config) {
    String? androidMinVersion = config?.forceUpdate?.androidMinVersion;
    String? androidMaxVersion = config?.forceUpdate?.androidMaxVersion;
    String? iosMaxVersion = config?.forceUpdate?.iosMaxVersion;
    String? iosMinVersion = config?.forceUpdate?.iosMinVersion;
    String currentAppVersion = getIt<MainConfig>().packageInfo.version;

    if (config?.underMaintenance?.isMaintainanceModeEnable ?? false) {
      return UpdateMaintenanceType.maintenance;
    }

    if (!kIsWeb) {
      if (Platform.isAndroid) {
        if (androidMinVersion != null) {
          if (currentAppVersion.compareTo(androidMinVersion) < 0) {
            return UpdateMaintenanceType.force;
          } else if (androidMaxVersion != null &&
              currentAppVersion.compareTo(androidMinVersion) >= 0 &&
              currentAppVersion.compareTo(androidMaxVersion) < 0) {
            return UpdateMaintenanceType.optional;
          }
        }
        return UpdateMaintenanceType.none;
      } else if (Platform.isIOS) {
        if (iosMinVersion != null) {
          if (currentAppVersion.compareTo(iosMinVersion) < 0) {
            return UpdateMaintenanceType.force;
          } else if (iosMaxVersion != null &&
              currentAppVersion.compareTo(iosMinVersion) >= 0 &&
              currentAppVersion.compareTo(iosMaxVersion) < 0) {
            return UpdateMaintenanceType.optional;
          }
        }
        return UpdateMaintenanceType.none;
      }
    }
    return UpdateMaintenanceType.none;
  }

  /// Check if under maintenance image
  UnderMaintenanceType _underMaintenanceType(
    ForceUpdateConfigModel? config,
  ) {
    if ((config?.underMaintenance?.maintainancePriority ?? 0) ==
        UnderMaintenanceType.image.type) {
      return UnderMaintenanceType.image;
    } else {
      return UnderMaintenanceType.text;
    }
  }
}

/// Provider for ForceUpdateNotifier (singleton for app-wide use).
final StateNotifierProvider<ForceUpdateNotifier, ForceUpdateUnderMaintenanceState> forceUpdateNotifierProvider =
    StateNotifierProvider<ForceUpdateNotifier, ForceUpdateUnderMaintenanceState>((Ref ref) {
  return ForceUpdateNotifier();
});

/// Opens Play Store or App Store for app update.
extension ForceUpdateNotifierExtension on ForceUpdateNotifier {
  Future<void> openPlayStoreAppStore(BuildContext context) async {
    final String packageName = getIt<MainConfig>().packageInfo.packageName;
    final String appId = Platform.isIOS ? packageName : packageName;
    
    if (Platform.isAndroid) {
      final Uri playStoreUri = Uri.parse('https://play.google.com/store/apps/details?id=$packageName');
      if (await canLaunchUrl(playStoreUri)) {
        await launchUrl(playStoreUri, mode: LaunchMode.externalApplication);
      }
    } else if (Platform.isIOS) {
      final Uri appStoreUri = Uri.parse('https://apps.apple.com/app/id$appId');
      if (await canLaunchUrl(appStoreUri)) {
        await launchUrl(appStoreUri, mode: LaunchMode.externalApplication);
      }
    }
  }
}

