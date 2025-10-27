
import '../../../utils/exports.dart';


/// Coordinates the Points History screen behavior.
class PointsHistoryCubit extends Cubit<PointsHistoryState> {
  /// Creates a points history cubit.
  PointsHistoryCubit() : super(PointsHistoryState.initial()) {
    // Initialize the mixin's dependency here
    displayShimmer();
  }


  /// Shows a shimmer and then emits success after a delay.
  void displayShimmer(){
    emit(state.copyWith(status: BaseStateStatus.loading));
    Future<void>.delayed(const Duration(seconds: Dimens.seconds3), () {
      if (!isClosed)
      {
        emit(state.copyWith(status: BaseStateStatus.success));
      }

    });
  }

}