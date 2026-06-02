import 'package:firebase_auth/firebase_auth.dart';
import '../../utils/exports.dart';

/// Result model for a successful Google sign-in operation.
class SocialLoginResult {
  /// Creates a [SocialLoginResult] with token and user details.
  const SocialLoginResult({required this.user, this.idToken, this.accessToken});

  /// Firebase authenticated user.
  final User user;

  /// Google ID token.
  final String? idToken;

  /// Google access token.
  final String? accessToken;
}

/// Service that handles social login flows.
class SocialLoginServices {
  bool _isGoogleSignInInitialized = false;

  /// Signs in the current user with Google and Firebase Authentication.
  Future<SocialLoginResult?> signInWithGoogle() async {
    if (!_isGoogleSignInInitialized) {
      await GoogleSignIn.instance.initialize();
      _isGoogleSignInInitialized = true;
    }

    GoogleSignInAccount googleUser;
    try {
      googleUser = await GoogleSignIn.instance.authenticate();
    } on GoogleSignInException catch (e) {
      if (e.code == GoogleSignInExceptionCode.canceled ||
          e.code == GoogleSignInExceptionCode.interrupted ||
          e.code == GoogleSignInExceptionCode.uiUnavailable) {
        return null;
      }
      rethrow;
    }

    final GoogleSignInAuthentication googleAuth = googleUser.authentication;
    final GoogleSignInClientAuthorization? authorization = await googleUser
        .authorizationClient
        .authorizationForScopes(<String>['email', 'profile']);

    if (googleAuth.idToken == null && authorization?.accessToken == null) {
      throw FirebaseAuthException(
        code: 'google-token-missing',
        message: 'Google Sign-In did not return auth tokens.',
      );
    }

    final OAuthCredential credential = GoogleAuthProvider.credential(
      accessToken: authorization?.accessToken,
      idToken: googleAuth.idToken,
    );

    final UserCredential firebaseCredential = await FirebaseAuth.instance
        .signInWithCredential(credential);
    final User? firebaseUser = firebaseCredential.user;

    if (firebaseUser == null) {
      throw FirebaseAuthException(
        code: 'firebase-user-null',
        message: 'Firebase user was null after Google sign-in.',
      );
    }

    return SocialLoginResult(
      user: firebaseUser,
      idToken: googleAuth.idToken,
      accessToken: authorization?.accessToken,
    );
  }
}
