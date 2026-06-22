import '../../../utils/exports.dart';

/// State for the Trading Overview page managing live price updates.
class TradingOverviewState extends BaseState {
  const TradingOverviewState({
    required this.livePrice,
    required this.progress,
    this.isTaken = false,
    super.status = BaseStateStatus.initial,
    super.msg = '',
    super.redirectRoute,
  });

  final double livePrice;
  final double progress;
  final bool isTaken;

  factory TradingOverviewState.initial(double initialPrice, {bool isTaken = false}) => TradingOverviewState(
        livePrice: initialPrice,
        progress: 0.5,
        isTaken: isTaken,
      );

  TradingOverviewState copyWith({
    BaseStateStatus? status,
    String? msg,
    PageRouteInfo? redirectRoute,
    double? livePrice,
    double? progress,
    bool? isTaken,
  }) =>
      TradingOverviewState(
        status: status ?? this.status,
        msg: msg ?? this.msg,
        redirectRoute: redirectRoute ?? this.redirectRoute,
        livePrice: livePrice ?? this.livePrice,
        progress: progress ?? this.progress,
        isTaken: isTaken ?? this.isTaken,
      );

  @override
  List<Object?> get props => <Object?>[
        status,
        msg,
        redirectRoute,
        livePrice,
        progress,
        isTaken,
      ];
}
