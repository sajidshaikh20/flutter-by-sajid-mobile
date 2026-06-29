const String _baseUrlKey = 'base_url';
const String _webSocketKey = 'web_socket';
const String _androidAppId = 'androidAppId';
const String _iosAppId = 'iosAppId';
const String _messagingSenderId = 'messagingSenderId';
const String _projectId = 'projectId';
const String _iosApiKey = 'iosApiKey';
const String _androidApiKey = 'androidApiKey';
const String _sentryDSNKey = 'sentryDSN';
const String _envKey = 'envKey';
const String _googleApiKey = 'googleApiKey';
const String _googleClientId = 'googleClientId';

///configBaseUrl
String get configBaseUrl {
  return const String.fromEnvironment(_baseUrlKey);
}

///configWebSocketUrl
String get configWebSocketUrl {
  final String rawWs = const String.fromEnvironment(_webSocketKey);
  if (rawWs.isEmpty) {
    return 'wss://thevinaymalviya.org/ws/websocket';
  }
  String wsUrl = rawWs;
  if (wsUrl.startsWith('https://')) {
    wsUrl = wsUrl.replaceFirst('https://', 'wss://');
  } else if (wsUrl.startsWith('http://')) {
    wsUrl = wsUrl.replaceFirst('http://', 'ws://');
  }
  if (wsUrl.endsWith('/')) {
    wsUrl = wsUrl.substring(0, wsUrl.length - 1);
  }
  return '$wsUrl/websocket';
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

///configGoogleClientId
String get configGoogleClientId {
  return const String.fromEnvironment(_googleClientId);
}
