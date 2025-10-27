// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'review_payment_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReviewPaymentResponseModel _$ReviewPaymentResponseModelFromJson(
        Map<String, dynamic> json) =>
    ReviewPaymentResponseModel(
      iOSApplePay: json['iOSApplePay'] as String?,
      androidApplePay: json['AndroidApplePay'] as String?,
      iOSGooglePay: json['iOSGooglePay'] as String?,
      androidGooglePay: json['AndroidGooglePay'] as String?,
      iOSApplePaySDK: json['iOSApplePaySDK'] as String?,
      cartCount: (json['cartCount'] as num?)?.toInt(),
      isWalletEnabled: json['isWalletEnabled'] as bool?,
      addWalletAmount: (json['addWalletAmount'] as num?)?.toInt(),
      isRewardEnabled: json['isRewardEnabled'] as bool?,
      success: json['success'] as bool?,
      couponCode: json['couponCode'] as String?,
      currencyCode: json['currencyCode'] as String?,
      canPlaceOrder: json['canPlaceOrder'] as bool?,
      canPlaceOrderMessage: json['canPlaceOrderMessage'] as String?,
      totalWeight: (json['totalWeight'] as num?)?.toDouble(),
      totalDiscount: json['totalDiscount'] as String?,
      totalDiscountAmount: (json['totalDiscountAmount'] as num?)?.toDouble(),
      billingAddressNew: json['billingAddressNew'] == null
          ? null
          : BillingAddressNew.fromJson(
              json['billingAddressNew'] as Map<String, dynamic>),
      shippingMethod: json['shippingMethod'] as String?,
      orderReviewData: json['orderReviewData'] == null
          ? null
          : OrderReviewData.fromJson(
              json['orderReviewData'] as Map<String, dynamic>),
      customerId: json['customerId'] as String?,
      timeslotDetails: json['timeslotDetails'] == null
          ? null
          : ReviewPaymentTimeslotDetails.fromJson(
              json['timeslotDetails'] as Map<String, dynamic>),
      creditCardData: json['creditCardData'] == null
          ? null
          : CreditCardData.fromJson(
              json['creditCardData'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ReviewPaymentResponseModelToJson(
        ReviewPaymentResponseModel instance) =>
    <String, dynamic>{
      'iOSApplePay': instance.iOSApplePay,
      'AndroidApplePay': instance.androidApplePay,
      'iOSGooglePay': instance.iOSGooglePay,
      'AndroidGooglePay': instance.androidGooglePay,
      'iOSApplePaySDK': instance.iOSApplePaySDK,
      'cartCount': instance.cartCount,
      'isWalletEnabled': instance.isWalletEnabled,
      'addWalletAmount': instance.addWalletAmount,
      'isRewardEnabled': instance.isRewardEnabled,
      'success': instance.success,
      'couponCode': instance.couponCode,
      'currencyCode': instance.currencyCode,
      'canPlaceOrder': instance.canPlaceOrder,
      'canPlaceOrderMessage': instance.canPlaceOrderMessage,
      'totalWeight': instance.totalWeight,
      'totalDiscount': instance.totalDiscount,
      'totalDiscountAmount': instance.totalDiscountAmount,
      'billingAddressNew': instance.billingAddressNew,
      'shippingMethod': instance.shippingMethod,
      'orderReviewData': instance.orderReviewData,
      'customerId': instance.customerId,
      'timeslotDetails': instance.timeslotDetails,
      'creditCardData': instance.creditCardData,
    };

BillingAddressNew _$BillingAddressNewFromJson(Map<String, dynamic> json) =>
    BillingAddressNew(
      name: json['name'] as String?,
      telephone: json['telephone'] as String?,
      company: json['company'] as String?,
      street:
          (json['street'] as List<dynamic>?)?.map((e) => e as String).toList(),
      city: json['city'] as String?,
      region: json['region'] as String?,
      countryId: json['countryId'] as String?,
    );

Map<String, dynamic> _$BillingAddressNewToJson(BillingAddressNew instance) =>
    <String, dynamic>{
      'name': instance.name,
      'telephone': instance.telephone,
      'company': instance.company,
      'street': instance.street,
      'city': instance.city,
      'region': instance.region,
      'countryId': instance.countryId,
    };

OrderReviewData _$OrderReviewDataFromJson(Map<String, dynamic> json) =>
    OrderReviewData(
      items: (json['items'] as List<dynamic>?)
          ?.map((e) => Item.fromJson(e as Map<String, dynamic>))
          .toList(),
      totals: json['totals'] == null
          ? null
          : ReviewPaymentTotals.fromJson(
              json['totals'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$OrderReviewDataToJson(OrderReviewData instance) =>
    <String, dynamic>{
      'items': instance.items,
      'totals': instance.totals,
    };

Item _$ItemFromJson(Map<String, dynamic> json) => Item(
      productName: json['productName'] as String?,
      thumbNail: json['thumbNail'] as String?,
      id: json['id'] as String?,
      sku: json['sku'] as String?,
      qty: (json['qty'] as num?)?.toInt(),
      price: json['price'] as String?,
      formattedPrice: json['formattedPrice'] as String?,
      finalPrice: json['finalPrice'] as String?,
      formattedFinalPrice: json['formattedFinalPrice'] as String?,
      discountPrice: json['discountPrice'] as String?,
      subTotal: json['subTotal'] as String?,
      unformattedPrice: (json['unformattedPrice'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$ItemToJson(Item instance) => <String, dynamic>{
      'productName': instance.productName,
      'thumbNail': instance.thumbNail,
      'id': instance.id,
      'sku': instance.sku,
      'qty': instance.qty,
      'price': instance.price,
      'formattedPrice': instance.formattedPrice,
      'finalPrice': instance.finalPrice,
      'formattedFinalPrice': instance.formattedFinalPrice,
      'discountPrice': instance.discountPrice,
      'subTotal': instance.subTotal,
      'unformattedPrice': instance.unformattedPrice,
    };

ReviewPaymentTotals _$ReviewPaymentTotalsFromJson(Map<String, dynamic> json) =>
    ReviewPaymentTotals(
      subtotal: json['subtotal'] == null
          ? null
          : ReviewPaymentSubTotal.fromJson(
              json['subtotal'] as Map<String, dynamic>),
      shipping: json['shipping'] == null
          ? null
          : ReviewPaymentShipping.fromJson(
              json['shipping'] as Map<String, dynamic>),
      tax: json['tax'] == null
          ? null
          : Tax.fromJson(json['tax'] as Map<String, dynamic>),
      totalExclVat: json['total_excl_vat'] == null
          ? null
          : TotalExclVat.fromJson(
              json['total_excl_vat'] as Map<String, dynamic>),
      grandTotal: json['grand_total'] == null
          ? null
          : GrandTotal.fromJson(json['grand_total'] as Map<String, dynamic>),
      discount: json['discount'] == null
          ? null
          : Discount.fromJson(json['discount'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ReviewPaymentTotalsToJson(
        ReviewPaymentTotals instance) =>
    <String, dynamic>{
      'subtotal': instance.subtotal,
      'shipping': instance.shipping,
      'tax': instance.tax,
      'total_excl_vat': instance.totalExclVat,
      'grand_total': instance.grandTotal,
      'discount': instance.discount,
    };

ReviewPaymentSubTotal _$ReviewPaymentSubTotalFromJson(
        Map<String, dynamic> json) =>
    ReviewPaymentSubTotal(
      title: json['title'] as String?,
      unformattedValue: (json['unformattedValue'] as num?)?.toInt(),
      formattedValue: json['formattedValue'] as String?,
      value: json['value'] as String?,
    );

Map<String, dynamic> _$ReviewPaymentSubTotalToJson(
        ReviewPaymentSubTotal instance) =>
    <String, dynamic>{
      'title': instance.title,
      'unformattedValue': instance.unformattedValue,
      'formattedValue': instance.formattedValue,
      'value': instance.value,
    };

ReviewPaymentShipping _$ReviewPaymentShippingFromJson(
        Map<String, dynamic> json) =>
    ReviewPaymentShipping(
      title: json['title'] as String?,
      unformattedValue: (json['unformattedValue'] as num?)?.toInt(),
      formattedValue: json['formattedValue'] as String?,
      value: json['value'] as String?,
    );

Map<String, dynamic> _$ReviewPaymentShippingToJson(
        ReviewPaymentShipping instance) =>
    <String, dynamic>{
      'title': instance.title,
      'unformattedValue': instance.unformattedValue,
      'formattedValue': instance.formattedValue,
      'value': instance.value,
    };

Tax _$TaxFromJson(Map<String, dynamic> json) => Tax(
      title: json['title'] as String?,
      unformattedValue: (json['unformattedValue'] as num?)?.toDouble(),
      formattedValue: json['formattedValue'] as String?,
      value: json['value'] as String?,
    );

Map<String, dynamic> _$TaxToJson(Tax instance) => <String, dynamic>{
      'title': instance.title,
      'unformattedValue': instance.unformattedValue,
      'formattedValue': instance.formattedValue,
      'value': instance.value,
    };

TotalExclVat _$TotalExclVatFromJson(Map<String, dynamic> json) => TotalExclVat(
      title: json['title'] as String?,
      unformattedValue: (json['unformattedValue'] as num?)?.toDouble(),
      formattedValue: json['formattedValue'] as String?,
      value: json['value'] as String?,
    );

Map<String, dynamic> _$TotalExclVatToJson(TotalExclVat instance) =>
    <String, dynamic>{
      'title': instance.title,
      'unformattedValue': instance.unformattedValue,
      'formattedValue': instance.formattedValue,
      'value': instance.value,
    };

GrandTotal _$GrandTotalFromJson(Map<String, dynamic> json) => GrandTotal(
      title: json['title'] as String?,
      unformattedValue: (json['unformattedValue'] as num?)?.toInt(),
      formattedValue: json['formattedValue'] as String?,
      value: json['value'] as String?,
    );

Map<String, dynamic> _$GrandTotalToJson(GrandTotal instance) =>
    <String, dynamic>{
      'title': instance.title,
      'unformattedValue': instance.unformattedValue,
      'formattedValue': instance.formattedValue,
      'value': instance.value,
    };

Discount _$DiscountFromJson(Map<String, dynamic> json) => Discount(
      title: json['title'] as String?,
      unformattedValue: (json['unformattedValue'] as num?)?.toInt(),
      formattedValue: json['formattedValue'] as String?,
      value: json['value'] as String?,
    );

Map<String, dynamic> _$DiscountToJson(Discount instance) => <String, dynamic>{
      'title': instance.title,
      'unformattedValue': instance.unformattedValue,
      'formattedValue': instance.formattedValue,
      'value': instance.value,
    };

ReviewPaymentTimeslotDetails _$ReviewPaymentTimeslotDetailsFromJson(
        Map<String, dynamic> json) =>
    ReviewPaymentTimeslotDetails(
      orderDeliveryDate: json['orderDeliveryDate'] as String?,
      orderDeliveryTime: json['orderDeliveryTime'] as String?,
    );

Map<String, dynamic> _$ReviewPaymentTimeslotDetailsToJson(
        ReviewPaymentTimeslotDetails instance) =>
    <String, dynamic>{
      'orderDeliveryDate': instance.orderDeliveryDate,
      'orderDeliveryTime': instance.orderDeliveryTime,
    };

CreditCardData _$CreditCardDataFromJson(Map<String, dynamic> json) =>
    CreditCardData(
      action: json['action'] as String?,
      amount: json['amount'] == null
          ? null
          : Amount.fromJson(json['amount'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CreditCardDataToJson(CreditCardData instance) =>
    <String, dynamic>{
      'action': instance.action,
      'amount': instance.amount,
    };

Amount _$AmountFromJson(Map<String, dynamic> json) => Amount(
      currencyCode: json['currencyCode'] as String?,
      value: (json['value'] as num?)?.toInt(),
    );

Map<String, dynamic> _$AmountToJson(Amount instance) => <String, dynamic>{
      'currencyCode': instance.currencyCode,
      'value': instance.value,
    };
