
library;

/// Represents the request model for returning an order.
///
/// This class contains the properties needed to make an API request to return
/// an order. It includes fields for the store ID, customer token, page number,
/// and website ID. The class provides a named constructor for initializing
/// an instance from a JSON map and a method to convert the instance back
/// into a JSON map for API requests.
class ReturnOrderRequestModel {
  /// Default constructor to initialize the properties of the model.
  ///
  /// [storeId] - The ID of the store where the return is being processed.
  /// [customerToken] - The token of the customer initiating the return.
  /// [p] - The page number for pagination purposes in API requests.
  /// [websiteId] - The ID of the website associated with the return.
  ReturnOrderRequestModel({
    this.storeId,
    this.customerToken,
    this.p,
    this.websiteId,
  });

  /// Named constructor to create an instance from a JSON map.
  ///
  /// [json] - A map containing the JSON data representing the request.
  /// This constructor is used to initialize the model from JSON received
  /// from an API or other sources.
  ReturnOrderRequestModel.fromJson(Map<String, dynamic> json) {
    storeId = json['storeId'];
    customerToken = json['customerToken'];
    p = json['p'];
    websiteId = json['websiteId'];
  }

  /// The ID of the store where the return is being processed.
  String? storeId;

  /// The token of the customer initiating the return.
  String? customerToken;

  /// The page number for pagination purposes in API requests.
  String? p;

  /// The ID of the website associated with the return.
  String? websiteId;

  /// Converts the instance into a JSON map.
  ///
  /// This method creates a map that can be used to send the request data
  /// in an API call. It maps the properties of the class to the corresponding
  /// JSON keys.
  ///
  /// Returns a `Map<String, dynamic>` representing the instance data.
  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = <String, dynamic>{};
    data['storeId'] = storeId;
    data['customerToken'] = customerToken;
    data['p'] = p;
    data['websiteId'] = websiteId;
    return data;
  }
}
