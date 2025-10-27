/// Class representing an item in the cart that can be removed.
class RemoveCartItem {
  /// Constructor for `RemoveCartItem`
  RemoveCartItem({
    bool? success,
    String? message,
    List<String>? freeGiftIds,
    num? minimumAmount,
    String? minimumFormattedAmount,
    bool? showThreshold,
    bool? allowMultipleShipping,
    bool? isfreeGiftAdded,
    num? freeGiftProductId,
    String? totalDiscount,
    num? totalDiscountAmount,
    List<ItemsOfCart>? items,
    String? freeGiftMsg,
    num? totalCount,
    num? cartCount,
    num? unformattedCartTotal,
    num? unformattedCartSubTotal,
    String? cartTotal,
    String? freeShippingAmt,
    String? freeShippingStartAmt,
    String? freeShippingAmtUnformatted,
    String? freeShippingMsg,
    List<TotalsDataOfRemoveCart>? totalsData,
    bool? isCheckoutAllowed,
    num? wishListTotalCount,
  }) {
    _success = success;
    _message = message;
    _freeGiftIds = freeGiftIds;
    _minimumAmount = minimumAmount;
    _minimumFormattedAmount = minimumFormattedAmount;
    _showThreshold = showThreshold;
    _allowMultipleShipping = allowMultipleShipping;
    _isfreeGiftAdded = isfreeGiftAdded;
    _freeGiftProductId = freeGiftProductId;
    _totalDiscount = totalDiscount;
    _totalDiscountAmount = totalDiscountAmount;
    _items = items;
    _freeGiftMsg = freeGiftMsg;
    _totalCount = totalCount;
    _cartCount = cartCount;
    _unformattedCartTotal = unformattedCartTotal;
    _unformattedCartSubTotal = unformattedCartSubTotal;
    _cartTotal = cartTotal;
    _freeShippingAmt = freeShippingAmt;
    _freeShippingStartAmt = freeShippingStartAmt;
    _freeShippingAmtUnformatted = freeShippingAmtUnformatted;
    _freeShippingMsg = freeShippingMsg;
    _totalsData = totalsData;
    _isCheckoutAllowed = isCheckoutAllowed;
    _wishListTotalCount = wishListTotalCount;
  }

  /// Factory constructor to create a `RemoveCartItem` from a JSON object.
  RemoveCartItem.fromJson(Map<String, dynamic> json) {
    _success = json['success'];
    _message = json['message'];
    _freeGiftIds = json['freeGiftIds'] != null && json['freeGiftIds'] is List
        ? List<String>.from(json['freeGiftIds'])
        : <String>[];

    // _freeGiftIds = json['freeGiftIds'] != null
    //     ? json['freeGiftIds'].cast<String>()
    //     : <String>[];
    _minimumAmount = json['minimumAmount'];
    _minimumFormattedAmount = json['minimumFormattedAmount'];
    _showThreshold = json['showThreshold'];
    _allowMultipleShipping = json['allowMultipleShipping'];
    _isfreeGiftAdded = json['isfreeGiftAdded'];
    _freeGiftProductId = json['freeGiftProductId'];
    _totalDiscount = json['totalDiscount'];
    _totalDiscountAmount = json['totalDiscountAmount'];
    if (json['items'] != null) {
      _items = (json['items'] as List<dynamic>)
          .map((dynamic v) => ItemsOfCart.fromJson(v))
          .toList();
    }

    _freeGiftMsg = json['freeGiftMsg'];
    _totalCount = json['totalCount'];
    _cartCount = json['cartCount'];
    _unformattedCartTotal = json['unformattedCartTotal'];
    _unformattedCartSubTotal = json['unformattedCartSubTotal'];
    _cartTotal = json['cartTotal'];
    _freeShippingAmt = json['freeShippingAmt'];
    _freeShippingStartAmt = json['freeShippingStartAmt'];
    _freeShippingAmtUnformatted = json['freeShippingAmtUnformatted'];
    _freeShippingMsg = json['freeShippingMsg'];
    if (json['totalsData'] != null) {
      _totalsData = (json['totalsData'] as List<dynamic>)
          .map((dynamic v) => TotalsDataOfRemoveCart.fromJson(v))
          .toList();
    }

    _isCheckoutAllowed = json['isCheckoutAllowed'];
    _wishListTotalCount = json['wishListTotalCount'];
  }

