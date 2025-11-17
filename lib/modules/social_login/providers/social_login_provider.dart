import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../utils/exports.dart';
import '../state/social_login_state.dart';
import '../../login/providers/login_provider.dart';

/// Notifier for handling social login functionality (Riverpod version).
class SocialLoginNotifier extends StateNotifier<SocialLoginState> {
  /// Creates a social login notifier.
  SocialLoginNotifier({
    required this.repository,
    required SocialLoginState initialState,
  }) : super(initialState);

  /// The repository used for login operations.
  final LoginRepository repository;

  /// Store login response to local pref
  Future<void> saveLoginInfoInSharedPref(LoginUserResponse response) async {
    // Save both login data and login status
    await Future.wait(<Future<void>>[
      SharedPref.instance.setValue(PrefsKey.isLoggedInKey, true),
      SharedPref.instance.saveLoginData(response),
    ]);

    // Debug: Verify login data was saved
    final bool isLoggedIn = SharedPref.instance.getBool(PrefsKey.isLoggedInKey, defValue: false);
    final String userProfileData = SharedPref.instance.getString(PrefsKey.userProfileKey, '');
    DebugLog.instance.i('Social login data saved - isLoggedIn: $isLoggedIn, hasUserData: ${userProfileData.isNotEmpty}');
  }

  /// Social login API call method
  Future<void> socialLogin({
    required String email,
    required String socialLoginType,
    String? googleToken,
    String? facebookToken,
    String? appleToken,
  }) async {
    try {
      state = state.copyWith(status: BaseStateStatus.loading);

      // Get device identifier and FCM token
      final String deviceId = getDeviceId();
      String fcmToken = SharedPref.instance.getString(PrefsKey.fcmTokenKey, '');

      // Check if FCM token is null or blank, refresh if needed
      if (fcmToken.isEmpty) {
        DebugLog.instance.i('FCM token is empty, refreshing...');
        final String? refreshedToken = await NotificationManager.instance.refreshFCMToken();
        if (refreshedToken != null && refreshedToken.isNotEmpty) {
          fcmToken = refreshedToken;
          DebugLog.instance.i('FCM token refreshed successfully');
        } else {
          DebugLog.instance.w('Failed to refresh FCM token, using empty string');
        }
      }

      // Determine the token to pass based on social login type
      String? tokenToPass;
      if (socialLoginType == SocialLoginType.google.name && googleToken != null && googleToken.isNotEmpty) {
        tokenToPass = googleToken;
        DebugLog.instance.i('Setting token field with Google access token');
      } else if (socialLoginType == SocialLoginType.facebook.name && facebookToken != null && facebookToken.isNotEmpty) {
        tokenToPass = facebookToken;
        DebugLog.instance.i('Setting token field with Facebook token');
      } else {
        tokenToPass = '';
        DebugLog.instance.i('Setting token field as blank');
      }

      // Create social login request model
      final LoginRequestModel request = LoginRequestModel(
        languageId: int.tryParse(getIt<LanguageService>().languageId) ?? 1,
        platform: getPlatformName(),
        version: getIt<MainConfig>().packageInfo.version,
        emailMobile: email,
        password: '', // Not needed for social login
        isSocialLogin: true,
        socialLoginType: socialLoginType,
        appleToken: appleToken ?? '',
        deviceId: deviceId,
        deviceToken: fcmToken, // Use the determined token
        token: tokenToPass, // Pass the appropriate token based on social login type
      );

      final ResponseHandler<BaseResponse<LoginUserResponse>> response =
      await repository.callLoginApi(request);

      if (response.isSuccess()) {
        final OnSuccessResponse<BaseResponse<LoginUserResponse>>?
        successInstance = response.getSuccessInstance();

        if (successInstance != null) {
          final BaseResponse<LoginUserResponse> baseResponse =
              successInstance.response;

          // Check if the BaseResponse is successful and has data
          if (baseResponse.success && baseResponse.data?.customerToken != null && baseResponse.statusCode ==200) {
            final LoginUserResponse loginData = baseResponse.data!;
            DebugLog.instance.i('Social login successful - customerToken: ${loginData.customerToken}');

            // Save login data to shared preferences
            await saveLoginInfoInSharedPref(loginData);

            // Update user profile service
            await UserProfileService.instance().updateUserProfile(
              customerName: loginData.customerName,
              customerEmail: loginData.customerEmail,
              phoneNumber: loginData.phoneNumber,
              customerToken: loginData.customerToken,
              customerId: loginData.customerId,
              quoteId: loginData.quoteId,
              totalOrderValue: loginData.totalOrderValue,
              lastOrderDate: loginData.lastOrderDate,
              storeCredit: loginData.walletBalance,
              rewardPoints: loginData.loyaltyPoints,
              totalOrder: loginData.totalOrder,
              cartCount: loginData.cartCount,
              referralCode: loginData.referralCode,
              gender: loginData.gender,
              birthday: loginData.birthday,
              nationality: loginData.nationality,
              prefix: loginData.prefix,
              arabicNationality: loginData.arabicNationality,
            );

            DebugLog.instance.i('Emitting success state with DashboardRoute redirect');
            final SocialLoginState newState = state.copyWith(
              status: BaseStateStatus.success,
              msg: baseResponse.message,
              redirectRoute: const DashboardRoute(),
            );
            DebugLog.instance.i('New state - Status: ${newState.status}, RedirectRoute: ${newState.redirectRoute}');
            state = newState;
          } else {
            state = state.copyWith(
              status: BaseStateStatus.failure,
              msg: baseResponse.message.isNotEmpty ? baseResponse.message : '',
            );
          }
        } else {
          state = state.copyWith(
            status: BaseStateStatus.failure,
          );
        }
      } else {
        final OnFailureResponse<BaseResponse<LoginUserResponse>>?
        failureInstance = response.getFailureInstance();
        final String errorMessage = failureInstance?.error?.errorMessage ?? '';
        state = state.copyWith(
          status: BaseStateStatus.failure,
          msg: errorMessage,
        );
      }
    } on Exception {
      state = state.copyWith(
        status: BaseStateStatus.failure,
      );
    }
  }
}

/// Provider for SocialLoginNotifier (family provider to support different initial states).
final StateNotifierProviderFamily<SocialLoginNotifier, SocialLoginState, SocialLoginState> socialLoginNotifierProvider =
    StateNotifierProviderFamily<SocialLoginNotifier, SocialLoginState, SocialLoginState>(
  (StateNotifierProviderRef<SocialLoginNotifier, SocialLoginState> ref, SocialLoginState initialState) {
    final LoginRepository repository = ref.watch(loginRepositoryProvider);
    return SocialLoginNotifier(
      repository: repository,
      initialState: initialState,
    );
  },
);

