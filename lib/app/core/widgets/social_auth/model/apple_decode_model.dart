/// This class represents the decoded data from an Apple ID token.
class AppleDecodedModel {
  /// The issuer of the token.
  String? iss;

  /// The audience for which the token is intended.
  String? aud;

  /// The expiration time of the token.
  int? exp;

  /// The issued at time of the token.
  int? iat;

  /// The subject of the token.
  String? sub;

  /// The cHash of the token.
  String? cHash;

  /// The email associated with the token.
  String? email;

  /// Indicates whether the email has been verified.
  bool? emailVerified;
  /// The time when the user was authenticated.
  int? authTime;

  /// The time when the user was nonceSupported.
  bool? nonceSupported;
//// Constructs a new instance of the AppleDecodedModel class.
  AppleDecodedModel(
      {this.iss,
        this.aud,
        this.exp,
        this.iat,
        this.sub,
        this.cHash,
        this.email,
        this.emailVerified,
        this.authTime,
        this.nonceSupported});
//// Constructs a new instance of the AppleDecodedModel class from a JSON map.
  AppleDecodedModel.fromJson(Map<String, dynamic> json) {
    iss = json['iss'];
    aud = json['aud'];
    exp = json['exp'];
    iat = json['iat'];
    sub = json['sub'];
    cHash = json['c_hash'];
    email = json['email'];
    emailVerified = json['email_verified'];
    authTime = json['auth_time'];
    nonceSupported = json['nonce_supported'];
  }
//// Converts the instance of the AppleDecodedModel class to a JSON map.
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['iss'] = iss;
    data['aud'] = aud;
    data['exp'] = exp;
    data['iat'] = iat;
    data['sub'] = sub;
    data['c_hash'] = cHash;
    data['email'] = email;
    data['email_verified'] = emailVerified;
    data['auth_time'] = authTime;
    data['nonce_supported'] = nonceSupported;
    return data;
  }
}
