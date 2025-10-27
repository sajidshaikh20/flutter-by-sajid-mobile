/// Represents the response of an order operation.
///
/// Contains details such as the order ID, transaction ID, date, total amount,
/// and optional messages for display or coupons.
class OrderResponse {
  /// The unique identifier for the order.
  final int? orderId;

  /// The transaction ID associated with the order.
  final String? transactionId;

  /// The date and time when the order was placed.
  final String? dateTime;

  /// The total amount for the order.
  final double? totalAmount;

  /// Optional message to display to the user.
  final String? msgToDisplay;

  /// Optional coupon message associated with the order.
  final String? msgCoupon;

  /// Creates an [OrderResponse] instance.
  const OrderResponse({
    this.orderId,
    this.transactionId,
    this.dateTime,
    this.totalAmount,
    this.msgToDisplay,
    this.msgCoupon,
  });

  /// Creates an [OrderResponse] from a JSON map.
  factory OrderResponse.fromJson(Map<String, dynamic> json) {
    return OrderResponse(
      orderId: json['orderId'] as int?,
      transactionId: json['transactionId'] as String?,
      dateTime: json['dateTime'] as String?,
      totalAmount: (json['totalAmount'] as num?)?.toDouble(),
      msgToDisplay: json['msgToDisplay'] as String?,
      msgCoupon: json['msg_coupon'] as String?,
    );
  }

  /// Converts this [OrderResponse] instance into a JSON map.
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'orderId': orderId,
      'transactionId': transactionId,
      'dateTime': dateTime,
      'totalAmount': totalAmount,
      'msgToDisplay': msgToDisplay,
      'msg_coupon': msgCoupon,
    };
  }
}