  bool? _success;
  String? _message;
  List<String>? _freeGiftIds;
  num? _minimumAmount;
  String? _minimumFormattedAmount;
  bool? _showThreshold;
  bool? _allowMultipleShipping;
  bool? _isfreeGiftAdded;
  num? _freeGiftProductId;
  String? _totalDiscount;
  num? _totalDiscountAmount;
  List<ItemsOfCart>? _items;
  String? _freeGiftMsg;
  num? _totalCount;
  num? _cartCount;
  num? _unformattedCartTotal;
  num? _unformattedCartSubTotal;
  String? _cartTotal;
  String? _freeShippingAmt;
  String? _freeShippingStartAmt;
  String? _freeShippingAmtUnformatted;
  String? _freeShippingMsg;
  List<TotalsDataOfRemoveCart>? _totalsData;
  bool? _isCheckoutAllowed;
  num? _wishListTotalCount;

  /// Creates a copy of this [RemoveCartItem] with optional new values.
  ///
  /// If a parameter is not provided, the current value is used.
  /// Returns a new instance with the updated values.
  RemoveCartItem copyWith({
    bool? success,
    String? message,
    List<String>? freeGiftIds,
    num? minimumAmount,
    String? minimumFormattedAmount,
    bool? showThreshold,
    bool? allowMultipleShipping,
    bool? isfreeGiftAdded,
    num? freeGiftProductId,
    String? totalDiscount,
    num? totalDiscountAmount,
    List<ItemsOfCart>? items,
    String? freeGiftMsg,
    num? totalCount,
    num? cartCount,
    num? unformattedCartTotal,
    num? unformattedCartSubTotal,
    String? cartTotal,
    String? freeShippingAmt,
    String? freeShippingStartAmt,
    String? freeShippingAmtUnformatted,
    String? freeShippingMsg,
    List<TotalsDataOfRemoveCart>? totalsData,
    bool? isCheckoutAllowed,
    num? wishListTotalCount,
    List<dynamic>? wishList,
  }) =>
      RemoveCartItem(
        success: success ?? _success,
        message: message ?? _message,
        freeGiftIds: freeGiftIds ?? _freeGiftIds,
        minimumAmount: minimumAmount ?? _minimumAmount,
        minimumFormattedAmount:
            minimumFormattedAmount ?? _minimumFormattedAmount,
        showThreshold: showThreshold ?? _showThreshold,
        allowMultipleShipping: allowMultipleShipping ?? _allowMultipleShipping,
        isfreeGiftAdded: isfreeGiftAdded ?? _isfreeGiftAdded,
        freeGiftProductId: freeGiftProductId ?? _freeGiftProductId,
        totalDiscount: totalDiscount ?? _totalDiscount,
        totalDiscountAmount: totalDiscountAmount ?? _totalDiscountAmount,
        items: items ?? _items,
        freeGiftMsg: freeGiftMsg ?? _freeGiftMsg,
        totalCount: totalCount ?? _totalCount,
        cartCount: cartCount ?? _cartCount,
        unformattedCartTotal: unformattedCartTotal ?? _unformattedCartTotal,
        unformattedCartSubTotal:
            unformattedCartSubTotal ?? _unformattedCartSubTotal,
        cartTotal: cartTotal ?? _cartTotal,
        freeShippingAmt: freeShippingAmt ?? _freeShippingAmt,
        freeShippingStartAmt: freeShippingStartAmt ?? _freeShippingStartAmt,
        freeShippingAmtUnformatted:
            freeShippingAmtUnformatted ?? _freeShippingAmtUnformatted,
        freeShippingMsg: freeShippingMsg ?? _freeShippingMsg,
        totalsData: totalsData ?? _totalsData,
        isCheckoutAllowed: isCheckoutAllowed ?? _isCheckoutAllowed,
        wishListTotalCount: wishListTotalCount ?? _wishListTotalCount,
//  wishList: wishList ?? _wishList,
      );

