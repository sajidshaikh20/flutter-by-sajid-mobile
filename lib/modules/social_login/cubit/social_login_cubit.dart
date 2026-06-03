import 'package:firebase_auth/firebase_auth.dart';
import '../../../utils/exports.dart';

/// Cubit that handles social login functionality.
class SocialLoginCubit extends Cubit<SocialLoginState> {
  /// Creates a social login cubit.
  SocialLoginCubit({required SocialLoginState initialState})
    : super(initialState);

  /// Service responsible for Google sign-in.
  final SocialLoginServices _socialLoginServices = getIt<SocialLoginServices>();

  /// Performs Firebase Google login and stores profile locally.
  Future<void> socialLoginWithGoogle() async {
    try {
      emit(state.copyWith(status: BaseStateStatus.loading));
      final SocialLoginResult? result = await _socialLoginServices
          .signInWithGoogle();
      if (result == null) {
        emit(state.copyWith(status: BaseStateStatus.initial));
        return;
      }

      final User user = result.user;
      DebugLog.instance.d('Google idToken: ${result.idToken}');
      DebugLog.instance.d('Google accessToken: ${result.accessToken}');

      await SharedPref.instance.setValue(PrefsKey.isLoggedInKey, true);
      await SharedPref.instance.setValue(
        PrefsKey.socialLoginTypeKey,
        SocialLoginType.google.name,
      );

      await UserProfileService.instance().updateUserProfile(
        customerName: user.displayName ?? user.email?.split('@').first ?? '',
        customerEmail: user.email ?? '',
        phoneNumber: user.phoneNumber ?? '',
        customerToken: result.idToken ?? result.accessToken ?? '',
        customerId: user.uid,
        quoteId: '',
        totalOrderValue: '0.0',
        lastOrderDate: '',
        storeCredit: '0.0',
        rewardPoints: '0',
        totalOrder: 0,
        cartCount: 0,
        referralCode: '',
        gender: '',
        birthday: '',
        nationality: '',
        prefix: '',
        arabicNationality: '',
      );

      await AccountVerificationHelper.setPending();

      emit(
        state.copyWith(
          status: BaseStateStatus.success,
          msg: 'Successfully logged in with Google',
          redirectRoute: AccountVerificationHelper.resolvePostLoginRoute(),
        ),
      );
    } on FirebaseAuthException catch (e) {
      emit(
        state.copyWith(
          status: BaseStateStatus.failure,
          msg: e.message ?? AppConstant.googleSignInFailed,
        ),
      );
    } on Exception {
      emit(
        state.copyWith(
          status: BaseStateStatus.failure,
          msg: AppConstant.googleSignInFailed,
        ),
      );
    }
  }
}
