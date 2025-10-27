/// Model representing the request data for reordering an order.
class ReorderApiRequestModel {

  /// Initializes a reorder API request model with optional parameters.
  ReorderApiRequestModel({
    this.storeId,
    this.incrementId,
    this.token,
  });
  /// The store ID associated with the reorder request.
  String? storeId;
  /// The increment ID of the order to be reordered.
  String? incrementId;
  /// The authentication token for the reorder request.
  String? token;

  /// Converts the reorder request model to a JSON map.
  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = <String, dynamic>{};
    data['storeId'] = storeId;
    data['incrementId'] = incrementId;
    data['customerToken'] = token;
    return data;
  }
}
