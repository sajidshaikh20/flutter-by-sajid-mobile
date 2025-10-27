import '../../../utils/exports.dart';

/// A data model representing a store, including its basic details,
/// availability information, and selection state.
///
/// This model is useful for listing stores in the UI, tracking selection,
/// and displaying availability messages.
///
/// It also includes a [copyWith] method for cloning and updating specific fields.
class StoreModel {
  /// The name of the store.
  final String storeName;

  /// The store's address.
  final String address;

  /// The distance of the store from the user (e.g., "2.5 km").
  final String distance;

  /// A message indicating which items are not available.
  final String itemsNotAvailable;

  /// Whether there are any unavailable items in this store.
  final bool isItemsNotAvailable;

  /// Whether the store items can be edited or deleted (optional).
  final bool? isItemsEditDelete;

  /// The store's image or icon (optional).
  final SvgGenImage? image;

  /// Whether this store is currently selected.
  bool isSelected;

  /// Creates a new [StoreModel] with the provided store details.
  StoreModel({
    required this.storeName,
    required this.address,
    required this.distance,
    this.isItemsEditDelete,
    required this.itemsNotAvailable,
    this.image,
    this.isItemsNotAvailable = false,
    this.isSelected = false,
  });

  /// Creates a new [StoreModel] by copying the current instance
  /// and updating the provided fields.
  ///
  /// This is useful for immutability when you want to change only
  /// certain fields without affecting the rest.
  ///
  /// Example:
  /// ```dart
  /// final updatedStore = store.copyWith(isSelected: true);
  /// ```
  StoreModel copyWith({
    String? storeName,
    String? address,
    String? distance,
    String? itemsNotAvailable,
    bool? isItemsNotAvailable,
    bool? isSelected,
    bool? isItemsEditDelete,
    SvgGenImage? image,
  }) {
    return StoreModel(
      storeName: storeName ?? this.storeName,
      address: address ?? this.address,
      distance: distance ?? this.distance,
      itemsNotAvailable: itemsNotAvailable ?? this.itemsNotAvailable,
      isItemsNotAvailable: isItemsNotAvailable ?? this.isItemsNotAvailable,
      isSelected: isSelected ?? this.isSelected,
      isItemsEditDelete: isItemsEditDelete ?? this.isItemsEditDelete,
      image: image ?? this.image,
    );
  }
}
