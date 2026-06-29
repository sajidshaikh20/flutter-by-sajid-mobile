import '../../../utils/exports.dart';
import '../model/whatsapp_login_models.dart';
import '../repo/whatsapp_login_repository.dart';
import 'whatsapp_login_state.dart';

class WhatsAppLoginCubit extends Cubit<WhatsAppLoginState> {
  WhatsAppLoginCubit({
    required this.repository,
    required WhatsAppLoginState initialState,
  }) : super(initialState);

  final WhatsAppLoginRepository repository;

  void updateCountryCode(CountryCode code) {
    emit(state.copyWith(
      countryDialCode: code.dialCode ?? '+91',
      countryIsoCode: code.code ?? 'IN',
    ));
  }

  void updateOtp(String otp) {
    emit(state.copyWith(otpCode: otp));
  }

  void resetFlow() {
    state.phoneController.clear();
    emit(state.copyWith(
      status: BaseStateStatus.initial,
      isOtpSent: false,
      otpCode: '',
      msg: '',
    ));
  }

  Future<void> sendOtp() async {
    final String phone = state.phone;
    if (phone.isEmpty) {
      emit(state.copyWith(
        status: BaseStateStatus.failure,
        msg: 'Please enter your phone number',
      ));
      return;
    }

    emit(state.copyWith(status: BaseStateStatus.loading));
    try {
      final ResponseHandler<BaseResponse<Map<String, dynamic>>> response =
          await repository.callSendLoginOtpApi(
        SendLoginOtpRequest(
          countryCode: state.countryDialCode,
          phone: phone,
        ),
      );

      if (response.isSuccess()) {
        final BaseResponse<Map<String, dynamic>>? baseResponse =
            response.getSuccessInstance()?.response;
        if (baseResponse != null && baseResponse.success) {
          emit(state.copyWith(
            status: BaseStateStatus.success,
            isOtpSent: true,
            msg: 'OTP sent successfully to your WhatsApp',
          ));
        } else {
          emit(state.copyWith(
            status: BaseStateStatus.failure,
            msg: baseResponse?.message ?? 'Failed to send OTP. Please try again.',
          ));
        }
      } else {
        final OnFailureResponse<BaseResponse<Map<String, dynamic>>>? failure =
            response.getFailureInstance();
        emit(state.copyWith(
          status: BaseStateStatus.failure,
          msg: failure?.error?.errorMessage ?? 'Failed to send OTP. Please try again.',
        ));
      }
    } on Exception {
      emit(state.copyWith(
        status: BaseStateStatus.failure,
        msg: 'An unexpected error occurred. Please try again.',
      ));
    }
  }

  Future<void> verifyOtp() async {
    if (state.otpCode.length < 6) {
      emit(state.copyWith(
        status: BaseStateStatus.failure,
        msg: 'Please enter a valid 6-digit OTP',
      ));
      return;
    }

    emit(state.copyWith(status: BaseStateStatus.loading));
    try {
      final ResponseHandler<BaseResponse<LoginUserResponse>> response =
          await repository.callLoginWithOtpApi(
        LoginWithOtpRequest(
          countryCode: state.countryDialCode,
          phone: state.phone,
          otp: state.otpCode,
        ),
      );

      if (response.isSuccess()) {
        final BaseResponse<LoginUserResponse>? baseResponse =
            response.getSuccessInstance()?.response;
        if (baseResponse != null &&
            baseResponse.success &&
            baseResponse.data != null) {
          final LoginUserResponse userResponse = baseResponse.data!;
          final UserResponseData? user = userResponse.user;

          if (user != null) {
            // Profile is completed! Log in directly.
            await SharedPref.instance.setValue(PrefsKey.isLoggedInKey, true);
            await SharedPref.instance.setValue(PrefsKey.isRegisteredKey, true);

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
            );

            await AccountVerificationHelper.setPending();
            unawaited(SocketManager.instance.connectSocket());

            emit(state.copyWith(
              status: BaseStateStatus.success,
              msg: 'Successfully logged in',
              redirectRoute: AccountVerificationHelper.resolvePostLoginRoute(),
            ));
          } else {
            // Profile is not completed! Redirect to SignUp with prefilled values.
            emit(state.copyWith(
              status: BaseStateStatus.success,
              msg: 'Please complete your registration',
              redirectRoute: SignUpRoute(
                prefilledPhone: state.phone,
                prefilledCountryCode: state.countryDialCode,
              ),
            ));
          }
        } else {
          emit(state.copyWith(
            status: BaseStateStatus.failure,
            msg: baseResponse?.message ?? 'Failed to verify OTP. Please try again.',
          ));
        }
      } else {
        final OnFailureResponse<BaseResponse<LoginUserResponse>>? failure =
            response.getFailureInstance();
        emit(state.copyWith(
          status: BaseStateStatus.failure,
          msg: failure?.error?.errorMessage ?? 'Failed to verify OTP. Please try again.',
        ));
      }
    } on Exception {
      emit(state.copyWith(
        status: BaseStateStatus.failure,
        msg: 'An unexpected error occurred. Please try again.',
      ));
    }
  }

  void clearMsg() {
    emit(state.copyWith(msg: ''));
  }
}
