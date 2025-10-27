import '../../my_order_listing/model/response/list_of_my_order_response.dart';

/// Represents the response model for the store receipt API.
class StoreReceiptModel {
  /// Creates an instance of [StoreReceiptModel].
  StoreReceiptModel({
    this.success,
    this.message,
    this.totalCount,
    this.receiptList,
    this.eTag,
  });

  /// Creates an instance of [StoreReceiptModel] from a JSON map.
  StoreReceiptModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    totalCount = json['totalCount'];

    if (json['receiptList'] != null) {
      receiptList = <StoreReceipt>[];
      // Explicitly declaring the type as List<StoreReceipt>
      for (final dynamic v in json['receiptList'] as List<dynamic>) {
        receiptList!.add(StoreReceipt.fromJson(v as Map<String, dynamic>));
      }
    }

    eTag = json['eTag'];
  }

  /// Indicates the success status of the API response.
  bool? success;

  /// Message returned by the API, typically for errors or information.
  String? message;

  /// Total count of receipts returned by the API.
  int? totalCount;

  /// List of receipts returned by the API.
  List<StoreReceipt>? receiptList;

  /// ETag for cache validation or concurrency control.
  String? eTag;

  /// Converts the [StoreReceiptModel] instance to a JSON map.
  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['message'] = message;
    data['totalCount'] = totalCount;
    if (receiptList != null) {
      data['receiptList'] = receiptList!.map((StoreReceipt v) => v.toJson()).toList();
    }
    data['eTag'] = eTag;
    return data;
  }
}

/// Represents an individual store receipt in the receipt list.
class StoreReceipt {
  /// Creates an instance of [StoreReceipt].
  StoreReceipt({
    this.id,
    this.date,
    this.state,
    this.statusCode,
    this.status,
    this.storeName,
    this.storeAddress,
    this.deliveryType,
    this.receiptId,
    this.receiptData,
    this.itemCount,
    this.receiptTotal,
    this.itemImageUrl,
    this.statusColorCode,
    this.canDownload,
    this.isDownloadAllowed,
  });

  /// Creates an instance of [StoreReceipt] from a JSON map.
  StoreReceipt.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    date = json['date'];
    state = json['state'];
    statusCode = json['status_code'];
    status = json['status'];
    storeName = json['store_name'];
    storeAddress = json['store_address'];
    deliveryType = json['delivery_type'];
    receiptId = json['receipt_id'];
    receiptData = json['receiptData'] != null
        ? ReceiptData.fromJson(json['receiptData'])
        : null;
    itemCount = json['item_count'];
    receiptTotal = json['receipt_total'];
    itemImageUrl = json['item_image_url'];
    statusColorCode = json['statusColorCode'];
    canDownload = json['canDownload'];
    isDownloadAllowed = json['isDownloadAllowed'];
  }

  /// Unique identifier of the receipt.
  int? id;

  /// Date when the receipt was generated.
  String? date;

  /// State of the receipt (e.g., generated, pending).
  String? state;

  /// Code representing the status of the receipt.
  String? statusCode;

  /// Status description of the receipt.
  String? status;

  /// Store name where the receipt was generated.
  String? storeName;

  /// Store address where the receipt was generated.
  String? storeAddress;

  /// Delivery type (pickup/delivery).
  String? deliveryType;

  /// Receipt ID for referencing.
  String? receiptId;

  /// Receipt details.
  ReceiptData? receiptData;

  /// Number of items in the receipt.
  int? itemCount;

  /// Total amount of the receipt.
  String? receiptTotal;

  /// URL of the image representing an item in the receipt.
  String? itemImageUrl;

  /// Color code representing the status of the receipt.
  String? statusColorCode;

  /// Indicates if the receipt can be downloaded.
  bool? canDownload;

  /// Indicates if downloading is allowed for the receipt.
  bool? isDownloadAllowed;

  /// Converts the [StoreReceipt] instance to a JSON map.
  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['date'] = date;
    data['state'] = state;
    data['status_code'] = statusCode;
    data['status'] = status;
    data['store_name'] = storeName;
    data['store_address'] = storeAddress;
    data['delivery_type'] = deliveryType;
    data['receipt_id'] = receiptId;
    if (receiptData != null) {
      data['receiptData'] = receiptData!.toJson();
    }
    data['item_count'] = itemCount;
    data['receipt_total'] = receiptTotal;
    data['item_image_url'] = itemImageUrl;
    data['statusColorCode'] = statusColorCode;
    data['canDownload'] = canDownload;
    data['isDownloadAllowed'] = isDownloadAllowed;
    return data;
  }
}

/// Represents receipt information.
class ReceiptData {
  /// Creates an instance of [ReceiptData].
  ReceiptData({this.receiptDate, this.receiptTime});

  /// Creates an instance of [ReceiptData] from a JSON map.
  ReceiptData.fromJson(Map<String, dynamic> json) {
    receiptDate = json['receiptDate'];
    receiptTime = json['receiptTime'];
  }

  /// Date when the receipt was generated.
  String? receiptDate;

  /// Time when the receipt was generated.
  String? receiptTime;

  /// Converts the [ReceiptData] instance to a JSON map.
  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = <String, dynamic>{};
    data['receiptDate'] = receiptDate;
    data['receiptTime'] = receiptTime;
    return data;
  }
}

/// Extension to convert ListOfMyOrderResponse to StoreReceipt
extension ListOfMyOrderResponseExtension on ListOfMyOrderResponse {
  /// Converts ListOfMyOrderResponse to StoreReceipt
  StoreReceipt toStoreReceipt() {
    return StoreReceipt(
      id: orderId,
      date: orderDate,
      status: orderStatus,
      storeName: storeObject?.storeName,
      receiptId: orderId?.toString(),
      itemCount: noOfItems,
      receiptTotal: orderFinalAmount?.toString(),
      itemImageUrl: firstProduct?.thumbUrl,
      storeAddress: storeObject?.address,
      deliveryType: orderType,
    );
  }
} 