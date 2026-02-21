import '../utils/exports.dart';

/// Configuration class that provides access to app-level services and info.
class MainConfig {
  /// Device information for Android platform.
  late final AndroidDeviceInfo androidInfo;

  /// Device information for iOS platform.
  late final IosDeviceInfo iosDeviceInfo;

  /// Information about the current web browser.
  late final WebBrowserInfo webBrowserInfo;

  /// Information about the app's package (version, build, etc.).
  late final PackageInfo packageInfo;

  /// Whether tablet support is enabled in the app.
  static bool get isTabletSupport => false;

  /// Provides the [ApiClient] instance.
  static ApiClient get apiClient => getIt<ApiClient>();

  /// Provides the current app [BuildContext].
  static BuildContext context = getIt<AppRouter>().navigatorKey.currentContext!;

  /// Provides the current tab context [BuildContext].
  static BuildContext tabContext =
  getIt<AppRouter>().navigatorKey.currentContext!;

  /// Retrieves the text theme for the current context.
  static TextTheme get textTheme => MainConfig.context.theme.textTheme;

  /// Provides the [JsonDataManagerService] instance.
  static JsonDataManagerService get jsonServiceManager =>
      getIt<JsonDataManagerService>();


  /// Retrieves a dynamic string value by name from the JsonDataManagerService.
  static String dynamicString(String name) =>
      getIt<JsonDataManagerService>().getValue(name);

  /// Retrieves the current AppString instance for localization.
  static AppString get appString => AppString.of(context);

  /// create instance of AppColors
  static AppColors get appColors => getIt<AppColors>();

  ///appStyle
  static AppStyles get appStyle => getIt<AppStyles>();

  /// appTheme
  static MyAppTheme get appTheme => getIt<MyAppTheme>();
}
