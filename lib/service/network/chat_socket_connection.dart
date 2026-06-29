import 'package:stomp_dart_client/stomp_dart_client.dart';
import '../../../utils/exports.dart';

/// Class managing the WebSocket connection over the STOMP protocol.
class ChatSocketConnection {
  StompClient? _client;
  bool _isConnected = false;
  final Set<String> _registeredSymbols = <String>{};
  void Function({Map<String, String>? unsubscribeHeaders})? _pricesSubscription;

  // Broadcast stream controllers to distribute updates to multiple listeners
  final StreamController<Map<String, dynamic>> _priceStreamController =
      StreamController<Map<String, dynamic>>.broadcast();
  final StreamController<Map<String, dynamic>> _tradeStreamController =
      StreamController<Map<String, dynamic>>.broadcast();
  final StreamController<Map<String, dynamic>> _tradeNotificationStreamController =
      StreamController<Map<String, dynamic>>.broadcast();

  /// Exposes live price updates stream.
  Stream<Map<String, dynamic>> get priceStream => _priceStreamController.stream;

  /// Exposes trade status updates stream.
  Stream<Map<String, dynamic>> get tradeStream => _tradeStreamController.stream;

  /// Exposes new trade notifications stream.
  Stream<Map<String, dynamic>> get tradeNotificationStream =>
      _tradeNotificationStreamController.stream;

  /// Returns true if currently connected to the WebSocket endpoint.
  bool get isConnected => _isConnected;

  /// Connection status message helper.
  String connectionStatus = "Disconnected";

  /// Returns the underlying StompClient if it exists.
  StompClient? getSocket() => _client;

  /// Connects to the raw WebSocket / STOMP endpoint.
  Future<void> connectSocket() async {
    final String token = UserProfileService.instance().accessToken;
    if (token.isEmpty) {
      DebugLog.instance.e('WebSocket: Cannot connect, access token is empty');
      connectionStatus = "Disconnected: Token Empty";
      return;
    }

    if (_client != null && _isConnected) {
      DebugLog.instance.d('WebSocket: Already connected');
      return;
    }

    // Clean up previous client before initiating a new connection
    disconnectSocket(shouldClearTheSocket: true);

    final String socketUrl = configWebSocketUrl;
    DebugLog.instance.i('WebSocket: Connecting to $socketUrl...');
    connectionStatus = "Connecting";

    _client = StompClient(
      config: StompConfig(
        url: socketUrl,
        onConnect: _onConnect,
        onDisconnect: _onDisconnect,
        onStompError: _onStompError,
        onWebSocketError: _onWebSocketError,
        onWebSocketDone: _onWebSocketDone,
        stompConnectHeaders: <String, String>{
          'Authorization': 'Bearer $token',
        },
        webSocketConnectHeaders: <String, String>{
          'Authorization': 'Bearer $token',
        },
      ),
    );

    _client!.activate();
  }

  void _onConnect(StompFrame frame) {
    _isConnected = true;
    connectionStatus = "Connected";
    DebugLog.instance.i('WebSocket: STOMP connection established.');
    
    // Subscribe to topics
    _subscribeTopics();
  }

  void _onDisconnect(StompFrame frame) {
    _isConnected = false;
    connectionStatus = "Disconnected";
    _pricesSubscription = null;
    DebugLog.instance.w('WebSocket: STOMP connection disconnected.');
  }

  void _onStompError(StompFrame frame) {
    DebugLog.instance.e('WebSocket: STOMP Error: ${frame.body}');
  }

  void _onWebSocketError(dynamic error) {
    DebugLog.instance.e('WebSocket: WebSocket Error: $error');
  }

  void _onWebSocketDone() {
    _isConnected = false;
    connectionStatus = "Disconnected";
    _pricesSubscription = null;
    DebugLog.instance.w('WebSocket: WebSocket Closed.');
  }

  void _subscribePricesTopic() {
    if (_client == null || !_client!.connected) return;
    if (_pricesSubscription != null) return; // Already subscribed

    DebugLog.instance.i('WebSocket: Subscribing to /topic/prices topic');
    _pricesSubscription = _client!.subscribe(
      destination: '/topic/prices',
      callback: (StompFrame frame) {
        if (frame.body != null) {
          try {
            final Map<String, dynamic> data =
                jsonDecode(frame.body!) as Map<String, dynamic>;
            _priceStreamController.add(data);
            DebugLog.instance.d('WebSocket: Price update received: $data');
          } on Exception catch (e) {
            DebugLog.instance.e('WebSocket: Error parsing price update: $e');
          }
        }
      },
    );
  }

