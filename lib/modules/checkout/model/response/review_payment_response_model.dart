import 'package:json_annotation/json_annotation.dart';

part 'review_payment_response_model.g.dart';

/// Model representing the response of a payment review process.
@JsonSerializable(ignoreUnannotated: false)
class ReviewPaymentResponseModel {

  /// Constructor for the [ReviewPaymentResponseModel] class.
  ReviewPaymentResponseModel({
    this.iOSApplePay,
    this.androidApplePay,
    this.iOSGooglePay,
    this.androidGooglePay,
    this.iOSApplePaySDK,
    this.cartCount,
    this.isWalletEnabled,
    this.addWalletAmount,
    this.isRewardEnabled,
    this.success,
    this.couponCode,
    this.currencyCode,
    this.canPlaceOrder,
    this.canPlaceOrderMessage,
    this.totalWeight,
    this.totalDiscount,
    this.totalDiscountAmount,
    this.billingAddressNew,
    this.shippingMethod,
    this.orderReviewData,
    this.customerId,
    this.timeslotDetails,
    this.creditCardData,
  });

  /// Factory method to create an instance of
  /// [ReviewPaymentResponseModel] from JSON data.
  factory ReviewPaymentResponseModel.fromJson(Map<String, dynamic> json) =>
      _$ReviewPaymentResponseModelFromJson(json);
  /// The iOS Apple Pay payment method.
  @JsonKey(name: 'iOSApplePay')
  final String? iOSApplePay;

  /// The Android Apple Pay payment method.
  @JsonKey(name: 'AndroidApplePay')
  final String? androidApplePay;

  /// The iOS Google Pay payment method.
  @JsonKey(name: 'iOSGooglePay')
  final String? iOSGooglePay;

  /// The Android Google Pay payment method.
  @JsonKey(name: 'AndroidGooglePay')
  final String? androidGooglePay;

  /// The iOS Apple Pay SDK payment method.
  @JsonKey(name: 'iOSApplePaySDK')
  final String? iOSApplePaySDK;

  /// The number of items in the cart.
  @JsonKey(name: 'cartCount')
  final int? cartCount;

  /// Whether the wallet feature is enabled.
  @JsonKey(name: 'isWalletEnabled')
  final bool? isWalletEnabled;

  /// The amount to be added to the wallet.
  @JsonKey(name: 'addWalletAmount')
  final int? addWalletAmount;

  /// Whether the reward feature is enabled.
  @JsonKey(name: 'isRewardEnabled')
  final bool? isRewardEnabled;



  /// Whether the payment process was successful.
  @JsonKey(name: 'success')
  final bool? success;

  /// The coupon code applied to the order.
  @JsonKey(name: 'couponCode')
  final String? couponCode;

  /// The currency code for the transaction.
  @JsonKey(name: 'currencyCode')
  final String? currencyCode;

  /// Whether the order can be placed.
  @JsonKey(name: 'canPlaceOrder')
  final bool? canPlaceOrder;

  /// The message related to placing the order.
  @JsonKey(name: 'canPlaceOrderMessage')
  final String? canPlaceOrderMessage;

  /// The total weight of the cart items.
  @JsonKey(name: 'totalWeight')
  final double? totalWeight;

  /// The total discount applied to the order.
  @JsonKey(name: 'totalDiscount')
  final String? totalDiscount;

  /// The total amount of discount applied to the order.
  @JsonKey(name: 'totalDiscountAmount')
  final double? totalDiscountAmount;

  /// The billing address for the order.
  @JsonKey(name: 'billingAddressNew')
  final BillingAddressNew? billingAddressNew;

  /// The selected shipping method for the order.
  @JsonKey(name: 'shippingMethod')
  final String? shippingMethod;

  /// Data related to order review before payment.
  @JsonKey(name: 'orderReviewData')
  final OrderReviewData? orderReviewData;

