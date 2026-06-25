import '../../utils/exports.dart';

/// A utility class for initializing the application.
class AppInitializer {
  AppInitializer._();

  /// Singleton instance
  static final AppInitializer instance = AppInitializer._();

  /// Initializes the application by setting up error handling,
  /// services, and running the app.
  Future<void> init(VoidCallback runApp) async {
    ErrorWidget.builder = (FlutterErrorDetails errorDetails) =>
        CustomTextLabelWidget(
      label: errorDetails.exceptionAsString(),
    );

    await runZonedGuarded(() async {
      try {
        final WidgetsBinding widgetsBinding =
            WidgetsFlutterBinding.ensureInitialized();
        FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

        await _initCriticalServices();

        FlutterError.onError = (FlutterErrorDetails errorDetails) {
          unawaited(logCrashlyticsError(errorDetails, null, fatal: true));
        };

        PlatformDispatcher.instance.onError = (Object error, StackTrace stack) {
          unawaited(logCrashlyticsError(error, stack));
          return true;
        };

        runApp();
        FlutterNativeSplash.remove();

        unawaited(_initDeferredServices());
      } on Exception catch (e) {
        DebugLog.instance.i('Error during app initialization: $e');
      }
    }, (Object exception, StackTrace stackTrace) async {
      DebugLog.instance.i('runZonedGuarded caught exception: $exception');
      await logCrashlyticsError(exception, stackTrace);
    });
  }

  /// Required before [runApp]: storage, DI, Firebase (crash reporting).
  Future<void> _initCriticalServices() async {
    await setupLocator();
    await DebugLog.instance.init();
    if (kDebugMode) {
      DebugLog.instance.i(
        'App config → env: $configEnv, baseUrl: $configBaseUrl',
      );
    }
    // SharedPref encryption key is derived from packageName — must run before storage.
    await _getPackageAndDeviceInfo();
    await _initStorage();
    await _initScreenPreference();
    await FirebaseInitializer.instance.initialize();
    await getIt<UserProfileService>().loadUserData();
    DebugLog.instance.i('AppInitializer: UserProfileService loaded');
    _setStatusBarTheme();
  }

  /// Heavy / optional work after the first frame.
  Future<void> _initDeferredServices() async {
    try {
      unawaited(
        FastCachedImageConfig.init(
          clearCacheAfter: const Duration(days: Dimens.days15),
        ),
      );
      unawaited(getIt<LanguageService>().loadLanguageData());
      unawaited(NotificationManager.instance.init());
      SocketManager.instance.initialize();
    } on Exception catch (err, stackTrace) {
      DebugLog.instance.i('Deferred init failed: $err');
      DebugLog.instance.i('Stack trace: $stackTrace');
    }
  }

  bool get isFirebaseInitialized => Firebase.apps.isNotEmpty;

  FutureOr<void> _initStorage() async {
    await GetStorage.init();
    await SharedPref.instance.init();
  }


  Future<void> _initScreenPreference() async {
    await SystemChrome.setPreferredOrientations(
      <DeviceOrientation>[
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ],
    );
  }

  void _setStatusBarTheme() {
    SystemChrome.setSystemUIOverlayStyle(MainConfig.appTheme.systemOverlay());
  }

  Future<void> _getPackageAndDeviceInfo() async {
    if (Platform.isAndroid) {
      getIt<MainConfig>().androidInfo =
          await DeviceInfoPlugin().androidInfo;
    } else if (Platform.isIOS) {
      getIt<MainConfig>().iosDeviceInfo = await DeviceInfoPlugin().iosInfo;
    }
    getIt<MainConfig>().packageInfo = await PackageInfo.fromPlatform();
  }
}
