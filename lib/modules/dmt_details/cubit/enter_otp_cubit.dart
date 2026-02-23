import '../../../../utils/exports.dart';

/// OTP digit count for Send Money flow.
const int kEnterOtpLength = 5;

/// Default digit pre-filled in each OTP box.
const String kDefaultOtpDigit = '1';

/// Cubit for Enter OTP bottom sheet. Holds controllers, focus nodes, and OTP state.
/// Controllers are initialized with [kDefaultOtpDigit] ('1') each.
class EnterOtpCubit extends Cubit<EnterOtpState> {
  EnterOtpCubit()
      : _controllers = List<TextEditingController>.generate(
          kEnterOtpLength,
          (_) => TextEditingController(text: kDefaultOtpDigit),
        ),
        _focusNodes = List<FocusNode>.generate(kEnterOtpLength, (_) => FocusNode()),
        super(const EnterOtpState(otp: '11111'));

  final List<TextEditingController> _controllers;
  final List<FocusNode> _focusNodes;

  List<TextEditingController> get controllers => _controllers;
  List<FocusNode> get focusNodes => _focusNodes;

  /// Updates the digit at [index] and emits new state.
  void updateDigit(int index, String value) {
    String digit = value.replaceAll(RegExp(r'\D'), '');
    if (digit.length > 1) {
      digit = digit.split('').last;
    }
    _controllers[index].text = digit;
    _controllers[index].selection = TextSelection.collapsed(offset: digit.length);
    final String newOtp = _controllers.map((TextEditingController c) => c.text).join();
    emit(state.copyWith(otp: newOtp));
  }

  String get otp => state.otp;

  @override
  Future<void> close() {
    for (final TextEditingController c in _controllers) {
      c.dispose();
    }
    for (final FocusNode f in _focusNodes) {
      f.dispose();
    }
    return super.close();
  }
}
