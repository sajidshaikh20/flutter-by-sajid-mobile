///DeleteWishlistRequest
class DeleteWishlistRequest {
  /// Constructor
  DeleteWishlistRequest({
    this.websiteId,
    this.storeId,
    this.customerToken,
    this.itemId,
  });

  /// Factory constructor for creating a new instance
  //from a map (JSON deserialization)
  factory DeleteWishlistRequest.fromJson(Map<String, dynamic> json) =>
      DeleteWishlistRequest(
        websiteId: json['websiteId'],
        storeId: json['storeId'],
        customerToken: json['customerToken'],
        itemId: json['itemId'],
      );

  ///Website Id
  String? websiteId;

  ///Store Id
  String? storeId;

  ///Customer token
  String? customerToken;

  ///Item id
  String? itemId;

  /// Method to convert this class instance
  ///into a map (JSON serialization)
  Map<String, dynamic> toJson() => <String, dynamic>{
        'websiteId': websiteId,
        'storeId': storeId,
        'customerToken': customerToken,
        'itemId': itemId,
      };
}
