import '../../../utils/exports.dart';

enum SignalFilter { all, active, pending, closed, cancelled }

/// State class for Trades tab managing filter, search, signals list and standard BaseState properties.
class TradesState extends BaseState {
  const TradesState({
    this.selectedFilter = SignalFilter.all,
    this.searchQuery = '',
    this.signals = const <TradingSignalModel>[],
    super.status = BaseStateStatus.initial,
    super.msg = '',
    super.redirectRoute,
  });

  final SignalFilter selectedFilter;
  final String searchQuery;
  final List<TradingSignalModel> signals;

  factory TradesState.initial() => const TradesState();

  TradesState copyWith({
    BaseStateStatus? status,
    String? msg,
    PageRouteInfo? redirectRoute,
    SignalFilter? selectedFilter,
    String? searchQuery,
    List<TradingSignalModel>? signals,
  }) =>
      TradesState(
        status: status ?? this.status,
        msg: msg ?? this.msg,
        redirectRoute: redirectRoute ?? this.redirectRoute,
        selectedFilter: selectedFilter ?? this.selectedFilter,
        searchQuery: searchQuery ?? this.searchQuery,
        signals: signals ?? this.signals,
      );

  @override
  List<Object?> get props => <Object?>[
        status,
        msg,
        redirectRoute,
        selectedFilter,
        searchQuery,
        signals,
      ];
}
