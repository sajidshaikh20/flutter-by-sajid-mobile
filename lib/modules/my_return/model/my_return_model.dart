import 'dart:convert';

/// Converts a JSON string [str] into a [MyReturnModel] instance.
///
/// This method takes a JSON string as input and decodes it into a Map.
/// Then, it uses the [MyReturnModel.fromJson] method to create an instance of
/// [MyReturnModel] from the decoded Map.
///
/// [str] - The JSON string representing the return model data.
///
/// Returns a [MyReturnModel] instance created from the decoded JSON.
MyReturnModel myReturnModelFromJson(String str) =>
    MyReturnModel.fromJson(json.decode(str));


/// Converts a [MyReturnModel] instance into a JSON string.
///
/// This method encodes the [MyReturnModel] instance into a JSON string by calling
/// the [] method on the [MyReturnModel] instance and then encoding the
/// resulting Map to a string using `json.encode`.
///
/// [data] - The [MyReturnModel] instance to be converted into JSON.
///
/// Returns a JSON string representing the [MyReturnModel] instance.
String myReturnModelToJson(MyReturnModel data) => json.encode(data.toJson());


/// A model representing the return response.
class MyReturnModel {
  /// Creates a new instance of [MyReturnModel].
  MyReturnModel({
    this.success,
    this.message,
    this.totalCount,
    this.orderlisting,
  });

  /// Creates a new instance of [MyReturnModel] from a JSON object.
  factory MyReturnModel.fromJson(Map<String, dynamic> json) => MyReturnModel(
        success: json['success'],
        message: json['message'],
        totalCount: json['totalCount'],
        orderlisting: json['orderlisting'] == null
            ? <ReturnOrderItem>[]
            : List<ReturnOrderItem>.from(
                (json['orderlisting'] as List<dynamic>).map(
                  (dynamic x) => ReturnOrderItem.fromJson(x),
                ),
              ),
      );

  /// Indicates whether the operation was successful.
  bool? success;

  /// A message related to the return operation.
  String? message;

  /// The total number of return orders.
  int? totalCount;

  /// A list of items in the return order.
  List<ReturnOrderItem>? orderlisting;

  /// Converts this [MyReturnModel] to a JSON object.
  ///
  /// Returns a map containing the model's fields and
  /// their corresponding values.
  Map<String, dynamic> toJson() => <String, dynamic>{
        'success': success,
        'message': message,
        'totalCount': totalCount,
        'orderlisting': orderlisting == null
            ? <ReturnOrderItem>[]
            : List<dynamic>.from(
                orderlisting!.map((ReturnOrderItem x) => x.toJson())),
      };
}

/// A model class representing an item in a return order.
class ReturnOrderItem {
  /// Creates an instance of [ReturnOrderItem].
  ///
  /// Each field is optional and can be provided when constructing an instance.
  ReturnOrderItem({
    this.requestId,
    this.orderId,
    this.storeId,
    this.createdAt,
    this.modifiedAt,
    this.status,
    this.customerId,
    this.customerName,
    this.urlHash,
    this.managerId,
    this.customFields,
    this.rating,
    this.ratingComment,
    this.note,
    this.shippingLabel,
    this.incrementId,
    this.qty,
    this.itemId,
    this.newMessage,
    this.productUrl,
    this.viewUrl,
    this.statusLabel,
    this.statusColor,
  });

  /// Creates an instance of [ReturnOrderItem] from a JSON map.
  factory ReturnOrderItem.fromJson(Map<String, dynamic> json) =>
      ReturnOrderItem(
        requestId: json['request_id'],
        orderId: json['order_id'],
        storeId: json['store_id'],
        createdAt: json['created_at'],
        modifiedAt: json['modified_at'],
        status: json['status'],
        customerId: json['customer_id'],
        customerName: json['customer_name'],
        urlHash: json['url_hash'],
        managerId: json['manager_id'],
        customFields: json['custom_fields'],
        rating: json['rating'],
        ratingComment: json['rating_comment'],
        note: json['note'],
        shippingLabel: json['shipping_label'],
        incrementId: json['increment_id'],
        qty: json['qty'],
        itemId: json['item_id'],
        newMessage: json['new_message'],
        productUrl: json['product_url'],
        viewUrl: json['view_url'],
        statusLabel: json['status_label'],
        statusColor: json['status_color'],
      );

  /// The unique identifier for the return request.
  String? requestId;

  /// The unique identifier for the order.
  String? orderId;

  /// The identifier of the store where the order was made.
  String? storeId;

  /// The date and time when the return order was created.
  String? createdAt;

  /// The date and time when the return order was last modified.
  String? modifiedAt;

  /// The status of the return order.
  String? status;

  /// The unique identifier for the customer who made the order.
  String? customerId;

  /// The name of the customer who made the order.
  String? customerName;

  /// A unique hash value for the URL associated with the return order.
  String? urlHash;

  /// The identifier of the manager handling the return order.
  String? managerId;

  /// Custom fields associated with the return order.
  String? customFields;

  /// The rating given for the return order item.
  String? rating;

  /// The comments left by the customer about the return order item rating.
  String? ratingComment;

  /// Additional notes regarding the return order item.
  String? note;

  /// The shipping label associated with the return order item.
  String? shippingLabel;

  /// The increment identifier for the order.
  String? incrementId;

  /// The quantity of items being returned.
  String? qty;

  /// The unique identifier for the item being returned.
  String? itemId;

  /// Any new message associated with the return order item.
  String? newMessage;

  /// The URL of the product associated with the return order item.
  String? productUrl;

  /// The view URL of the return order item.
  String? viewUrl;

  /// The label describing the status of the return order item.
  String? statusLabel;

  /// The color associated with the status label.
  String? statusColor;

  /// Converts the [ReturnOrderItem] instance into a JSON map.\
  Map<String, dynamic> toJson() => <String, dynamic>{
        'request_id': requestId,
        'order_id': orderId,
        'store_id': storeId,
        'created_at': createdAt,
        'modified_at': modifiedAt,
        'status': status,
        'customer_id': customerId,
        'customer_name': customerName,
        'url_hash': urlHash,
        'manager_id': managerId,
        'custom_fields': customFields,
        'rating': rating,
        'rating_comment': ratingComment,
        'note': note,
        'shipping_label': shippingLabel,
        'increment_id': incrementId,
        'qty': qty,
        'item_id': itemId,
        'new_message': newMessage,
        'product_url': productUrl,
        'view_url': viewUrl,
        'status_label': statusLabel,
        'status_color': statusColor,
      };
}