  /// Gets the success status of the cart removal operation.
  bool? get success => _success;

  /// Gets the message associated with the cart removal operation.
  String? get message => _message;

  /// Gets the list of free gift IDs associated with the cart.
  List<String>? get freeGiftIds => _freeGiftIds;

  /// Gets the minimum amount required for the cart.
  num? get minimumAmount => _minimumAmount;

  /// Gets the formatted minimum amount for display.
  String? get minimumFormattedAmount => _minimumFormattedAmount;

  /// Gets whether to show the threshold information.
  bool? get showThreshold => _showThreshold;

  /// Gets whether multiple shipping addresses are allowed.
  bool? get allowMultipleShipping => _allowMultipleShipping;

  /// Gets whether a free gift has been added to the cart.
  bool? get isfreeGiftAdded => _isfreeGiftAdded;

  /// Gets the product ID of the free gift.
  num? get freeGiftProductId => _freeGiftProductId;

  /// Gets the total discount applied to the cart.
  String? get totalDiscount => _totalDiscount;

  /// Gets the total discount amount as a number.
  num? get totalDiscountAmount => _totalDiscountAmount;

  /// Gets the list of items in the cart.
  List<ItemsOfCart>? get items => _items;

  /// Gets the free gift message for the cart.
  String? get freeGiftMsg => _freeGiftMsg;

  /// Gets the total count of items in the cart.
  num? get totalCount => _totalCount;

  /// Gets the cart count (total quantity of items).
  num? get cartCount => _cartCount;

  /// Gets the unformatted total amount of the cart.
  num? get unformattedCartTotal => _unformattedCartTotal;

  /// Gets the unformatted subtotal amount of the cart.
  num? get unformattedCartSubTotal => _unformattedCartSubTotal;

  /// Gets the formatted total amount of the cart.
  String? get cartTotal => _cartTotal;

  /// Gets the free shipping amount threshold.
  String? get freeShippingAmt => _freeShippingAmt;

  /// Gets the starting amount for free shipping.
  String? get freeShippingStartAmt => _freeShippingStartAmt;

  /// Gets the unformatted free shipping amount.
  String? get freeShippingAmtUnformatted => _freeShippingAmtUnformatted;

  /// Gets the free shipping message.
  String? get freeShippingMsg => _freeShippingMsg;

  /// Gets the totals data for the cart removal operation.
  List<TotalsDataOfRemoveCart>? get totalsData => _totalsData;

  /// Gets whether checkout is allowed for this cart.
  bool? get isCheckoutAllowed => _isCheckoutAllowed;

  /// Gets the total count of items in the wishlist.
  num? get wishListTotalCount => _wishListTotalCount;

  // List<dynamic>? get wishList => _wishList;

  /// Converts this [RemoveCartItem] instance to a JSON map.
  ///
  /// Returns a [Map<String, dynamic>] containing all the cart data
  /// in the format expected by the API.
  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = <String, dynamic>{};
    map['success'] = _success;
    map['message'] = _message;
    map['freeGiftIds'] = _freeGiftIds;
    map['minimumAmount'] = _minimumAmount;
    map['minimumFormattedAmount'] = _minimumFormattedAmount;
    map['showThreshold'] = _showThreshold;
    map['allowMultipleShipping'] = _allowMultipleShipping;
    map['isfreeGiftAdded'] = _isfreeGiftAdded;
    map['freeGiftProductId'] = _freeGiftProductId;
    map['totalDiscount'] = _totalDiscount;
    map['totalDiscountAmount'] = _totalDiscountAmount;
    if (_items != null) {
      map['items'] = _items?.map((ItemsOfCart v) => v.toJson()).toList();
    }
    map['freeGiftMsg'] = _freeGiftMsg;
    map['totalCount'] = _totalCount;
    map['cartCount'] = _cartCount;
    map['unformattedCartTotal'] = _unformattedCartTotal;
    map['unformattedCartSubTotal'] = _unformattedCartSubTotal;
    map['cartTotal'] = _cartTotal;
    map['freeShippingAmt'] = _freeShippingAmt;
    map['freeShippingStartAmt'] = _freeShippingStartAmt;
    map['freeShippingAmtUnformatted'] = _freeShippingAmtUnformatted;
    map['freeShippingMsg'] = _freeShippingMsg;
    if (_totalsData != null) {
      map['totalsData'] =
          _totalsData?.map((TotalsDataOfRemoveCart v) => v.toJson()).toList();
    }
    map['isCheckoutAllowed'] = _isCheckoutAllowed;
    map['wishListTotalCount'] = _wishListTotalCount;
    return map;
  }
}

