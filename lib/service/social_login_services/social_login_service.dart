import '../../utils/exports.dart';

/// This class provides methods for signing in and signing out with Google,
/// Facebook, and Apple services. It handles the authentication flows for each
/// service, including token extraction and user data retrieval.
///
/// Example usage:
/// ```dart
/// SocialLoginServices loginService = SocialLoginServices();
/// await loginService.signInWithGoogle();
/// ```
class SocialLoginServices {
  /// Google Sign-In and Firebase Auth instances
  final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: <String>[
      'email',
      'profile',
    ],
  );
  GoogleSignInAccount? _googleUser;
  GoogleSignInAuthentication? _googleAuth;

  /// Sign in with Google
  /// Returns the signed-in user's Google account.
  Future<GoogleSignInAccount?> signInWithGoogle() async {
    try {
      DebugLog.instance.i('=== Starting Google Sign In Process ===');
      DebugLog.instance.i('GoogleSignIn instance: $_googleSignIn');
      
      // Check Google Sign In configuration
      await _checkGoogleSignInConfiguration();
      
      // Check if user is already signed in
      DebugLog.instance.i('Checking for existing sign-in...');
      _googleUser = await _googleSignIn.signInSilently();
      
      if (_googleUser != null) {
        DebugLog.instance.i('User was already signed in: ${_googleUser!.email}');
      } else {
        DebugLog.instance.i('No existing sign-in found, showing sign-in UI...');
        // If silent sign-in fails, show the sign-in UI
        _googleUser = await _googleSignIn.signIn();
        
        if (_googleUser != null) {
          DebugLog.instance.i('User signed in successfully: ${_googleUser!.email}');
        } else {
          DebugLog.instance.e('User cancelled or sign-in failed');
          return null;
        }
      }
      
      if (_googleUser != null) {
        DebugLog.instance.i('Getting authentication tokens...');
        _googleAuth = await _googleUser!.authentication;
        DebugLog.instance.i('User signed in: ${_googleUser!.displayName}');
        DebugLog.instance.i('User email: ${_googleUser!.email}');
        DebugLog.instance.i('User ID: ${_googleUser!.id}');
        DebugLog.instance.i('Access Token: ${_googleAuth!.accessToken ?? 'No access token'}');
        DebugLog.instance.i('ID Token: ${_googleAuth!.idToken}');
        DebugLog.instance.i('=== Google Sign In Process Completed Successfully ===');
      }
      
      return _googleUser;
    } on PlatformException catch (error) {
      DebugLog.instance.e('=== Platform Exception during Google Sign In ===');
      DebugLog.instance.e('Error Code: ${error.code}');
      DebugLog.instance.e('Error Message: ${error.message}');
      DebugLog.instance.e('Error Details: ${error.details}');
      DebugLog.instance.e('Stack Trace: ${error.stacktrace}');
      return null;
    } on Exception catch (error, stackTrace) {
      DebugLog.instance.e('=== General Exception during Google Sign In ===');
      DebugLog.instance.e('Error: $error');
      DebugLog.instance.e('Stack Trace: $stackTrace');
      return null;
    }
  }

  /// Check Google Sign In configuration
  Future<void> _checkGoogleSignInConfiguration() async {
    try {
      DebugLog.instance.i('=== Checking Google Sign In Configuration ===');
      DebugLog.instance.i('Scopes: ${_googleSignIn.scopes}');
      DebugLog.instance.i('Hosted Domain: ${_googleSignIn.hostedDomain}');
      DebugLog.instance.i('Sign In Option: ${_googleSignIn.signInOption}');
      
      // Check if Google Play Services is available
      bool isAvailable = await _googleSignIn.isSignedIn();
      DebugLog.instance.i('Is currently signed in: $isAvailable');
      
      // Test if we can access Google Sign In
      try {
        await _googleSignIn.signOut(); // This should work even if not signed in
        DebugLog.instance.i('Google Sign In service is accessible');
      } on Exception catch (e) {
        DebugLog.instance.e('Google Sign In service is not accessible: $e');
      }
      
      DebugLog.instance.i('=== Google Sign In Configuration Check Complete ===');
    } on Exception catch (error) {
      DebugLog.instance.e('Error checking Google Sign In configuration: $error');
    }
  }

  /// Handles Google sign-in process
  /// Returns the Google user account if successful.
  Future<GoogleSignInAccount?> handleSignIn(GoogleSignIn googleSignIn) async {
    try {
      _googleUser = await googleSignIn.signInSilently();

      if (_googleUser != null) {
        _googleAuth = await _googleUser!.authentication;
        DebugLog.instance.i('User signed in: ${_googleUser!.displayName}');
        DebugLog.instance.i('Access Token: ${_googleAuth!.accessToken ?? 'No access token'}');
        DebugLog.instance.i('ID Token: ${_googleAuth!.idToken}');
      }

      return _googleUser;
    } on PlatformException catch (error) {
      DebugLog.instance.e('Platform Exception during Google Sign In: ${error.code} - ${error.message}');
      return null;
    } on Exception catch (error) {
      DebugLog.instance.e('Error during Google Sign In: $error');
      return null;
    }
  }

  /// Handles Google sign-out process
  /// Returns the signed-out Google account if successful.
  Future<GoogleSignInAccount?> handleGoogleSignOut() async {
    try {
      return await _googleSignIn.signOut();
    } on PlatformException catch (error) {
      DebugLog.instance.e('Platform Exception during Google Sign Out: ${error.code} - ${error.message}');
      return null;
    } on Exception catch (error) {
      DebugLog.instance.e('Error during Google Sign Out: $error');
      return null;
    }
  }

  /// Initiates Facebook login
  /// Returns user data if login is successful.
  Future<Map<String, dynamic>?> loginWithFacebookClick() async {
    Map<String, dynamic>? userData = await _loginWithFacebook();
    return userData;
  }

  /// Handles Facebook sign-out process
  /// Returns true if logout was successful.
  Future<bool> handleFbSignOutClick() async {
    bool logout = await _handleFbSignOut();
    return logout;
  }

  /// Gets Google authentication tokens for the current user
  /// Returns the authentication object containing accessToken and idToken
  Future<GoogleSignInAuthentication?> getGoogleAuthTokens() async {
    try {
      if (_googleUser != null && _googleAuth != null) {
        return _googleAuth;
      } else if (_googleUser != null) {
        _googleAuth = await _googleUser!.authentication;
        return _googleAuth;
      }
      return null;
    } on Exception catch (e) {
      DebugLog.instance.e('Error getting Google auth tokens: $e');
      return null;
    }
  }

  /// Handles Apple sign-in and returns decoded user data
  Future<AppleDecodedModel> handleAppleSignIn() async {
    AuthorizationCredentialAppleID credential =
        await SignInWithApple.getAppleIDCredential(
      scopes: <AppleIDAuthorizationScopes>[
        AppleIDAuthorizationScopes.email,
        AppleIDAuthorizationScopes.fullName,
      ],
    );
    AppleDecodedModel appleDecodedModel =
        extractDataFromToken(credential.identityToken ?? '');
    return appleDecodedModel;
  }

  /// Handles Apple sign-in and returns both decoded user data and identity token
  Future<Map<String, dynamic>> handleAppleSignInWithToken() async {
    try {
      DebugLog.instance.i('Starting Apple Sign In credential request...');
      
      // Check if Apple Sign In is available
      bool isAvailable = await SignInWithApple.isAvailable();
      DebugLog.instance.i('Apple Sign In available: $isAvailable');
      
      if (!isAvailable) {
        DebugLog.instance.e('Apple Sign In is not available on this device');
        throw Exception('Apple Sign In is not available on this device. Please ensure you are running on iOS 13+ and the device supports Apple Sign In.');
      }
      
      // Check if device is signed into Apple ID
      try {
        final CredentialState credentialState = await SignInWithApple.getCredentialState('user');
        DebugLog.instance.i('Apple ID credential state: $credentialState');
        
        if (credentialState == CredentialState.notFound) {
          DebugLog.instance.w('No Apple ID found on device. User may need to sign in to Apple ID in Settings.');
        }
      } on SignInWithAppleCredentialsException catch (e) {
        DebugLog.instance.e('Apple ID credential state check failed: $e - ${e.message}');
        DebugLog.instance.e('This indicates a configuration issue with Apple Sign-In');
        // Don't throw here, continue with the sign-in attempt
      }on Exception catch (e) {
        DebugLog.instance.w('Could not check Apple ID credential state: $e');
      }
      
      DebugLog.instance.i('Requesting Apple ID credential...');
      
      // Try with minimal scopes first if the full request fails
      AuthorizationCredentialAppleID credential;
      try {
        credential = await SignInWithApple.getAppleIDCredential(
          scopes: <AppleIDAuthorizationScopes>[
            AppleIDAuthorizationScopes.email,
            AppleIDAuthorizationScopes.fullName,
          ],
        );
      }on Exception catch (e) {
        DebugLog.instance.w('Full scope request failed, trying with email only: $e');
        // Fallback to email only scope
        credential = await SignInWithApple.getAppleIDCredential(
          scopes: <AppleIDAuthorizationScopes>[
            AppleIDAuthorizationScopes.email,
          ],
        );
      }
      
      DebugLog.instance.i('Apple credential received successfully');
      DebugLog.instance.i('Apple credential received - Identity Token: ${credential.identityToken}');
      DebugLog.instance.i('Apple credential received - Authorization Code: ${credential.authorizationCode}');
      DebugLog.instance.i('Apple credential received - User ID: ${credential.userIdentifier}');
      DebugLog.instance.i('Apple credential received - Email: ${credential.email}');
      DebugLog.instance.i('Apple credential received - Full Name: ${credential.givenName} ${credential.familyName}');
      
      AppleDecodedModel appleDecodedModel =
          extractDataFromToken(credential.identityToken ?? '');
      
      DebugLog.instance.i('Apple decoded model - Email: ${appleDecodedModel.email}');
      
      return <String, dynamic>{
        'user': appleDecodedModel,
        'identityToken': credential.identityToken ?? '',
        'authorizationCode': credential.authorizationCode,
      };
    } on SignInWithAppleAuthorizationException catch (error) {
      DebugLog.instance.e('Apple Sign In Authorization Exception: ${error.code} - ${error.message}');
      
      // Provide specific error messages for common issues
      String userFriendlyMessage;
      switch (error.code) {
        case AuthorizationErrorCode.unknown:
          userFriendlyMessage = 'Apple Sign In failed. Please ensure:\n'
              '1. You are signed into Apple ID in Settings\n'
              '2. The app is properly configured in Apple Developer Console\n'
              '3. You are running on a physical device (not simulator)\n'
              '4. Your device supports Apple Sign In';
        case AuthorizationErrorCode.canceled:
          userFriendlyMessage = 'Apple Sign In was cancelled by user';
        case AuthorizationErrorCode.invalidResponse:
          userFriendlyMessage = 'Invalid response from Apple Sign In';
        case AuthorizationErrorCode.notHandled:
          userFriendlyMessage = 'Apple Sign In request was not handled';
        case AuthorizationErrorCode.failed:
          userFriendlyMessage = 'Apple Sign In failed';
        default:
          userFriendlyMessage = 'Apple Sign In failed with error: ${error.message}';
      }
      
      DebugLog.instance.e('User-friendly error message: $userFriendlyMessage');
      throw Exception(userFriendlyMessage);
    } on PlatformException catch (error) {
      DebugLog.instance.e('Apple Sign In Platform Exception: ${error.code} - ${error.message}');
      DebugLog.instance.e('Apple Sign In Platform Exception Details: ${error.details}');
      throw Exception('Platform error during Apple Sign In: ${error.message}');
    } on Exception catch (error, stackTrace) {
      DebugLog.instance.e('Apple Sign In General Exception: $error');
      DebugLog.instance.e('Apple Sign In Stack Trace: $stackTrace');
      rethrow;
    }
  }

  /// Extracts and decodes Apple identity token
  /// Returns decoded Apple data model.
  AppleDecodedModel extractDataFromToken(String identityToken) {
    if (identityToken.isNotEmpty) {
      Map<String, dynamic> decodedToken = JwtDecoder.decode(identityToken);
      AppleDecodedModel appleDecodedModel =
          AppleDecodedModel.fromJson(decodedToken);
      return appleDecodedModel;
    } else {
      return AppleDecodedModel();
    }
  }

  /// Generates a cryptographically secure random nonce
  /// Defaults to 32 characters, used for authentication.
  String generateNonce([int length = 32]) {
    const String charset = AppConstant.nonceKey;
    Random random = Random.secure();
    return List<dynamic>.generate(
        length, (_) => charset[random.nextInt(charset.length)]).join();
  }

  /// Logs in with Facebook and fetches user data
  /// Returns user data if login is successful.
  Future<Map<String, dynamic>?> _loginWithFacebook() async {
    try {
      generateNonce();
      TrackingStatus? status;
      if (Platform.isIOS) {
        status = await AppTrackingTransparency.trackingAuthorizationStatus;
      }
      LoginResult result = await FacebookAuth.instance.login(
        permissions: <String>[
          FacebookPermissionEnum.email.value,
          if (Platform.isAndroid || status == TrackingStatus.authorized)
            FacebookPermissionEnum.publicProfile.value,
        ],
        loginTracking: status == TrackingStatus.authorized
            ? LoginTracking.enabled
            : LoginTracking.limited,
      );

      AccessToken? accessToken = result.accessToken;
      if (accessToken != null) {
        DebugLog.instance.i('Fb token ${accessToken.tokenString}');
      }

      if (result.status == LoginStatus.success) {
        AccessToken accessToken = result.accessToken!;
        Map<String, dynamic> userData = <String, dynamic>{};

        if (Platform.isAndroid) {
          Map<String, dynamic> userData =
              await FacebookAuth.instance.getUserData(
            fields: '${FacebookPermissionEnum.email.value},'
                '${FacebookPermissionEnum.name.value},'
                '${FacebookPermissionEnum.firstName.value},'
                '${FacebookPermissionEnum.lastName.value},'
                '${FacebookPermissionEnum.picture.value}',
          );
          DebugLog.instance.i('Fb  $userData');
          return userData;
        } else {
          userData = accessToken.toJson();
        }

        return userData;
      }
    } on Exception catch (error) {
      DebugLog.instance.i('Error during Facebook login: $error');
      return null;
    }
    return null;
  }

  /// Handles Facebook sign-out process
  /// Returns true if sign-out was successful.
  Future<bool> _handleFbSignOut() async {
    try {
      await FacebookAuth.instance.logOut();
      return true;
    } on Exception catch (error) {
      DebugLog.instance.i('Error during Google Sign Out: $error');
      return false;
    }
  }

  /// Handles Apple sign-out process
  /// Logs the Apple sign-out locally.
  Future<void> handleAppleSignOut() async {
    try {
      DebugLog.instance.i(
        'Apple sign-out handled locally. Clear relevant data if necessary.',
      );
    } on Exception catch (error) {
      DebugLog.instance.i('Error during Apple Sign Out: $error');
    }
  }
}
