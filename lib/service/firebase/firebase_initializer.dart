import '../../utils/exports.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

/// A dedicated service for handling Firebase initialization.
/// This service ensures Firebase is initialized only once and handles
/// platform-specific initialization logic.
class FirebaseInitializer {
  FirebaseInitializer._();

  /// Singleton instance
  static final FirebaseInitializer instance = FirebaseInitializer._();

  /// Initialize Firebase early in the app lifecycle
  Future<void> initialize() async {
    // Skip Firebase initialization on web if not configured
    if (kIsWeb) {
      DebugLog.instance.i("Firebase initialization skipped on web (not configured)");
      return;
    }

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
        // For iOS and web, don't rethrow Firebase errors - app can work without Firebase
        if (kIsWeb) {
          DebugLog.instance.w("Firebase initialization failed on web, app will continue without Firebase");
        } else if (!kIsWeb && Platform.isIOS) {
          DebugLog.instance.w("Firebase initialization failed on iOS, app will continue without Firebase");
        } else {
          rethrow;
        }
      }
    }
  }

  /// Check if Firebase is already initialized
  bool get isInitialized => Firebase.apps.isNotEmpty;
}
