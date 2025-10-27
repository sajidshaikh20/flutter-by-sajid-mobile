import '../../../../utils/exports.dart';

/// A model representing the detailed response for an order.
class MyOrderDetailResponseModel {
  /// The unique identifier for the order.
  final int? orderId;

  /// The date when the order was placed.
  final String? orderDate;

  /// The current status of the order.
  final String? orderStatus;

  /// The type of the order (e.g., delivery, pickup).
  final String? orderType;

  /// The number of items in the order.
  final int? noOfItems;

  /// The final total amount of the order.
  final double? orderFinalAmount;

  /// The Mashkor status of the order.
  final String? mashkorStatus;

  /// The store information associated with the order.
  final ListOfStoreResponse? storeObject;

  /// The payment method used for the order.
  final String? paymentMethod;

  /// The points earned from this order.
  final String? pointEarned;

  /// The list of products in the order.
  final List<ProductListingResponse>? products;

  /// The list of reward products in the order.
  final List<ProductListingResponse>? rewardProducts;

  /// The user's address information for the order.
  final List<MyAddressListingResponse>? userAddress;

  /// The list of order status updates.
  final List<OrderStatusModel>? orderStatuses;

  /// The summary information for the order.
  final OrderSummary? orderSummary;

  /// The ratings and reviews for the order.
  final ListOfMyReviewsRatingResponseModel? orderRatings;

  /// Creates a [MyOrderDetailResponseModel] instance.
  ///
  /// All parameters are optional and represent order details data.
  MyOrderDetailResponseModel({
    this.orderId,
    this.orderDate,
    this.orderStatus,
    this.orderType,
    this.noOfItems,
    this.orderFinalAmount,
    this.mashkorStatus,
    this.storeObject,
    this.paymentMethod,
    this.pointEarned,
    this.products,
    this.rewardProducts,
    this.userAddress,
    this.orderStatuses,
    this.orderSummary,
    this.orderRatings,
  });

  /// Creates a [MyOrderDetailResponseModel] instance from a JSON map.
  ///
  /// [json] must contain the order details data in the expected format.
  /// Returns a new instance populated with the JSON data.
  factory MyOrderDetailResponseModel.fromJson(Map<String, dynamic> json) {
    return MyOrderDetailResponseModel(
      orderId: json['orderId'] as int?,
      orderDate: json['orderDate'] as String?,
      orderStatus: json['orderStatus'] as String?,
      orderType: json['orderType'] as String?,
      noOfItems: json['noOfItems'] as int?,
      orderFinalAmount: (json['orderFinalAmount'] as num?)?.toDouble(),
      mashkorStatus: json['mashkor_status'] as String?,
      storeObject: json['storeObject'] != null
          ? ListOfStoreResponse.fromJson(json['storeObject'] as Map<String, dynamic>)
          : null,
      orderRatings: json['orderRatings'] != null
          ? ListOfMyReviewsRatingResponseModel.fromJson(json['orderRatings'] as Map<String, dynamic>)
          : null,
      paymentMethod: json['paymentMethod'] as String?,
      pointEarned: json['pointEarned'] as String?,
      products: (json['products'] as List<dynamic>?)
          ?.map((dynamic e) => ProductListingResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
      rewardProducts: (json['rewardProducts'] as List<dynamic>?)
          ?.map((dynamic e) => ProductListingResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
      userAddress: (json['userAddress'] as List<dynamic>?)
          ?.map((dynamic e) => MyAddressListingResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
      orderStatuses: (json['orderStatuses'] as List<dynamic>?)
          ?.map((dynamic e) => OrderStatusModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      orderSummary: json['orderSummary'] != null
          ? OrderSummary.fromJson(json['orderSummary'] as Map<String, dynamic>)
          : null,
    );
  }

  /// Converts this [MyOrderDetailResponseModel] instance to a JSON map.
  ///
  /// Returns a [Map<String, dynamic>] containing all the order details data
  /// in the format expected by the API.
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'orderId': orderId,
      'orderDate': orderDate,
      'orderStatus': orderStatus,
      'orderType': orderType,
      'noOfItems': noOfItems,
      'orderFinalAmount': orderFinalAmount,
      'mashkor_status': mashkorStatus,
      'storeObject': storeObject?.toJson(),
      'paymentMethod': paymentMethod,
      'pointEarned': pointEarned,
      'products': products?.map((ProductListingResponse e) => e.toJson()).toList(),
      'rewardProducts': rewardProducts?.map((ProductListingResponse e) => e.toJson()).toList(),
      'userAddress': userAddress?.map((MyAddressListingResponse e) => e.toJson()).toList(),
      'orderStatuses': orderStatuses?.map((OrderStatusModel e) => e.toJson()).toList(),
      'orderSummary': orderSummary?.toJson(),
      'orderRatings': orderRatings?.toJson(),
    };
  }
}
/// Model class for order summary information.
class OrderSummary {
  /// The subtotal amount of the order.
  final double? subTotal;

  /// The delivery charge for the order.
  final double? deliveryCharge;

  /// The loyalty points applied to the order.
  final String? loyaltyPointsApplied;

  /// The wallet amount applied to the order.
  final String? walletApplied;

  /// The coupon code applied to the order.
  final String? couponCodeApplied;

  /// The final total amount of the order.
  final double? finalTotal;

  /// The total amount saved on the order.
  final String? totalSaved;

  /// Creates an instance of [OrderSummary].
  OrderSummary({
    this.subTotal,
    this.deliveryCharge,
    this.loyaltyPointsApplied,
    this.walletApplied,
    this.couponCodeApplied,
    this.finalTotal,
    this.totalSaved,
  });

  /// Creates an instance of [OrderSummary] from a JSON map.
  factory OrderSummary.fromJson(Map<String, dynamic> json) {
    return OrderSummary(
      subTotal: json['subTotal'] as double?,
      deliveryCharge: json['deliveryCharge'] as double?,
      loyaltyPointsApplied: json['LoyalityPointsApplied'] as String?,
      walletApplied: json['walletApplied'] as String?,
      couponCodeApplied: json['couponCodeApplied'] as String?,
      finalTotal: json['finalTotal'] as double?,
      totalSaved: json['totalSaved'] as String?,
    );
  }

  /// Converts the model to a JSON map.
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'subTotal': subTotal,
      'deliveryCharge': deliveryCharge,
      'LoyalityPointsApplied': loyaltyPointsApplied,
      'walletApplied': walletApplied,
      'couponCodeApplied': couponCodeApplied,
      'finalTotal': finalTotal,
      'totalSaved': totalSaved,
    };
  }
}

/// Model representing an order status with its details.
class OrderStatusModel {
  /// The status of the order.
  final String? status;

  /// The description of the order status.
  final String? description;

  /// Whether the order status is completed.
  final bool? isDone;

  /// The time of the order status update.
  final String? time;

  /// The date of the order status update.
  final String? date;

  /// Creates an instance of [OrderStatusModel].
  OrderStatusModel({
    this.status,
    this.description,
    this.isDone,
    this.time,
    this.date,
  });

  /// Creates an instance of [OrderStatusModel] from a JSON map.
  factory OrderStatusModel.fromJson(Map<String, dynamic> json) {
    return OrderStatusModel(
      status: json['status'] as String?,
      description: json['description'] as String?,
      isDone: json['isDone'] as bool?,
      time: json['time'] as String?,
      date: json['date'] as String?,
    );
  }

  /// Converts the model to a JSON map.
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'status': status,
      'description': description,
      'isDone': isDone,
      'time': time,
      'date': date,
    };
  }
}