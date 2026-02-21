import '../../../utils/exports.dart';

/// UI-only BankTransferCubit.
class BankTransferCubit extends BaseCubit<BankTransferState> {
  BankTransferCubit() : super(BankTransferState.initial());

  @override
  BankTransferState getResetErrorState() => state.copyWith(msg: '');

  @override
  BankTransferState getResetRedirectionState() => state.copyWith();
}
