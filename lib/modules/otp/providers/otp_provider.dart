import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../utils/exports.dart';
import '../state/otp_state.dart';
import '../repository/verify_otp_repository.dart';

/// Notifier for managing OTP verification and countdown (Riverpod version).
class OtpNotifier extends StateNotifier<OtpState> {
  /// Creates an OTP notifier.
  OtpNotifier({
    OtpFlowType? flowType,
    SignUpFormDataModel? signupFormData,
    String? autoFilledOtp,
  }) : super(OtpState(
          secondsRemaining: Dimens.second60,
          flowType: flowType ?? OtpFlowType.signup,
          signupFormData: signupFormData,
          autoFilledOtp: autoFilledOtp,
        )) {
    startTimer();
    if (autoFilledOtp != null && autoFilledOtp.isNotEmpty) {
      otpChange(autoFilledOtp);
    }
  }

  /// Key to control the OTP input widget.
  final GlobalKey<OtpPinFieldState> otpPinFieldKey = GlobalKey<OtpPinFieldState>();
  Timer? _timer;
  final VerifyOtpRepository _repository = VerifyOtpRepositoryImpl();

  /// Updates the current OTP value in the state.
  void otpChange(String otpNumber) {
    state = state.copyWith(otpNumber: otpNumber);
  }

  /// Starts the OTP countdown timer and emits each tick.
  void startTimer() {
    Duration countdownDuration = const Duration(seconds: Dimens.second60);
    int remainingSeconds = countdownDuration.inSeconds;
    _timer = Timer.periodic(const Duration(seconds: 1), (Timer timer) {
      remainingSeconds--;
      if (remainingSeconds <= 0) {
        timer.cancel();
      }
      state = state.copyWith(secondsRemaining: remainingSeconds);
    });
  }

  /// Clears any temporary message in the state.
  void clearMessage() {
    if (state.msg?.isNotEmpty ?? false) {
      state = state.copyWith(msg: '');
    }
  }

  /// Extracts OTP from a message and auto-fills it
  void extractAndFillOtp(String message) {
    final String? extractedOtp = OtpExtractor.extractOtpFromMessage(message);
    if (extractedOtp != null && extractedOtp.isNotEmpty) {
      otpChange(extractedOtp);
    }
  }

  /// Resends OTP
  Future<void> resendOtp({
    String? mobileNumber,
    String? email,
  }) async {
    state = state.copyWith(status: BaseStateStatus.loading);
    // Add resend OTP logic here
    // This is a placeholder - implement actual API call
    state = state.copyWith(status: BaseStateStatus.success);
  }

  /// Verifies OTP
  Future<void> verifyOtp({
    String? mobileNumber,
    PageRouteInfo? redirectRoute,
  }) async {
    state = state.copyWith(status: BaseStateStatus.loading);
    // Add verification logic here
    // This is a placeholder - implement actual API call
    if (redirectRoute != null) {
      state = state.copyWith(
        status: BaseStateStatus.success,
        redirectRoute: redirectRoute,
      );
    } else {
      state = state.copyWith(status: BaseStateStatus.success);
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}

/// Provider for OtpNotifier (auto-dispose for page-level instances).
final AutoDisposeStateNotifierProviderFamily<OtpNotifier, OtpState, OtpNotifierParams> otpNotifierProvider =
    StateNotifierProvider.autoDispose.family<OtpNotifier, OtpState, OtpNotifierParams>(
  (AutoDisposeStateNotifierProviderRef<OtpNotifier, OtpState> ref, OtpNotifierParams params) {
    return OtpNotifier(
      flowType: params.flowType,
      signupFormData: params.signupFormData,
      autoFilledOtp: params.autoFilledOtp,
    );
  },
);

/// Parameters for creating OtpNotifier
class OtpNotifierParams {
  final OtpFlowType? flowType;
  final SignUpFormDataModel? signupFormData;
  final String? autoFilledOtp;

  OtpNotifierParams({
    this.flowType,
    this.signupFormData,
    this.autoFilledOtp,
  });
}

