///BiometricModel
class BiometricModel {
  String? _email;
  String? _password;




  /// Constructor
  BiometricModel({String? email, String? password})
      : _email = email,
        _password = password;


  /// From JSON
  factory BiometricModel.fromJson(Map<String, dynamic> json) {
    return BiometricModel(
      email: json['email'] as String?,
      password: json['password'] as String?,
    );
  }

  /// To JSON
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'email': _email,
      'password': _password,
    };
  }

  @override
  String toString() {
    return 'BiometricModel(email: $_email, password: $_password)';
  }
}
