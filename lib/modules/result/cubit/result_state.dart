import '../../../utils/exports.dart';

class ResultState extends BaseState {
  const ResultState({
    this.resultItems = const <TradeResultModel>[],
    this.shimmerLoading = false,
    super.status = BaseStateStatus.initial,
    super.msg = '',
    super.redirectRoute,
  });

  final List<TradeResultModel> resultItems;
  final bool shimmerLoading;

  factory ResultState.initial() => const ResultState();

  ResultState copyWith({
    BaseStateStatus? status,
    String? msg,
    PageRouteInfo? redirectRoute,
    List<TradeResultModel>? resultItems,
    bool? shimmerLoading,
  }) =>
      ResultState(
        status: status ?? this.status,
        msg: msg ?? this.msg,
        redirectRoute: redirectRoute ?? this.redirectRoute,
        resultItems: resultItems ?? this.resultItems,
        shimmerLoading: shimmerLoading ?? this.shimmerLoading,
      );

  @override
  List<Object?> get props => <Object?>[
        status,
        msg,
        redirectRoute,
        resultItems,
        shimmerLoading,
      ];
}
