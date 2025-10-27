import '../../../utils/exports.dart';

/// Cubit that manages loyalty points state and operations.
class LoyaltyPointsCubit extends Cubit<LoyaltyPointsState> {
  /// Creates a loyalty points cubit.
  LoyaltyPointsCubit() : super(LoyaltyPointsState.initial()){
    displayShimmer();
  }

  /// Displays a shimmer effect by emitting loading state and then success after a delay.
  void displayShimmer(){
    emit(state.copyWith(status: BaseStateStatus.loading));
    Future<void>.delayed(const Duration(seconds: 3), () {
      if (!isClosed)
      {
        emit(state.copyWith(status: BaseStateStatus.success));
      }

    });
  }

}
