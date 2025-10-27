import '../../../utils/exports.dart';

/// Cubit that manages internet connectivity state and monitoring.
class InternetCubit extends BaseCubit<NoInternetState> {
  /// Creates an internet cubit with connectivity monitoring.
  ///
  /// [_connectivity] The connectivity instance used to monitor network changes.
  InternetCubit(this._connectivity) : super(const NoInternetState()) {
    _monitorConnectivity();
  }

  /// The connectivity instance used to monitor network changes.
  final Connectivity _connectivity;

  void _monitorConnectivity() {
    _connectivity.onConnectivityChanged.listen((List<ConnectivityResult> result) {
      if (result.contains(ConnectivityResult.mobile) ||
          result.contains(ConnectivityResult.wifi)) {
        emit(
          state.copyWith(
            status: BaseStateStatus.success,
            isInternetConnected: true,
          ),
        );
      } else {
        emit(
          state.copyWith(
            status: BaseStateStatus.failure,
            isInternetConnected: false,
          ),
        );
      }
    });
  }

  /// Checks the current connectivity status and emits the appropriate state.
  ///
  /// Returns `true` if internet is connected (mobile or wifi), `false` otherwise.
  Future<bool> checkConnectivity() async {
    List<ConnectivityResult> result = await _connectivity.checkConnectivity();
    if (result.contains(ConnectivityResult.mobile) ||
        result.contains(ConnectivityResult.wifi)) {
      emit(
        state.copyWith(
          status: BaseStateStatus.success,
          isInternetConnected: true,
        ),
      );
      return true;
    } else {
      emit(
        state.copyWith(
          status: BaseStateStatus.failure,
          isInternetConnected: false,
        ),
      );
      return false;
    }
  }

  @override
  NoInternetState getResetErrorState() => state.copyWith(msg: '');

  @override
  NoInternetState getResetRedirectionState() => state.copyWith();
}
