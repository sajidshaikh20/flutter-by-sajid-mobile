import '../../../../utils/exports.dart';

/// Represents the response model for a cart list.
class CartListResponseModel {
  /// Creates a new instance of [CartListResponseModel].
  CartListResponseModel({
    this.quoteId,
    this.freeShippingMsg,
    this.freeShippingAmtUnformatted,
    this.timeslotDetails,
    this.items,
    this.totalDiscount,
    this.totalDiscountAmount,
    this.freeGiftMsg,
    this.cartCount,
    this.totalsData,
    this.isCheckoutAllowed,
    this.customerId,
    this.wishListTotalCount,
    this.wishList,
    this.couponCode,
    this.success,
  });

  /// Creates a new instance of [CartListResponseModel] from a JSON map.
  CartListResponseModel.fromJson(Map<String, dynamic> json) {
    quoteId = json['quoteId'];
    freeShippingMsg = json['freeShippingMsg'];
    freeShippingAmtUnformatted = json['freeShippingAmtUnformatted'];
    timeslotDetails = json['timeslotDetails'] != null
        ? TimeslotDetails.fromJson(json['timeslotDetails'])
        : null;
    /* if (json['items'] != null) {
      items = <Items>[];
      json['items'].forEach((dynamic v) {
        items!.add(Items.fromJson(v as Map<String, dynamic>));
      });
    }*/

    // if (json['items'] != null) {
    //   items = <Items>[];
    //   for (final Map<String, dynamic> v
    //       in (json['items'] as List<Map<String, dynamic>>)) {
    //     items!.add(Items.fromJson(v));
    //   }
    // }

    if (json['items'] != null) {
      items = (json['items'] as List<dynamic>)
          .map((dynamic v) => Items.fromJson(v as Map<String, dynamic>))
          .toList();
    }



    totalDiscount = json['totalDiscount'];
    totalDiscountAmount = json['totalDiscountAmount'];
    freeGiftMsg = json['freeGiftMsg'];
    couponCode = json.containsKey('couponCode') ? json['couponCode'] : null;
    cartCount = json['cartCount'];
    totalsData = json['totalsData'] != null
        ? TotalsData.fromJson(json['totalsData'])
        : null;
    isCheckoutAllowed = json['isCheckoutAllowed'];
    customerId = json['customerId'].toString();
    wishListTotalCount = json['wishListTotalCount'];
    // if (json['wishList'] != null) {
    //   wishList = <EmptyData>[];
    //   json['wishList'].forEach((Map<String, dynamic> v) {
    //     wishList!.add(EmptyData.fromJson(v));
    //   });
    // }

    if (json['wishList'] != null) {
      wishList = <EmptyData>[];
      for (final dynamic v in (json['wishList'] as List<dynamic>)) {
        wishList!.add(EmptyData.fromJson(v as Map<String, dynamic>));
      }
    }


    success = json['success'];
  }

  /// The unique quote ID for the cart.
  String? quoteId;

  /// A message indicating if free shipping is available.
  String? freeShippingMsg;

  /// The unformatted amount for free shipping.
  String? freeShippingAmtUnformatted;

  /// The timeslot details for the delivery, if available.
  TimeslotDetails? timeslotDetails;

  /// A list of items in the cart.
  List<Items>? items;

  /// The total discount applied to the cart.
  String? totalDiscount;

  /// The total discount amount applied to the cart.
  num? totalDiscountAmount;

  /// A message indicating if a free gift is available.
  String? freeGiftMsg;

  /// The coupon code applied to the cart, if any.
  String? couponCode;

  /// The total count of items in the cart.
  int? cartCount;

  /// The total data related to the cart, including subtotals and totals.
  TotalsData? totalsData;

  /// A flag indicating whether checkout is allowed.
  bool? isCheckoutAllowed;

  /// The unique customer ID associated with the cart.
  String? customerId;

  /// The total count of items in the wishlist.
  int? wishListTotalCount;

  /// A list of items in the wishlist.
  List<EmptyData>? wishList;

