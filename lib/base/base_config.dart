const String _baseUrlKey = 'base_url';
const String _androidAppId = 'androidAppId';
const String _iosAppId = 'iosAppId';
const String _messagingSenderId = 'messagingSenderId';
const String _projectId = 'projectId';
const String _iosApiKey = 'iosApiKey';
const String _androidApiKey = 'androidApiKey';
const String _sentryDSNKey = 'sentryDSN';
const String _envKey = 'envKey';
const String _googleApiKey = 'googleApiKey';


///configBaseUrl
String get configBaseUrl {
  return const String.fromEnvironment(_baseUrlKey);
}

///configEnv
String get configEnv {
  return const String.fromEnvironment(_envKey);
}

///configAndroidAppId
String get configAndroidAppId {
  return const String.fromEnvironment(_androidAppId);
}
///configIosAppId
String get configIosAppId {
  return const String.fromEnvironment(_iosAppId);
}



///configSentryDSN
String get configSentryDSN {
  return const String.fromEnvironment(_sentryDSNKey);
}
///configMessagingSenderId
String get configMessagingSenderId {
  return const String.fromEnvironment(_messagingSenderId);
}
///configProjectId
String get configProjectId {
  return const String.fromEnvironment(_projectId);
}
///configIOSApiKey
String get configIOSApiKey {
  return const String.fromEnvironment(_iosApiKey);
}
///configAndroidApiKey
String get configAndroidApiKey {
  return const String.fromEnvironment(_androidApiKey);
}
///configGoogleApiKey
String get configGoogleApiKey {
  return const String.fromEnvironment(_googleApiKey);
}
