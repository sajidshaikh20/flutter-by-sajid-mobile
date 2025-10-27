import '../../../../utils/exports.dart';

/// Immutable state for the OTP flow.
class OtpState extends BaseState {
  /// Remaining seconds for the countdown timer.
  final int secondsRemaining;
  /// The OTP digits entered by the user.
  final String otpNumber;
  /// Mobile number for reset password flow.
  final String mobileNumber;
  /// OTP for reset password flow.
  final String otp;
  /// Flow type to determine which API to call
  final OtpFlowType flowType;
  /// Signup form data for signup flow
  final SignUpFormDataModel? signupFormData;
  /// Update Email form data
  final UpdateEmailRequestModel? updateEmailRequestModel;

  /// Auto-filled OTP from signup response
  final String? autoFilledOtp;

  /// Creates a new [OtpState].
  const OtpState({
    super.status = BaseStateStatus.initial,
    super.redirectRoute,
    super.msg,
    this.otpNumber = '',
    required this.secondsRemaining,
    this.mobileNumber = '',
    this.otp = '',
    this.flowType = OtpFlowType.forgotPassword,
    this.signupFormData,
    this.updateEmailRequestModel,
    this.autoFilledOtp,
  });

  /// Returns a copy of this state with selectively overridden fields.
  OtpState copyWith({
    PageRouteInfo? redirectRoute,
    BaseStateStatus? status,
    String? msg,
    String? otpNumber,
    int? secondsRemaining,
    String? mobileNumber,
    String? otp,
    OtpFlowType? flowType,
    SignUpFormDataModel? signupFormData,
    UpdateEmailRequestModel? updateEmailRequestModel,
    String? autoFilledOtp,
  }) {
    return OtpState(
      redirectRoute: redirectRoute,
      status: status ?? this.status,
      msg: msg ?? this.msg,
      otpNumber: otpNumber ?? this.otpNumber,
      secondsRemaining: secondsRemaining ?? this.secondsRemaining,
      mobileNumber: mobileNumber ?? this.mobileNumber,
      otp: otp ?? this.otp,
      flowType: flowType ?? this.flowType,
      signupFormData: signupFormData ?? this.signupFormData,
      updateEmailRequestModel: updateEmailRequestModel ?? this.updateEmailRequestModel,
      autoFilledOtp: autoFilledOtp ?? this.autoFilledOtp,
    );
  }

  @override
  /// Properties used for state equality comparisons.
  List<Object?> get props =>
      <Object?>[status, secondsRemaining, otpNumber, msg, redirectRoute, mobileNumber, otp, flowType, signupFormData,updateEmailRequestModel, autoFilledOtp];
}
