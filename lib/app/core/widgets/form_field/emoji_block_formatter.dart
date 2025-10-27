import '../../../../utils/exports.dart';

/// InputFormatter to block emoji characters when emojis are not allowed
/// Uses a regex that matches most emoji ranges in Unicode.
/// This is a best-effort filter and may not cover 100% of cases, but
/// effectively blocks common emojis on Android/iOS keyboards.
class EmojiBlockFormatter extends TextInputFormatter {
  static final RegExp _emojiRegex = RegExp(
    r"[\u{1F600}-\u{1F64F}\u{1F300}-\u{1F5FF}\u{1F680}-\u{1F6FF}\u{1F700}-\u{1F77F}\u{1F780}-\u{1F7FF}\u{1F800}-\u{1F8FF}\u{1F900}-\u{1F9FF}\u{1FA00}-\u{1FA6F}\u{1FA70}-\u{1FAFF}\u{2600}-\u{26FF}\u{2700}-\u{27BF}]",
    unicode: true,
  );

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final String filtered = newValue.text.replaceAll(_emojiRegex, '');
    if (filtered == newValue.text) {
      return newValue;
    }
    final int baseOffset = filtered.length;
    return TextEditingValue(
      text: filtered,
      selection: TextSelection.collapsed(offset: baseOffset),
    );
  }
}
