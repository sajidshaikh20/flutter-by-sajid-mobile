/*
import '../../utils/exports.dart';

class ShakeDetectorService {
  ShakeDetectorService._();
  static final ShakeDetectorService _instance = ShakeDetectorService._();
  factory ShakeDetectorService() => _instance;

  StreamSubscription<AccelerometerEvent>? _subscription;
  Timer? _debounceTimer;
  VoidCallback? _onShakeDetected;
  bool _isListening = false;

  static const double _threshold = 12.0;
  static const Duration _debounceTime = Duration(milliseconds: 500);

  double _lastX = 0.0, _lastY = 0.0, _lastZ = 0.0;

  void initialize({VoidCallback? onShakeDetected}) {
    _onShakeDetected = onShakeDetected;
    DebugLog.instance.i('ShakeDetectorService: Initialized');
  }

  Future<void> startListening() async {
    if (_isListening) return;

    try {
      _subscription = accelerometerEvents.listen((AccelerometerEvent event) {
        _processEvent(event);
      });
      _isListening = true;
      DebugLog.instance.i('ShakeDetectorService: Started listening');
    } on Exception catch (e) {
      DebugLog.instance.e('ShakeDetectorService: Error: $e');
    }
  }

  Future<void> stopListening() async {
    await _subscription?.cancel();
    _debounceTimer?.cancel();
    _isListening = false;
    DebugLog.instance.i('ShakeDetectorService: Stopped listening');
  }

  void _processEvent(AccelerometerEvent event) {
    double deltaX = (event.x - _lastX).abs();
    double deltaY = (event.y - _lastY).abs();
    double deltaZ = (event.z - _lastZ).abs();

    if (deltaX > _threshold || deltaY > _threshold || deltaZ > _threshold) {
      _handleShake();
    }

    _lastX = event.x;
    _lastY = event.y;
    _lastZ = event.z;
  }

  void _handleShake() {
    if (_debounceTimer?.isActive ?? false) return;

    _debounceTimer = Timer(_debounceTime, () async {
      DebugLog.instance.i('ShakeDetectorService: Shake detected!');
      _onShakeDetected?.call();
      if (kDebugMode) {
        try {
          // Present Chucker UI when shaking in debug mode
          // Ensure navigator is available via observer
         // ChuckerFlutter.showChuckerScreen();
        } on Exception catch (e) {
          DebugLog.instance.e('ShakeDetectorService: Error showing Chucker: $e');
        }
      }
    });
  }

  // Chucker methods removed

  Future<void> dispose() async {
    await stopListening();
    _onShakeDetected = null;
  }
}

extension ShakeDetectorExtension on BuildContext {
  ShakeDetectorService get shakeDetector => ShakeDetectorService();
}

*/
