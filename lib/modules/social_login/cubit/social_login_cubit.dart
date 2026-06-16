import '../../../utils/exports.dart';

/// Cubit that handles social login functionality.
class SocialLoginCubit extends Cubit<SocialLoginState> {
  /// Creates a social login cubit.
  SocialLoginCubit({required SocialLoginState initialState})
    : super(initialState);

  /// Service responsible for Google sign-in.
  final SocialLoginServices _socialLoginServices = getIt<SocialLoginServices>();

  /// Performs Google login and prints details in console.
  Future<void> socialLoginWithGoogle() async {
    try {
      emit(state.copyWith(status: BaseStateStatus.loading));
      final SocialLoginResult? result = await _socialLoginServices
          .signInWithGoogle();
      if (result == null) {
        emit(state.copyWith(status: BaseStateStatus.initial));
        return;
      }

      // Print all Google details to the console as requested by the user
      final String consoleLog = '''
==================================================
GOOGLE SIGN-IN SUCCESSFUL (WITHOUT FIREBASE)
--------------------------------------------------
Google ID:       ${result.id}
Email:           ${result.email}
Display Name:    ${result.displayName}
Photo URL:       ${result.photoUrl}
ID Token:        ${result.idToken}
Access Token:    ${result.accessToken}
==================================================
''';

      // Use DebugLog to guarantee visibility and comply with lint rules
      DebugLog.instance.i(consoleLog);

      // We stay on the same page by emitting initial status with a success message
      emit(
        state.copyWith(
          status: BaseStateStatus.initial,
          msg: 'Google Sign-In Successful! Details printed to console.',
        ),
      );
    } on Exception catch (e) {
      DebugLog.instance.e('Google Sign-In failed in Cubit: $e');
      emit(
        state.copyWith(
          status: BaseStateStatus.failure,
          msg: AppConstant.googleSignInFailed,
        ),
      );
    }
  }
}