  /// The customer ID for the order.
  @JsonKey(name: 'customerId')
  final String? customerId;

  /// The details of the timeslot selected for delivery.
  @JsonKey(name: 'timeslotDetails')
  final ReviewPaymentTimeslotDetails? timeslotDetails;

  /// Credit card data used for payment.
  @JsonKey(name: 'creditCardData')
  final CreditCardData? creditCardData;

  /// Method to convert [ReviewPaymentResponseModel] to JSON.
  Map<String, dynamic> toJson() => _$ReviewPaymentResponseModelToJson(this);
}



/// Represents a billing address with associated details.
/// This class stores the billing address information
/// required for processing orders.
@JsonSerializable(ignoreUnannotated: false)
class BillingAddressNew {

  /// Constructor for the [BillingAddressNew] class.
  BillingAddressNew({
    this.name,
    this.telephone,
    this.company,
    this.street,
    this.city,
    this.region,
    this.countryId,
  });

  /// Factory method to create an instance of
  /// [BillingAddressNew] from JSON data.
  factory BillingAddressNew.fromJson(Map<String, dynamic> json) =>
      _$BillingAddressNewFromJson(json);
  /// The name of the person or entity associated with the billing address.
  @JsonKey(name: 'name')
  final String? name;

  /// The telephone number associated with the billing address.
  @JsonKey(name: 'telephone')
  final String? telephone;

  /// The company name associated with the billing address,
  /// if applicable.
  @JsonKey(name: 'company')
  final String? company;

  /// A list of street addresses for the billing address
  /// (e.g., house number, street name).
  @JsonKey(name: 'street')
  final List<String>? street;

  /// The city for the billing address.
  @JsonKey(name: 'city')
  final String? city;

  /// The region or state for the billing address.
  @JsonKey(name: 'region')
  final String? region;

  /// The country ID for the billing address, typically an ISO code.
  @JsonKey(name: 'countryId')
  final String? countryId;

  /// Method to convert [BillingAddressNew] to JSON.
  Map<String, dynamic> toJson() => _$BillingAddressNewToJson(this);
}

/// Represents the data related to an order review.
@JsonSerializable(ignoreUnannotated: false)
class OrderReviewData {

  /// Constructor for the [OrderReviewData] class.
  OrderReviewData({this.items, this.totals});

  /// Factory method to create an instance of
  /// [OrderReviewData] from JSON data.
  factory OrderReviewData.fromJson(Map<String, dynamic> json) =>
      _$OrderReviewDataFromJson(json);
  /// A list of items included in the order.
  @JsonKey(name: 'items')
  final List<Item>? items;

  /// The total information for the order, including
  /// totals for price, taxes,
  /// discounts, etc.
  @JsonKey(name: 'totals')
  final ReviewPaymentTotals? totals;

  /// Method to convert [OrderReviewData] to JSON.
  Map<String, dynamic> toJson() => _$OrderReviewDataToJson(this);
}

/// A class representing details about a item.
@JsonSerializable(ignoreUnannotated: false)
class Item {

  /// Creates a new instance of the Item class.
  Item({
    this.productName,
    this.thumbNail,
    this.id,
    this.sku,
    // this.weight,
    this.qty,
    this.price,
    this.formattedPrice,
    this.finalPrice,
    this.formattedFinalPrice,
    this.discountPrice,
    this.subTotal,
    this.unformattedPrice,
  });

  /// Creates an instance of Item from a JSON map.
  factory Item.fromJson(Map<String, dynamic> json) => _$ItemFromJson(json);
  /// The product name.
  @JsonKey(name: 'productName')
  final String? productName;

  /// The thumbnail URL of the product.
  @JsonKey(name: 'thumbNail')
  final String? thumbNail;

  /// The unique identifier for the product.
  @JsonKey(name: 'id')
  final String? id;

  /// The stock-keeping unit (SKU) for the product.
  @JsonKey(name: 'sku')
  final String? sku;