  /// A flag indicating whether the request was successful.
  bool? success;

  /// Converts the [CartListResponseModel] object to a JSON map.
  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = <String, dynamic>{};
    data['quoteId'] = quoteId;
    data['freeShippingMsg'] = freeShippingMsg;
    data['freeShippingAmtUnformatted'] = freeShippingAmtUnformatted;
    if (timeslotDetails != null) {
      data['timeslotDetails'] = timeslotDetails!.toJson();
    }
    if (items != null) {
      data['items'] = items?.map((Items v) => v.toJson()).toList() ??
          <Map<String, dynamic>>[];
    }
    data['totalDiscount'] = totalDiscount;
    data['totalDiscountAmount'] = totalDiscountAmount;
    data['freeGiftMsg'] = freeGiftMsg;
    data['cartCount'] = cartCount;
    data['couponCode'] = couponCode;
    if (totalsData != null) {
      data['totalsData'] = totalsData!.toJson();
    }
    data['isCheckoutAllowed'] = isCheckoutAllowed;
    data['customerId'] = customerId;
    data['wishListTotalCount'] = wishListTotalCount;
    if (wishList != null) {
      data['wishList'] = wishList!.map((EmptyData v) => v.toJson()).toList();
    }
    data['success'] = success;
    return data;
  }
}

/// Represents the details of a delivery timeslot.
class TimeslotDetails {
  /// Creates a new instance of [TimeslotDetails].
  TimeslotDetails({
    this.showDeliverySlots,
    this.deliverySlot,
    this.orderDeliveryDate,
    this.orderDeliveryTime,
  });

  /// Creates a new instance of [TimeslotDetails] from a JSON map.
  TimeslotDetails.fromJson(Map<String, dynamic> json) {
    showDeliverySlots = json['showDeliverySlots'];
    deliverySlot = json['deliverySlot'];
    orderDeliveryDate = json['orderDeliveryDate'];
    orderDeliveryTime = json['orderDeliveryTime'];
  }

  /// A flag indicating whether delivery slots are available.
  bool? showDeliverySlots;

  /// The chosen delivery slot for the order.
  String? deliverySlot;

  /// The date for the order delivery.
  String? orderDeliveryDate;

  /// The time for the order delivery.
  String? orderDeliveryTime;

  /// Converts the [TimeslotDetails] object to a JSON map.
  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = <String, dynamic>{};
    data['showDeliverySlots'] = showDeliverySlots;
    data['deliverySlot'] = deliverySlot;
    data['orderDeliveryDate'] = orderDeliveryDate;
    data['orderDeliveryTime'] = orderDeliveryTime;
    return data;
  }
}

/// Represents an item in an order or cart.
class Items {
  /// Creates a new instance of [Items].
  Items({
    this.image,
    this.name,
    this.isFreeProduct,
    this.id,
    this.sku,
    this.qty,
    this.typeId,
    this.price,
    this.formattedPrice,
    this.finalPrice,
    this.formattedFinalPrice,
    this.discountPrice,
    this.subTotal,
    this.isInRange,
    this.messages,
    this.productId,
    this.selectedValueOfDropDown,
  });

  /// Creates a new instance of [Items] from a JSON map.
  Items.fromJson(Map<String, dynamic> json) {
    image = json['image'];
    name = json['name'];
    isFreeProduct = json['isFreeProduct'];
    id = json['id'];
    sku = json['sku'];
    qty = json['qty'];
    typeId = json['typeId'];
    price = json['price'];
    formattedPrice = json['formattedPrice'];
    finalPrice = json['finalPrice'];
    formattedFinalPrice = json['formattedFinalPrice'];
    discountPrice = json['discountPrice'];
    subTotal = json['subTotal'];
    isInRange = json['isInRange'];
    // if (json['messages'] != null) {
    //   messages = <Messages>[];
    //   json['messages'].forEach((Map<String, dynamic> v) {
    //     messages?.add(Messages.fromJson(v));
    //   });
    // }

    if (json['messages'] != null) {
      messages = (json['messages'] as List<dynamic>)
          .map((dynamic v) => Messages.fromJson(v as Map<String, dynamic>))
          .toList();
    }




    productId = json['productId'];
  }

