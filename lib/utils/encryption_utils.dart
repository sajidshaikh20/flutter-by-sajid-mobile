import 'package:encrypt/encrypt.dart' as encrypt;
import '../utils/exports.dart';

/// Encryption
///
/// Using AES Algorithym
/// Using PKCS7 Padding
/// Using ECB Blocker
// ignore: avoid_classes_with_only_static_members // This is because our base structure follows certain rules which are needed for readability
class AESEncryption {

  /// The singleton instance of the [AESEncryption] class.
  static AESEncryption instance= getIt<AESEncryption>();
  /// Encrypts a given [text] using the AES encryption
  /// algorithm with the provided
  /// Returns an empty string if encryption fails.
  /// [encryptKey] and [encryptIV]. Returns
  /// the encrypted text as a base64 string.
  String encryptCode(
      String encryptKey,
      String encryptIV, {
        String? text = '',
      }) {
    encrypt.Key key = encrypt.Key.fromUtf8(encryptKey);
    encrypt.IV iv = encrypt.IV.fromUtf8(encryptIV);
    try {
      if(text.isNotNullOrEmpty) {
        return encrypt.Encrypter(encrypt.AES(key, mode: encrypt.AESMode.cbc))
            .encrypt(text ?? '', iv: iv)
            .base64;
      }else{
        return '';
      }
    } on Exception catch (e) {
      DebugLog.instance.e('Exception ::::: $e');
      return '';
    }
  }

  /// Decrypts a given [text] (in base64 format) using
  /// the AES encryption algorithm
  /// [text] is the base64-encoded encrypted text
  /// to decrypt (defaults to an empty string).
  /// with the provided [encryptKey] and [encryptIV].
  ///  Returns the decrypted text.
  String decryptCode(
      String encryptKey,
      String encryptIV, {
        String? text = '',
      }) {
    encrypt.Key key = encrypt.Key.fromUtf8(encryptKey);
    encrypt.IV iv = encrypt.IV.fromUtf8(encryptIV);
    return encrypt.Encrypter(encrypt.AES(key, mode: encrypt.AESMode.cbc)).decrypt64(text!, iv: iv);
  }
}
