import '../../../../utils/exports.dart';

/// Represents the response model for upsell product details.
class UpsellResponseModel {
  /// Constructor to initialize UpsellResponseModel with an
  /// optional result list.
  UpsellResponseModel({this.result});

  /// Creates an UpsellResponseModel instance from a JSON map.
  UpsellResponseModel.fromJson(Map<String, dynamic> json) {
    /*if (json['result'] != null) {
      result = <ProductList>[];
      json['result'].forEach((dynamic v) {
        result!.add(ProductList.fromJson(v as Map<String, dynamic>));
      });
    }*/
    if (json['result'] != null) {
      result = (json['result'] as List<dynamic>)
          .map<ProductList>(
              (dynamic v) => ProductList.fromJson(v as Map<String, dynamic>))
          .toList();
    }
  }

  /// A list of products in the upsell response.
  List<ProductList>? result;

  /// A list of objects for equating instances.
  List<Object?> get props => <Object?>[result];

  /// Converts the UpsellResponseModel to a JSON map.
  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = <String, dynamic>{};
    if (result != null) {
      data['result'] = result!.map((ProductList v) => v.toJson()).toList();
    }
    return data;
  }

  /// Returns a copy of the UpsellResponseModel with optional
  /// new values for fields.
  UpsellResponseModel copyWith({
    List<ProductList>? result,
  }) =>
      UpsellResponseModel(
        result: result ?? this.result,
      );
}