  /// The image URL for the item.
  String? image;

  /// The name of the item.
  String? name;

  /// Indicates whether the item is a free product.
  bool? isFreeProduct;

  /// The unique identifier of the item.
  String? id;

  /// The SKU (Stock Keeping Unit) of the item.
  String? sku;

  /// The quantity of the item.
  int? qty;

  /// The type ID of the item (e.g., 'simple', 'configurable').
  String? typeId;

  /// The price of the item.
  String? price;

  /// The formatted price of the item (e.g., with currency symbols).
  String? formattedPrice;

  /// The final price of the item after discounts.
  String? finalPrice;

  /// The formatted final price of the item (e.g., with currency symbols).
  String? formattedFinalPrice;

  /// The discount price of the item.
  String? discountPrice;

  /// The subtotal price of the item.
  String? subTotal;

  /// A flag indicating whether the item is within a valid price range.
  bool? isInRange;

  /// A list of messages related to the item (e.g., warnings, errors).
  List<Messages>? messages;

  /// The product ID of the item.
  String? productId;

  /// The selected value for a dropdown (e.g., size, color).
  String? selectedValueOfDropDown;

  /// A flag indicating whether the item has a special price to show.
  bool showSpecialPrice = false;

  /// The percentage discount of the special price.
  String percentage = '';

  /// The formatted strike price (the original price before discount).
  String formattedStrikePrice = '';

  /// Converts the [Items] object to a JSON map.
  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = <String, dynamic>{};
    data['image'] = image;
    data['name'] = name;
    data['isFreeProduct'] = isFreeProduct;
    data['id'] = id;
    data['sku'] = sku;
    data['qty'] = qty;
    data['typeId'] = typeId;
    data['price'] = price;
    data['formattedPrice'] = formattedPrice;
    data['finalPrice'] = finalPrice;
    data['formattedFinalPrice'] = formattedFinalPrice;
    data['discountPrice'] = discountPrice;
    data['subTotal'] = subTotal;
    data['isInRange'] = isInRange;
    if (messages != null) {
      data['messages'] = messages!.map((Messages v) => v.toJson()).toList();
    }
    data['productId'] = productId;
    return data;
  }

  /// Calculates and updates the special price and
  /// discount percentage for the item.
  void calculateSpecialPrice() {
    double finalPrice1 = double.tryParse(finalPrice ?? '0') ?? 0;
    double priceForOfferView = double.tryParse(price ?? '0') ?? 0;

    showSpecialPrice = finalPrice1 != 0 &&
        finalPrice1 < priceForOfferView &&
        (isInRange ?? false);

    if (showSpecialPrice) {
      double val =
          ((priceForOfferView - finalPrice1) / priceForOfferView) * 100;

      if (val == 0) {
        percentage = '';
      } else {
        percentage = val.toStringAsFixed(0);
      }

      if (formattedPrice != null) {
        formattedStrikePrice = formattedPrice!;
      }
    } else {
      percentage = '';
      formattedFinalPrice = formattedPrice;
      formattedStrikePrice = '';
    }
  }
}

/// Represents a message with associated text and type.
class Messages {
  /// Creates a new instance of [Messages].
  Messages({
    this.text,
    this.type,
  });

  /// Creates a new instance of [Messages] from a JSON map.
  Messages.fromJson(Map<String, dynamic> json) {
    text = json['text'];
    type = json['type'];
  }

  /// The text content of the message.
  String? text;

  /// The type of the message (e.g., 'info', 'error', 'warning').
  String? type;

  /// Converts the [Messages] object to a JSON map.
  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = <String, dynamic>{};
    data['text'] = text;
    data['type'] = type;
    return data;
  }
}

/// Represents the total amounts for an order, including the subtotal, shipping,
class TotalsData {
  /// Creates a new instance of [TotalsData].
  TotalsData({
    this.subtotal,
    this.shipping,
    this.tax,
    this.totalExclVat,
    this.grandTotal,
    this.discount,
  });

