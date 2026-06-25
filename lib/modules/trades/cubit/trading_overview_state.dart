import '../../../utils/exports.dart';

/// State for the Trading Overview page managing live price updates.
class TradingOverviewState extends BaseState {
  const TradingOverviewState({
    required this.signal,
    required this.livePrice,
    required this.progress,
    this.isTaken = false,
    super.status = BaseStateStatus.initial,
    super.msg = '',
    super.redirectRoute,
  });

  final TradingSignalModel signal;
  final double livePrice;
  final double progress;
  final bool isTaken;

  factory TradingOverviewState.initial(TradingSignalModel signal) => TradingOverviewState(
        signal: signal,
        livePrice: signal.livePrice ?? signal.entryPrice,
        progress: 0.5,
        isTaken: signal.isTaken,
      );

  TradingOverviewState copyWith({
    BaseStateStatus? status,
    String? msg,
    PageRouteInfo? redirectRoute,
    TradingSignalModel? signal,
    double? livePrice,
    double? progress,
    bool? isTaken,
  }) =>
      TradingOverviewState(
        status: status ?? this.status,
        msg: msg ?? this.msg,
        redirectRoute: redirectRoute ?? this.redirectRoute,
        signal: signal ?? this.signal,
        livePrice: livePrice ?? this.livePrice,
        progress: progress ?? this.progress,
        isTaken: isTaken ?? this.isTaken,
      );

  @override
  List<Object?> get props => <Object?>[
        status,
        msg,
        redirectRoute,
        signal,
        livePrice,
        progress,
        isTaken,
      ];
}
