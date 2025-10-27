import '../../../utils/exports.dart';

/// A model class representing a selectable store address option.
///
/// This model holds details about a store location, its distance,
/// the availability of items, and selection state for UI purposes.
class Selectaddressmodel {
  /// The name of the store.
  final String storeName;

  /// The full address of the store.
  final String address;

  /// The distance from the current location to the store, usually in km or miles.
  final String distance;

  /// A description of items that are not available at this store.
  final String itemsNotAvailable;

  /// Indicates whether there are any items unavailable in this store.
  final bool isItemsNotAvailable;

  /// The store’s display image (SVG format).
  final SvgGenImage image;

  /// Indicates whether this address is currently selected.
  ///
  /// Defaults to `false`.
  bool isSelected;

  /// Creates a [Selectaddressmodel] instance.
  ///
  /// [storeName], [address], [image], [distance], and [itemsNotAvailable]
  /// are required parameters.
  Selectaddressmodel({
    required this.storeName,
    required this.address,
    required this.image,
    required this.distance,
    required this.itemsNotAvailable,
    this.isItemsNotAvailable = false,
    this.isSelected = false,
  });
}
