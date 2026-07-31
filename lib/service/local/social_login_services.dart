import '../../utils/exports.dart';

/// Result model for a successful Google sign-in operation.
class SocialLoginResult {
  /// Creates a [SocialLoginResult] with token and user details.
  const SocialLoginResult({
    required this.id,
    required this.email,
    this.displayName,
    this.photoUrl,
    this.idToken,
    this.accessToken,
  });

  /// Google user ID.
  final String id;

  /// Google email.
  final String email;

  /// Google display name.
  final String? displayName;

  /// Google profile picture URL.
  final String? photoUrl;

  /// Google ID token.
  final String? idToken;

  /// Google access token.
  final String? accessToken;
}

/// Service that handles social login flows.
class SocialLoginServices {
  bool _isGoogleSignInInitialized = false;

  /// Signs in the current user with Google.
  Future<SocialLoginResult?> signInWithGoogle() async {
    if (!_isGoogleSignInInitialized) {
      await GoogleSignIn.instance.initialize(
        clientId: configGoogleClientId,
        serverClientId: configGoogleClientId,
      );
      _isGoogleSignInInitialized = true;
    }

    final GoogleSignInAccount googleUser;
    try {
      googleUser = await GoogleSignIn.instance.authenticate();
    } on GoogleSignInException catch (e) {
      if (e.code == GoogleSignInExceptionCode.canceled ||
          e.code == GoogleSignInExceptionCode.interrupted ||
          e.code == GoogleSignInExceptionCode.uiUnavailable) {
        return null;
      }
      rethrow;
    } catch (e) {
      DebugLog.instance.e('Google Sign-In Error: $e');
      rethrow;
    }

    final GoogleSignInAuthentication googleAuth = googleUser.authentication;
    final GoogleSignInClientAuthorization? authorization = await googleUser
        .authorizationClient
        .authorizationForScopes(<String>['email', 'profile']);

    DebugLog.instance.i('=== Google Login User Data ===');
    DebugLog.instance.i('ID: ${googleUser.id}');
    DebugLog.instance.i('Email: ${googleUser.email}');
    DebugLog.instance.i('DisplayName: ${googleUser.displayName}');
    DebugLog.instance.i('PhotoUrl: ${googleUser.photoUrl}');
    DebugLog.instance.i('ID Token: ${googleAuth.idToken}');
    DebugLog.instance.i('ServerAuthCode: ${googleUser.authentication}');
    DebugLog.instance.i('Access Token: ${authorization?.accessToken}');
    DebugLog.instance.i('==============================');

    return SocialLoginResult(
      id: googleUser.id,
      email: googleUser.email,
      displayName: googleUser.displayName,
      photoUrl: googleUser.photoUrl,
      idToken: googleAuth.idToken,
      accessToken: authorization?.accessToken,
    );
  }
}
