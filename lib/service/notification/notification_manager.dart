import '../../utils/exports.dart';

/// A manager class to handle Firebase messaging and Awesome notifications.
/// It manages FCM token retrieval, background, foreground, and opened app
/// messaging events, and also integrates with Firebase services
/// like Crashlytics
/// and Analytics.
class NotificationManager {
  /// Private constructor to ensure singleton pattern.
  NotificationManager._internal();

  /// Singleton instance of NotificationManager.
  static final NotificationManager instance = NotificationManager._internal();

  /// Initializes the notification manager by setting up Firebase and Awesome
  /// notifications, retrieving the FCM token, and setting up messaging events.
  Future<void> init() async {
    // Firebase is already initialized in AppInitializer, so we skip it here
    // await firebaseInitialize();
    await AwesomeNotificationManager.instance.init();
    _getBackgroundMessage();
    await _getToken();
    _onMessage();
    _onMessageOpenedApp();
  }

  /// Initializes Firebase, enabling Crashlytics and Analytics services.
  Future<void> firebaseInitialize() async {
    try {
      // Check if Firebase is already initialized
      if (Firebase.apps.isNotEmpty) {
        DebugLog.instance.i("Firebase already initialized, skipping initialization");
        return;
      }
      
      // Initialize Firebase
      await Firebase.initializeApp(
        options: getCurrentPlatformFirebaseOptions(),
      );
      
      // Enable Crashlytics
      await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(true);
      
      // Initialize Analytics

      
      DebugLog.instance.i("Firebase initialized successfully");
    } on Exception catch (e) {
      String errorMessage = e.toString();
      if (errorMessage.contains('duplicate-app') || errorMessage.contains('already exists')) {
        DebugLog.instance.i("Firebase app already exists, continuing with existing instance");
        // Try to enable services even if app already exists
        try {
          await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(true);

        }on Exception catch (serviceError) {
          DebugLog.instance.e("Error enabling Firebase services: $serviceError");
        }
      } else {
        DebugLog.instance.e("Error initializing Firebase: $e");
        rethrow;
      }
    }
  }

  /// Registers the background message handler for Firebase messaging.
  void _getBackgroundMessage() {
    // Only register background message handler if Firebase is initialized
    if (Firebase.apps.isNotEmpty) {
      FirebaseMessaging.onBackgroundMessage(firebaseBackground);
    } else {
      DebugLog.instance.w("Firebase not initialized, skipping background message registration");
    }
  }

  /// Retrieves the Firebase Cloud Messaging (FCM) token and stores it.
  Future<void> _getToken() async {
    // Only proceed if Firebase is initialized
    if (Firebase.apps.isEmpty) {
      DebugLog.instance.w("Firebase not initialized, skipping FCM token retrieval");
      return;
    }
    
    // Get APNs token firstCartListResponseModelCartListResponseModel
    if (Platform.isIOS) {
      String? apnsToken = await FirebaseMessaging.instance.getAPNSToken();

      if (apnsToken == null) {
        DebugLog.instance.e('APNs Token not available');
        // Handle the error or retry
        return;
      }

      DebugLog.instance.d('APNs Token: $apnsToken');
    }

    try {
      await FirebaseMessaging.instance.getToken().then((String? value) async {
        if (value != null) {
          //SentryService.instance.captureEvent(value.toString(), type: 'token');
          DebugLog.instance.d('FCM Token : $value');
          await SharedPref.instance.setValue(PrefsKey.fcmTokenKey, value);
        } else {
          DebugLog.instance.e('FCM Token not available');
        }
      });
    } on FirebaseException catch (e, st) {
      DebugLog.instance.e('Error getting FCM token: $e\n$st');
    }
    // Then get FCM token
  }

  /// Gets the current FCM token from SharedPreferences, refreshes if null/empty
  /// Returns the FCM token or null if unable to get one
  Future<String?> getOrRefreshFCMToken() async {
    String currentToken = SharedPref.instance.getString(PrefsKey.fcmTokenKey, '');
    
    if (currentToken.isNotEmpty) {
      DebugLog.instance.d('Using existing FCM token');
      return currentToken;
    } else {
      DebugLog.instance.i('FCM token is empty, refreshing...');
      return refreshFCMToken();
    }
  }

  /// Refreshes the FCM token and stores it in SharedPreferences
  /// This method should be called when the token is null or blank after logout
  Future<String?> refreshFCMToken() async {
    // Only proceed if Firebase is initialized
    if (Firebase.apps.isEmpty) {
      DebugLog.instance.w("Firebase not initialized, skipping FCM token refresh");
      return null;
    }
    
    try {
      DebugLog.instance.i('Refreshing FCM token...');
      
      // Get APNs token first for iOS
      if (Platform.isIOS) {
        String? apnsToken = await FirebaseMessaging.instance.getAPNSToken();
        if (apnsToken == null) {
          DebugLog.instance.e('APNs Token not available during refresh');
          return null;
        }
        DebugLog.instance.d('APNs Token refreshed: $apnsToken');
      }

      // Get fresh FCM token
      String? fcmToken = await FirebaseMessaging.instance.getToken();
      
      if (fcmToken != null && fcmToken.isNotEmpty) {
        DebugLog.instance.i('FCM Token refreshed successfully: $fcmToken');
        await SharedPref.instance.setValue(PrefsKey.fcmTokenKey, fcmToken);
        return fcmToken;
      } else {
        DebugLog.instance.e('Failed to refresh FCM token - token is null or empty');
        return null;
      }
    } on FirebaseException catch (e, st) {
      DebugLog.instance.e('Error refreshing FCM token: $e\n$st');
      return null;
    } on Exception catch (e) {
      DebugLog.instance.e('Unexpected error refreshing FCM token: $e');
      return null;
    }
  }


  /// Listens for foreground messages from Firebase Cloud Messaging (FCM).
  void _onMessage() {
    // Only proceed if Firebase is initialized
    if (Firebase.apps.isEmpty) {
      DebugLog.instance.w("Firebase not initialized, skipping foreground message listener");
      return;
    }
    
    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      DebugLog.instance.i(
        'FCM Foreground Message : ${message.data} ${message.notification}',
      );
      DebugLog.instance.i(
        'FCM Foreground Message : ${message.data}',
      );
      DebugLog.instance.i(
        'FCM Foreground Message :${message.notification}',
      );
      if (Platform.isAndroid) {
        await AwesomeNotificationManager.instance
            .showNotification(payload: message.data);
      }
    });
  }

  /// Listens for when the app is opened from the background state
  ///  via a FCM message.
  void _onMessageOpenedApp() {
    // Only proceed if Firebase is initialized
    if (Firebase.apps.isEmpty) {
      DebugLog.instance.w("Firebase not initialized, skipping message opened app listener");
      return;
    }
    
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      DebugLog.instance.i(
        'FCM MessageOpenedApp Message : ${message.data} ${message.notification}',
      );

      Map<String, dynamic> data = message.data;
      String type = data['type']?.toString().toLowerCase() ?? '';
      String entity = data['entity']?.toString().toLowerCase() ?? '';

      DebugLog.instance.i(
        'FCM MessageOpenedApp Message type : $type',
      );
      DebugLog.instance.i(
        'FCM MessageOpenedApp Message entity : $entity',
      );

    });
  }
}
