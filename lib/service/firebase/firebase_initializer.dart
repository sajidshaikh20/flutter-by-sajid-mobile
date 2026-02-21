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
    try {
      if (Firebase.apps.isEmpty) {
        // For iOS, let Firebase auto-initialize using the GoogleService-Info.plist file
        await Firebase.initializeApp(
          options: getCurrentPlatformFirebaseOptions(),
        );
        // Try to enable Firebase services
        try {
          await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(true);

          DebugLog.instance.i("Firebase services enabled successfully");
        } on Exception catch (serviceError) {
          DebugLog.instance.e("Error enabling Firebase services: $serviceError");
          // Don't rethrow service errors, app can continue without them
        }
      } else {
        DebugLog.instance.i("Firebase already initialized");
      }
    } catch (e) {
      String errorMessage = e.toString();
      if (errorMessage.contains('duplicate-app') || errorMessage.contains('already exists')) {
        DebugLog.instance.i("Firebase app already exists, continuing");
      } else {
        DebugLog.instance.e("Error initializing Firebase: $e");
        // For iOS, don't rethrow Firebase errors - app can work without Firebase
        if (!Platform.isIOS) {
          rethrow;
        } else {
          DebugLog.instance.w("Firebase initialization failed on iOS, app will continue without Firebase");
        }
      }
    }
  }

  /// Check if Firebase is already initialized
  bool get isInitialized => Firebase.apps.isNotEmpty;
}
