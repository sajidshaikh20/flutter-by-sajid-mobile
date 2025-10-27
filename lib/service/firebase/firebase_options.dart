import '../../utils/exports.dart';

/// Returns the Firebase options based on the current platform.
///
/// This method fetches the Firebase configuration values for the platform
/// where the app is running. It throws an [UnsupportedError] for web, macOS,
/// fuchsia, linux, and windows platforms, indicating that Firebase options
/// are not configured for those platforms. For Android and iOS, it returns
/// the corresponding Firebase configuration options.
FirebaseOptions getCurrentPlatformFirebaseOptions() {
  if (kIsWeb) {
    //
    throw UnsupportedError(
      'DefaultFirebaseOptions have not been configured for web - '
          'you can reconfigure this by running the FlutterFire CLI again.',
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
      throw UnsupportedError(
        'DefaultFirebaseOptions have not been configured for macos - '
            'you can reconfigure this by running the FlutterFire CLI again.',
      );
    case TargetPlatform.fuchsia:
      throw UnsupportedError(
        'DefaultFirebaseOptions have not been configured for macos - '
            'you can reconfigure this by running the FlutterFire CLI again.',
      );
    case TargetPlatform.linux:
      throw UnsupportedError(
        'DefaultFirebaseOptions have not been configured for macos - '
            'you can reconfigure this by running the FlutterFire CLI again.',
      );
    case TargetPlatform.windows:
      throw UnsupportedError(
        'DefaultFirebaseOptions have not been configured for macos - '
            'you can reconfigure this by running the FlutterFire CLI again.',
      );
  }
}
