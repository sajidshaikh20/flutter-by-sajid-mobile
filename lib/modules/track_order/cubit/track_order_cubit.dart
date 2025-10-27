import '../../../utils/exports.dart';

/// Business logic for the Track Order flow.
class TrackOrderCubit extends Cubit<TrackOrderState> {
  /// Initializes the cubit with an initial [TrackOrderState].
  TrackOrderCubit()
      : super(
          const TrackOrderState(
            status: BaseStateStatus.initial,
          ),
        );

  /// Maps an [OrderStatus] to the corresponding timeline index.
  int getIndex(
    OrderStatus? status,
  ) {
    if (status == null) {
      return 0;
    }
    switch (status) {
      case OrderStatus.processing:
        return 1;
      case OrderStatus.orderPlaced:
        return 0;
      case OrderStatus.pendingPayment:
        return 0;
      case OrderStatus.outForDelivery:
        return 2;
      case OrderStatus.complete:
        return 3;
      case OrderStatus.canceled:
        return 0;
      case OrderStatus.paymentReview:
        return 0;
      case OrderStatus.pending:
        return 0;
    }
  }
}
