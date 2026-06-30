import 'package:flutter/foundation.dart';

const String _baseUrlKey = 'base_url';
const String _webBaseUrlKey = 'web_base_url';
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
const String _webAppId = 'webAppId';
const String _webApiKey = 'webApiKey';
const String _authDomain = 'authDomain';
const String _storageBucket = 'storageBucket';
const String _measurementId = 'measurementId';

///configBaseUrl
String get configBaseUrl {
  return const String.fromEnvironment(_baseUrlKey);
}

/// Relative or absolute API base URL used on web builds.
String get configWebBaseUrl {
  return const String.fromEnvironment(_webBaseUrlKey);
}

/// Platform-aware API base URL.
/// On web, uses [configWebBaseUrl] when set (for dev proxy or same-origin API).
String get configApiBaseUrl {
  if (kIsWeb) {
    final String webBaseUrl = configWebBaseUrl;
    if (webBaseUrl.isNotEmpty) {
      return webBaseUrl.endsWith('/') ? webBaseUrl : '$webBaseUrl/';
    }
  }
  final String baseUrl = configBaseUrl;
  return baseUrl.endsWith('/') ? baseUrl : '$baseUrl/';
}

String _webSocketUrlThroughDevProxy(String proxyPrefix) {
  final Uri page = Uri.base;
  final String wsScheme = page.scheme == 'https' ? 'wss' : 'ws';
  final String normalizedPrefix = proxyPrefix.endsWith('/')
      ? proxyPrefix.substring(0, proxyPrefix.length - 1)
      : proxyPrefix;
  return '$wsScheme://${page.authority}$normalizedPrefix/ws/websocket';
}

///configWebSocketUrl
String get configWebSocketUrl {
  if (kIsWeb) {
    final String webBaseUrl = configWebBaseUrl;
    if (webBaseUrl.startsWith('/')) {
      return _webSocketUrlThroughDevProxy(webBaseUrl);
    }
  }

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

///configWebAppId
String get configWebAppId {
  return const String.fromEnvironment(_webAppId);
}

///configWebApiKey
String get configWebApiKey {
  return const String.fromEnvironment(_webApiKey);
}

///configAuthDomain
String get configAuthDomain {
  return const String.fromEnvironment(_authDomain);
}

///configStorageBucket
String get configStorageBucket {
  return const String.fromEnvironment(_storageBucket);
}

///configMeasurementId
String get configMeasurementId {
  return const String.fromEnvironment(_measurementId);
}
