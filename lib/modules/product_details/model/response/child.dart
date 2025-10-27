/// Model class for child data response.
class Child {
  /// The raw data map containing child information.
  Map<String, dynamic> data = <String, dynamic>{};

  /// Creates a [Child] instance from a JSON map.
  Child.fromJson(Map<String, dynamic> json){
    data = json;
  }

  /// Converts the model to a JSON map.
  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = <String, dynamic>{};
    // data['name'] = name;
    return data;
  }
}
