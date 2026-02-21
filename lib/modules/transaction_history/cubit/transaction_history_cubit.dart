import '../../../utils/exports.dart';

/// UI-only TransactionHistoryCubit.
class TransactionHistoryCubit extends BaseCubit<TransactionHistoryState> {
  TransactionHistoryCubit() : super(TransactionHistoryState.initial());

  Future<void> loadTransactions() async {
    emit(state.copyWith(status: BaseStateStatus.loading));
    await Future<void>.delayed(const Duration(milliseconds: 300));
    emit(state.copyWith(
      status: BaseStateStatus.success,
      list: <dynamic>[],
      msg: '',
    ));
  }

  @override
  TransactionHistoryState getResetErrorState() => state.copyWith(msg: '');

  @override
  TransactionHistoryState getResetRedirectionState() => state.copyWith();
}