  // Uncomment and document if needed:
  // /// The weight of the product.
  // @JsonKey(name: 'weight')
  // final String? weight;

  /// The quantity of the product.
  @JsonKey(name: 'qty')
  final int? qty;

  /// The price of the product.
  @JsonKey(name: 'price')
  final String? price;

  /// The formatted price of the product.
  @JsonKey(name: 'formattedPrice')
  final String? formattedPrice;

  /// The final price of the product after discounts.
  @JsonKey(name: 'finalPrice')
  final String? finalPrice;

  /// The formatted final price of the product.
  @JsonKey(name: 'formattedFinalPrice')
  final String? formattedFinalPrice;

  /// The discount price applied to the product.
  @JsonKey(name: 'discountPrice')
  final String? discountPrice;

  /// The subtotal price for the product.
  @JsonKey(name: 'subTotal')
  final String? subTotal;

  /// The unformatted price of the product (as a double value).
  @JsonKey(name: 'unformattedPrice')
  final double? unformattedPrice;

  /// Converts an Item instance into a JSON map.
  Map<String, dynamic> toJson() => _$ItemToJson(this);
}

/// A class representing details about a review payment total.
@JsonSerializable(ignoreUnannotated: false)
class ReviewPaymentTotals {

  /// Creates a new instance of ReviewPaymentTotals.
  ReviewPaymentTotals({
    this.subtotal,
    this.shipping,
    this.tax,
    this.totalExclVat,
    this.grandTotal,
    this.discount,
  });

  /// Creates an instance of ReviewPaymentTotals from a JSON map.
  factory ReviewPaymentTotals.fromJson(Map<String, dynamic> json) =>
      _$ReviewPaymentTotalsFromJson(json);
  /// The subtotal amount for the payment.
  @JsonKey(name: 'subtotal')
  final ReviewPaymentSubTotal? subtotal;

  /// The shipping cost for the payment.
  @JsonKey(name: 'shipping')
  final ReviewPaymentShipping? shipping;

  /// The tax amount for the payment.
  @JsonKey(name: 'tax')
  final Tax? tax;

  /// The total amount excluding VAT.
  @JsonKey(name: 'total_excl_vat')
  final TotalExclVat? totalExclVat;

  /// The grand total of the payment.
  @JsonKey(name: 'grand_total')
  final GrandTotal? grandTotal;

  /// The discount applied to the payment.
  @JsonKey(name: 'discount')
  final Discount? discount;

  /// Converts an instance of ReviewPaymentTotals into a JSON map.
  Map<String, dynamic> toJson() => _$ReviewPaymentTotalsToJson(this);
}

/// A class representing details about a review payment sub total.
@JsonSerializable(ignoreUnannotated: false)
class ReviewPaymentSubTotal {

  /// Creates a new instance of ReviewPaymentSubTotal.
  ReviewPaymentSubTotal({
    this.title,
    this.unformattedValue,
    this.formattedValue,
    this.value,
  });

  /// Creates an instance of ReviewPaymentSubTotal from a JSON map.
  factory ReviewPaymentSubTotal.fromJson(Map<String, dynamic> json) =>
      _$ReviewPaymentSubTotalFromJson(json);
  /// The title or label for the subtotal.
  @JsonKey(name: 'title')
  final String? title;

  /// The unformatted numerical value of the subtotal.
  @JsonKey(name: 'unformattedValue')
  final int? unformattedValue;

  /// The formatted string representation of the subtotal.
  @JsonKey(name: 'formattedValue')
  final String? formattedValue;

  /// The value of the subtotal as a string.
  @JsonKey(name: 'value')
  final String? value;

  /// Converts an instance of ReviewPaymentSubTotal into a JSON map.
  Map<String, dynamic> toJson() => _$ReviewPaymentSubTotalToJson(this);
}

/// A class representing details about a review payment shipping.
@JsonSerializable(ignoreUnannotated: false)
class ReviewPaymentShipping {

