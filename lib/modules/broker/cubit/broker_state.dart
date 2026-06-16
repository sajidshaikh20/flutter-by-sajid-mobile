import '../../../utils/exports.dart';

class BrokerState extends BaseState {
  const BrokerState({
    this.brokers = const <BrokerModel>[],
    super.status = BaseStateStatus.initial,
    super.msg = '',
    super.redirectRoute,
  });

  final List<BrokerModel> brokers;

  factory BrokerState.initial() => const BrokerState();

  BrokerState copyWith({
    BaseStateStatus? status,
    String? msg,
    PageRouteInfo? redirectRoute,
    List<BrokerModel>? brokers,
  }) =>
      BrokerState(
        status: status ?? this.status,
        msg: msg ?? this.msg,
        redirectRoute: redirectRoute ?? this.redirectRoute,
        brokers: brokers ?? this.brokers,
      );

  @override
  List<Object?> get props => <Object?>[
        status,
        msg,
        redirectRoute,
        brokers,
      ];
}
