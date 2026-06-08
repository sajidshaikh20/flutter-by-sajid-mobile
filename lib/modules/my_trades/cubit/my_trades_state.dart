import '../../../utils/exports.dart';

/// State class for My Trades tab managing filter, search and standard BaseState properties.
class MyTradesState extends BaseState {
  const MyTradesState({
    this.selectedFilter = SignalFilter.all,
    this.searchQuery = '',
    super.status = BaseStateStatus.initial,
    super.msg = '',
    super.redirectRoute,
  });

  final SignalFilter selectedFilter;
  final String searchQuery;

  factory MyTradesState.initial() => const MyTradesState();

  MyTradesState copyWith({
    BaseStateStatus? status,
    String? msg,
    PageRouteInfo? redirectRoute,
    SignalFilter? selectedFilter,
    String? searchQuery,
  }) =>
      MyTradesState(
        status: status ?? this.status,
        msg: msg ?? this.msg,
        redirectRoute: redirectRoute ?? this.redirectRoute,
        selectedFilter: selectedFilter ?? this.selectedFilter,
        searchQuery: searchQuery ?? this.searchQuery,
      );

  @override
  List<Object?> get props => <Object?>[
        status,
        msg,
        redirectRoute,
        selectedFilter,
        searchQuery,
      ];
}
