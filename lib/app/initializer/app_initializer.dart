import '../../utils/exports.dart';

// final remoteConfig = FirebaseRemoteConfig.instance;

/// A utility class for initializing the application.
/// This class handles error reporting, service initialization,
/// and application startup configurations.
class AppInitializer {
  AppInitializer._();

  /// Singleton instance
  static final AppInitializer instance = AppInitializer._();

  /// Initializes the application by setting up error handling,
  /// services, and running the app.
  Future<void> init(
      VoidCallback runApp,
      ) async {
    ErrorWidget.builder =
        (FlutterErrorDetails errorDetails) => CustomTextLabelWidget(
      label: errorDetails.exceptionAsString(),
    );
    await runZonedGuarded(() async {
      try {
        //   WidgetsFlutterBinding.ensureInitialized();
        WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
        FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
        await _initServices();

        // Set up error handlers after Firebase is initialized
        FlutterError.onError = (FlutterErrorDetails errorDetails) {
          // Only use Firebase Crashlytics if Firebase is initialized
          unawaited(logCrashlyticsError(errorDetails, null, fatal: true));
        };

        // Pass all uncaught asynchronous errors that aren't handled by the Flutter framework to Crashlytics
        PlatformDispatcher.instance.onError = (Object error, StackTrace stack) {
          // Only use Firebase Crashlytics if Firebase is initialized
          unawaited(logCrashlyticsError(error, stack));
          return true;
        };

        runApp();

        // Remove the native splash screen after app initialization is complete
        FlutterNativeSplash.remove();
      } on Exception catch (e) {
        DebugLog.instance.i('Error during app initialization: $e');
      }
    }, (Object exception, StackTrace stackTrace) async {
      DebugLog.instance.i('runZonedGuarded caught exception: $exception');
      DebugLog.instance.i('Stack trace: $stackTrace');
      // Only use Firebase Crashlytics if Firebase is initialized
      await logCrashlyticsError(exception, stackTrace);
      // await SentryService.instance.captureException(exception, stackTrace: stackTrace);
    });
    //set status bar color
  }

  Future<void> _initServices() async {
    try {
      // Critical services that must be awaited for app to function
      await setupLocator();
      await DebugLog.instance.init();
      await  FastCachedImageConfig.init(clearCacheAfter: const Duration(days: Dimens.days15));

      await FirebaseInitializer.instance.initialize();
      await _getPackageAndDeviceInfo();
      await _initStorage();
      await _initScreenPreference();

      // Non-critical services that can run in background
      unawaited(_setStatusBarThemeAsync());

      // Load data services with comprehensive logging
      DebugLog.instance.i('AppInitializer: Starting service data loading...');


      DebugLog.instance.i('AppInitializer: CountryService loaded');


      DebugLog.instance.i('AppInitializer: LanguageService loaded');

      // Verify services are properly loaded



      unawaited(NotificationManager.instance.init());

      // Request notification permission on app start (non-blocking)
      unawaited(_requestNotificationPermissionOnStart());
    } on Exception catch (err, stackTrace) {
      // Use DebugLog.instance.i for errors before DebugLog is available
      DebugLog.instance.i('Service initialization failed: $err');
      DebugLog.instance.i('Stack trace: $stackTrace');
      rethrow;
    }
  }

  /// Common method to check if Firebase is initialized
  bool get isFirebaseInitialized => Firebase.apps.isNotEmpty;

  /// StatusBar Customise - Async version for unawaited call
  Future<void> _setStatusBarThemeAsync() async {
    _setStatusBarTheme();
  }

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

  /// StatusBar Customise
  ///
  void _setStatusBarTheme() {
    SystemChrome.setSystemUIOverlayStyle(MainConfig.appTheme.systemOverlay());
  }

  Future<void> _getPackageAndDeviceInfo() async {
    if (Platform.isAndroid) {
      AndroidDeviceInfo androidDeviceInfo =
      await DeviceInfoPlugin().androidInfo;
      getIt<MainConfig>().androidInfo = androidDeviceInfo;
    } else if (Platform.isIOS) {
      IosDeviceInfo iosDeviceInfo = await DeviceInfoPlugin().iosInfo;
      getIt<MainConfig>().iosDeviceInfo = iosDeviceInfo;
    }

    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    getIt<MainConfig>().packageInfo = packageInfo;
  }

  /// Request notification permission on app start (non-blocking)
  /// This method asks for permission but doesn't force the user to enable it
  Future<void> _requestNotificationPermissionOnStart() async {
    try {
      // Wait a bit for the app to fully initialize
      await Future<void>.delayed(const Duration(seconds: 2));

      // If we've already asked once before and it's not granted, don't auto-request again
      final bool alreadyAsked = SharedPref.instance.getBool(
        PrefsKey.notificationPermissionAskedKey,
        defValue: false,
      );

      if (alreadyAsked) {
        DebugLog.instance.i('AppInitializer: Notification permission was already asked before; skipping auto-request');
        return;
      }

      // Check if permission is already granted
      final bool isAlreadyGranted = await AwesomeNotificationManager.instance.isNotificationPermissionGranted();

      if (!isAlreadyGranted) {
        DebugLog.instance.i('AppInitializer: Requesting notification permission on app start');

        // Request permission (non-blocking)
        final bool granted = await AwesomeNotificationManager.instance.requestNotificationPermission();

        if (granted) {
          DebugLog.instance.i('AppInitializer: Notification permission granted on app start');
          await SharedPref.instance.setValue(PrefsKey.notificationPermissionAskedKey, true);
        } else {
          DebugLog.instance.i('AppInitializer: Notification permission denied on app start - app continues normally');
          await SharedPref.instance.setValue(PrefsKey.notificationPermissionAskedKey, true);
        }
      } else {
        DebugLog.instance.i('AppInitializer: Notification permission already granted');
        await SharedPref.instance.setValue(PrefsKey.notificationPermissionAskedKey, true);
      }
    } on Exception catch (e) {
      DebugLog.instance.e('AppInitializer: Error requesting notification permission on start: $e');
      // Don't rethrow - app should continue even if permission request fails
    }
  }
}
