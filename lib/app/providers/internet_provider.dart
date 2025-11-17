import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../utils/exports.dart';
import '../../modules/no_internet/state/no_internet_state.dart';

/// Notifier for managing internet connectivity state and monitoring (Riverpod version).
class InternetNotifier extends StateNotifier<NoInternetState> {
  /// Creates an internet notifier with connectivity monitoring.
  ///
  /// [_connectivity] The connectivity instance used to monitor network changes.
  InternetNotifier(this._connectivity) : super(const NoInternetState()) {
    _monitorConnectivity();
  }

  /// The connectivity instance used to monitor network changes.
  final Connectivity _connectivity;

  void _monitorConnectivity() {
    _connectivity.onConnectivityChanged.listen((List<ConnectivityResult> result) {
      if (result.contains(ConnectivityResult.mobile) ||
          result.contains(ConnectivityResult.wifi)) {
        state = state.copyWith(
          status: BaseStateStatus.success,
          isInternetConnected: true,
        );
      } else {
        state = state.copyWith(
          status: BaseStateStatus.failure,
          isInternetConnected: false,
        );
      }
    });
  }

  /// Checks the current connectivity status and emits the appropriate state.
  ///
  /// Returns `true` if internet is connected (mobile or wifi), `false` otherwise.
  Future<bool> checkConnectivity() async {
    final List<ConnectivityResult> result = await _connectivity.checkConnectivity();
    if (result.contains(ConnectivityResult.mobile) ||
        result.contains(ConnectivityResult.wifi)) {
      state = state.copyWith(
        status: BaseStateStatus.success,
        isInternetConnected: true,
      );
      return true;
    } else {
      state = state.copyWith(
        status: BaseStateStatus.failure,
        isInternetConnected: false,
      );
      return false;
    }
  }
}

/// Provider for Connectivity.
final Provider<Connectivity> connectivityProvider = Provider<Connectivity>((ProviderRef<Connectivity> ref) {
  return Connectivity();
});

/// Provider for InternetNotifier.
final StateNotifierProvider<InternetNotifier, NoInternetState> internetNotifierProvider =
    StateNotifierProvider<InternetNotifier, NoInternetState>((StateNotifierProviderRef<InternetNotifier, NoInternetState> ref) {
  final Connectivity connectivity = ref.watch(connectivityProvider);
  return InternetNotifier(connectivity);
});

