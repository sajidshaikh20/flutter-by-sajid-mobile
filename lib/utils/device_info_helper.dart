import 'exports.dart';

mixin DeviceInfoHelper {
  static String getDeviceType() {
    if (kIsWeb) return 'WEB';
    if (Platform.isAndroid) return 'ANDROID';
    if (Platform.isIOS) return 'IOS';
    return 'UNKNOWN';
  }

  static String getDeviceId() {
    if (kIsWeb) {
      return getIt<MainConfig>().webBrowserInfo.userAgent ?? 'web_browser';
    }
    if (Platform.isAndroid) {
      return getIt<MainConfig>().androidInfo.id;
    }
    if (Platform.isIOS) {
      return getIt<MainConfig>().iosDeviceInfo.identifierForVendor ?? '';
    }
    return '';
  }

  static String getPlatform() {
    if (kIsWeb) {
      return 'Web (${getIt<MainConfig>().webBrowserInfo.browserName.name})';
    }
    if (Platform.isAndroid) {
      final AndroidDeviceInfo androidInfo = getIt<MainConfig>().androidInfo;
      return 'Android ${androidInfo.version.release} (API ${androidInfo.version.sdkInt})';
    }
    if (Platform.isIOS) {
      final IosDeviceInfo iosInfo = getIt<MainConfig>().iosDeviceInfo;
      return '${iosInfo.systemName} ${iosInfo.systemVersion}';
    }
    return Platform.operatingSystem;
  }

  static String getAppVersion() {
    return getIt<MainConfig>().packageInfo.version;
  }
}
