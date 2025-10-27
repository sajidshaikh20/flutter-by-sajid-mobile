
/// Represents the response from a CMS API, containing success status and
/// a list of CMS data items. It can be created from JSON or serialized
/// back to JSON for API communication.
class CmsResponseModel {
  /// Indicates whether the CMS request was successful.
  bool? success;

  /// A list of CMS data items, which may be null if not provided in
  /// the response.
  List<CmsData>? cmsData;

  /// Creates an instance of [CmsResponseModel] with optional
  /// [success] and [cmsData].
  CmsResponseModel({this.success, this.cmsData});

  /// Creates an instance of [CmsResponseModel] from JSON data.
  CmsResponseModel.fromJson(Map<String, dynamic> json) {
    success = json['success']; // Parses the success field.

    // Parses and maps cmsData if present in the JSON response.
    if (json['cmsData'] != null) {
      cmsData = (json['cmsData'] as List<dynamic>)
          .map((dynamic v) => CmsData.fromJson(v)) // Maps JSON
      // items to CmsData.
          .toList(); // Converts the iterable to a list.
    }
  }

  /// Converts [CmsResponseModel] to a JSON map for serialization.
  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success; // Converts success field to JSON.

    // Converts the cmsData list to JSON if it's not null.
    if (cmsData != null) {
      data['cmsData'] = cmsData!.map((CmsData v) => v.toJson()).toList();
    }
    return data;
  }
}


/// Represents an individual CMS data item containing an ID and title.
/// This can be created from JSON or serialized back to JSON for API
/// communication.
class CmsData {
  /// The unique identifier for the CMS data item.
  String? id;

  /// The title or name associated with the CMS data item.
  String? title;

  /// Creates an instance of [CmsData] with optional [id] and [title].
  CmsData({this.id, this.title});

  /// Creates an instance of [CmsData] from JSON data.
  CmsData.fromJson(Map<String, dynamic> json) {
    id = json['id']; // Parses the id field from JSON.
    title = json['title']; // Parses the title field from JSON.
  }

  /// Converts [CmsData] to a JSON map for serialization.
  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id; // Converts the id field to JSON.
    data['title'] = title; // Converts the title field to JSON.
    return data;
  }
}
