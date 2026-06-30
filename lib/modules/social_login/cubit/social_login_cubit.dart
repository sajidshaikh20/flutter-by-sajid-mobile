import '../../../utils/exports.dart';

/// Cubit that handles social login functionality.
class SocialLoginCubit extends Cubit<SocialLoginState> {
  /// Creates a social login cubit.
  SocialLoginCubit({
    required SocialLoginState initialState,
    required this.loginRepository,
  }) : super(initialState);

  /// Repository for login operations.
  final LoginRepository loginRepository;

  /// Service responsible for Google sign-in.
  final SocialLoginServices _socialLoginServices = getIt<SocialLoginServices>();

  /// Performs Google login, makes API request, and routes user.
  Future<void> socialLoginWithGoogle() async {
    try {
      emit(state.copyWith(status: BaseStateStatus.loading));
      final SocialLoginResult? result = await _socialLoginServices
          .signInWithGoogle();
      if (result == null) {
        emit(state.copyWith(status: BaseStateStatus.initial));
        return;
      }

      // Call Google Login API
      final ResponseHandler<BaseResponse<LoginUserResponse>> response =
          await loginRepository.callGoogleLoginApi(
            GoogleLoginRequest(token: result.idToken ?? ''),
          );

      if (response.isSuccess()) {
        final BaseResponse<LoginUserResponse>? baseResponse = response.getSuccessInstance()
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
            );

            await AccountVerificationHelper.setPending();
            unawaited(SocketManager.instance.connectSocket());

            emit(
              state.copyWith(
                status: BaseStateStatus.success,
                msg: baseResponse.message.isNotEmpty
                    ? baseResponse.message
                    : 'Successfully logged in with Google',
                redirectRoute:
                    AccountVerificationHelper.resolvePostLoginRoute(),
              ),
            );
          } else {
            // If user data is missing, redirect to registration flow with prefilled details
            emit(
              state.copyWith(
                status: BaseStateStatus.success,
                redirectRoute: SignUpRoute(
                  prefilledName: result.displayName,
                  prefilledEmail: result.email,
                ),
              ),
            );
          }
        } else {
          // baseResponse.success is false or missing data.
          // Check if this is a registration need vs another error.
          final String? errorMsg = baseResponse?.message;
          final bool isUserNotFound = errorMsg == null ||
              errorMsg.toLowerCase().contains('not found') ||
              errorMsg.toLowerCase().contains('not registered') ||
              errorMsg.toLowerCase().contains('no user') ||
              errorMsg.toLowerCase().contains('does not exist');

          if (isUserNotFound) {
            emit(
              state.copyWith(
                status: BaseStateStatus.success,
                redirectRoute: SignUpRoute(
                  prefilledName: result.displayName,
                  prefilledEmail: result.email,
                ),
              ),
            );
          } else {
            // Other API errors (like "Account already exists with different role")
            emit(
              state.copyWith(
                status: BaseStateStatus.failure,
                msg: errorMsg,
              ),
            );
          }
        }
      } else {
        // API failed (e.g. 404 user not found).
        final OnFailureResponse<BaseResponse<LoginUserResponse>>? failure =
            response.getFailureInstance();
        final String? errorMsg = failure?.error?.errorMessage;
        final int? statusCode = failure?.statusCode;

        final bool isUserNotFound = statusCode == 404 ||
            (errorMsg != null && (
               errorMsg.toLowerCase().contains('not found') ||
               errorMsg.toLowerCase().contains('not registered') ||
               errorMsg.toLowerCase().contains('no user') ||
               errorMsg.toLowerCase().contains('does not exist')
            ));

        if (isUserNotFound) {
          emit(
            state.copyWith(
              status: BaseStateStatus.success,
              redirectRoute: SignUpRoute(
                prefilledName: result.displayName,
                prefilledEmail: result.email,
              ),
            ),
          );
        } else {
          // Other failures, show the error message on screen
          emit(
            state.copyWith(
              status: BaseStateStatus.failure,
              msg: errorMsg ?? 'Google Login failed. Please try again.',
            ),
          );
        }
      }
    } on Exception catch (e) {
      DebugLog.instance.e('Google Sign-In/Login failed: $e');
      emit(
        state.copyWith(
          status: BaseStateStatus.failure,
          msg: AppConstant.googleSignInFailed,
        ),
      );
    }
  }

  /// Clears one-shot feedback message after it has been shown.
  void clearMsg() {
    if (state.msg?.isNotEmpty ?? false) {
      emit(state.copyWith(msg: ''));
    }
  }
}
