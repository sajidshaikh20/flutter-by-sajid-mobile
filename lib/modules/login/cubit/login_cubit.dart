import '../../../utils/exports.dart';

/// Cubit that manages login state and authentication operations.
class LoginCubit extends Cubit<LoginState> {
  /// Creates a login cubit.
  ///
  /// [repository] The repository for login operations.
  /// [initialState] The initial state of the login screen.
  /// [isFromCart] Whether the login was initiated from the cart.
  LoginCubit({
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
    bool isLoggedIn = SharedPref.instance.getBool(
      PrefsKey.isLoggedInKey,
      defValue: false,
    );
    String userProfileData = SharedPref.instance.getString(
      PrefsKey.userProfileKey,
    );
    DebugLog.instance.i(
      'Login data saved - isLoggedIn: $isLoggedIn, hasUserData: ${userProfileData.isNotEmpty}',
    );
  }

  /// Login API call method (Real implementation)
  Future<void> login({
    required String emailMobile,
    required String password,
  }) async {
    try {
      emit(state.copyWith(status: BaseStateStatus.loading));

      final String fcmToken = await NotificationManager.instance.getOrRefreshFCMToken() ?? '';

      final ResponseHandler<BaseResponse<LoginUserResponse>> response =
          await repository.callLoginApi(
            LoginRequestModel(
              emailOrUsername: emailMobile,
              password: password,
              fcmToken: fcmToken,
              deviceType: DeviceInfoHelper.getDeviceType(),
              deviceId: DeviceInfoHelper.getDeviceId(),
              platform: DeviceInfoHelper.getPlatform(),
              appVersion: DeviceInfoHelper.getAppVersion(),
            ),
          );

      if (response.isSuccess()) {
        final BaseResponse<LoginUserResponse>? baseResponse = response
            .getSuccessInstance()
            ?.response;
        if (baseResponse != null &&
            baseResponse.success &&
            baseResponse.data != null) {
          final LoginUserResponse userResponse = baseResponse.data!;
          final UserResponseData? user = userResponse.user;
          if (user != null) {
            // Save login status and registration status
            await SharedPref.instance.setValue(PrefsKey.isLoggedInKey, true);
            await SharedPref.instance.setValue(PrefsKey.isRegisteredKey, true);

            // Update user profile service with actual values
            await UserProfileService.instance().updateUserProfile(
              customerName: user.name,
              customerEmail: user.email,
              phoneNumber: user.phone,
              customerToken: userResponse.accessToken,
              accessToken: userResponse.accessToken,
              refreshToken: userResponse.refreshToken,
              customerId: user.publicId,
              username: user.username,
              prefix: user.countryCode,
              roleId: user.role?.id,
              roleName: user.role?.name,
              subscriptionPublicId:
                  user.activeSubscription?.subscriptionPublicId,
              planName: user.activeSubscription?.planName,
              planCode: user.activeSubscription?.planCode,
              category: user.activeSubscription?.category,
              billingCycle: user.activeSubscription?.billingCycle,
              amount: user.activeSubscription?.amount != null
                  ? double.tryParse(user.activeSubscription!.amount.toString())
                  : null,
              currencyCode: user.activeSubscription?.currencyCode,
              paymentStatus: user.activeSubscription?.paymentStatus,
              subscriptionStatus: user.activeSubscription?.subscriptionStatus,
              startDate: user.activeSubscription?.startDate,
              endDate: user.activeSubscription?.endDate,
              isActive: user.activeSubscription?.isActive,
              durationDays: user.activeSubscription?.durationDays,
              profilePictureUrl: user.profilePictureUrl,
              firstTimeLogin: user.firstTimeLogin,
              amountBalance: user.amountBalance,
              riskPercentage: user.riskPercentage,
            );

            await AccountVerificationHelper.setPending();
            unawaited(SocketManager.instance.connectSocket());

            emit(
              state.copyWith(
                status: BaseStateStatus.success,
                msg: baseResponse.message.isNotEmpty
                    ? baseResponse.message
                    : 'Successfully logged in',
                redirectRoute:
                    AccountVerificationHelper.resolvePostLoginRoute(),
              ),
            );
          } else {
            emit(
              state.copyWith(
                status: BaseStateStatus.failure,
                msg: 'Invalid response: user data is missing.',
              ),
            );
          }
        } else {
          emit(
            state.copyWith(
              status: BaseStateStatus.failure,
              msg: baseResponse?.message ?? 'Failed to log in.',
            ),
          );
        }
      } else {
        final OnFailureResponse<BaseResponse<LoginUserResponse>>? failure =
            response.getFailureInstance();
        final String? errorMsg = failure?.error?.errorMessage;
        final String message = failure?.statusCode == 401
            ? (errorMsg?.isNotEmpty ?? false
                ? errorMsg!
                : APIConstant.unauthorizedKey)
            : (errorMsg ?? 'Failed to log in. Please try again.');
        emit(
          state.copyWith(
            status: BaseStateStatus.failure,
            msg: message,
          ),
        );
      }
    } on Exception {
      emit(
        state.copyWith(
          status: BaseStateStatus.failure,
          msg: 'An unexpected error occurred. Please try again.',
        ),
      );
    }
  }

  ///Toggle password visibility
  void toggleCurrentPassObscureText() {
    emit(
      state.copyWith(
        passwordObscureText: !state.passwordObscureText,
        status: BaseStateStatus.initial,
      ),
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
    emit(state.copyWith(emailErrorMessage: value));
  }

  /// Updates the validation error message for the password field.
  ///
  /// [value] The error message to display.
  void handleValidationErrorMessageForPassword(String value) {
    emit(state.copyWith(passwordErrorMessage: value));
  }

  /// Updates whether email authentication is being considered.
  ///
  /// [isEmail] Whether email authentication is selected.
  void updateEmailConsideration({required bool isEmail}) {
    emit(state.copyWith(isEmailConsidered: isEmail));
  }

  /// Updates whether phone number authentication is being considered.
  ///
  /// [isNumber] Whether phone number authentication is selected.
  void updateNumberConsideration({required bool isNumber}) {
    emit(state.copyWith(isNumberConsidered: isNumber));
  }
}
