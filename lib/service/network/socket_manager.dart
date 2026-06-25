import '../../../utils/exports.dart';

/// Manages the application's socket connection, ensuring it stays in sync with network connectivity
/// and handles global trade notification events.
class SocketManager {
  SocketManager._internal();

  /// The single instance of `SocketManager`.
  static final SocketManager instance = SocketManager._internal();

  StreamSubscription<List<ConnectivityResult>>? _connectivitySubscription;
  StreamSubscription<Map<String, dynamic>>? _tradeNotificationSubscription;

  /// Initializes the `SocketManager` by listening to connectivity changes
  /// and subscribing to trade notification stream updates.
  void initialize() {
    _connectivitySubscription =
        Connectivity().onConnectivityChanged.listen((List<ConnectivityResult> result) async {
      final bool hasInternet =
          result.contains(ConnectivityResult.mobile) ||
          result.contains(ConnectivityResult.wifi);

      if (hasInternet) {
        final bool isLoggedIn =
            SharedPref.instance.getBool(PrefsKey.isLoggedInKey, defValue: false);
        if (isLoggedIn) {
          await connectSocket();
        }
      } else {
        disconnectSocket();
      }
    });

    // Handle incoming trade notification updates globally
    _tradeNotificationSubscription =
        MainConfig.chatSocketConnection.tradeNotificationStream.listen((Map<String, dynamic> data) {
      final String? message = data['message'] as String?;
      final String? symbol = data['symbol'] as String?;
      if (message != null && message.isNotEmpty) {
        unawaited(
          AwesomeNotificationManager.instance.showNotification(
            payload: <String, String>{
              'title': symbol != null ? '$symbol Trade Alert' : 'Trade Alert',
              'body': message,
            },
          ),
        );
      }
    });

    // Also trigger initial check
    scheduleMicrotask(() async {
      final bool isLoggedIn =
          SharedPref.instance.getBool(PrefsKey.isLoggedInKey, defValue: false);
      if (isLoggedIn) {
        final List<ConnectivityResult> result = await Connectivity().checkConnectivity();
        final bool hasInternet =
            result.contains(ConnectivityResult.mobile) ||
            result.contains(ConnectivityResult.wifi);
        if (hasInternet) {
          await connectSocket();
        }
      }
    });
  }

  /// Connects the socket connection.
  Future<void> connectSocket() async {
    final String token = UserProfileService.instance().accessToken;
    if (token.isEmpty) {
      DebugLog.instance.w('SocketManager: Cannot connect socket, token is empty');
      return;
    }
    await MainConfig.chatSocketConnection.connectSocket();
  }

  /// Disconnects the socket.
  void disconnectSocket({bool shouldClearTheSocket = false}) {
    MainConfig.chatSocketConnection.disconnectSocket(
      shouldClearTheSocket: shouldClearTheSocket,
    );
  }

  /// Cleans up resources.
  void dispose() {
    unawaited(_connectivitySubscription?.cancel());
    unawaited(_tradeNotificationSubscription?.cancel());
  }
}