/// Represents data related to the removal of an item from the cart.
class TotalsDataOfRemoveCart {
  /// Constructs a [TotalsDataOfRemoveCart] object.
  TotalsDataOfRemoveCart({
    String? title,
    String? value,
    String? formattedValue,
    num? unformattedValue,
  }) {
    _title = title;
    _value = value;
    _formattedValue = formattedValue;
    _unformattedValue = unformattedValue;
  }

  /// Creates a [TotalsDataOfRemoveCart] object from a JSON map.
  TotalsDataOfRemoveCart.fromJson(Map<String, dynamic> json) {
    _title = json['title'];
    _value = json['value'];
    _formattedValue = json['formattedValue'];
    _unformattedValue = json['unformattedValue'];
  }

  String? _title;
  String? _value;
  String? _formattedValue;
  num? _unformattedValue;

  /// Creates a copy of this [TotalsDataOfRemoveCart]
  /// object with the option to override specific fields.
  TotalsDataOfRemoveCart copyWith({
    String? title,
    String? value,
    String? formattedValue,
    num? unformattedValue,
  }) =>
      TotalsDataOfRemoveCart(
        title: title ?? _title,
        value: value ?? _value,
        formattedValue: formattedValue ?? _formattedValue,
        unformattedValue: unformattedValue ?? _unformattedValue,
      );

  /// The title associated with this data (e.g., 'Total', 'Discount').
  String? get title => _title;

  /// The value associated with this data (e.g., '100').
  String? get value => _value;

  /// The formatted version of the value (e.g., '$100.00').
  String? get formattedValue => _formattedValue;

  /// The raw, unformatted value (e.g., 100).
  num? get unformattedValue => _unformattedValue;

  /// Converts this [TotalsDataOfRemoveCart] object to a JSON map.
  ///
  /// The returned map will contain keys 'title', 'value',
  ///  'formattedValue', and 'unformattedValue'.
  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = <String, dynamic>{};
    map['title'] = _title;
    map['value'] = _value;
    map['formattedValue'] = _formattedValue;
    map['unformattedValue'] = _unformattedValue;
    return map;
  }
}

/// Represents an item in the shopping cart.
class ItemsOfCart {
  /// Constructs an [ItemsOfCart] object with optional
  /// properties for various item attributes.
  ItemsOfCart({
    String? image,
    String? thresholdQty,
    num? remainingQty,
    String? dominantColor,
    String? name,
    bool? canMoveToWishlist,
    bool? isFreeProduct,
    String? id,
    String? sku,
    num? qty,
    String? typeId,
    num? price,
    String? discountPrice,
    String? subTotal,
    String? finalPrice,
    String? formattedPrice,
    String? formattedFinalPrice,
    bool? isInRange,
    num? groupedProductId,
    String? productId,
    List<RemoveCartMessages>? messages,
  }) {
    _image = image;
    _thresholdQty = thresholdQty;
    _remainingQty = remainingQty;
    _dominantColor = dominantColor;
    _name = name;
    _canMoveToWishlist = canMoveToWishlist;
    _isFreeProduct = isFreeProduct;
    _id = id;
    _sku = sku;
    _qty = qty;
    _typeId = typeId;
    _price = price;
    _discountPrice = discountPrice;
    _subTotal = subTotal;
    _finalPrice = finalPrice;
    _formattedPrice = formattedPrice;
    _formattedFinalPrice = formattedFinalPrice;
    _isInRange = isInRange;
    _groupedProductId = groupedProductId;
    _productId = productId;
    _messages = messages;
  }

