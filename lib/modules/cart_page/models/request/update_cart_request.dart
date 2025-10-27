/// Represents a request model for updating a cart with various parameters.
class UpdateCartRequest {
  /// Constructor for initializing the UpdateCartRequest with
  /// optional parameters.
  UpdateCartRequest({
    String? currency,
    String? customerToken,
    String? freeGiftProductId,
    List<String>? itemIds,
    List<String>? itemQtys,
    String? quoteId,
    String? storeId,
    String? websiteId,
  }) {
    _currency = currency;
    _customerToken = customerToken;
    _freeGiftProductId = freeGiftProductId;
    _itemIds = itemIds;
    _itemQtys = itemQtys;
    _quoteId = quoteId;
    _storeId = storeId;
    _websiteId = websiteId;
  }

  /// Creates an UpdateCartRequest instance from a JSON map.
  /// Creates an UpdateCartRequest instance from a JSON map.
  UpdateCartRequest.fromJson(Map<String, dynamic> json) {
    _currency = json['currency'];
    _customerToken = json['customerToken'];
    _freeGiftProductId = json['freeGiftProductId'];
    /*_itemIds =
        json['itemIds'] != null ? json['itemIds'].cast<String>() : <String>[];
    _itemQtys =
        json['itemQtys'] != null ? json['itemQtys'].cast<String>() : <String>[];
*/
    _itemIds = (json['itemIds'] is List) ? List<String>.from(json['itemIds']) : <String>[];
    _itemQtys = (json['itemQtys'] is List) ? List<String>.from(json['itemQtys']) : <String>[];


    _quoteId = json['quoteId'];
    _storeId = json['storeId'];
    _websiteId = json['websiteId'];
  }

  /// Currency for the cart update request.
  String? _currency;

  /// Customer token for identifying the user making the request.
  String? _customerToken;

  /// Free gift product ID (if applicable).
  String? _freeGiftProductId;

  /// List of item IDs for the products to be updated in the cart.
  List<String>? _itemIds;

  /// List of item quantities corresponding to the item IDs.
  List<String>? _itemQtys;

  /// Quote ID associated with the cart.
  String? _quoteId;

  /// Store ID where the cart is being updated.
  String? _storeId;

  /// Website ID where the cart is being updated.
  String? _websiteId;

  /// Copies the current UpdateCartRequest and allows updating some fields.
  UpdateCartRequest copyWith({
    String? currency,
    String? customerToken,
    String? freeGiftProductId,
    List<String>? itemIds,
    List<String>? itemQtys,
    String? quoteId,
    String? storeId,
    String? websiteId,
  }) =>
      UpdateCartRequest(
        currency: currency ?? _currency,
        customerToken: customerToken ?? _customerToken,
        freeGiftProductId: freeGiftProductId ?? _freeGiftProductId,
        itemIds: itemIds ?? _itemIds,
        itemQtys: itemQtys ?? _itemQtys,
        quoteId: quoteId ?? _quoteId,
        storeId: storeId ?? _storeId,
        websiteId: websiteId ?? _websiteId,
      );

  /// Converts the UpdateCartRequest to a JSON map.
  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = <String, dynamic>{};
    map['currency'] = _currency;
    map['customerToken'] = _customerToken;
    map['freeGiftProductId'] = _freeGiftProductId;
    map['itemIds'] = _itemIds;
    map['itemQtys'] = _itemQtys;
    map['quoteId'] = _quoteId;
    map['storeId'] = _storeId;
    map['websiteId'] = _websiteId;
    return map;
  }
}
