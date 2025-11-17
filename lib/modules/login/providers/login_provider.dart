import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../utils/exports.dart';
import '../state/login_state.dart';

/// Notifier for managing login state and authentication operations (Riverpod version).
class LoginNotifier extends StateNotifier<LoginState> {
  /// Creates a login notifier.
  ///
  /// [repository] The repository for login operations.
  /// [initialState] The initial state of the login screen.
  /// [isFromCart] Whether the login was initiated from the cart.
  LoginNotifier({
    required this.repository,
    required LoginState initialState,
    this.isFromCart = false,
  }) : super(initialState);

  /// The repository used for login operations.
  final LoginRepository repository;

  /// Whether the login was initiated from the cart.
  final bool? isFromCart;

  ///Store login response to local pref
  Future<void> saveLoginInfoInSharedPref(LoginUserResponse response) async {
    // Save both login data and login status
    await SharedPref.instance.setValue(PrefsKey.isLoggedInKey, true);

    // Debug: Verify login data was saved
    final bool isLoggedIn = SharedPref.instance.getBool(PrefsKey.isLoggedInKey, defValue: false);
    final String userProfileData = SharedPref.instance.getString(PrefsKey.userProfileKey, '');
    DebugLog.instance.i('Login data saved - isLoggedIn: $isLoggedIn, hasUserData: ${userProfileData.isNotEmpty}');
  }

  /// Login API call method
  Future<void> login({
    required String emailMobile,
    required String password,
  }) async {
    try {
      state = state.copyWith(status: BaseStateStatus.loading);

      // Get device identifier and FCM token
      final String deviceId = getDeviceId();
      String deviceToken = SharedPref.instance.getString(PrefsKey.fcmTokenKey, '');

      // Check if FCM token is null or blank, refresh if needed
      if (deviceToken.isEmpty) {
        DebugLog.instance.i('FCM token is empty during login, refreshing...');
        final String? refreshedToken = await NotificationManager.instance.refreshFCMToken();
        if (refreshedToken != null && refreshedToken.isNotEmpty) {
          deviceToken = refreshedToken;
          DebugLog.instance.i('FCM token refreshed successfully during login');
        } else {
          DebugLog.instance.w('Failed to refresh FCM token during login, using empty string');
        }
      }

      // Create login request model
      final LoginRequestModel request = LoginRequestModel(
          languageId: int.tryParse(getIt<LanguageService>().languageId) ?? 1,
          platform: getPlatformName(),
          version: getIt<MainConfig>().packageInfo.version,
          emailMobile: emailMobile,
          password: password,
          isSocialLogin: false,
          socialLoginType: '',
          appleToken: '',
          deviceId: deviceId,
          deviceToken: deviceToken);

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
                arabicNationality: loginData.arabicNationality
            );
            state = state.copyWith(
              status: BaseStateStatus.success,
              msg: baseResponse.message,
              redirectRoute: const DashboardRoute(),
            );
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

  ///Toggle password visibility
  void toggleCurrentPassObscureText() {
    state = state.copyWith(
      passwordObscureText: !state.passwordObscureText,
      status: BaseStateStatus.initial,
    );
  }

  /// Changes focus to the next field.
  ///
  /// [nextFocusNode] The focus node to move focus to.
  void moveToNextField(FocusNode nextFocusNode) {
    nextFocusNode.requestFocus();
  }

  /// Updates the validation error message for the email field.
  ///
  /// [value] The error message to display.
  void handleValidationErrorMessageForEmail(String value) {
    state = state.copyWith(emailErrorMessage: value);
  }

  /// Updates the validation error message for the password field.
  ///
  /// [value] The error message to display.
  void handleValidationErrorMessageForPassword(String value) {
    state = state.copyWith(passwordErrorMessage: value);
  }

  /// Updates whether email authentication is being considered.
  ///
  /// [isEmail] Whether email authentication is selected.
  void updateEmailConsideration({required bool isEmail}) {
    state = state.copyWith(
      isEmailConsidered: isEmail,
    );
  }

  /// Updates whether phone number authentication is being considered.
  ///
  /// [isNumber] Whether phone number authentication is selected.
  void updateNumberConsideration({required bool isNumber}) {
    state = state.copyWith(
      isNumberConsidered: isNumber,
    );
  }
}

/// Provider for LoginRepository.
final Provider<LoginRepository> loginRepositoryProvider =
    Provider<LoginRepository>((ProviderRef<LoginRepository> ref) {
  return LoginRepositoryImpl();
});

/// Provider for LoginNotifier (auto-dispose for page-level instances).
final AutoDisposeStateNotifierProvider<LoginNotifier, LoginState> loginNotifierProvider =
    StateNotifierProvider.autoDispose<LoginNotifier, LoginState>(
  (AutoDisposeStateNotifierProviderRef<LoginNotifier, LoginState> ref) {
    final LoginRepository repository = ref.watch(loginRepositoryProvider);
    final LoginState initialState = LoginState(
      status: BaseStateStatus.initial,
      emailController: TextEditingController(),
      passwordController: TextEditingController(),
      formKey: GlobalKey<FormState>(),
      emailFocusNode: FocusNode(),
      passwordFocusNode: FocusNode(),
    );
    return LoginNotifier(
      repository: repository,
      initialState: initialState,
    );
  },
);

