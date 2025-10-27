import '../../../utils/exports.dart';

/// Handles My Order cancellation logic.
class MyOrderCancelCubit extends Cubit<MyOrderCancelState> {
  /// Initializes the cubit with the given state.
  MyOrderCancelCubit({
    required MyOrderCancelState initialState,
  }) : super(initialState);

  /// Selects a reason for order cancellation.
  void radioButtonSelection(int index) {
    emit(state.copyWith(selectedIndex: index, status: BaseStateStatus.initial));
  }

  /// Clears the comment input field.
  void clearComment() {
    state.commentEditingController.dispose();
    state.formKey.currentState?.reset();
  }

  @override
  Future<void> close() {
    clearComment();
    return super.close();
  }
}