  void _unsubscribePricesTopic() {
    if (_pricesSubscription != null) {
      DebugLog.instance.i('WebSocket: Unsubscribing from /topic/prices topic');
      try {
        _pricesSubscription!();
      } on Exception catch (e) {
        DebugLog.instance.e('WebSocket: Error unsubscribing from /topic/prices: $e');
      }
      _pricesSubscription = null;
    }
  }

  void _subscribeTopics() {
    if (_client == null || !_client!.connected) return;

    // 1. Subscribe to Live Market Price Updates if there are registered symbols
    if (_registeredSymbols.isNotEmpty) {
      _subscribePricesTopic();
    }

    // 2. Subscribe to Trade Status Updates
    _client!.subscribe(
      destination: '/topic/trades',
      callback: (StompFrame frame) {
        if (frame.body != null) {
          try {
            final Map<String, dynamic> data =
                jsonDecode(frame.body!) as Map<String, dynamic>;
            _tradeStreamController.add(data);
            DebugLog.instance.d('WebSocket: Trade status update received: $data');
          } on Exception catch (e) {
            DebugLog.instance.e('WebSocket: Error parsing trade update: $e');
          }
        }
      },
    );

    // 3. Subscribe to New Trade Notifications
    _client!.subscribe(
      destination: '/topic/trade-notifications',
      callback: (StompFrame frame) {
        if (frame.body != null) {
          try {
            final Map<String, dynamic> data =
                jsonDecode(frame.body!) as Map<String, dynamic>;
            _tradeNotificationStreamController.add(data);
            DebugLog.instance.d('WebSocket: Trade notification received: $data');
          }  on Exception catch (e) {
            DebugLog.instance.e('WebSocket: Error parsing trade notification: $e');
          }
        }
      },
    );
  }

  /// Disconnects the socket client and clears listeners.
  void disconnectSocket({bool shouldClearTheSocket = false}) {
    _unsubscribePricesTopic();
    if (_client != null) {
      _client!.deactivate();
      if (shouldClearTheSocket) {
        _client = null;
      }
    }
    _isConnected = false;
    connectionStatus = "Disconnected";
    DebugLog.instance.w("WebSocket: Disconnected socket manually");
  }

  /// Registers a symbol with the backend so it begins streaming live prices.
  Future<void> registerSymbol(String symbol) async {
    final String normalized = _normalizeSymbol(symbol);
    final bool added = _registeredSymbols.add(normalized);
    _subscribePricesTopic();

    if (!added) {
      DebugLog.instance.d('WebSocket: Symbol $normalized is already registered.');
      return;
    }

    final bool isCrypto = normalized.endsWith('USDT');
    final String endUrl = isCrypto ? Apis.cryptoLivePrice : Apis.marketLivePrice;

    DebugLog.instance.i('WebSocket: Registering symbol $normalized via $endUrl');

    try {
      final ResponseHandler<Map<String, dynamic>?> response = await MainConfig.apiClient.handleApiCall<Map<String, dynamic>>(
        endUrl: endUrl,
        params: <String, dynamic>{'symbol': normalized},
      );
      if (response.isSuccess()) {
        DebugLog.instance.i('WebSocket: Successfully registered symbol $normalized');
      } else {
        DebugLog.instance.e('WebSocket: Failed to register symbol $normalized');
      }
    } on Exception catch (e) {
      DebugLog.instance.e('WebSocket: Error registering symbol $normalized: $e');
    }
  }

  /// Unregisters a symbol from backend streaming.
  Future<void> unregisterSymbol(String symbol) async {
    final String normalized = _normalizeSymbol(symbol);
    final bool removed = _registeredSymbols.remove(normalized);
    if (_registeredSymbols.isEmpty) {
      _unsubscribePricesTopic();
    }

    if (!removed) {
      DebugLog.instance.d('WebSocket: Symbol $normalized was not registered.');
      return;
    }

    final bool isCrypto = normalized.endsWith('USDT');
    final String endUrl = isCrypto ? Apis.cryptoLivePrice : Apis.marketLivePrice;

    DebugLog.instance.i('WebSocket: Unregistering symbol $normalized via $endUrl');

    try {
      final ResponseHandler<Map<String, dynamic>?> response = await MainConfig.apiClient.handleApiCall<Map<String, dynamic>>(
        endUrl: endUrl,
        apiType: ApiType.delete,
        params: <String, dynamic>{'symbol': normalized},
      );
      if (response.isSuccess()) {
        DebugLog.instance.i('WebSocket: Successfully unregistered symbol $normalized');
      } else {
        DebugLog.instance.e('WebSocket: Failed to unregister symbol $normalized');
      }
    } on Exception catch (e) {
      DebugLog.instance.e('WebSocket: Error unregistering symbol $normalized: $e');
    }
  }

  String _normalizeSymbol(String symbol) {
    return symbol.replaceAll('/', '').toUpperCase();
  }
}
