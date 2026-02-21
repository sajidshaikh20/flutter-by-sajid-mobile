import '../../../utils/exports.dart';

/// State for the transaction history screen.
class TransactionHistoryState extends BaseState {
  const TransactionHistoryState({
    required super.status,
    super.msg = '',
    super.redirectRoute,
    this.list = const <dynamic>[],
  });

  final List<dynamic> list;

  TransactionHistoryState copyWith({
    BaseStateStatus? status,
    PageRouteInfo? redirectRoute,
    String? msg,
    List<dynamic>? list,
  }) =>
      TransactionHistoryState(
        status: status ?? this.status,
        redirectRoute: redirectRoute ?? this.redirectRoute,
        msg: msg ?? this.msg,
        list: list ?? this.list,
      );

  @override
  List<Object?> get props => <Object?>[...super.props, list];

  factory TransactionHistoryState.initial() {
    return const TransactionHistoryState(
      status: BaseStateStatus.initial,
    );
  }
}
