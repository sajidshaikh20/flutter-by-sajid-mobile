
import '../../../utils/exports.dart';

/// Cubit that manages the cart item count state.
class CartCountCubit extends Cubit<int> {
  /// Creates a cart count cubit with initial count of 0.
  CartCountCubit() : super(0); // Initial state is 0

  /// Updates the cart count and emits the new value.
  ///
  /// [count] The new cart item count to emit.
  void updateCount(int count) {
    emit(count);
  }  // update cart count

}