  /// Creates an [ItemsOfCart] object from a JSON map.
  ItemsOfCart.fromJson(Map<String, dynamic> json) {
    _image = json['image'];
    _thresholdQty = json['thresholdQty'];
    _remainingQty = json['remainingQty'];
    _dominantColor = json['dominantColor'];
    _name = json['name'];
    _canMoveToWishlist = json['canMoveToWishlist'];
    _isFreeProduct = json['isFreeProduct'];
    _id = json['id'];
    _sku = json['sku'];
    _qty = json['qty'];
    _typeId = json['typeId'];
    _price = json['price'];
    _discountPrice = json['discountPrice'];
    _subTotal = json['subTotal'];
    _finalPrice = json['finalPrice'];
    _formattedPrice = json['formattedPrice'];
    _formattedFinalPrice = json['formattedFinalPrice'];
    _isInRange = json['isInRange'];
    _groupedProductId = json['groupedProductId'];
    _productId = json['productId'];
    if (json['messages'] != null) {
      _messages = (json['messages'] as List<dynamic>)
          .map((dynamic v) => RemoveCartMessages.fromJson(v))
          .toList();
    }
  }

  String? _image;
  String? _thresholdQty;
  num? _remainingQty;
  String? _dominantColor;
  String? _name;
  bool? _canMoveToWishlist;
  bool? _isFreeProduct;
  String? _id;
  String? _sku;
  num? _qty;
  String? _typeId;
  num? _price;
  String? _discountPrice;
  String? _subTotal;
  String? _finalPrice;
  String? _formattedPrice;
  String? _formattedFinalPrice;
  bool? _isInRange;
  num? _groupedProductId;
  String? _productId;
  List<RemoveCartMessages>? _messages;

  /// Creates a copy of this [ItemsOfCart] with optional modifications.
  ItemsOfCart copyWith({
    String? image,
    String? thresholdQty,
    num? remainingQty,
    String? dominantColor,
    String? name,
    bool? canMoveToWishlist,
    bool? isFreeProduct,
    String? id,
    String? sku,
    num? qty,
    String? typeId,
    num? price,
    String? discountPrice,
    String? subTotal,
    String? finalPrice,
    String? formattedPrice,
    String? formattedFinalPrice,
    bool? isInRange,
    num? groupedProductId,
    String? productId,
    List<RemoveCartMessages>? messages,
  }) =>
      ItemsOfCart(
        image: image ?? _image,
        thresholdQty: thresholdQty ?? _thresholdQty,
        remainingQty: remainingQty ?? _remainingQty,
        dominantColor: dominantColor ?? _dominantColor,
        name: name ?? _name,
        canMoveToWishlist: canMoveToWishlist ?? _canMoveToWishlist,
        isFreeProduct: isFreeProduct ?? _isFreeProduct,
        id: id ?? _id,
        sku: sku ?? _sku,
        qty: qty ?? _qty,
        typeId: typeId ?? _typeId,
        price: price ?? _price,
        discountPrice: discountPrice ?? _discountPrice,
        subTotal: subTotal ?? _subTotal,
        finalPrice: finalPrice ?? _finalPrice,
        formattedPrice: formattedPrice ?? _formattedPrice,
        formattedFinalPrice: formattedFinalPrice ?? _formattedFinalPrice,
        isInRange: isInRange ?? _isInRange,
        groupedProductId: groupedProductId ?? _groupedProductId,
        productId: productId ?? _productId,
        messages: messages ?? _messages,
      );

  // Getter methods
  /// Gets the image URL for this cart item.
  String? get image => _image;

  /// Gets the threshold quantity for this cart item.
  String? get thresholdQty => _thresholdQty;

