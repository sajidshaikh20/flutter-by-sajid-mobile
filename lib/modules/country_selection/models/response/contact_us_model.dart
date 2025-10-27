import '../../../../utils/exports.dart';

/// A model class representing the contact information for a user.
/// It contains fields for the user's phone, email, subject, and WhatsApp
/// details.
class ContactUsModel {
  /// Constructor for creating an instance of [ContactUsModel].
  /// All fields are optional and can be set later.
  ContactUsModel({this.phone, this.email, this.subject, this.whatsapp});

  /// Factory constructor for creating an instance of [ContactUsModel] from a
  /// JSON object.
  ContactUsModel.fromJson(Map<String, dynamic> json) {
    phone = json['phone'];
    email = json['email'];
    subject = json['subject'];
    whatsapp = json['whatsapp'];
  }

  /// Factory constructor to create an instance of [ContactUsModel]
  /// from Shared Preferences data stored under the key `PrefsKey.contactUsKey`.
  factory ContactUsModel.fromSharedPref() {
    String data = SharedPref.instance.getString(PrefsKey.contactUsKey);
    Map<String, dynamic> json = jsonDecode(data);
    return ContactUsModel.fromJson(json);
  }

  /// The phone number of the user.
  String? phone;

  /// The email address of the user.
  String? email;

  /// The subject related to the contact.
  String? subject;

  /// The WhatsApp number or handle for contacting the user.
  String? whatsapp;

  /// Converts the current instance of [ContactUsModel] to a JSON object.
  /// Useful for saving or transmitting the model's data.
  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = <String, dynamic>{};
    data['phone'] = phone;
    data['email'] = email;
    data['subject'] = subject;
    data['whatsapp'] = whatsapp;
    return data;
  }
}
