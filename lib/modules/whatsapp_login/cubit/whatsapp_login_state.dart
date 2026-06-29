import '../../../utils/exports.dart';

class WhatsAppLoginState extends BaseState {
  const WhatsAppLoginState({
    required super.status,
    super.msg = '',
    super.redirectRoute,
    required this.phoneController,
    required this.phoneFocusNode,
    this.otpCode = '',
    this.countryDialCode = '+91',
    this.countryIsoCode = 'IN',
    this.isOtpSent = false,
  });

  final TextEditingController phoneController;
  final FocusNode phoneFocusNode;
  final String otpCode;
  final String countryDialCode;
  final String countryIsoCode;
  final bool isOtpSent;

  String get phone => phoneController.text.trim();

  @override
  List<Object?> get props => <Object?>[
        ...super.props,
        otpCode,
        countryDialCode,
        countryIsoCode,
        isOtpSent,
      ];

  WhatsAppLoginState copyWith({
    BaseStateStatus? status,
    String? msg,
    PageRouteInfo? redirectRoute,
    String? otpCode,
    String? countryDialCode,
    String? countryIsoCode,
    bool? isOtpSent,
  }) {
    return WhatsAppLoginState(
      status: status ?? this.status,
      msg: msg ?? this.msg,
      redirectRoute: redirectRoute ?? this.redirectRoute,
      phoneController: phoneController,
      phoneFocusNode: phoneFocusNode,
      otpCode: otpCode ?? this.otpCode,
      countryDialCode: countryDialCode ?? this.countryDialCode,
      countryIsoCode: countryIsoCode ?? this.countryIsoCode,
      isOtpSent: isOtpSent ?? this.isOtpSent,
    );
  }
}
