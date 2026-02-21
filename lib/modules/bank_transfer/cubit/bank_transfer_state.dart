import '../../../utils/exports.dart';

/// State for the bank transfer screen.
class BankTransferState extends BaseState {
  const BankTransferState({
    required super.status,
    super.msg = '',
    super.redirectRoute,
  });

  BankTransferState copyWith({
    BaseStateStatus? status,
    PageRouteInfo? redirectRoute,
    String? msg,
  }) =>
      BankTransferState(
        status: status ?? this.status,
        redirectRoute: redirectRoute ?? this.redirectRoute,
        msg: msg ?? this.msg,
      );

  @override
  List<Object?> get props => <Object?>[...super.props];

  factory BankTransferState.initial() {
    return const BankTransferState(
      status: BaseStateStatus.initial,
    );
  }
}