  /// Creates a new instance of [TotalsData] from a JSON map.
  TotalsData.fromJson(Map<String, dynamic> json) {
    subtotal =
        json['subtotal'] != null ? Subtotal.fromJson(json['subtotal']) : null;
    shipping =
        json['shipping'] != null ? Shipping.fromJson(json['shipping']) : null;
    tax = json['tax'] != null ? Subtotal.fromJson(json['tax']) : null;
    totalExclVat = json['total_excl_vat'] != null
        ? Subtotal.fromJson(json['total_excl_vat'])
        : null;
    grandTotal = json['grand_total'] != null
        ? Subtotal.fromJson(json['grand_total'])
        : null;
    discount =
        json['discount'] != null ? Subtotal.fromJson(json['discount']) : null;
  }

  /// The subtotal of the order (excluding shipping, tax, and discounts).
  Subtotal? subtotal;

  /// The shipping cost for the order.
  Shipping? shipping;

  /// The tax applied to the order.
  Subtotal? tax;

  /// The total cost of the order excluding VAT.
  Subtotal? totalExclVat;

  /// The grand total of the order, including all costs and adjustments.
  Subtotal? grandTotal;

  /// The discount applied to the order.
  Subtotal? discount;

  /// Converts the [TotalsData] object to a JSON map.
  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = <String, dynamic>{};
    if (subtotal != null) {
      data['subtotal'] = subtotal!.toJson();
    }
    if (shipping != null) {
      data['shipping'] = shipping!.toJson();
    }
    if (tax != null) {
      data['tax'] = tax!.toJson();
    }
    if (totalExclVat != null) {
      data['total_excl_vat'] = totalExclVat!.toJson();
    }
    if (grandTotal != null) {
      data['grand_total'] = grandTotal!.toJson();
    }
    if (discount != null) {
      data['discount'] = discount!.toJson();
    }
    return data;
  }
}

/// Represents the subtotal information of an order.
class Subtotal {
  /// Creates a new instance of [Subtotal].
  Subtotal({
    this.title,
    this.unformattedValue,
    this.formattedValue,
    this.value,
  });

  /// Creates a new instance of [Subtotal] from a JSON map.
  Subtotal.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    unformattedValue = json['unformattedValue'];
    formattedValue = json['formattedValue'];
    value = json['value'];
  }

  /// The title or name of the subtotal (e.g., 'Subtotal').
  String? title;

  /// The unformatted value of the subtotal.
  num? unformattedValue;

  /// The formatted value of the subtotal.
  String? formattedValue;

  /// A string representation of the subtotal cost, potentially containing
  String? value;

  /// Converts the [Subtotal] object to a JSON map.
  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = title;
    data['unformattedValue'] = unformattedValue;
    data['formattedValue'] = formattedValue;
    data['value'] = value;
    return data;
  }
}

/// Represents shipping information for an order.
class Shipping {
  /// The constructor allows optional parameters for each of the properties:
  Shipping({
    this.title,
    this.unformattedValue,
    this.formattedValue,
    this.value,
  });

  /// Creates a new instance of [Shipping] from a JSON map.
  Shipping.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    unformattedValue = json['unformattedValue'];
    formattedValue = json['formattedValue'];
    value = json['value'];
  }

  /// The title or name of the shipping method (e.g., 'Standard Shipping').
  String? title;

  /// The unformatted value of the shipping cost.
  /// This value is typically a raw numeric value (e.g., 10.5).
  num? unformattedValue;

  /// The formatted value of the shipping cost.
  /// This value is typically a string formatted with
  /// currency symbols (e.g., '$10.50').
  String? formattedValue;

  /// A string representation of the shipping cost, potentially containing
  /// additional information, such as a discount or surcharge.
  String? value;

  /// Converts the [Shipping] object to a JSON map.
  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = title;
    data['unformattedValue'] = unformattedValue;
    data['formattedValue'] = formattedValue;
    data['value'] = value;
    return data;
  }
}
