import '../../../utils/exports.dart';

/// Cubit that manages gift card state and operations.
class GiftCardCubit extends Cubit<GiftCardState> {
  /// Creates a gift card cubit with initial state.
  GiftCardCubit() : super(GiftCardState.initial());

  /// Updates the validation error message for recipient full name.
  ///
  /// [value] The error message to display.
  void handleValidationRecipientFullNameErrorMessage(String value) {
    emit(state.copyWith(recipientFullNameErrorMessage: value));
  }

  /// Updates the validation error message for recipient email.
  ///
  /// [value] The error message to display.
  void handleValidationRecipientEmailErrorMessage(String value) {
    emit(state.copyWith(recipientEmailErrorMessage: value));
  }

  /// Selects a predefined amount by index and clears custom amount.
  ///
  /// [index] The index of the selected amount in the predefined amounts list.
  void selectAmount(int index) {
    emit(state.copyWith(
      selectedAmountIndex: index,
      lastSelectedAmountIndex: index, // Store last selected index
    ));

    // Clear custom amount when selecting a predefined amount
    state.customAmountController.clear();
  }

  /// Handles changes to the custom amount input field.
  ///
  /// [value] The new custom amount value.
  void onCustomAmountChanged(String value) {
    if (value.isNotEmpty) {
      // Save last selected predefined amount and deselect predefined amounts
      emit(state.copyWith(
        lastSelectedAmountIndex: state.selectedAmountIndex, // Store last selected
        selectedAmountIndex: -1, // Deselect all
      ));
    } else {
      // Restore last selected predefined amount when custom amount is cleared
      emit(state.copyWith(
        selectedAmountIndex: state.lastSelectedAmountIndex,
      ));
    }
  }
}
