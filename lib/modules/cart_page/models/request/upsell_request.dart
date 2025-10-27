/// Represents a request for upsell information, including store
///  and website details.
class UpsellRequest {
  /// Constructor for initializing the UpsellRequest with optional parameters.
  UpsellRequest({
    String? store,
    String? website,
  }) {
    _store = store;
    _website = website;
  }

  /// Creates an UpsellRequest instance from a JSON map.
  UpsellRequest.fromJson(Map<String, dynamic> json) {
    _store = json['store'];
    _website = json['website'];
  }

  /// Store ID where the upsell request is associated.
  String? _store;

  /// Website ID where the upsell request is associated.
  String? _website;

  /// Copies the current UpsellRequest and allows updating some fields.
  UpsellRequest copyWith({
    String? store,
    String? website,
  }) =>
      UpsellRequest(
        store: store ?? _store,
        website: website ?? _website,
      );

  /// Retrieves the store ID.
  String? get store => _store;

  /// Retrieves the website ID.
  String? get website => _website;

  /// Converts the UpsellRequest to a JSON map.
  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = <String, dynamic>{};
    map['store'] = _store;
    map['website'] = _website;
    return map;
  }
}
