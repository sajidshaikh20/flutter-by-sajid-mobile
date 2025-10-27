import '../../../utils/exports.dart';

/// Manages payment status changes and side effects on the success screen.
class PaymentStatusCubit extends Cubit<PaymentStatusState> {
  /// Creates a payment status cubit.
  PaymentStatusCubit()
      : super(const PaymentStatusState(status: BaseStateStatus.initial));

  /// Creates an instance of [PaymentStatusCubit].
  factory PaymentStatusCubit.instance() => PaymentStatusCubit();

  /// Placeholder for payment status logic.
  void changePaymentStatus() {}
}
