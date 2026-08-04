import 'package:stomp_dart_client/stomp_dart_client.dart';
import '../../../utils/exports.dart';

/// Class managing the WebSocket connection over the STOMP protocol.
class ChatSocketConnection {
  StompClient? _client;
  bool _isConnected = false;
  final Set<String> _registeredSymbols = <String>{};
  final Map<String, void Function({Map<String, String>? unsubscribeHeaders})> _symbolSubscriptions =
      <String, void Function({Map<String, String>? unsubscribeHeaders})>{};

  // Broadcast stream controllers to distribute updates to multiple listeners
  final StreamController<Map<String, dynamic>> _priceStreamController =
      StreamController<Map<String, dynamic>>.broadcast();
  final StreamController<Map<String, dynamic>> _tradeStreamController =
      StreamController<Map<String, dynamic>>.broadcast();

  /// Exposes live price updates stream.
  Stream<Map<String, dynamic>> get priceStream => _priceStreamController.stream;

  /// Exposes trade status updates stream.
  Stream<Map<String, dynamic>> get tradeStream => _tradeStreamController.stream;

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
    _symbolSubscriptions.clear();
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
    _symbolSubscriptions.clear();
    DebugLog.instance.w('WebSocket: WebSocket Closed.');
  }

  void _subscribePricesTopic(String symbol) {
    if (_client == null || !_client!.connected) return;
    if (_symbolSubscriptions.containsKey(symbol)) return; // Already subscribed

    DebugLog.instance.i('WebSocket: Subscribing to /topic/prices/$symbol');
    final void Function({Map<String, String>? unsubscribeHeaders}) unsubscribeFn = _client!.subscribe(
      destination: '/topic/prices/$symbol',
      callback: (StompFrame frame) {
        if (frame.body != null) {
          try {
            final Map<String, dynamic> data =
                jsonDecode(frame.body!) as Map<String, dynamic>;
            _priceStreamController.add(data);
            DebugLog.instance.d('WebSocket: Price update received for $symbol: $data');
          } on Exception catch (e) {
            DebugLog.instance.e('WebSocket: Error parsing price update for $symbol: $e');
          }
        }
      },
    );
    _symbolSubscriptions[symbol] = unsubscribeFn;
  }

  void _unsubscribePricesTopic(String symbol) {
    final void Function({Map<String, String>? unsubscribeHeaders})? unsubscribeFn = _symbolSubscriptions.remove(symbol);
    if (unsubscribeFn != null) {
      DebugLog.instance.i('WebSocket: Unsubscribing from /topic/prices/$symbol');
      try {
        unsubscribeFn();
      } on Exception catch (e) {
        DebugLog.instance.e('WebSocket: Error unsubscribing from /topic/prices/$symbol: $e');
      }
    }
  }

  void _subscribeTopics() {
    if (_client == null || !_client!.connected) return;

    // Clear old active subscriptions to avoid duplicates
    _symbolSubscriptions.clear();

    // 1. Re-subscribe to all active symbols
    for (final String symbol in _registeredSymbols) {
      _subscribePricesTopic(symbol);
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
  }

  /// Disconnects the socket client and clears listeners.
  void disconnectSocket({bool shouldClearTheSocket = false}) {
    // Unsubscribe all active symbol subscriptions
    for (final String symbol in _symbolSubscriptions.keys.toList()) {
      _unsubscribePricesTopic(symbol);
    }
    _symbolSubscriptions.clear();

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

    if (_client != null && _client!.connected) {
      _subscribePricesTopic(normalized);
    }

    if (!added) {
      DebugLog.instance.d('WebSocket: Symbol $normalized is already registered.');
      return;
    }

    DebugLog.instance.i('WebSocket: Symbol $normalized registered successfully.');
  }

  /// Unregisters a symbol from backend streaming.
  Future<void> unregisterSymbol(String symbol) async {
    final String normalized = _normalizeSymbol(symbol);
    final bool removed = _registeredSymbols.remove(normalized);

    _unsubscribePricesTopic(normalized);

    if (!removed) {
      DebugLog.instance.d('WebSocket: Symbol $normalized was not registered.');
      return;
    }

    DebugLog.instance.i('WebSocket: Symbol $normalized unregistered successfully.');
  }

  String _normalizeSymbol(String symbol) {
    return symbol.replaceAll('/', '').toUpperCase();
  }
}
