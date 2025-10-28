import '/utils/exports.dart';

/// Model class for deals response data.
class DealsResponseModel {
  /// The unique identifier of the deal.
  final String? id;

  /// The type of the deal.
  final String? type;

  /// The label or title of the deal.
  final String? label;

  /// The URL to redirect to when the deal is clicked.
  final String? redirectUrl;

  /// List of products associated with the deal.


  /// Creates an instance of [DealsResponseModel].
  DealsResponseModel({
    this.id,
    this.type,
    this.label,
    this.redirectUrl,

  });

///fromJson
  factory DealsResponseModel.fromJson(Map<String, dynamic> json) {


    if (json['productList'] != null) {
      final dynamic productListData = json['productList'];

      if (productListData is List) {
        for (int i = 0; i < productListData.length; i++) {
          final dynamic item = productListData[i];


        }
      }
    }
    return DealsResponseModel(
      id: json['id'] as String?,
      type: json['type'] as String?,
      label: json['label'] as String?,
      redirectUrl: json['redirectUrl'] as String?,

    );
  }
}