  /// Creates a new instance of ReviewPaymentShipping.
  ReviewPaymentShipping({
    this.title,
    this.unformattedValue,
    this.formattedValue,
    this.value,
  });

  /// Creates an instance of ReviewPaymentShipping from a JSON map.
  factory ReviewPaymentShipping.fromJson(Map<String, dynamic> json) =>
      _$ReviewPaymentShippingFromJson(json);
  /// The title or label for the shipping cost.
  @JsonKey(name: 'title')
  final String? title;

  /// The unformatted numerical value of the shipping cost.
  @JsonKey(name: 'unformattedValue')
  final int? unformattedValue;

  /// The formatted string representation of the shipping cost.
  @JsonKey(name: 'formattedValue')
  final String? formattedValue;

  /// The value of the shipping cost as a string.
  @JsonKey(name: 'value')
  final String? value;

  /// Converts an instance of ReviewPaymentShipping into a JSON map.
  Map<String, dynamic> toJson() => _$ReviewPaymentShippingToJson(this);
}

/// A class representing details about a tax.
@JsonSerializable(ignoreUnannotated: false)
class Tax {

  /// Creates a new instance of the Tax class.
  Tax({
    this.title,
    this.unformattedValue,
    this.formattedValue,
    this.value,
  });

  /// Creates an instance of the Tax class from a JSON map.
  factory Tax.fromJson(Map<String, dynamic> json) => _$TaxFromJson(json);
  /// The title or label for the tax.
  @JsonKey(name: 'title')
  final String? title;

  /// The unformatted numerical value of the tax.
  @JsonKey(name: 'unformattedValue')
  final double? unformattedValue;

  /// The formatted string representation of the tax.
  @JsonKey(name: 'formattedValue')
  final String? formattedValue;

  /// The value of the tax as a string.
  @JsonKey(name: 'value')
  final String? value;

  /// Converts an instance of the Tax class into a JSON map.
  Map<String, dynamic> toJson() => _$TaxToJson(this);
}

/// A class representing details about a total amount excluding VAT.
@JsonSerializable(ignoreUnannotated: false)
class TotalExclVat {

  /// Creates a new instance of [TotalExclVat].
  TotalExclVat({
    this.title,
    this.unformattedValue,
    this.formattedValue,
    this.value,
  });

  /// Creates a [TotalExclVat] instance from a JSON map.
  factory TotalExclVat.fromJson(Map<String, dynamic> json) =>
      _$TotalExclVatFromJson(json);
  /// The title of the total amount.
  @JsonKey(name: 'title')
  final String? title;

  /// The unformatted numeric value of the total amount.
  @JsonKey(name: 'unformattedValue')
  final double? unformattedValue;

  /// The formatted string representation of the total amount.
  @JsonKey(name: 'formattedValue')
  final String? formattedValue;

  /// The value as a string.
  @JsonKey(name: 'value')
  final String? value;

  /// Converts this [TotalExclVat] instance to a JSON map.
  Map<String, dynamic> toJson() => _$TotalExclVatToJson(this);
}

/// A class representing details about a grand total.
@JsonSerializable(ignoreUnannotated: false)
class GrandTotal {

  /// Creates a new instance of the GrandTotal class.
  GrandTotal({
    this.title,
    this.unformattedValue,
    this.formattedValue,
    this.value,
  });

  /// Creates an instance of the GrandTotal class from a JSON map.
  factory GrandTotal.fromJson(Map<String, dynamic> json) =>
      _$GrandTotalFromJson(json);
  /// The title or label for the grand total.
  @JsonKey(name: 'title')
  final String? title;

  /// The unformatted numerical value of the grand total.
  @JsonKey(name: 'unformattedValue')
  final int? unformattedValue;

  /// The formatted string representation of the grand total.
  @JsonKey(name: 'formattedValue')
  final String? formattedValue;

