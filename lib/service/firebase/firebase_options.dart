import '../../utils/exports.dart';

/// Returns the Firebase options based on the current platform.
FirebaseOptions getCurrentPlatformFirebaseOptions() {
  if (kIsWeb) {
    if (configWebAppId.isEmpty) {
      throw UnsupportedError(
        'Firebase web is not configured. Add webAppId to your env JSON.',
      );
    }

    final String apiKey = configWebApiKey.isNotEmpty
        ? configWebApiKey
        : configAndroidApiKey;
    final String authDomain = configAuthDomain.isNotEmpty
        ? configAuthDomain
        : '$configProjectId.firebaseapp.com';
    final String storageBucket = configStorageBucket.isNotEmpty
        ? configStorageBucket
        : '$configProjectId.firebasestorage.app';

    return FirebaseOptions(
      apiKey: apiKey,
      appId: configWebAppId,
      messagingSenderId: configMessagingSenderId,
      projectId: configProjectId,
      authDomain: authDomain,
      storageBucket: storageBucket,
      measurementId:
          configMeasurementId.isNotEmpty ? configMeasurementId : null,
    );
  }

  switch (defaultTargetPlatform) {
    case TargetPlatform.android:
      return FirebaseOptions(
        apiKey: configAndroidApiKey,
        appId: configAndroidAppId,
        messagingSenderId: configMessagingSenderId,
        projectId: configProjectId,
      );
    case TargetPlatform.iOS:
      return FirebaseOptions(
        apiKey: configIOSApiKey,
        appId: configIosAppId,
        messagingSenderId: configMessagingSenderId,
        projectId: configProjectId,
      );
    case TargetPlatform.macOS:
    case TargetPlatform.fuchsia:
    case TargetPlatform.linux:
    case TargetPlatform.windows:
      throw UnsupportedError(
        'DefaultFirebaseOptions have not been configured for '
        '$defaultTargetPlatform.',
      );
  }
}
