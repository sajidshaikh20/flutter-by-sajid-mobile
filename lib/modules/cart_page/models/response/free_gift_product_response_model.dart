import '../../../../utils/exports.dart';

/// Represents the response containing information about free gift products.
class FreeGiftProductResponseModel {
  /// Constructor for initializing FreeGiftProductResponseModel with
  /// optional parameters.
  FreeGiftProductResponseModel({this.success, this.message, this.productList});

  /// Creates a FreeGiftProductResponseModel instance from a JSON map.
  FreeGiftProductResponseModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['productList'] != null) {
      productList = (json['productList'] as List<dynamic>)
          .map<ProductList>((dynamic v) => ProductList.fromJson(v as Map<String, dynamic>))
          .toList();
    }

    /* if (json['productList'] != null) {
      productList = <ProductList>[];
      json['productList'].forEach((Map<String, dynamic> v) {
        productList!.add(ProductList.fromJson(v));
      });
    }*/
  }

  /// Indicates whether the request for free gift products was successful.
  bool? success;

  /// A message providing additional information about the free gift products.
  String? message;

  /// A list of free gift products.
  List<ProductList>? productList;

  /// Converts the FreeGiftProductResponseModel to a JSON map.
  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['message'] = message;
    if (productList != null) {
      data['productList'] =
          productList!.map((ProductList v) => v.toJson()).toList();
    }
    return data;
  }
}
