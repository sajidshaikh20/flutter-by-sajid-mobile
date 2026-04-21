import '../../../utils/exports.dart';

/// State for watchlist screen.
class WatchlistState extends BaseState {
  const WatchlistState({
    required super.status,
    super.msg = '',
    super.redirectRoute,
    this.stocks = const <WatchlistStockModel>[],
  });

  final List<WatchlistStockModel> stocks;

  factory WatchlistState.initial() {
    return const WatchlistState(
      status: BaseStateStatus.initial,
    );
  }

  WatchlistState copyWith({
    BaseStateStatus? status,
    String? msg,
    PageRouteInfo? redirectRoute,
    List<WatchlistStockModel>? stocks,
  }) {
    return WatchlistState(
      status: status ?? this.status,
      msg: msg ?? this.msg,
      redirectRoute: redirectRoute ?? this.redirectRoute,
      stocks: stocks ?? this.stocks,
    );
  }

  @override
  List<Object?> get props => <Object?>[...super.props, stocks];
}