  /// The value of the grand total as a string.
  @JsonKey(name: 'value')
  final String? value;

  /// Converts an instance of the GrandTotal class into a JSON map.
  Map<String, dynamic> toJson() => _$GrandTotalToJson(this);
}

/// A class representing details about a discount.
@JsonSerializable(ignoreUnannotated: false)
class Discount {

  /// Creates a new instance of [Discount].
  Discount({
    this.title,
    this.unformattedValue,
    this.formattedValue,
    this.value,
  });

  /// Creates a [Discount] instance from a JSON map.
  factory Discount.fromJson(Map<String, dynamic> json) =>
      _$DiscountFromJson(json);
  /// The title or name of the discount.
  @JsonKey(name: 'title')
  final String? title;

  /// The unformatted numeric value of the discount.
  @JsonKey(name: 'unformattedValue')
  final int? unformattedValue;

  /// The formatted string representation of the discount value.
  @JsonKey(name: 'formattedValue')
  final String? formattedValue;

  /// The value of the discount as a string.
  @JsonKey(name: 'value')
  final String? value;

  /// Converts this [Discount] instance to a JSON map.
  Map<String, dynamic> toJson() => _$DiscountToJson(this);
}

/// A class representing details about a review payment timeslot details.
@JsonSerializable(ignoreUnannotated: false)
class ReviewPaymentTimeslotDetails {

  /// Creates a new instance of ReviewPaymentTimeslotDetails.
  ReviewPaymentTimeslotDetails({
    this.orderDeliveryDate,
    this.orderDeliveryTime,
  });

  /// Creates an instance of ReviewPaymentTimeslotDetails from a JSON map.
  factory ReviewPaymentTimeslotDetails.fromJson(
    Map<String, dynamic> json,
  ) =>
      _$ReviewPaymentTimeslotDetailsFromJson(json);
  /// The delivery date for the order.
  @JsonKey(name: 'orderDeliveryDate')
  final String? orderDeliveryDate;

  /// The delivery time for the order.
  @JsonKey(name: 'orderDeliveryTime')
  final String? orderDeliveryTime;

  /// Converts an instance of ReviewPaymentTimeslotDetails into a JSON map.
  Map<String, dynamic> toJson() => _$ReviewPaymentTimeslotDetailsToJson(this);
}

/// A class representing credit card transaction data.
@JsonSerializable(ignoreUnannotated: false)
class CreditCardData {

  /// Creates a new instance of [CreditCardData].
  CreditCardData({this.action, this.amount});

  /// Creates a [CreditCardData] instance from a JSON map.
  factory CreditCardData.fromJson(Map<String, dynamic> json) =>
      _$CreditCardDataFromJson(json);
  /// The action associated with the credit card
  /// transaction (e.g., 'payment' or 'refund').
  @JsonKey(name: 'action')
  final String? action;

  /// The amount involved in the credit card transaction.
  @JsonKey(name: 'amount')
  final Amount? amount;

  /// Converts this [CreditCardData] instance to a JSON map.
  Map<String, dynamic> toJson() => _$CreditCardDataToJson(this);
}

/// A class representing details about a amount.
@JsonSerializable(ignoreUnannotated: false)
class Amount {

  /// Creates a new instance of the Amount class.
  Amount({
    this.currencyCode,
    this.value,
  });

  /// Creates an instance of the Amount class from a JSON map.
  factory Amount.fromJson(Map<String, dynamic> json) => _$AmountFromJson(json);
  /// The code representing the currency (e.g., USD, EUR).
  @JsonKey(name: 'currencyCode')
  final String? currencyCode;

  /// The monetary value in the smallest currency
  /// unit (e.g., cents for USD).
  @JsonKey(name: 'value')
  final int? value;

  /// Converts an instance of the Amount class into a JSON map.
  Map<String, dynamic> toJson() => _$AmountToJson(this);
}
