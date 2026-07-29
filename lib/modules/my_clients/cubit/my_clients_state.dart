import '../../../utils/exports.dart';


class MyClientsState extends BaseState {
  const MyClientsState({
    this.trades = const <TradeWithClientsModel>[],
    this.offset = 0,
    this.hasReachedMax = false,
    this.isLoadingMore = false,
    this.totalCount = 0,
    super.status = BaseStateStatus.initial,
    super.msg = '',
    super.redirectRoute,
  });

  final List<TradeWithClientsModel> trades;
  final int offset;
  final bool hasReachedMax;
  final bool isLoadingMore;
  final int totalCount;

  factory MyClientsState.initial() => const MyClientsState();

  bool get isInitialLoading =>
      status == BaseStateStatus.loading && trades.isEmpty && !isLoadingMore;

  MyClientsState copyWith({
    BaseStateStatus? status,
    String? msg,
    PageRouteInfo? redirectRoute,
    List<TradeWithClientsModel>? trades,
    int? offset,
    bool? hasReachedMax,
    bool? isLoadingMore,
    int? totalCount,
  }) =>
      MyClientsState(
        status: status ?? this.status,
        msg: msg ?? this.msg,
        redirectRoute: redirectRoute ?? this.redirectRoute,
        trades: trades ?? this.trades,
        offset: offset ?? this.offset,
        hasReachedMax: hasReachedMax ?? this.hasReachedMax,
        isLoadingMore: isLoadingMore ?? this.isLoadingMore,
        totalCount: totalCount ?? this.totalCount,
      );

  @override
  List<Object?> get props => <Object?>[
        status,
        msg,
        redirectRoute,
        trades,
        offset,
        hasReachedMax,
        isLoadingMore,
        totalCount,
      ];
}