  /// Gets the remaining quantity available for this cart item.
  num? get remainingQty => _remainingQty;

  /// Gets the dominant color of this cart item.
  String? get dominantColor => _dominantColor;

  /// Gets the name of this cart item.
  String? get name => _name;

  /// Gets whether this cart item can be moved to wishlist.
  bool? get canMoveToWishlist => _canMoveToWishlist;

  /// Gets whether this cart item is a free product.
  bool? get isFreeProduct => _isFreeProduct;

  /// Gets the unique identifier for this cart item.
  String? get id => _id;

  /// Gets the SKU for this cart item.
  String? get sku => _sku;

  /// Gets the quantity of this cart item in the cart.
  num? get qty => _qty;

  /// Gets the type identifier for this cart item.
  String? get typeId => _typeId;

  /// Gets the price of this cart item.
  num? get price => _price;

  /// Gets the discount price of this cart item.
  String? get discountPrice => _discountPrice;

  /// Gets the subtotal for this cart item.
  String? get subTotal => _subTotal;

  /// Gets the final price of this cart item after discounts.
  String? get finalPrice => _finalPrice;

  /// Gets the formatted price for display.
  String? get formattedPrice => _formattedPrice;

  /// Gets the formatted final price for display.
  String? get formattedFinalPrice => _formattedFinalPrice;

  /// Gets whether this cart item is in range.
  bool? get isInRange => _isInRange;

  /// Gets the grouped product ID for this cart item.
  num? get groupedProductId => _groupedProductId;

  /// Gets the product ID for this cart item.
  String? get productId => _productId;

  /// Gets the list of messages associated with this cart item.
  List<RemoveCartMessages>? get messages => _messages;

  /// Converts this [ItemsOfCart] object to a JSON map.
  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = <String, dynamic>{};
    map['image'] = _image;
    map['thresholdQty'] = _thresholdQty;
    map['remainingQty'] = _remainingQty;
    map['dominantColor'] = _dominantColor;
    map['name'] = _name;
    map['canMoveToWishlist'] = _canMoveToWishlist;
    map['isFreeProduct'] = _isFreeProduct;
    map['id'] = _id;
    map['sku'] = _sku;
    map['qty'] = _qty;
    map['typeId'] = _typeId;
    map['price'] = _price;
    map['discountPrice'] = _discountPrice;
    map['subTotal'] = _subTotal;
    map['finalPrice'] = _finalPrice;
    map['formattedPrice'] = _formattedPrice;
    map['formattedFinalPrice'] = _formattedFinalPrice;
    map['isInRange'] = _isInRange;
    map['groupedProductId'] = _groupedProductId;
    map['productId'] = _productId;
    if (_messages != null) {
      map['messages'] =
          _messages?.map((RemoveCartMessages v) => v.toJson()).toList();
    }
    return map;
  }
}

/// Represents a message related to removing an item from the cart.
class RemoveCartMessages {
  /// Constructs a [RemoveCartMessages] object with optional [text] and [type].
  RemoveCartMessages({
    String? text,
    String? type,
  }) {
    _text = text;
    _type = type;
  }

  /// Creates a [RemoveCartMessages] object from a JSON map.
  RemoveCartMessages.fromJson(Map<String, dynamic> json) {
    _text = json['text'];
    _type = json['type'];
  }

  String? _text;
  String? _type;

  /// Creates a copy of this [RemoveCartMessages] object,
  /// allowing optional modification of the [text] and [type].
  RemoveCartMessages copyWith({
    String? text,
    String? type,
  }) =>
      RemoveCartMessages(
        text: text ?? _text,
        type: type ?? _type,
      );

  /// The text content of the message (e.g., 'Item removed successfully').
  String? get text => _text;

  /// The type of the message (e.g., 'success', 'error').
  String? get type => _type;

  /// Converts this [RemoveCartMessages] object to a JSON map.
  ///
  /// The resulting map will contain keys 'text' and 'type',
  ///  representing the message content and its type.
  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = <String, dynamic>{};
    map['text'] = _text;
    map['type'] = _type;
    return map;
  }
}
