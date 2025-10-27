/// Model for updating cart quantity with entity ID and index information.
class UpdateCartQtyModel {
  /// The entity ID of the cart item.
  final String entityId;

  /// The index of the item in the list.
  final int index;

  /// The new quantity to set.
  final int qty;

  /// Creates an instance of [UpdateCartQtyModel].
  UpdateCartQtyModel(
      {required this.index, required this.entityId, required this.qty});
}
