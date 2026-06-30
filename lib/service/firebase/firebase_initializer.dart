import '../../utils/exports.dart';

/// A dedicated service for handling Firebase initialization.
/// This service ensures Firebase is initialized only once and handles
/// platform-specific initialization logic.
class FirebaseInitializer {
  FirebaseInitializer._();

  /// Singleton instance
  static final FirebaseInitializer instance = FirebaseInitializer._();

  /// Initialize Firebase early in the app lifecycle
  Future<void> initialize() async {
    if (kIsWeb && configWebAppId.isEmpty) {
      DebugLog.instance.w(
        'Firebase web is not configured (webAppId missing). '
        'Skipping Firebase initialization on web.',
      );
      return;
    }

    try {
      if (Firebase.apps.isEmpty) {
        await Firebase.initializeApp(
          options: getCurrentPlatformFirebaseOptions(),
        );
        try {
          if (!kIsWeb) {
            await FirebaseCrashlytics.instance
                .setCrashlyticsCollectionEnabled(true);
          }
          DebugLog.instance.i('Firebase services enabled successfully');
        } on Exception catch (serviceError) {
          DebugLog.instance.e('Error enabling Firebase services: $serviceError');
        }
      } else {
        DebugLog.instance.i('Firebase already initialized');
      }
    } catch (e) {
      final String errorMessage = e.toString();
      if (errorMessage.contains('duplicate-app') ||
          errorMessage.contains('already exists')) {
        DebugLog.instance.i('Firebase app already exists, continuing');
      } else {
        DebugLog.instance.e('Error initializing Firebase: $e');
        if (!kIsWeb && !Platform.isIOS) {
          rethrow;
        }
        DebugLog.instance.w(
          'Firebase initialization failed, app will continue without Firebase',
        );
      }
    }
  }

  /// Check if Firebase is already initialized
  bool get isInitialized => Firebase.apps.isNotEmpty;
}
