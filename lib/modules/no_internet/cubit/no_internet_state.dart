import '../../../utils/exports.dart';

/// Immutable state representing the internet connectivity status.
class NoInternetState extends BaseState {
  /// Creates an instance of [NoInternetState].
  const NoInternetState({
    super.status = BaseStateStatus.initial,
    super.msg,
    super.redirectRoute,
    this.isInternetConnected = true,
  });

  /// Whether internet connectivity is available.
  final bool isInternetConnected;

  @override
  List<Object?> get props => <Object?>[
        status,
        msg,
        redirectRoute,
        isInternetConnected,
      ];

  /// Creates a copy of this [NoInternetState] with optional new values.
  NoInternetState copyWith({
    BaseStateStatus? status,
    String? msg,
    PageRouteInfo<dynamic>? redirectRoute,
    bool? isInternetConnected,
  }) =>
      NoInternetState(
        status: status ?? this.status,
        msg: msg ?? this.msg,
        redirectRoute: redirectRoute ?? this.redirectRoute,
        isInternetConnected: isInternetConnected ?? this.isInternetConnected,
      );
}
