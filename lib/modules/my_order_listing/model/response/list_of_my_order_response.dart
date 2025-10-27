import '../../../../utils/exports.dart';


/// Model class for individual order response data.
class ListOfMyOrderResponse {
  /// The unique identifier for the order.
  final int? orderId;

  /// The number of items in the order.
  final int? noOfItems;

  /// The final amount of the order.
  final double? orderFinalAmount;

  /// The date when the order was placed.
  final String? orderDate;

  /// The current status of the order.
  final String? orderStatus;

  /// The type of the order.
  final String? orderType;

  /// The Mashkor status of the order.
  final String? mashkorStatus;

  /// The first product in the order.
  final FirstProduct? firstProduct;

  /// The store information associated with the order.
  final ListOfStoreResponse? storeObject;

  /// Creates an instance of [ListOfMyOrderResponse].
  ListOfMyOrderResponse({
    this.orderId,
    this.noOfItems,
    this.orderFinalAmount,
    this.orderDate,
    this.orderStatus,
    this.orderType,
    this.mashkorStatus,
    this.firstProduct,
    this.storeObject,
  });

  /// Creates a copy of this [ListOfMyOrderResponse] with optional new values.
  ListOfMyOrderResponse copyWith({
    int? orderId,
    int? noOfItems,
    double? orderFinalAmount,
    String? orderDate,
    String? orderStatus,
    String? orderType,
    String? mashkorStatus,
    FirstProduct? firstProduct,
    ListOfStoreResponse? storeObject
}) => ListOfMyOrderResponse(
    orderId: orderId ?? this.orderId,
    noOfItems: noOfItems ?? this.noOfItems,
    orderFinalAmount: orderFinalAmount ?? this.orderFinalAmount,
    orderDate: orderDate ?? this.orderDate,
    orderStatus: orderStatus ?? this.orderStatus,
    orderType: orderType ?? this.orderType,
    mashkorStatus: mashkorStatus ?? this.mashkorStatus,
    firstProduct: firstProduct ?? this.firstProduct,
    storeObject: storeObject ?? this.storeObject,
  );

  /// Creates an instance of [ListOfMyOrderResponse] from a JSON map.
  factory ListOfMyOrderResponse.fromJson(Map<String, dynamic> json) {
    return ListOfMyOrderResponse(
      orderId: json['orderId'] as int?,
      noOfItems: json['noOfItems'] as int?,
      orderFinalAmount: json['orderFinalAmount'] as double?,
      orderDate: json['orderDate'] as String?,
      orderStatus: json['orderStatus'] as String?,
      orderType: json['orderType'] as String?,
        mashkorStatus: json['mashkor_status'] as String?,
        firstProduct: json['firstProduct'] != null
            ? FirstProduct.fromJson(json['firstProduct'] as Map<String, dynamic>)
            : null,

        storeObject: json['storeObject'] != null
    ? ListOfStoreResponse.fromJson(json['storeObject'] as Map<String, dynamic>)
        : null
    );
  }

}

/// Model class for the first product in an order.
class FirstProduct {
  /// The unique identifier for the product.
  final int? id;

  /// The name of the product.
  final String? name;

  /// The thumbnail URL of the product image.
  final String? thumbUrl;

  /// Creates an instance of [FirstProduct].
  FirstProduct({
    this.id,
    this.name,
    this.thumbUrl,
  });

  /// Creates an instance of [FirstProduct] from a JSON map.
  factory FirstProduct.fromJson(Map<String, dynamic> json) {
    final dynamic rawId = json['id'];
    final int? parsedId = (rawId is int)
        ? rawId
        : (rawId is String && rawId.isNotEmpty)
        ? int.tryParse(rawId)
        : null;
    return FirstProduct(
      id: parsedId,
      name: json['name'] as String?,
      thumbUrl: json['thumb_url'] as String?,
    );
  }
}