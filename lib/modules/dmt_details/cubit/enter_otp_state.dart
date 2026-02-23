import '../../../../utils/exports.dart';

/// State for Enter OTP bottom sheet.
class EnterOtpState extends Equatable {
  const EnterOtpState({this.otp = '11111'});

  /// Current OTP string (length 5). Default '11111'.
  final String otp;

  EnterOtpState copyWith({String? otp}) => EnterOtpState(otp: otp ?? this.otp);

  @override
  List<Object?> get props => <Object?>[otp];
}
